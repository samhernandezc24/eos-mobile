import 'package:eos_mobile/shared/shared_libraries.dart';

class ConfiguracionesIndexPage extends StatefulWidget {
  const ConfiguracionesIndexPage({Key? key}) : super(key: key);

  @override
  State<ConfiguracionesIndexPage> createState() => _ConfiguracionesIndexPageState();
}

class _ConfiguracionesIndexPageState extends State<ConfiguracionesIndexPage> {
  /// PROPERTIES
  bool _darkModeEnabled           = false;
  bool _updateAppEnabled          = true;
  bool _notificationUpdateEnabled = false;

  /// METHODS
  void _showUpdateAppConfirmationDialog(BuildContext context) {
    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Inhabilitar actualización automática', style: $styles.textStyles.h3.copyWith(height: 1.2)),
          content: Text($strings.settingsUpdateDialogContent, style: $styles.textStyles.bodySmall.copyWith(fontSize: 16)),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                setState(() {
                  _updateAppEnabled = false;
                });
              },
              child: Text($strings.disableButtonText, style: $styles.textStyles.button.copyWith(color: Theme.of(context).colorScheme.error)),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                setState(() {
                  _updateAppEnabled = true;
                });
              },
              child: Text($strings.cancelButtonText, style: $styles.textStyles.button),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Configuración general', style: $styles.textStyles.h3)),
      body: ListView(
        children: <Widget>[
          ListTile(
            onTap: (){},
            leading: const Icon(Icons.dark_mode),
            title: Text($strings.settingsThemeAppTitle),
            subtitle: Text($strings.settingsThemeAppSubtitle),
            trailing: Switch(
              onChanged: (bool? value) {
                setState(() {
                  _darkModeEnabled = value!;
                });
              },
              value: _darkModeEnabled,
            ),
          ),
          ListTile(
            onTap: () {
              if (_updateAppEnabled) {
                _showUpdateAppConfirmationDialog(context);
              } else {
                setState(() {
                  _updateAppEnabled = true;
                });
              }
            },
            leading: const Icon(Icons.update),
            title: Text($strings.settingsUpdateAppTitle),
            subtitle: Text($strings.settingsUpdateAppSubtitle),
            trailing: Switch(
              onChanged: (bool value) {
                if (!value) {
                  _showUpdateAppConfirmationDialog(context);
                } else {
                  setState(() {
                    _updateAppEnabled = value;
                  });
                }
              },
              value: _updateAppEnabled,
            ),
          ),
          ListTile(
            onTap: (){},
            leading: const Icon(Icons.task_alt),
            title: Text($strings.settingsRecentUpdateTitle),
            subtitle: Text($strings.settingsRecentUpdateSubtitle),
            trailing: Switch(
              onChanged: (bool? value) {
                setState(() {
                  _notificationUpdateEnabled = value!;
                });
              },
              value: _notificationUpdateEnabled,
            ),
          ),
        ],
      ),
    );
  }
}
