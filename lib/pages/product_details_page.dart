import 'package:flutter/material.dart';
import 'package:mini_ecommerce_app/components/my_product_tile.dart';

import '../models/product.dart';

class ProductDetailsPage extends StatelessWidget {
  final Product product;
  const ProductDetailsPage({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(product.name),
      ),
      body: Center(
          child: MyProductTile(
        product: product,
      )),
    );
  }
}
