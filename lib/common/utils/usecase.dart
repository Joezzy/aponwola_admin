import 'package:aponwola_admin/common/error/failure.dart';
import 'package:dartz/dartz.dart';

abstract class UseCase<Type,Params>{
  Future<Either<Failure,Type>> call(Params params);
}


class Params<T>{
  final T data;
  Params(this.data);
}

class NoParams<T>{
  NoParams();
}

