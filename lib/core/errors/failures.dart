
import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable{}


class OffLineFailure extends Failure{
  @override
  List<Object?> get props =>  [];
}
class ServerFailure extends Failure{
  @override
  List<Object?> get props =>  [];
}

class EmptyCacheFailure extends Failure{
  @override
  List<Object?> get props =>  [];
}
class FirebaseFailure extends Failure{
  @override
  List<Object?> get props =>  [];
}