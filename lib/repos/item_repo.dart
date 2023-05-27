import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:food_fusion/models/item_model.dart';

class ItemRepo {
  static final instance = ItemRepo();
  final firestore = FirebaseFirestore.instance;
  static final FirebaseStorage storage = FirebaseStorage.instance;
  final storageReference = storage.ref().child(storagePath);
  static const String storagePath = 'itemsImages';

  Future<void> addItem({required File img, required ItemModel model}) async {
    String docid = DateTime.now().toString();
    String itemImage = await uploadImages(
        image: img, name: model.name + DateTime.now().toString());
    await firestore
        .collection('items')
        .doc(docid)
        .set(model.copyWith(image: itemImage, itemId: docid).toMap());
  }

  Future<String> uploadImages({
    required File image,
    required String name,
  }) async {
    final resp = await storageReference.child('/$name.jpg').putFile(image);
    return resp.ref.getDownloadURL();
  }
}
