// file: lib/pages/shop_page.dart
// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:mini_ecommerce_app/components/my_drawer.dart';
import 'package:mini_ecommerce_app/components/my_product_tile.dart';
import 'package:provider/provider.dart';

import '../components/my_app_bar.dart';
import '../models/shop.dart';
import '../models/product.dart';
import 'product_details_page.dart';

class ShopPage extends StatelessWidget {
  const ShopPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Product> products = context.watch<Shop>().shop;
    // Assuming you might have a separate list for featured products
    // For this example, we'll just use the first few products from the main list.
    final List<Product> featuredProducts = products.take(5).toList();

    return Scaffold(
      appBar: MyAppBar( // Use your custom AppBar
        title: "Minimal Shop",
        // You can add other actions if needed:
        // actions: [
        //   IconButton(icon: Icon(Icons.search), onPressed: () {}),
        // ],
      ),
      drawer: const MyDrawer(),
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: CustomScrollView(
        slivers: <Widget>[
          // 1. Initial Title
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(top: 40.0, bottom: 20.0),
              child: Center(
                child: ShaderMask(
                  blendMode: BlendMode.srcIn, // Apply shader to the text
                  shaderCallback: (Rect bounds) {
                    return LinearGradient( // Define your gradient
                      colors: [
                        Theme.of(context).colorScheme.primary,
                        Theme.of(context).colorScheme.tertiary, // Or another color from your scheme
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ).createShader(bounds);
                  },
                  child: Text(
                    'Explore Premium Choices',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w700, // Bold
                      // The color here is effectively ignored due to ShaderMask,
                      // but it's good practice to set a base color.
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                ),
              ),
            ),
          ),

          // 2. HORIZONTAL SCROLLING SECTION (e.g., Featured Products)
          SliverToBoxAdapter(
            child: Padding( // Optional: Add a title for this section
              padding: const EdgeInsets.only(top: 20.0, left: 18.0, bottom: 10.0),
              child: Text(
                "Featured Products",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.inversePrimary,
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              height: 230, // CRUCIAL: Define a fixed height for the horizontal list container
              // Adjust this based on the height of your MyProductTile + padding
              child: ListView.builder(
                scrollDirection: Axis.horizontal, // Enable horizontal scrolling
                itemCount: featuredProducts.length, // Use your horizontal list data
                padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0), // Padding for items
                itemBuilder: (context, index) {
                  final product = featuredProducts[index]; // Get product from horizontal list
                  // You might want a different tile or styling for horizontal items
                  // For simplicity, we reuse MyProductTile
                  return Container( // Optional: Add a width to control tile size in horizontal list
                    width: 170, // Adjust as needed
                    margin: EdgeInsets.only(right:10), // Spacing between horizontal items
                    child: MyProductTile(
                      product: product,
                    ),
                  );
                },
              ),
            ),
          ),
          // END OF HORIZONTAL SCROLLING SECTION

          // 3. Grid View Title
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(top: 25.0, left: 18.0, right: 18.0, bottom: 15.0),
              child: Text(
                "All Products", // Changed title slightly
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.inversePrimary,
                ),
              ),
            ),
          ),

          // 4. Product Grid (Vertical Scrolling as part of CustomScrollView)
          SliverPadding(
            padding: const EdgeInsets.all(10.0),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 10.0,
                crossAxisSpacing: 10.0,
                childAspectRatio: 0.65, // Adjust this
              ),
              delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                  final product = products[index]; // Use the main products list
                  return MyProductTile(
                    product: product,
                  );
                },
                childCount: products.length,
              ),
            ),
          ),

          const SliverToBoxAdapter(
            child: SizedBox(height: 25),
          ),
        ],
      ),
    );
  }
}