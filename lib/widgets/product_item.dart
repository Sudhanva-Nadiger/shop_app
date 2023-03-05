import 'package:flutter/material.dart';

class ProductItem extends StatelessWidget {
  const ProductItem(
      {required this.id, required this.title, required this.imageUrl, Key? key})
      : super(key: key);

  final String id;
  final String title;
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        footer: GridTileBar(
          leading: IconButton(
            icon: Icon(
              Icons.favorite,
              color: Theme.of(context).colorScheme.secondary,
            ),
            onPressed: () {},
          ),
          trailing: IconButton(
            icon: Icon(
              Icons.shopping_cart,
              color: Theme.of(context).colorScheme.secondary,
            ),
            onPressed: () {},
          ),
          backgroundColor: Colors.black87,
          title: Text(
            title,
            textAlign: TextAlign.center,
          ),
        ),
        child: Image.network(
          imageUrl,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
