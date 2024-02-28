import 'package:eos_mobile/shared/shared.dart';

class DrawerHeader extends StatelessWidget {
  const DrawerHeader({
    required this.imagePath,
    Key? key,
  }) : super(key: key);

  final Image imagePath;

  @override
  Widget build(BuildContext context) {
    return const UserAccountsDrawerHeader(
      currentAccountPicture: CircleAvatar(
        backgroundImage: NetworkImage(
          'https://images.unsplash.com/photo-1584999734482-0361aecad844?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA&ixlib=rb-1.2.1&q=80&utm_campaign=api-credit&utm_medium=referral&utm_source=unsplash_source&w=300',
        ),
      ),
      accountEmail: Text(
        'mauricio.santiago@heavy-lift.com.mx',
        style: TextStyle(
          color: Colors.white,
        ),
      ),
      accountName: Text(
        'Mauricio Santiago',
        style: TextStyle(
          color: Colors.white,
        ),
      ),
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.fill,
          image: AssetImage(ImagePaths.background1),
        ),
      ),
    );
  }
}
