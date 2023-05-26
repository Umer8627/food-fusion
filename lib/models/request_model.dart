// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:geoflutterfire2/geoflutterfire2.dart';

class RequestModel {
  String uid;
  String docId;
  String price;
  int radius;
  String discription;
  String requestType;
  GeoFirePoint geoFirePoint;
  int createdAt;
  bool isApproved;
  bool isDeleted;
  String? handymanId;
  List<String> ignored;
  RequestModel({
    required this.uid,
    required this.docId,
    required this.price,
    required this.radius,
    required this.discription,
    required this.requestType,
    required this.geoFirePoint,
    required this.createdAt,
    required this.isApproved,
    required this.isDeleted,
    required this.ignored,
    this.handymanId,
  });

  RequestModel copyWith({
    String? uid,
    String? docId,
    String? price,
    int? radius,
    String? discription,
    String? requestType,
    int? dateTime,
    GeoFirePoint? geoFirePoint,
    int? createdAt,
    bool? isApproved,
    bool? isDeleted,
    String? handymanId,
    List<String>? ignored,
  }) {
    return RequestModel(
      uid: uid ?? this.uid,
      docId: docId ?? this.docId,
      price: price ?? this.price,
      radius: radius ?? this.radius,
      discription: discription ?? this.discription,
      requestType: requestType ?? this.requestType,
      geoFirePoint: geoFirePoint ?? this.geoFirePoint,
      createdAt: createdAt ?? this.createdAt,
      isApproved: isApproved ?? this.isApproved,
      isDeleted: isDeleted ?? this.isDeleted,
      handymanId: handymanId ?? this.handymanId,
      ignored: ignored ?? this.ignored,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
      'docId': docId,
      'price': price,
      'radius': radius,
      'discription': discription,
      'requestType': requestType,
      'geoFirePoint': geoFirePoint.data,
      'createdAt': createdAt,
      'isApproved': isApproved,
      'isDeleted': isDeleted,
      'handymanId': handymanId,
      'ignored': ignored,
    };
  }

  factory RequestModel.fromMap(Map<String, dynamic> map) {
    return RequestModel(
      uid: map['uid'] as String,
      docId: map['docId'] as String,
      price: map['price'] as String,
      radius: map['radius'] as int,
      discription: map['discription'] as String,
      requestType: map['requestType'] as String,
      geoFirePoint: GeoFirePoint(
        map['geoFirePoint']['geopoint'].latitude,
        map['geoFirePoint']['geopoint'].longitude,
      ),
      createdAt: map['createdAt'] as int,
      isApproved: map['isApproved'] as bool,
      isDeleted: map['isDeleted'] as bool,
      handymanId:
          map['handymanId'] != null ? map['handymanId'] as String : null,
      ignored: List<String>.from(map['ignored'] as List<dynamic>),
    );
  }
}
