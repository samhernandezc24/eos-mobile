import 'package:dartz/dartz.dart';
import 'package:eos_mobile/core/network/errors/failures.dart';

/// [UseCase]
///
/// Proporciona una abstracción para definir casos de uso
/// en la aplicación.
///
/// Un caso de uso representa una acción o tarea específica que
/// se puede realizar en la capa de dominio de la aplicación.
///
/// El método `call` es responsable de ejecutar el caso de uso y
/// devolver un objeto `Either` que encapsula el resultado exitoso
/// o un error representado por la clase `Failure`.
abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

class NoParams { }
