import 'package:dartz/dartz.dart';
import 'package:informat/core/failure/failure.dart';

abstract class Usecase<P, R> {
  Future<Either<Failure,R>> call(P params);
}

abstract class StreamUsecase<P, R> {
  Stream<R> call(P params);
}

class NoParams {}
