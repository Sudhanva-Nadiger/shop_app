import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/oders.dart';
import 'package:shop_app/widgets/app_drawer.dart';
import 'package:shop_app/widgets/order_item.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  static const routeName = '/orders';

  @override
  Widget build(BuildContext context) {
    final ordersData = Provider.of<Orders>(context);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Your Orders',
          ),
        ),
        body: ListView.builder(
          itemCount: ordersData.orders.length,
          itemBuilder: ((_, index) {
            return OrderItemTile(ordersData.orders[index]);
          }),
        ),
        drawer: const AppDrawer(),
      ),
    );
  }
}
