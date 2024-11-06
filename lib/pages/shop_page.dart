import 'package:flutter/material.dart';
import 'package:mini_ecommerce_app/components/my_drawer.dart';
import 'package:mini_ecommerce_app/components/my_product_tile.dart';
import 'package:provider/provider.dart';

import '../models/shop.dart';
import 'product_details_page.dart';

class ShopPage extends StatelessWidget {
  const ShopPage({super.key});

  @override
  Widget build(BuildContext context) {
    //navigate  to product details page

    //access products in shop
    final products = context.watch<Shop>().shop;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Shop Page"),
        actions: [
          //go to cart button
          IconButton(
            onPressed: () => Navigator.pushNamed(context, '/cart_page'),
            icon: const Icon(Icons.shopping_cart_outlined),
          ),
        ],
      ),
      drawer: const MyDrawer(),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: ListView(
        children: [
          const SizedBox(height: 25),
          //shop title
          Center(
            child: Text(
              'Pick from a selected list of premium products',
              style: TextStyle(
                  color: Theme.of(context).colorScheme.inversePrimary),
            ),
          ),

          //To Do: shop subtitle

          //product list

          SizedBox(
            height: 550,
            child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: products.length,
              padding: const EdgeInsets.all(15),
              itemBuilder: (context, index) {
                //get each product from shop
                //final product = products[index];

                //return as a product tile Ui
                return MyProductTile(
                  product: products[index],
                  //to remove on Tap here!!!!!
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProductDetailsPage(
                          product: products[index],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
         const SizedBox(
            height: 15,
          ),
          const Text("grid view"),
          const SizedBox(
            height: 15,
          ),
          // GridView.builder(
          //     scrollDirection: Axis.vertical,
          //     shrinkWrap: true,
          //     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          //       crossAxisCount: 2,
          //       mainAxisSpacing: 18.0,
          //       crossAxisSpacing: 8.0,
          //     ),
          //     itemCount: products.length,
          //     padding: EdgeInsets.all(18.0),
          //     itemBuilder: (context, index) {
          //       return MyProductTile(
          //         product: products[index],
          //       );
          //     },
          //   ),

          // SizedBox(
          //   child: Center(
          //     child: ListView.builder(
          //         shrinkWrap: true,
          //         scrollDirection: Axis.horizontal,
          //         itemCount: products.length,
          //         padding: const EdgeInsets.all(15),
          //         itemBuilder: (context, index) {
          //           return MyProductTile(product: products[index]);
          //         }),
          //   ),
          // ),
        ],
      ),
    );
  }
}
