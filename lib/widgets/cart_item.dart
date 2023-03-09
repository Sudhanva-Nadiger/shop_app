import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/cart.dart';

class CartItemTile extends StatelessWidget {
  final String id;
  final String productId;
  final double price;
  final int quantity;
  final String title;

  const CartItemTile({
    super.key,
    required this.id,
    required this.productId,
    required this.price,
    required this.quantity,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(id),
      background: Container(
        color: Theme.of(context).errorColor,
        alignment: Alignment.centerRight,
        child: const Padding(
          padding: EdgeInsets.all(8.0),
          child: Icon(
            Icons.delete,
            size: 40,
            color: Colors.white,
          ),
        ),
      ),
      direction: DismissDirection.endToStart,
      onDismissed: ((_) {
        Provider.of<Cart>(context, listen: false).removeItem(productId);
      }),
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: ListTile(
            leading: CircleAvatar(
              child: FittedBox(
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Text('\$$price'),
                ),
              ),
            ),
            title: Text(title),
            subtitle: Text(
              'Total: \$${price * quantity}',
            ),
            trailing: Text(
              '$quantity x',
            ),
          ),
        ),
      ),
    );
  }
}
