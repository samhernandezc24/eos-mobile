import 'package:eos_mobile/core/common/data/elementos/module_data.dart';
import 'package:eos_mobile/core/common/widgets/scaling_grid_delegate.dart';
import 'package:eos_mobile/shared/shared.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  /// LIST
  static List<ModuleData> lstModules = <ModuleData>[];

  @override
  Widget build(BuildContext context) {
    // Establecer los datos para los módulos.
    lstModules = <ModuleData>[
      ModuleData($strings.homePageModule1, Icons.checklist),
      ModuleData($strings.homePageModule2, Icons.shopping_cart),
      ModuleData($strings.homePageModule3, Icons.forklift),
      ModuleData($strings.homePageModule6, Icons.local_shipping),
    ];

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all($styles.insets.xs),
        child: GridView.builder(
          padding: EdgeInsets.all($styles.insets.xs),
          gridDelegate: ScalingGridDelegate(dimension: 180),
          itemCount: lstModules.length,
          itemBuilder: (BuildContext context, int index) {
            return InkWell(
              onTap: (){
                switch (index) {
                  case 0:
                    GoRouter.of(context).go('/home/inspecciones');
                  case 1:
                    GoRouter.of(context).go('/home/compras');
                  case 2:
                    GoRouter.of(context).go('/home/embarques');
                  case 3:
                    GoRouter.of(context).go('/home/unidades');
                }
              },
              child: GridTile(
                header: GridTileBar(
                  title: Text(
                    lstModules[index].name,
                    style: $styles.textStyles.bodySmall.copyWith(
                      color: Theme.of(context).colorScheme.onTertiaryContainer,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                child: Container(
                  margin: EdgeInsets.all($styles.insets.xs),
                  decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular($styles.corners.md),
                    ),
                    gradient: RadialGradient(
                      colors: <Color>[
                        Theme.of(context).colorScheme.tertiaryContainer.withOpacity(0.8),
                        Theme.of(context).colorScheme.tertiaryContainer,
                      ],
                    ),
                  ),
                  child: LayoutBuilder(
                    builder: (BuildContext context, BoxConstraints constraints) {
                      return Center(
                        child: Container(
                          width: constraints.maxWidth * 0.38,
                          height: constraints.maxWidth * 0.38,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Theme.of(context).primaryColor.withOpacity(0.2),
                          ),
                          child: Center(
                            child: Icon(
                              lstModules[index].icon,
                              size: constraints.maxWidth * 0.28,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
