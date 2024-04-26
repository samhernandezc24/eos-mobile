import 'package:dotted_border/dotted_border.dart';
import 'package:eos_mobile/shared/shared_libraries.dart';
import 'package:syncfusion_flutter_signaturepad/signaturepad.dart';

class DrawSignature extends StatefulWidget {
  const DrawSignature({Key? key}) : super(key: key);

  @override
  State<DrawSignature> createState() => _DrawSignatureState();
}

class _DrawSignatureState extends State<DrawSignature> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Dibujar Firma',
          style: $styles.textStyles.h2,
        ),
      ),
      body: Container(
        padding: EdgeInsets.all($styles.insets.sm),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () {},
                  child: Column(
                    children: [
                      const Icon(Icons.undo),
                      Gap($styles.insets.xxs),
                      const Text('Rehacer'),
                    ],
                  ),
                ),
                SizedBox(width: $styles.insets.md),
                GestureDetector(
                  onTap: () {},
                  child: Column(
                    children: [
                      const Icon(Icons.redo),
                      Gap($styles.insets.xxs),
                      const Text('Deshacer'),
                    ],
                  ),
                ),
              ],
            ),
            Gap($styles.insets.sm),
            SizedBox(
              height: 300,
              width: double.infinity,
              child: DottedBorder(
                color: Theme.of(context).primaryColor,
                strokeWidth: 3,
                dashPattern: const [5, 4],
                borderType: BorderType.RRect,
                radius: Radius.circular($styles.corners.sm),
                child: SfSignaturePad(
                  minimumStrokeWidth: 1,
                  maximumStrokeWidth: 3,
                  strokeColor: Colors.blue,
                  backgroundColor: Theme.of(context).canvasColor,
                ),
              ),
            ),
            Gap($styles.insets.sm),
            Text(
              'Soy testigo de la inspección realizada al equipo que tengo a mi cargo y se me informo específicamente de cada punto a considerar para su atención correctiva.',
              style: $styles.textStyles.bodySmall.copyWith(
                color: Theme.of(context)
                    .textTheme
                    .bodySmall!
                    .color!
                    .withOpacity(0.63),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        height: 70,
        child: Row(
          children: <Widget>[
            FilledButton.tonal(
              onPressed: () {},
              child: Text(
                'Limpiar',
                style: $styles.textStyles.button,
              ),
            ),
            const Spacer(),
            FilledButton(
              onPressed: () {},
              child: Text(
                'Guardar',
                style: $styles.textStyles.button,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
