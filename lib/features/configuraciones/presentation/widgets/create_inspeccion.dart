import 'package:eos_mobile/shared/shared.dart';

class CreateInspeccion extends StatelessWidget {
  const CreateInspeccion({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Nueva inspección',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Form(
              child: Container(
                padding: EdgeInsets.zero,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Text('Nombre *'),
                    const Gap(6),
                    TextFormField(
                      autofocus: true,
                      decoration: const InputDecoration(
                        isDense: true,
                      ),
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                    ),
                    const Gap(24),
                    const Text('Folio (opcional)'),
                    const Gap(6),
                    TextFormField(
                      decoration: const InputDecoration(
                        isDense: true,
                      ),
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.done,
                    ),
                  ],
                ),
              ),
            ),
            const Spacer(),
            FilledButton(
              onPressed: () {},
              child: const Text('Guardar'),
            ),
          ],
        ),
      ),
    );
  }
}
