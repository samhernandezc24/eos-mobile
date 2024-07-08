import 'dart:io';

import 'package:eos_mobile/features/inspecciones/presentation/pages/fotos/foto_tile.dart';
import 'package:eos_mobile/shared/shared_libs.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

/// Staggered Masonry styled grid for displaying two columns of different aspect-ratio images.
class FotosInspeccionFicheroGrid extends StatefulWidget {
  const FotosInspeccionFicheroGrid({
    required this.files,
    required this.isUploading,
    Key? key,
  }) : super(key: key);

  final List<File> files;
  final bool isUploading;

  @override
  State<FotosInspeccionFicheroGrid> createState() => FotosInspeccionFicheroGridState();
}

class FotosInspeccionFicheroGridState extends State<FotosInspeccionFicheroGrid> {
  late ScrollController _controller;

  double _prevVel = -1;

  void _handleResultsScrolled() {
    // Hide the keyboard if the list is scrolled manually by the pointer, ignoring velocity based scroll changes like deceleration or over-scroll bounce
    // ignore: INVALID_USE_OF_PROTECTED_MEMBER, INVALID_USE_OF_VISIBLE_FOR_TESTING_MEMBER
    final vel = _controller.position.activity?.velocity;
    if (vel == 0 && _prevVel == 0) {
      FocusManager.instance.primaryFocus?.unfocus();
    }
    _prevVel = vel ?? _prevVel;
  }

  @override
  Widget build(BuildContext context) {
    return ScrollDecorator.shadow(
      onInit  : (controller) => controller.addListener(_handleResultsScrolled),
      builder : (controller) {
        _controller = controller;
        return CustomScrollView(
          controller: controller,
          scrollBehavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
          slivers: [
            SliverPadding(
              padding: EdgeInsets.all($styles.insets.sm).copyWith(bottom: $styles.insets.offset),
              sliver: SliverMasonryGrid.count(
                crossAxisCount    : (context.widthPx / 300).ceil(),
                mainAxisSpacing   : $styles.insets.sm,
                crossAxisSpacing  : $styles.insets.sm,
                childCount        : widget.files.length,
                itemBuilder       : (BuildContext context, int index) =>
                    FotoInspeccionFicheroTile(
                      objFile         : widget.files[index],
                      isUploading     : widget.isUploading && index == 0,
                      index           : index,
                    ),
              ),
            ),
          ],
        );
      },
    );
  }
}
