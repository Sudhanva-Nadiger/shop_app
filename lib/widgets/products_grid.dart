import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/products_provider.dart';
import 'package:shop_app/widgets/product_item.dart';

class ProducstGrid extends StatelessWidget {
  const ProducstGrid(
    this.showFavorites, {
    Key? key,
  }) : super(key: key);

  final bool showFavorites;

  @override
  Widget build(BuildContext context) {
    final productsProvider = Provider.of<Products>(context);
    final loadedProducts = !showFavorites
        ? productsProvider.items
        : productsProvider.favoriteItems;
    return GridView.builder(
      padding: const EdgeInsets.all(10),
      itemCount: loadedProducts.length,
      itemBuilder: ((context, index) {
        final product = loadedProducts[index];
        return ChangeNotifierProvider.value(
          value: product,
          child: const ProductItem(),
        );
      }),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
    );
  }
}
