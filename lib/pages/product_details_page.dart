import 'package:flutter/material.dart';
import 'package:mini_ecommerce_app/components/my_button.dart'; // Assuming you have a styled MyButton
import 'package:provider/provider.dart'; // For accessing Shop to add to cart
import '../models/product.dart';
import '../models/shop.dart'; // For accessing Shop

class ProductDetailsPage extends StatelessWidget {
  final Product product;

  const ProductDetailsPage({super.key, required this.product});

  // Method to add to cart (similar to the one in MyProductTile, but can be adapted)
  void addToCart(BuildContext context) {
    final shop = context.read<Shop>();
    showDialog<bool>(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
          title: Row(
            children: [
              Icon(Icons.shopping_cart_checkout_outlined, color: Theme.of(dialogContext).colorScheme.primary),
              const SizedBox(width: 10),
              const Text("Confirm Add"),
            ],
          ),
          content: Text(
            "Add \"${product.name}\" to your cart?",
            style: const TextStyle(fontSize: 16),
          ),
          actionsAlignment: MainAxisAlignment.spaceEvenly,
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(dialogContext).pop(false);
              },
              child: Text(
                "CANCEL",
                style: TextStyle(color: Theme.of(dialogContext).colorScheme.onSurfaceVariant),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(dialogContext).colorScheme.primary,
                foregroundColor: Theme.of(dialogContext).colorScheme.onPrimary,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
              ),
              onPressed: () {
                Navigator.of(dialogContext).pop(true);
                shop.addToCart(product);
              },
              child: const Padding(
                padding:  EdgeInsets.symmetric(horizontal: 8.0),
                child: Text("ADD TO CART"
                 ),
                ),
              ),

          ],
        );
      },
    ).then((confirmed) {
      if (confirmed == true) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("\"${product.name}\" added to your cart!"),
            duration: const Duration(seconds: 2),
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: colorScheme.surface, // Or colorScheme.background
      appBar: AppBar(
        backgroundColor: Colors.transparent, // Modern transparent app bar
        elevation: 0,
        foregroundColor: colorScheme.onSurface, // Adapts to theme (better than inversePrimary sometimes)
        title: Text(
          product.name,
          style: TextStyle(fontWeight: FontWeight.bold, color: colorScheme.onSurface),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView( // Allows content to scroll if it overflows
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch, // Make children stretch horizontally
          children: <Widget>[
            // Product Image Section
            Container(
              height: 300, // Adjust height as needed
              decoration: BoxDecoration(
                color: colorScheme.surfaceVariant.withOpacity(0.5), // Subtle background for image
                borderRadius: BorderRadius.circular(16.0),
              ),
              padding: const EdgeInsets.all(16.0),
              child: Hero( // Optional: For smooth transition if coming from a list
                tag: 'product_image_${product.name}', // Unique tag for Hero animation
                child: Image.asset(
                  product.imagePath,
                  fit: BoxFit.contain, // Show whole image
                  errorBuilder: (context, error, stackTrace) {
                    return Center(
                        child: Icon(Icons.broken_image, size: 60, color: colorScheme.outline));
                  },
                ),
              ),
            ),
            const SizedBox(height: 24.0),

            // Product Name (can be repeated here for emphasis or styled differently)
            Text(
              product.name,
              style: textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: colorScheme.onSurface,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12.0),

            // Product Price
            Center(
              child: Text(
                '\$${product.price.toStringAsFixed(2)}',
                style: textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: colorScheme.onSurface, // Use primary color for price
                ),
              ),
            ),
            const SizedBox(height: 24.0),

            // Product Description Section
            Text(
              "Description",
              style: textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
                color: colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 8.0),
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: colorScheme.surfaceVariant.withOpacity(0.3),
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Text(
                product.description,
                style: textTheme.bodyLarge?.copyWith(
                  color: colorScheme.onSurface.withOpacity(0.8),
                  height: 1.6, // Better line spacing for readability
                ),
              ),
            ),
            const SizedBox(height: 30.0),
          ],
        ),
      ),
      // Bottom Navigation Bar for "Add to Cart" button (more modern placement)
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(
          left: 20.0,
          right: 20.0,
          top: 10.0,
          bottom: MediaQuery.of(context).padding.bottom + 10.0, // Handles safe area
        ),
        child: MyButton(
          onTap: () => addToCart(context),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0), // Adjust padding for button text
            child: Text(
              "ADD TO CART",
              // Ensure MyButton's child TextStyle is appropriate
              // e.g., style: TextStyle(color: colorScheme.onPrimary, fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ),
        ),
      ),
    );
  }
}