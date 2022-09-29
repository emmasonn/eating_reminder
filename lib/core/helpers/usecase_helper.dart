abstract class Usecase<P, R> {
  Future<R> call(P params);
}

abstract class StreamUsecase<P, R> {
  Stream<R> call(P params);
}

class NoParams {}
