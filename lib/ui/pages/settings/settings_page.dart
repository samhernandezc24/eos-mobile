import 'package:eos_mobile/shared/shared_libraries.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  // PROPERTIES
  bool _isDarkModeEnabled                 = false;
  bool _isAutoUpdateEnabled               = true;
  bool _isRecenUpdateNotificationEnabled  = false;

  // EVENTS
  void _showConfirmationDisableAutoUpdate(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title   : Text('Inhabilitar actualización automática', style: $styles.textStyles.h3.copyWith(fontSize: 18, height: 1.3)),
          content : Text($strings.settingsUpdateDialogContent, style: $styles.textStyles.body.copyWith(height: 1.5)),
          actions : <Widget>[
            TextButton(
              onPressed : () => Navigator.pop(context, $strings.cancelButtonText),
              child     : Text($strings.cancelButtonText, style: $styles.textStyles.button),
            ),
            TextButton(
              onPressed : (){},
              child     : Text($strings.disableButtonText, style: $styles.textStyles.button.copyWith(color: Theme.of(context).colorScheme.error)),
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
          // CAMBIAR TEMA DE LA APP:
          SwitchListTile(
            title     : Text($strings.settingsThemeAppTitle),
            subtitle  : Text($strings.settingsThemeAppSubtitle),
            secondary : const Icon(Icons.dark_mode),
            value     : _isDarkModeEnabled,
            onChanged : (bool value) {
              setState(() {
                _isDarkModeEnabled = value;
              });
            },
          ),

          // AUTO-UPDATE:
          SwitchListTile(
            title     : Text($strings.settingsUpdateAppTitle),
            subtitle  : Text($strings.settingsUpdateAppSubtitle),
            secondary : const Icon(Icons.update),
            value     : _isAutoUpdateEnabled,
            onChanged : (bool value) {
              if (!value) {
                _showConfirmationDisableAutoUpdate(context);
              } else {
                setState(() {
                  _isAutoUpdateEnabled = value;
                });
              }
            },
          ),

          // NOTIFICACIONES DE NUEVAS ACTUALIZACIONES:
          SwitchListTile(
            title     : Text($strings.settingsRecentUpdateTitle),
            subtitle  : Text($strings.settingsRecentUpdateSubtitle),
            secondary : const Icon(Icons.task_alt),
            value     : _isRecenUpdateNotificationEnabled,
            onChanged : (bool value) {
              setState(() {
                _isRecenUpdateNotificationEnabled = value;
              });
            },
          ),
        ],
      ),
    );
  }
}
