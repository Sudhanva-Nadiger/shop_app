import 'package:flutter/material.dart';
import 'package:shop_app/providers/oders.dart';
import 'package:intl/intl.dart';

class OrderItemTile extends StatelessWidget {
  const OrderItemTile(this.order, {super.key});

  final OrderItem order;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10),
      child: Column(
        children: [
          ListTile(
            title: Text('\$${order.amount}'),
            subtitle: Text(
              DateFormat('dd MM yyyy').format(order.dateTime),
            ),
            trailing: IconButton(
              icon: const Icon(Icons.expand_more),
              onPressed: () {},
            ),
          )
        ],
      ),
    );
  }
}
