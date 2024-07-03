import 'package:eos_mobile/shared/shared_libs.dart';

/// [UseCase]
///
/// Este método proporciona una abstracción para la definición de
/// los casos de uso en la capa de dominio basado en el patrón
/// Clean Architecture.
///
/// Un caso de uso representa una acción o tarea especifíca que se puede
/// realizar en la capa de dominio y ser llamada en la capa de presentación.
abstract class UseCase<T, P>{
  Future<T> call({required P params});
}

/// [NoParams]
///
/// Esta clase se utiliza para representar la ausencia de párametros en los casos
/// de uso que no requieran entrada específica.
///
/// En el contexto de Clean Architecture, algunos casos de uso no necesitan
/// ningún parámetro para ejecutarse. Para mantener la consistencia y evitar
/// el uso de `null` o `void` en esos casos, se utiliza la clase `NoParams`.
class NoParams extends Equatable {
  @override
  List<Object?> get props => [];
}
