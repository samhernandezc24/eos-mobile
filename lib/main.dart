import 'package:eos_mobile/config/themes/app_theme.dart';
import 'package:eos_mobile/features/configuraciones/presentation/bloc/inspecciones/remote/remote_inspecciones_bloc.dart';
import 'package:eos_mobile/features/configuraciones/presentation/bloc/inspecciones/remote/remote_inspecciones_event.dart';
import 'package:eos_mobile/features/configuraciones/presentation/pages/inspecciones/lista_page.dart';
import 'package:eos_mobile/injection_container.dart';
import 'package:eos_mobile/shared/shared.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  initializeDependencies();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<RemoteInspeccionesBloc>(
      create: (context) =>
          sl()..add(const GetInspecciones()),
      child: MaterialApp(
        title: 'EOS Mobile',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: ThemeMode.light,
        home: const ListPage(),
      ),
    );
  }
}
