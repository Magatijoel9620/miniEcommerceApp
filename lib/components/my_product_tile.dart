// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/product.dart';
import '../models/shop.dart';

import '../pages/product_details_page.dart';

class MyProductTile extends StatelessWidget {
  final Product product;
  final void Function()? onTap;
  const MyProductTile({super.key, required this.product, this.onTap});

//add to cart button pressed
  void addToCart(BuildContext context) {
    //show a dialog box to ask user to confirm to add to cart
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Text("Add this item to your cart?"),
        actions: [
          //cancel button
          MaterialButton(
            onPressed: () => Navigator.pop(context),
            child: Text("cancel"),
          ),
          //yes button
          MaterialButton(
            onPressed: () {
              //pop dialog box
              Navigator.pop(context);
              //add to cart
              context.read<Shop>().addToCart(product);
            },
            child: Text("yes"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    //final products = context.watch<Shop>().shop;

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetailsPage(
              product: product,
            ),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          borderRadius: BorderRadius.circular(12),
        ),
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(25),
        width: 300,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                //product image

                AspectRatio(
                  aspectRatio: 1,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.secondary,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    width: double.infinity,
                    padding: EdgeInsets.all(25),
                    child: Image.asset(
                      product.imagePath,
                    ),
                  ),
                ),
                const SizedBox(height: 25),
                //product name
                Text(
                  product.name,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                const SizedBox(height: 10),
                //product description
                Text(
                  product.description,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.inversePrimary,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 25),
            //product price + add to cart button
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                //product price
                Text('\$${product.price.toStringAsFixed(2)}'),

                //add to cart button
                Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.secondary,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: IconButton(
                    onPressed: () => addToCart(context),
                    icon: const Icon(Icons.add),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
