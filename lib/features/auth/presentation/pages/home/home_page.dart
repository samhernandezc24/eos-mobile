import 'dart:convert';
import 'dart:math' as math;

import 'package:eos_mobile/core/common/widgets/eos_mobile_logo.dart';
import 'package:eos_mobile/core/di/injection_container.dart';
import 'package:eos_mobile/core/utils/string_utils.dart';
import 'package:eos_mobile/features/auth/presentation/bloc/auth/local/local_auth_bloc.dart';
import 'package:eos_mobile/features/auth/presentation/widgets/home/about_dialog_content.dart';
import 'package:eos_mobile/features/auth/presentation/widgets/home/drawer_header_effect.dart';
import 'package:eos_mobile/shared/shared.dart';
import 'package:flutter/rendering.dart';
import 'package:package_info_plus/package_info_plus.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  /// METHODS
  Future<void> _handleAboutPressed(BuildContext context) async {
    final PackageInfo packageInfo = await PackageInfo.fromPlatform();
    if (!mounted) return;
    showAboutDialog(
      context: context,
      applicationName: $strings.defaultAppName,
      applicationVersion: packageInfo.version,
      applicationLegalese: 'Powered by Workcube © 2024',
      children: [const AboutDialogContent()],
      applicationIcon: Container(
        padding: EdgeInsets.all($styles.insets.xs),
        child: const EOSMobileLogo(width: 52),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LocalAuthBloc>(
      create: (_) => sl<LocalAuthBloc>()..add(GetUserInfo()),
      child: Scaffold(
        appBar: AppBar(
          title: Text($strings.defaultAppName, style: $styles.textStyles.h3),
          actions: <Widget>[
            IconButton(onPressed: () {}, icon: const Icon(Icons.notifications))
          ],
        ),
        body: Padding(
          padding: EdgeInsets.all($styles.insets.sm),
          child: GridView.builder(
            padding: EdgeInsets.all($styles.insets.xs),
            gridDelegate: CustomGridDelegate(dimension: 140),
            itemBuilder: (BuildContext context, int index) {
              final math.Random random = math.Random(index);
              return GridTile(
                header: GridTileBar(title: Text('$index')),
                child: Container(
                  margin: EdgeInsets.all($styles.insets.xs),
                  decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    gradient: const RadialGradient(
                        colors: <Color>[Color(0x0F88EEFF), Color(0x2F0099BB)]),
                  ),
                  child: FlutterLogo(
                    style: FlutterLogoStyle
                        .values[random.nextInt(FlutterLogoStyle.values.length)],
                  ),
                ),
              );
            },
          ),
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              BlocBuilder<LocalAuthBloc, LocalAuthState>(
                builder: (BuildContext context, LocalAuthState state) {
                  if (state is LocalUserInfoSuccess) {
                    if (state.userInfo != null) {
                      final Map<String, dynamic> objUserData = jsonDecode(state.userInfo!['user'] ?? '{}') as Map<String, dynamic>;

                      final String? accountName = state.userInfo!['nombre'];
                      final String? accountEmail = objUserData['email'] as String?;

                      return UserAccountsDrawerHeader(
                        accountName: Text(accountName ?? '', style: const TextStyle(color: Colors.white)),
                        accountEmail: Text(accountEmail ?? '', style: const TextStyle(color: Colors.white)),
                        currentAccountPicture: CircleAvatar(
                          backgroundColor: Theme.of(context).chipTheme.backgroundColor,
                          child: Text(StringUtils.getInitials(accountName ?? ''), style: $styles.textStyles.h2),
                        ),
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(ImagePaths.background1),
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    } else {
                      return const UserAccountsDrawerHeader(
                        accountName: Text('John Doe'),
                        accountEmail: Text('john@doe.com'),
                        currentAccountPicture: CircleAvatar(
                          backgroundImage: NetworkImage(
                            'https://images.unsplash.com/photo-1584999734482-0361aecad844?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA&ixlib=rb-1.2.1&q=80&utm_campaign=api-credit&utm_medium=referral&utm_source=unsplash_source&w=300',
                          ),
                        ),
                      );
                    }
                  } else {
                    // Retornamos el `DrawerHeaderEffect` si no se puede cargar la información correctamente.
                    return const DrawerHeaderEffect();
                  }
                },
              ),
              ListTile(
                leading: const Icon(Icons.home),
                title: Text($strings.homeTitle),
                onTap: (){
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.dashboard),
                title: Text($strings.dashboardTitle),
                onTap: (){
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.format_list_bulleted),
                title: Text($strings.activityTitle),
                onTap: (){
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.account_circle),
                title: Text($strings.accountTitle),
                onTap: (){
                  Navigator.pop(context);
                },
              ),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.info),
                title: Text($strings.homeMenuButtonAbout),
                onTap: () => _handleAboutPressed(context),
              ),
            ],
          ),
        ),
        // bottomNavigationBar: AboutDialog(),
        resizeToAvoidBottomInset: false,
      ),
    );
  }
}

