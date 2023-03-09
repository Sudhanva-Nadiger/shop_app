import 'package:flutter/material.dart';
import 'package:shop_app/widgets/products_grid.dart';

enum FilteredOptions { favorites, all }

class ProductOverviewScreen extends StatefulWidget {
  const ProductOverviewScreen({Key? key}) : super(key: key);

  @override
  State<ProductOverviewScreen> createState() => _ProductOverviewScreenState();
}

class _ProductOverviewScreenState extends State<ProductOverviewScreen> {
  bool showONlyFavorites = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(showONlyFavorites ? 'Favorites' : 'MyShop'),
        actions: [
          PopupMenuButton(
            onSelected: (FilteredOptions val) {
              if (val == FilteredOptions.favorites) {
                showONlyFavorites = true;
              } else {
                showONlyFavorites = false;
              }
              setState(() {});
            },
            itemBuilder: (_) => const [
              PopupMenuItem(
                value: FilteredOptions.favorites,
                child: Text('Only Favorites'),
              ),
              PopupMenuItem(
                value: FilteredOptions.all,
                child: Text('Show All'),
              ),
            ],
            icon: const Icon(Icons.more_vert),
          ),
        ],
      ),
      body: ProducstGrid(showONlyFavorites),
    );
  }
}
