import 'package:eos_mobile/shared/shared_libs.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ServerFailurePage extends StatelessWidget {
  const ServerFailurePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all($styles.insets.sm),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SvgPicture.asset(
              SvgPaths.error500,
              width           : context.widthPx,
              semanticsLabel  : AppStrings.errorServerSemanticLabel,
            ),
            Gap($styles.insets.lg),
            Text(
              AppStrings.errorServerTitle,
              style     : $styles.textStyles.title1.copyWith(fontWeight: FontWeight.w600),
              textAlign : TextAlign.center,
            ),
            Gap($styles.insets.md),
            FilledButton(
              onPressed : () => context.go(AppRoutes.home),
              child     : Text(AppStrings.btnGoBackText, style: $styles.textStyles.button),
            ),
          ],
        ),
      ),
    );
  }
}
