// ignore: one_member_abstracts
abstract class UseCase<Type, Params> {
  Future<Type> call({required Params params});
}
