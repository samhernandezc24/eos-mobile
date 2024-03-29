/// [UseCase]
///
/// Proporciona una abstracción para definir casos de uso en la aplicación.
///
/// Un caso de uso representa una acción o tarea específica que se puede realizar
/// en la capa de dominio de la aplicación.
abstract class UseCase<T, P> {
  Future<T> call({required P params});
}

class NoParams {}
