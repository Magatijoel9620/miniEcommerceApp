// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/product.dart';
import '../models/shop.dart';
import '../pages/product_details_page.dart';

// Removed the ProductDetailsPage import as it's not directly used for overflow fixing
// but ensure it exists if your onTap needs it.

class MyProductTile extends StatelessWidget {
  final Product product;
  // final void Function()? onTap; // onTap is handled by GestureDetector directly now

  const MyProductTile({super.key, required this.product}); // Removed onTap from constructor
  void addToCart(BuildContext context, Product product) { // Pass product explicitly for clarity
    final shop = context.read<Shop>(); // Get shop instance once

    showDialog<bool>( // Generic type <bool> indicates what kind of value it might return
      context: context,
      barrierDismissible: true, // User can tap outside to dismiss (optional, default is true)
      builder: (BuildContext dialogContext) { // Use a different name for dialog's context
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0), // Modern rounded corners
          ),
          title: Row( // Optional: Add an icon to the title
            children: [
              Icon(Icons.shopping_cart_checkout_outlined, color: Theme.of(dialogContext).colorScheme.primary),
              SizedBox(width: 10),
              Text("Confirm Add"),
            ],
          ),
          content: Text(
            "Add \"${product.name}\" to your cart?", // Dynamic product name
            style: TextStyle(fontSize: 16),
          ),
          actionsAlignment: MainAxisAlignment.spaceEvenly, // Better spacing for actions
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(dialogContext).pop(false); // Dismiss dialog, return false (cancelled)
              },
              child: Text(
                "CANCEL",
                style: TextStyle(color: Theme.of(dialogContext).colorScheme.onSurfaceVariant),
              ),
            ),
            ElevatedButton( // Make the confirm action more prominent
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(dialogContext).colorScheme.primary,
                foregroundColor: Theme.of(dialogContext).colorScheme.onPrimary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              onPressed: () {
                Navigator.of(dialogContext).pop(true); // Dismiss dialog, return true (confirmed)
                shop.addToCart(product); // Add to cart after dialog is popped
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text("ADD TO CART", style: TextStyle(color: Theme.of(dialogContext).colorScheme.onSurfaceVariant),
                ),
              ),
            ),
          ],
        );
      },
    ).then((confirmed) {
      if (confirmed == true) {
        // Optional: Show a SnackBar or some other feedback after item is added
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("\"${product.name}\" added to your cart!"),
            duration: Duration(seconds: 2),
            behavior: SnackBarBehavior.floating, // Modern look for SnackBar
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          ),
        );
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () { // You can keep the original onTap logic if needed for navigation
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetailsPage( // Make sure ProductDetailsPage is imported
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
        margin: const EdgeInsets.all(8), // Slightly reduced margin
        padding: const EdgeInsets.all(16), // Slightly reduced padding
        // width: 300, // Avoid fixed width here; let the parent (GridView/ListView) decide
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween, // Good for vertical distribution
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top section (Image, Name, Description)
            Expanded( // Allow this section to take available vertical space and handle overflow
              child: SingleChildScrollView( // Allow content to scroll if it's too tall
                physics: NeverScrollableScrollPhysics(), // Disable if inside another scrollable like grid item
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min, // Take minimum space needed by children
                  children: [
                    AspectRatio(
                      aspectRatio: 1, // Keeps the image container square
                      child: Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.secondary,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        width: double.infinity, // Fill available width
                        padding: EdgeInsets.all(16), // Reduced padding
                        child: Image.asset(
                          product.imagePath,
                          fit: BoxFit.contain, // Ensures image fits without cropping
                        ),
                      ),
                    ),
                    const SizedBox(height: 12), // Reduced spacing
                    Text(
                      product.name,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18, // Slightly reduced font size
                      ),
                      maxLines: 2, // Limit product name to 2 lines
                      overflow: TextOverflow.ellipsis, // Add ellipsis if it overflows
                    ),
                    const SizedBox(height: 8), // Reduced spacing
                    Text(
                      product.description,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.inversePrimary,
                        fontSize: 13, // Slightly reduced font size
                      ),
                      maxLines: 3, // Limit description to 3 lines
                      overflow: TextOverflow.ellipsis, // Add ellipsis if it overflows
                    ),
                  ],
                ),
              ),
            ),

            // Bottom section (Price, Add to Cart button)
            // This part is kept separate from Expanded to ensure it's always visible at the bottom
            Padding(
              padding: const EdgeInsets.only(top: 12.0), // Add some space before the price row
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center, // Align items vertically in the center
                children: [
                  Flexible( // Allow text to shrink if button takes space
                    child: Text(
                      '\$${product.price.toStringAsFixed(2)}',
                      style: TextStyle( // Added style for consistency
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                      overflow: TextOverflow.ellipsis, // Handle potential price overflow
                      maxLines: 1,
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.secondary,
                      borderRadius: BorderRadius.circular(10), // Slightly smaller radius
                    ),
                    child: IconButton(
                      padding: EdgeInsets.all(8), // Adjust padding for the button icon
                      constraints: BoxConstraints(), // Removes default min size for IconButton
                      iconSize: 20, // Adjust icon size
                      onPressed: () => addToCart(context,product),
                      icon: const Icon(Icons.add),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}