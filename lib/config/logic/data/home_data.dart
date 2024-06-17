import 'package:eos_mobile/shared/shared_libraries.dart';

class HomeData {
  const HomeData(this.title, this.icon);

  final String title;
  final IconData icon;
}

List<HomeData> lstModulesData = [
  HomeData($strings.homePageModule1, Icons.checklist),
  HomeData($strings.homePageModule2, Icons.shopping_cart),
  HomeData($strings.homePageModule3, Icons.forklift),
  HomeData($strings.homePageModule4, Icons.local_shipping),
];
