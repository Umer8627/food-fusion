import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:food_fusion/models/order_model.dart';
import 'package:food_fusion/repos/order_repo.dart';
import 'package:food_fusion/view/rider/orders/widgets/rider_order_details_widget.dart';
import 'package:food_fusion/view/user/order/widgets/order_details_widget.dart';


class UserArrivedOrderTab extends StatefulWidget {
  const UserArrivedOrderTab({super.key});

  @override
  State<UserArrivedOrderTab> createState() => _UserArrivedOrderTabState();
}

class _UserArrivedOrderTabState extends State<UserArrivedOrderTab> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<List<OrderModel>>(
        stream: OrderRepo.instance.getUserArrivedOrder(),
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
              return OrderDetailsWidget(order: order);
            },
          );
        },
      ),
    );
  }
}