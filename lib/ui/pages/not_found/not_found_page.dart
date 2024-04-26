import 'package:eos_mobile/shared/shared_libraries.dart';

class NotFoundPage extends StatelessWidget {
  const NotFoundPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all($styles.insets.sm),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SvgPicture.asset(
              SvgPaths.error404,
              fit: BoxFit.cover,
              width: screenSize.width,
              semanticsLabel: $strings.error404SemanticLabel,
            ),

            Gap($styles.insets.md),

            Text($strings.error404Title, style: $styles.textStyles.h3, textAlign: TextAlign.center),

            Gap($styles.insets.md),

            FilledButton(
              onPressed: () => context.go(ScreenPaths.home),
              child: Text($strings.homeGoBackButtonText),
            ),
          ],
        ),
      ),
    );
  }
}
