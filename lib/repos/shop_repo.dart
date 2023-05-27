import 'dart:developer';
import 'dart:math' show atan2, cos, pi, pow, sin, sqrt;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:food_fusion/models/user_model.dart';
import 'package:geoflutterfire2/geoflutterfire2.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ShopRepo {
  static final instance = ShopRepo();
  final firestore = FirebaseFirestore.instance;

  Future<List<UserModel>> getAllShops(UserModel userModel, int radius) async {
    final centerLatLng = LatLng(
        userModel.geoFirePoint.latitude, userModel.geoFirePoint.longitude);
    log(userModel.type);
    final querySnapshot = await firestore
        .collection('users')
        .where('type', isEqualTo: 'Shop Keeper')
        .get();

    final userModels = querySnapshot.docs
        .map((document) => UserModel.fromMap(document.data()))
        .where((request) {
      LatLng requestLatLng =
          LatLng(request.geoFirePoint.latitude, request.geoFirePoint.longitude);
      log(radius.toString());
      final rad = radius * 1000;
      final distance = calculateDistance(centerLatLng, requestLatLng);
      return distance <= rad;
    }).toList();

    return userModels;
  }

  void getAllUsersByGeoPackage(
      {required UserModel userModel, required int rad}) {
    try {
      final geo = GeoFlutterFire();
      final firestore = FirebaseFirestore.instance;
      GeoFirePoint center = geo.point(
          latitude: userModel.geoFirePoint.latitude,
          longitude: userModel.geoFirePoint.longitude);
      log(center.toString());

      var queryRef =
          firestore.collection('users').where('type', isEqualTo: 'Shop Keeper');
      var stream = geo.collection(collectionRef: queryRef).within(
          center: center,
          radius: rad.toDouble(),
          field: 'geoFirePoint',
          strictMode: true);
      stream.listen((event) {
        log(event.toString());
      });
    } catch (e) {
      log(e.toString());
    }
  }

  Stream<List<UserModel>> getAllRequest(UserModel userModel, int rad) {
    final centerLatLng = LatLng(
        userModel.geoFirePoint.latitude, userModel.geoFirePoint.longitude);
    log(userModel.type);
    return firestore
        .collection('users')
        .where('type', isEqualTo: 'Shop Keeper')
        .snapshots()
        .distinct()
        .map((event) =>
            event.docs.map((e) => UserModel.fromMap(e.data())).where((request) {
              LatLng requestLatLng = LatLng(request.geoFirePoint.latitude,
                  request.geoFirePoint.longitude);

              const radius = 1 * 1000;
              final distance = calculateDistance(centerLatLng, requestLatLng);
              return distance <= radius;
            }).toList());
  }

  double calculateDistance(LatLng center, LatLng request) {
    const double earthRadiusKm = 6371.0;

    double latDiff = degreesToRadians(request.latitude - center.latitude);
    double lngDiff = degreesToRadians(request.longitude - center.longitude);

    double a = pow(sin(latDiff / 2), 2) +
        cos(degreesToRadians(center.latitude)) *
            cos(degreesToRadians(request.latitude)) *
            pow(sin(lngDiff / 2), 2);
    double c = 2 * atan2(sqrt(a), sqrt(1 - a));
    return earthRadiusKm * c;
  }

  double degreesToRadians(double degrees) {
    return degrees * (pi / 180.0);
  }
}
