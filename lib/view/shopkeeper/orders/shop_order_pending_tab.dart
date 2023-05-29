

import 'package:flutter/material.dart';
import 'package:food_fusion/models/order_model.dart';
import 'package:food_fusion/repos/order_repo.dart';
import 'package:food_fusion/view/shopkeeper/orders/widgets/shop_order_detail_widget.dart';

class ShopOrderPendingTab extends StatefulWidget {
  const ShopOrderPendingTab({super.key});

  @override
  State<ShopOrderPendingTab> createState() => _ShopOrderPendingTabState();
}

class _ShopOrderPendingTabState extends State<ShopOrderPendingTab> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<List<OrderModel>>(
        stream: OrderRepo.instance.getShopPendingOrders(),
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
              return ShopOrderDetailView(order: order);
            },
          );
        },
      ),
    );
  }
}