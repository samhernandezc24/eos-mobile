import 'package:eos_mobile/shared/shared.dart';

class Error404Page extends StatelessWidget {
  const Error404Page({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mqSize = MediaQuery.of(context).size;
    void handleHomePressed() => context.go('/');

    return Scaffold(
      body: Container(
        padding: EdgeInsets.all($styles.insets.sm),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SvgPicture.asset(
              SvgPaths.error404,
              fit: BoxFit.cover,
              width: mqSize.width,
              semanticsLabel: $strings.error404SemanticLabel,
            ),
            Gap($styles.insets.lg),
            Text($strings.error404Title, style: $styles.textStyles.h1),
            Gap($styles.insets.sm),
            Text(
              $strings.error404Message,
              textAlign: TextAlign.center,
              style: $styles.textStyles.body.copyWith(height: 1.5),
            ),
            Gap($styles.insets.lg),
            FilledButton(
              onPressed: handleHomePressed,
              child: Text(
                $strings.homeGoBackButtonText,
                style: $styles.textStyles.button,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
