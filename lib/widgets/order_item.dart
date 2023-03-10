import 'dart:math';

import 'package:flutter/material.dart';
import 'package:shop_app/providers/oders.dart';
import 'package:intl/intl.dart';

class OrderItemTile extends StatefulWidget {
  const OrderItemTile(this.order, {super.key});

  final OrderItem order;

  @override
  State<OrderItemTile> createState() => _OrderItemTileState();
}

class _OrderItemTileState extends State<OrderItemTile> {
  var _isExpanded = false;
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10),
      child: Column(
        children: [
          ListTile(
            title: Text('\$${widget.order.amount}'),
            subtitle: Text(
              DateFormat('dd MM yyyy').format(widget.order.dateTime),
            ),
            trailing: IconButton(
              icon: Icon(!_isExpanded ? Icons.expand_more : Icons.expand_less),
              onPressed: () {
                setState(() {
                  _isExpanded = !_isExpanded;
                });
              },
            ),
          ),
          if (_isExpanded)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: min(widget.order.products.length * 20.0 + 10, 180),
                child: ListView.builder(
                  itemCount: widget.order.products.length,
                  itemBuilder: (context, index) => Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.order.products[index].title,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '\$${widget.order.products[index].quantity}x \$${widget.order.products[index].price}',
                        style: const TextStyle(
                          fontSize: 18,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
        ],
      ),
    );
  }
}
