import 'package:geoflutterfire2/geoflutterfire2.dart';

class UserModel {
  String uid;
  String name;
  String email;
  String phoneNo;
  String address;
  String type;
  String imageUrl;
  String cnic;
  GeoFirePoint geoFirePoint;
  int createdAt;
  bool isApproved;
  bool isBlocked;

  UserModel({
    required this.uid,
    required this.name,
    required this.email,
    required this.phoneNo,
    required this.address,
    required this.type,
    required this.imageUrl,
    required this.cnic,
    required this.geoFirePoint,
    this.createdAt = 0,
    this.isApproved = false,
    this.isBlocked = false,
  });

  UserModel copyWith({
    String? uid,
    String? name,
    String? email,
    String? phoneNo,
    String? address,
    String? type,
    String? imageUrl,
    String? cnic,
    GeoFirePoint? geoFirePoint,
    int? createdAt,
    bool? isApproved,
    bool? isBlocked,
  }) {
    return UserModel(
      uid: uid ?? this.uid,
      name: name ?? this.name,
      email: email ?? this.email,
      phoneNo: phoneNo ?? this.phoneNo,
      address: address ?? this.address,
      type: type ?? this.type,
      imageUrl: imageUrl ?? this.imageUrl,
      cnic: cnic ?? this.cnic,
      geoFirePoint: geoFirePoint ?? this.geoFirePoint,
      createdAt: createdAt ?? this.createdAt,
      isApproved: isApproved ?? this.isApproved,
      isBlocked: isBlocked ?? this.isBlocked,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
      'name': name,
      'email': email,
      'phoneNo': phoneNo,
      'address': address,
      'type': type,
      'imageUrl': imageUrl,
      'cnic': cnic,
      'geoFirePoint': geoFirePoint.data,
      'createdAt': createdAt,
      'isApproved': isApproved,
      'isBlocked': isBlocked,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'] as String,
      name: map['name'] as String,
      email: map['email'] as String,
      phoneNo: map['phoneNo'] as String,
      address: map['address'] as String,
      type: map['type'] as String,
      imageUrl: map['imageUrl'] as String,
      cnic: map['cnic'] as String,
      geoFirePoint: GeoFirePoint(
        map['geoFirePoint']['geopoint'].latitude,
        map['geoFirePoint']['geopoint'].longitude,
      ),
      createdAt: map['createdAt'] ?? 0,
      isApproved: map['isApproved'] ?? false,
      isBlocked: map['isBlocked'] ?? false,
    );
  }
}
