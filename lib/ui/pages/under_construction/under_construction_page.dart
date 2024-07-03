import 'package:eos_mobile/shared/shared_libs.dart';
import 'package:lottie/lottie.dart';

class UnderConstructionPage extends StatelessWidget {
  const UnderConstructionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Lottie.asset(
            LottiePaths.underConstruction,
            width         : context.widthPx,
            fit           : BoxFit.contain,
            filterQuality : FilterQuality.high,
          ),
          Padding(
            padding: EdgeInsets.fromLTRB($styles.insets.lg, $styles.insets.sm, $styles.insets.lg, 0),
            child: Text(
              AppStrings.underConstructionTitle,
              style     : $styles.textStyles.title1.copyWith(fontWeight: FontWeight.w600),
              textAlign : TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
