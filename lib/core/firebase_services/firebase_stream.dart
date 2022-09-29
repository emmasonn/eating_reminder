import 'firebase_util.dart';

abstract class StreamSource<T> {
  Stream<List<T>> subscribeTo(List<WhereClause>? where);
}