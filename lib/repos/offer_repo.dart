import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:food_fusion/models/offer_model.dart';
import 'package:food_fusion/models/request_model.dart';

class OfferRepo {
  static final instance = OfferRepo();
  final firestore = FirebaseFirestore.instance;

  Future<void> createOffer(
      RequestModel requestModel, OfferModel offerModel) async {
    String docId = DateTime.now().millisecondsSinceEpoch.toString();
    await firestore
        .collection('requests')
        .doc(requestModel.docId)
        .collection('offers')
        .doc(docId)
        .set(offerModel.copyWith(docId: docId).toMap());
  }

  Stream<OfferModel?> checkIfOfferExist({required RequestModel requestModel}) {
    return firestore
        .collection('requests')
        .doc(requestModel.docId)
        .collection('offers')
        .where('handyManId', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .snapshots()
        .map((snapshot) {
      if (snapshot.docs.isNotEmpty) {
        final data = snapshot.docs.first.data();
        return OfferModel.fromMap(data);
      } else {
        return null;
      }
    });
  }

  Stream<List<OfferModel>> getMyOffers({required RequestModel requestModel}) {
    return firestore
        .collection('requests')
        .doc(requestModel.docId)
        .collection('offers')
        .snapshots()
        .map((event) =>
            event.docs.map((e) => OfferModel.fromMap(e.data())).toList());
  }
}
