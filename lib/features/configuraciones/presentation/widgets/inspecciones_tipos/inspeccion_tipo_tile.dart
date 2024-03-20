import 'package:eos_mobile/core/common/widgets/controls/basic_modal.dart';
import 'package:eos_mobile/features/configuraciones/domain/entities/inspeccion_tipo_entity.dart';
import 'package:eos_mobile/features/configuraciones/presentation/widgets/inspecciones_tipos/update_inspeccion_tipo_form.dart';
import 'package:eos_mobile/shared/shared.dart';

class InspeccionTipoTile extends StatelessWidget {
  const InspeccionTipoTile({Key? key, this.inspeccionTipo}) : super(key: key);

  final InspeccionTipoEntity? inspeccionTipo;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Colors.transparent,
        child: Image.asset(ImagePaths.circleVehicle),
      ),
      title: Text(inspeccionTipo!.name.toProperCase(), overflow: TextOverflow.ellipsis),
      subtitle: Text('Folio: ${inspeccionTipo!.folio}'),
      onTap: (){},
      trailing: IconButton(
        icon: const Icon(Icons.more_vert),
        onPressed: () => _showModalBottomSheet(context),
      ),
    );
  }

  void _showModalBottomSheet(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.symmetric(vertical: $styles.insets.sm),
          height: 250,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text('Folio: ${inspeccionTipo!.folio}', textAlign: TextAlign.center, style: $styles.textStyles.h3),
              Gap($styles.insets.sm),
              ListTile(
                leading: const Icon(Icons.add),
                title: const Text('Crear categorías'),
                onTap: (){},
              ),
              ListTile(
                leading: const Icon(Icons.edit),
                title: const Text('Editar'),
                onTap: (){
                  Navigator.push<void>(
                    context,
                    PageRouteBuilder<void>(
                      transitionDuration: $styles.times.pageTransition,
                      pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
                        const Offset begin  = Offset(0, 1);
                        const Offset end    = Offset.zero;
                        const Cubic curve   = Curves.ease;

                        final Animatable<Offset> tween = Tween<Offset>(begin: begin, end: end).chain(CurveTween(curve: curve));

                        return SlideTransition(
                          position: animation.drive<Offset>(tween),
                          child: BasicModal(
                            title: 'Editar: ${inspeccionTipo!.folio}',
                            child: UpdateInspeccionTipoForm(inspeccionTipo: inspeccionTipo),
                          ),
                        );
                      },
                      fullscreenDialog: true,
                    ),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.delete),
                title: const Text('Eliminar'),
                onTap: (){},
              ),
            ],
          ),
        );
      },
    );
  }
}
