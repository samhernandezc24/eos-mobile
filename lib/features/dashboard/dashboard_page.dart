import 'package:eos_mobile/shared/shared.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int currentPageIndex = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Dashboard',
          style: $styles.textStyles.h3,
        ),
      ),
      body: Container(),
      bottomNavigationBar: NavigationBar(
        destinations: const <NavigationDestination>[
          NavigationDestination(icon: Icon(Icons.home), label: 'Inicio'),
          NavigationDestination(icon: Icon(Icons.dashboard), label: 'Dashboard'),
          NavigationDestination(icon: Icon(Icons.format_list_bulleted), label: 'Actividad'),
          NavigationDestination(icon: Icon(Icons.account_circle), label: 'Cuenta'),
        ],
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
          _navigateToPage(index);
        },
        selectedIndex: currentPageIndex,
      ),
    );
  }

  void _navigateToPage(int index) {
    switch (index) {
      case 0:
        GoRouter.of(context).go(ScreenPaths.home);
      case 1:
        GoRouter.of(context).go(ScreenPaths.dashboard);
      case 2:
        GoRouter.of(context).go(ScreenPaths.actividad);
      case 3:
        GoRouter.of(context).go(ScreenPaths.cuenta);
    }
  }
}
