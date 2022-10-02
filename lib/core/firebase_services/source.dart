
import 'package:informat/core/firebase_services/data_model.dart';
import 'package:informat/core/firebase_services/firebase_util.dart';

enum SourceType { remote, local }
enum RequestType { local, remote }

abstract class Source<T extends DataModel> {

  SourceType get type;

  Future<T?> viewItem(String id);

  Future<List<T>> getItems();

  Future<T?> setItem(T obj);

  Future<void> deleteItem(T obj);

  Future<void> updateItem(T obj);

  Stream<List<T>> subscribeTo(List<WhereClause>? where);

}