class CustomGridDelegate extends SliverGridDelegate {
  CustomGridDelegate({required this.dimension});

  // This is the desired height of each row (and width of each square).
  // When there is not enough room, we shrink this to the width of the scroll view.
  final double dimension;

  // The layout is two rows of squares, then one very wide cell, repeat.

  @override
  SliverGridLayout getLayout(SliverConstraints constraints) {
    // Determine how many squares we can fit per row.
    int count = constraints.crossAxisExtent ~/ dimension;
    if (count < 1) {
      count = 1; // Always fit at least one regardless.
    }
    final double squareDimension = constraints.crossAxisExtent / count;
    return CustomGridLayout(
      crossAxisCount: count,
      fullRowPeriod:
          3, // Number of rows per block (one of which is the full row).
      dimension: squareDimension,
    );
  }

  @override
  bool shouldRelayout(CustomGridDelegate oldDelegate) {
    return dimension != oldDelegate.dimension;
  }
}

class CustomGridLayout extends SliverGridLayout {
  const CustomGridLayout({
    required this.crossAxisCount,
    required this.dimension,
    required this.fullRowPeriod,
  })  : assert(crossAxisCount > 0),
        assert(fullRowPeriod > 1),
        loopLength = crossAxisCount * (fullRowPeriod - 1) + 1,
        loopHeight = fullRowPeriod * dimension;

  final int crossAxisCount;
  final double dimension;
  final int fullRowPeriod;

  // Computed values.
  final int loopLength;
  final double loopHeight;

  @override
  double computeMaxScrollOffset(int childCount) {
    // This returns the scroll offset of the end side of the childCount'th child.
    // In the case of this example, this method is not used, since the grid is
    // infinite. However, if one set an itemCount on the GridView above, this
    // function would be used to determine how far to allow the user to scroll.
    if (childCount == 0 || dimension == 0) {
      return 0;
    }
    return (childCount ~/ loopLength) * loopHeight +
        ((childCount % loopLength) ~/ crossAxisCount) * dimension;
  }

  @override
  SliverGridGeometry getGeometryForChildIndex(int index) {
    // This returns the position of the index'th tile.
    //
    // The SliverGridGeometry object returned from this method has four
    // properties. For a grid that scrolls down, as in this example, the four
    // properties are equivalent to x,y,width,height. However, since the
    // GridView is direction agnostic, the names used for SliverGridGeometry are
    // also direction-agnostic.
    //
    // Try changing the scrollDirection and reverse properties on the GridView
    // to see how this algorithm works in any direction (and why, therefore, the
    // names are direction-agnostic).
    final int loop = index ~/ loopLength;
    final int loopIndex = index % loopLength;
    if (loopIndex == loopLength - 1) {
      // Full width case.
      return SliverGridGeometry(
        scrollOffset: (loop + 1) * loopHeight - dimension, // "y"
        crossAxisOffset: 0, // "x"
        mainAxisExtent: dimension, // "height"
        crossAxisExtent: crossAxisCount * dimension, // "width"
      );
    }
    // Square case.
    final int rowIndex = loopIndex ~/ crossAxisCount;
    final int columnIndex = loopIndex % crossAxisCount;
    return SliverGridGeometry(
      scrollOffset: (loop * loopHeight) + (rowIndex * dimension), // "y"
      crossAxisOffset: columnIndex * dimension, // "x"
      mainAxisExtent: dimension, // "height"
      crossAxisExtent: dimension, // "width"
    );
  }

  @override
  int getMinChildIndexForScrollOffset(double scrollOffset) {
    // This returns the first index that is visible for a given scrollOffset.
    //
    // The GridView only asks for the geometry of children that are visible
    // between the scroll offset passed to getMinChildIndexForScrollOffset and
    // the scroll offset passed to getMaxChildIndexForScrollOffset.
    //
    // It is the responsibility of the SliverGridLayout to ensure that
    // getGeometryForChildIndex is consistent with getMinChildIndexForScrollOffset
    // and getMaxChildIndexForScrollOffset.
    //
    // Not every child between the minimum child index and the maximum child
    // index need be visible (some may have scroll offsets that are outside the
    // view; this happens commonly when the grid view places tiles out of
    // order). However, doing this means the grid view is less efficient, as it
    // will do work for children that are not visible. It is preferred that the
    // children are returned in the order that they are laid out.
    final int rows = scrollOffset ~/ dimension;
    final int loops = rows ~/ fullRowPeriod;
    final int extra = rows % fullRowPeriod;
    return loops * loopLength + extra * crossAxisCount;
  }

  @override
  int getMaxChildIndexForScrollOffset(double scrollOffset) {
    // (See commentary above.)
    final int rows = scrollOffset ~/ dimension;
    final int loops = rows ~/ fullRowPeriod;
    final int extra = rows % fullRowPeriod;
    final int count = loops * loopLength + extra * crossAxisCount;
    if (extra == fullRowPeriod - 1) {
      return count;
    }
    return count + crossAxisCount - 1;
  }
}
