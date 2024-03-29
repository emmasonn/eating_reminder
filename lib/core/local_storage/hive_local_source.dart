import 'package:hive_flutter/hive_flutter.dart';
import 'package:informat/core/firebase_services/data_model.dart';
import 'package:informat/core/firebase_services/source.dart';
import 'package:informat/feature/what_to_eat/domain/food_model.dart';

abstract class HiveLocalSource<T extends DataModel> {
  SourceType get type;
  Future<void> initBox();
  Future<List<T>> getItems();
  Future<T?> getItem(String id);
  Future<T?> setItem(T obj);
  Future<void> deleteItem(T obj);
  Future<void> deleteFavorite(T obj);
  Future<List<String>> getFavoritesId();
  Future<void> toggleFavorite(String id);
  // Stream<List<T>> get itemsStream;
  Future<void> clear();
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

  // @override
  // Stream<List<T>> get itemsStream => _itemsBox.watch().mapToList(
  //       (event) {
  //         final List<T> foods = [];
  //         for (var event in event.value) {
  //           foods.add(fromJson(event.cast<String, dynamic>()));
  //         }
  //         return foods;
  //       },
  //     );

  @override
  Future<List<T>> getItems() async =>
      _itemsBox.values
          ?.map<T>((data) => fromJson(data.cast<String, dynamic>()))
          .toList() ??
      [];

  @override
  Future<T?> getItem(String id) async {
    final data = _itemsBox.get(id);
    if (data != null) {
      return fromJson((data as Map).cast<String, dynamic>());
    }
    return null;
  }

  @override
  Future<T?> setItem(T obj) async {
    _itemsBox.put(obj.id!, toJson(obj));
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
}
