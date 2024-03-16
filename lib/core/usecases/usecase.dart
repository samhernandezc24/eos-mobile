/// [UseCase]
///
/// Proporciona una abstracción para definir casos de uso
/// en la aplicación.
///
/// Un caso de uso representa una acción o tarea específica que
/// se puede realizar en la capa de dominio de la aplicación.
///
/// El método `call` es responsable de ejecutar el caso de uso y
/// devolver un objeto `Type`.
abstract class UseCase<Type, Params> {
  Future<Type> call(Params params);
}

class NoParams { }
