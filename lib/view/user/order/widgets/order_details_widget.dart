import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:food_fusion/constants/color_constant.dart';
import 'package:food_fusion/enums/order_enums.dart';
import 'package:food_fusion/models/order_model.dart';
import 'package:food_fusion/models/user_model.dart';
import 'package:food_fusion/view/widgets/show_status_widget.dart';
import '../../../../repos/user_repo.dart';

class OrderDetailsWidget extends StatelessWidget {
  final OrderModel order;

  const OrderDetailsWidget({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      color: backgroundColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                const Icon(FontAwesomeIcons.hashtag, size: 16),
                const SizedBox(width: 16),
                Text(
                  order.orderId,
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall
                      ?.copyWith(fontSize: 13, fontWeight: FontWeight.w700),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          FutureBuilder<UserModel>(
              future: UserRepo.instance.getUserById(order.shopId),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const SizedBox(height: 20);
                }
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          const Icon(FontAwesomeIcons.shop, size: 16),
                          const SizedBox(width: 16),
                          Text(
                            snapshot.data?.shopName ?? " ",
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.copyWith(
                                    fontSize: 13, fontWeight: FontWeight.w700),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          const Icon(FontAwesomeIcons.mapMarkerAlt, size: 16),
                          const SizedBox(width: 16),
                          Flexible(
                            child: Text(
                              'Address: ${snapshot.data?.address ?? " "}',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w700),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              }),
          const SizedBox(height: 10),
          Padding(
             padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Align(
                alignment: Alignment.centerRight,
                child: ShowStatusWidget(
                    color: order.orderEnum.getColor(), text: 'Pending')),
          ),
          const SizedBox(height: 8),
          if (order.riderId.isNotEmpty)
            FutureBuilder<UserModel>(
                future: UserRepo.instance.getUserById(order.riderId),
                builder: (_, snap) {
                  if (snap.connectionState == ConnectionState.waiting) {
                    return const SizedBox(height: 10);
                  }
                  return Row(
                    children: [
                      CircleAvatar(
                        backgroundImage:
                            NetworkImage(snap.data?.imageUrl ?? ''),
                        radius: 20,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Rider: ${snap.data?.name ?? ''}',
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ],
                  );
                }),
          order.riderId.isNotEmpty?const SizedBox(height: 16):const SizedBox.shrink(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Text(
              'Items:',
              style: Theme.of(context)
                  .textTheme
                  .bodySmall
                  ?.copyWith(fontSize: 13, fontWeight: FontWeight.w700),
            ),
          ),
          const SizedBox(height: 8),
          ListView.builder(
            shrinkWrap: true,
            itemCount: order.items?.length,
            itemBuilder: (context, index) {
              final item = order.items![index];
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Card(
                  elevation: 6,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 21,
                      backgroundImage: NetworkImage(
                        item.image,
                      ),
                    ),
                    title: Text(
                      item.name,
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall
                          ?.copyWith(fontSize: 13, fontWeight: FontWeight.w700),
                    ),
                    // subtitle: Text(item.description),
                    trailing: Text('${item.quantity}x ${item.price}'),
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 2,
                  offset:const Offset(0, -1),
                ),
              ],
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total Payable Amount:',
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall
                          ?.copyWith(fontSize: 15, fontWeight: FontWeight.w700),
                    ),
                    Text(
                      '${order.totalAmount} Rs',
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall
                          ?.copyWith(fontSize: 13, fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Order Date:',
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall
                          ?.copyWith(fontSize: 15, fontWeight: FontWeight.w700),
                    ),
                    Text(
                      order.formattedOrderPlacedDate,
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall
                          ?.copyWith(fontSize: 13, fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
