class OfferModel {
  final String reqId;
  final String docId;
  final String price;
  final String handyManId;
  final bool isAccepted;
  final bool isRejected;
  final int createdAt;

  OfferModel({
    required this.reqId,
    required this.docId,
    required this.price,
    required this.handyManId,
    this.isAccepted = false,
    this.isRejected = false,
    required this.createdAt,
  });

  OfferModel copyWith({
    String? reqId,
    String? docId,
    String? price,
    String? handyManId,
    bool? isAccepted,
    bool? isRejected,
    int? createdAt,
  }) {
    return OfferModel(
      reqId: reqId ?? this.reqId,
      docId: docId ?? this.docId,
      price: price ?? this.price,
      handyManId: handyManId ?? this.handyManId,
      isAccepted: isAccepted ?? this.isAccepted,
      isRejected: isRejected ?? this.isRejected,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'reqId': reqId,
      'docId': docId,
      'price': price,
      'handyManId': handyManId,
      'isAccepted': isAccepted,
      'isRejected': isRejected,
      'createdAt': createdAt,
    };
  }

  factory OfferModel.fromMap(Map<String, dynamic> map) {
    return OfferModel(
      reqId: map['reqId'] as String,
      docId: map['docId'] as String,
      price: map['price'] as String,
      handyManId: map['handyManId'] as String,
      isAccepted: map['isAccepted'] as bool,
      isRejected: map['isRejected'] as bool,
      createdAt: map['createdAt'] as int,
    );
  }
}
