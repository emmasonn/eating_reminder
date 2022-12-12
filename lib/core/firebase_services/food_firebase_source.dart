import 'package:informat/core/firebase_services/firebase_util.dart';
import 'package:informat/feature/what_to_eat/domain/food_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart' as firestore;

abstract class FoodFirebaseSource {
  Future<FoodModel?> viewItem(String id);
  Future<List<FoodModel>> getItems();
  Future<FoodModel> createItem(FoodModel obj);
  Future<void> deleteItem(FoodModel obj);
  Future<FoodModel> updateItem(FoodModel obj);
  Stream<List<FoodModel>> subscribeTo(List<WhereClause>? where);
}

class FoodFirebaseSourceImpl extends FoodFirebaseSource {
  FoodFirebaseSourceImpl() {
    collection = firestore.FirebaseFirestore.instance.collection('foods');
    itemsQuery = collection;
    fromJson = (data) => FoodModel.fromJson(data);
    toJson = (food) => food.toJson();
  }
  late final firestore.CollectionReference collection;
  late final FoodModel Function(Map<String, dynamic> data) fromJson;
  late final Map<String, dynamic> Function(FoodModel obj) toJson;
  late firestore.Query itemsQuery;

  //convert form document to dart model
  FoodModel fromDocument(firestore.DocumentSnapshot documemt) => fromJson({
        ...(documemt.data() as Map).cast<String, dynamic>(), //deconstructuring
        ...{'id': documemt.id}
      });

  @override
  Future<List<FoodModel>> getItems() async =>
      (await collection.get()).docs.map((doc) => fromDocument(doc)).toList();

  Future<List<FoodModel>> getNextItems(FoodModel current) async {
    final firestore.DocumentSnapshot lastItem =
        await collection.doc(current.id).get();
    itemsQuery = collection.limit(20).startAfterDocument(lastItem);
    return (await itemsQuery.get())
        .docs
        .map((doc) => fromDocument(doc))
        .toList();
  }

  Future<List<FoodModel>> getPrevItems(FoodModel current) async {
    final firestore.DocumentSnapshot lastItem =
        await collection.doc(current.id).get();
    itemsQuery = collection.limit(20).endBeforeDocument(lastItem);
    return (await itemsQuery.get())
        .docs
        .map((doc) => fromDocument(doc))
        .toList();
  }

  @override
  Future<FoodModel> createItem(FoodModel obj) async {
    late firestore.DocumentReference docRef;
    //Firebase equivalent of POST
    final itemId = collection.doc().id; //auto-generate an id
    final newObj = obj.copyWith(id: itemId);
    await collection.doc(itemId).set(toJson(newObj));
    docRef = collection.doc(itemId);

    //Return a reloaded document incase it had any
    //fields that were resolved on the server
    return fromDocument(await docRef.get());
  }

  @override
  Future<void> deleteItem(FoodModel obj) async =>
      await collection.doc(obj.id).delete();

  @override
  Future<FoodModel> updateItem(FoodModel obj) async {
    late firestore.DocumentReference docRef;
    //if the object already exists, do the Firebase equivalent of
    //PUT/PATCH
    await collection.doc(obj.id).set(toJson(obj));
    docRef = collection.doc(obj.id);
    //Return a reloaded document incase it had any
    //fields that were resolved on the server
    return fromDocument(await docRef.get());
  }

  @override
  Stream<List<FoodModel>> subscribeTo(List<WhereClause>? where) async* {
    //collection.where() returns a 'Query'
    firestore.Query query = collection;
    if (where != null && where.isNotEmpty) {
      for (final whereClause in where) {
        if (whereClause.type == FilterType.equals) {
          query =
              query.where(whereClause.fieldName, isEqualTo: whereClause.value);
        } else if (whereClause.type == FilterType.greaterThan) {
          query = query.where(whereClause.fieldName,
              isGreaterThan: whereClause.value);
        } else if (whereClause.type == FilterType.whereIn) {
          query = query.where(whereClause.fieldName,
              whereIn: whereClause.value as List<Object>);
        } else {
          throw Exception('Failed to handle FilterType of ${whereClause.type}');
        }
      }
    }

    Stream<firestore.QuerySnapshot> snapshots = query.limit(20).snapshots();
    yield* snapshots.map<List<FoodModel>>(
      (firestore.QuerySnapshot snapshot) =>
          snapshot.docs.map<FoodModel>(fromDocument).toList(),
    );
  }

  //this function get single item.
  @override
  Future<FoodModel?> viewItem(String id) async {
    firestore.DocumentSnapshot snapshot = await collection.doc(id).get();
    if (snapshot.data() != null) {
      return fromDocument(snapshot);
    } else {
      return null;
    }
  }
}
