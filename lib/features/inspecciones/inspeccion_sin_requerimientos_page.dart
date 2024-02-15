// ignore_for_file: lines_longer_than_80_chars

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

class InspeccionSinRequerimientosPage extends StatefulWidget {
  const InspeccionSinRequerimientosPage({super.key});

  @override
  State<InspeccionSinRequerimientosPage> createState() => _InspeccionSinRequerimientosPageState();
}

class _InspeccionSinRequerimientosPageState extends State<InspeccionSinRequerimientosPage> {
  final bool _isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inspección de Unidad Sin Req.'),
        leading: IconButton(
          icon: const FaIcon(FontAwesomeIcons.xmark),
          onPressed: () {
            GoRouter.of(context).go('/inspecciones');
          },
        ),
      ),
      body: Container(
        child: Center(
          //child: CheckboxListTile(value: _isChecked, onChanged: ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: (){},
        label: const Text('Guardar Inspección'),
        icon: const FaIcon(FontAwesomeIcons.floppyDisk),
      ),
    );
  }
}
