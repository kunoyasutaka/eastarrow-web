import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class StorageRepository {
  final _storage = firebase_storage.FirebaseStorage.instance;

  Future<String> uploadImage(String path, Uint8List data) async {
    final metadata =
        firebase_storage.SettableMetadata(contentType: 'image/png');
    final snapshot = await _storage.ref(path).putData(data, metadata);
    return snapshot.ref.getDownloadURL();
  }

  Future<void> deleteImage(String path) async {
    try {
      await _storage.ref(path).delete();
    } catch (e) {
      print(e);
    }
  }
}
