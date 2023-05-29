

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:food_fusion/models/order_model.dart';
import 'package:food_fusion/repos/order_repo.dart';
import 'package:food_fusion/view/shopkeeper/orders/widgets/shop_order_detail_widget.dart';

class ShowOrderAcceptedTab extends StatefulWidget {
  const ShowOrderAcceptedTab({super.key});

  @override
  State<ShowOrderAcceptedTab> createState() => _ShowOrderAcceptedTabState();
}

class _ShowOrderAcceptedTabState extends State<ShowOrderAcceptedTab> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<List<OrderModel>>(
        stream: OrderRepo.instance.getShopAcceptedOrders(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return  Center(child: Text(snapshot.error.toString()));
          }
          if (snapshot.data!.isEmpty) {
            return const Center(child: Text('No orders found'));
          }
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {

              final order = snapshot.data![index];
              log(order.toString());
              return ShopOrderDetailView(order: order);
            },
          );
        },
      ),
    );
  }
}