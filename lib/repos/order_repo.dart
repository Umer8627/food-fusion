import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../enums/order_enums.dart';
import '../models/order_model.dart';

class OrderRepo{
  static final instance = OrderRepo();
  final firestore = FirebaseFirestore.instance;
  Future<void> addOrder(OrderModel orderModel)async{
    String docId = DateTime.now().millisecondsSinceEpoch.toString(); 
    await firestore.collection("orders").doc(docId).set(orderModel.copyWith(orderId: docId).toMap());
  }
  

  Stream<List<OrderModel>> getUserPendingOrders(){
    return firestore.collection("orders").where("userId", isEqualTo: FirebaseAuth.instance.currentUser!.uid).where("orderEnum", isEqualTo: OrderEnum.pending.index).snapshots().map((event) => event.docs.map((e) => OrderModel.fromMap(e.data())).toList());
  }

}