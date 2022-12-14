import 'dart:developer';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart' as storage;
import 'package:path_provider/path_provider.dart';

class FirebaseStorage<T> {
  FirebaseStorage() {
    storageRef = storage.FirebaseStorage.instance.ref();
  }
  late storage.Reference storageRef;

  //fn that upload to cloud bucket
  // and return the download url
  Future<String> uploadFile({
    required String storagePath,
    required String fileId,
    required String filePath,
    String? contentType,
  }) async {
    //create a storage location
    final ref = storageRef.child('$storagePath/$fileId');
    final file = File(filePath);
    //create file metadata to update
    // final newMetaData = storage.SettableMetadata(contentType: contentType);

    try {
      await ref.putFile(file);
      // await ref.updateMetadata(newMetaData); // update metadata properties
      return ref.getDownloadURL();
    } on storage.FirebaseException catch (error) {
      log('Failed to upload image $error');
      return '';
    }
  }

  Future<void> downloadFile({
    required String storagePath,
    required String fileId,
    required String filePath,
  }) async {
    //reference to the file on the cloud
    final ref = storageRef.child('$storagePath/$fileId');
    //path to download file
    final appDocDir = await getApplicationDocumentsDirectory();
    final filePath = "${appDocDir.absolute}/images/$fileId.jpg";
    final file = File(filePath);

    //trigger file download
    await ref.writeToFile(file);
  }

  Stream<storage.ListResult> getStoredItems({
    required storage.Reference ref,
  }) async* {
    String? pageToken;

    do {
      final listResult = await ref.list(storage.ListOptions(
        maxResults: 20,
        pageToken: pageToken,
      ));

      yield listResult;
      pageToken = listResult.nextPageToken;
    } while (pageToken != null);
  }

  Future<void> deleteFile({
    required String fileId,
    required String storagePath,
  }) async {
    //create a reference to the file to delete
    final ref = storageRef.child('$storagePath/$fileId');
    await ref.delete();
  }
}
