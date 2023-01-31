import 'package:cloud_firestore/cloud_firestore.dart' as firestore;
import 'package:informat/core/firebase_services/firebase_auth.dart';
import 'package:informat/core/firebase_services/firebase_storage.dart';
import 'package:informat/core/firebase_services/firebase_util.dart';
import 'package:informat/core/resources/strings.dart';
import 'package:informat/feature/what_to_eat/domain/food_model.dart';

class FoodRemoteSource {
  final CustomFirebaseStorage firebaseStorage;
  final CoreFirebaseAuth coreFirebaseAuth;

  FoodRemoteSource({
    required this.firebaseStorage,
    required this.coreFirebaseAuth,
  }) {
    collection = firestore.FirebaseFirestore.instance.collection('foods');
    foodsQuery = collection;
  }

  late firestore.CollectionReference collection;
  late firestore.Query foodsQuery;

  //convert form document to dart model
  FoodModel fromDocument(firestore.DocumentSnapshot documemt) =>
      FoodModel.fromJson({
        ...(documemt.data() as Map).cast<String, dynamic>(), //deconstructuring
        ...{'id': documemt.id}
      });

  Future<List<FoodModel>> fetchNext(FoodModel current) async {
    final firestore.DocumentSnapshot lastItem =
        await collection.doc(current.id).get();
    foodsQuery = collection.limit(20).startAfterDocument(lastItem);
    return (await foodsQuery.get())
        .docs
        .map((doc) => fromDocument(doc))
        .toList();
  }

  Future<List<FoodModel>> fetchPrevious(FoodModel current) async {
    final firestore.DocumentSnapshot lastItem =
        await collection.doc(current.id).get();
    foodsQuery = collection.limit(20).endBeforeDocument(lastItem);
    return (await foodsQuery.get())
        .docs
        .map((doc) => fromDocument(doc))
        .toList();
  }

  Future<bool> createItem(FoodModel obj) async {
    late firestore.DocumentReference docRef;
    //get current user
    final currentUser = await coreFirebaseAuth.currentUser;
    //Firebase equivalent of POST
    final itemId = collection.doc().id; //auto-generate an id

    if (obj.imageUrl != null && obj.imageUrl!.isNotEmpty) {
      //upload the image on foodModel to storage to get link
      final imageLink = await firebaseStorage.uploadFile(
        storagePath: '$foodStoragePath/${currentUser!.id}',
        fileId: itemId,
        filePath: obj.imageUrl ?? '',
      );
      await collection.doc().set(obj.copyWith(imageLink: imageLink).toJson());
      return true;
    }

    // final newObj = obj.copyWith(newId: itemId);
    await collection.doc(itemId).set(obj.toJson());
    // docRef = collection.doc(itemId);

    //Return a reloaded document incase it had any
    //fields that were resolved on the server
    // return fromDocument(await docRef.get());
    return true;
  }

  Future<FoodModel> updateItem(FoodModel obj) async {
    late firestore.DocumentReference docRef;
    //if the object already exists, do the Firebase equivalent of
    //PUT/PATCH
    await collection.doc(obj.id).update(obj.toJson());
    docRef = collection.doc(obj.id);
    //Return a reloaded document incase it had any
    //fields that were resolved on the server
    return fromDocument(await docRef.get());
  }

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

    Stream<firestore.QuerySnapshot> snapshots =
        query.orderBy('lastUpdated').snapshots();
    yield* snapshots.map<List<FoodModel>>(
      (firestore.QuerySnapshot snapshot) =>
          snapshot.docs.map<FoodModel>(fromDocument).toList(),
    );
  }

  Future<bool> deleteFoods(FoodModel food) async {
    try {
      await collection.doc(food.id!).delete();
      if (food.imageUrl != null && food.imageUrl!.isNotEmpty) {
        firebaseStorage.deleteFile(
            fileId: food.id!, storagePath: foodStoragePath);
      }
      return true;
    } catch (e) {
      throw Exception(e);
    }
  }

  //this function get single item.
  Future<FoodModel?> viewFood(String id) async {
    firestore.DocumentSnapshot snapshot = await collection.doc(id).get();
    if (snapshot.data() != null) {
      return fromDocument(snapshot);
    } else {
      return null;
    }
  }
}
