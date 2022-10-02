import 'package:hive_flutter/hive_flutter.dart';
import 'package:informat/core/firebase_services/data_model.dart';
import 'package:informat/core/firebase_services/source.dart';

abstract class HiveLocalSource<T extends DataModel> {
  SourceType get type;
  Future<void> initBox();
  Future<List<T>> getItems();
  Future<T?> getItem(String id);
  Future<T?> setItem(T obj);
  Future<void> deleteItem(T obj);
  Future<void> deleteFavorite(T obj);
  Future<void> updateItem(T obj);
  Future<List<String>> getFavoritesId();
  Future<void> toggleFavorite(String id);
  Future<void> setFavorite(String id, bool isFavorited);
}

class HiveLocalSourceImpl<T extends DataModel> extends HiveLocalSource<T> {
  late Box _itemsBox;
  late Box _favoriteBox;

  HiveLocalSourceImpl({
    required this.toJson,
    required this.fromJson,
  });

  final T Function(Map<String, dynamic> data) fromJson;
  final Map<String, dynamic> Function(T obj) toJson;

  String get _itemsBoxName => '${T.toString()}-items'; //hive db name
  String get _favoriteBoxName => '${T.toString()}-favorites'; //hive db name

 @override
  Future<void> initBox() async {
    _itemsBox = await Hive.openBox(_itemsBoxName);
    _favoriteBox = await Hive.openBox(_favoriteBoxName);
  }

  @override
  Future<List<T>> getItems() async =>
      _itemsBox.values
          ?.map<T>((data) => fromJson(data.castt<String, dynamic>()))
          .toList() ??
      [];

  @override
  Future<T?> setItem(T obj) async {
    _itemsBox.put(obj.id, obj);
    return fromJson(
      (_itemsBox.get(obj.id) as Map).cast<String, dynamic>(),
    );
  }

  @override
  Future<void> deleteItem(T obj) {
    // TODO: implement deleteItem
    throw UnimplementedError();
  }

  @override
  Future<void> deleteFavorite(T obj) async {}

  @override
  SourceType get type => SourceType.local;

  @override
  Future<void> updateItem(T obj) {
    // TODO: implement updateItem
    throw UnimplementedError();
  }

  Future<void> clear() async {
    _favoriteBox.clear();
    _itemsBox.clear();
  }

  @override
  Future<List<String>> getFavoritesId() async =>
      _favoriteBox.keys.cast<String>().toList();

  @override
  Future<void> setFavorite(String id, bool isFavorited) =>
      isFavorited ? _favoriteBox.delete(id) : _favoriteBox.put(id, true);

  @override
  Future<void> toggleFavorite(String id) async => _favoriteBox.containsKey(id)
      ? _favoriteBox.delete(id)
      : _favoriteBox.put(id, true);

  @override
  Future<T?> getItem(String id) async {
    final data = _itemsBox.get(id);
    return data != null ? fromJson(data) : null;
  }
}
