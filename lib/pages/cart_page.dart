// lib/pages/cart_page.dart
// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:mini_ecommerce_app/components/my_button.dart'; // Assuming MyButton is styled well
import 'package:provider/provider.dart';
import '../models/product.dart';
import '../models/shop.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  void removeItemFromCart(BuildContext context, Product product) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)), // Modern dialog shape
        title: Text("Remove Item", style: TextStyle(fontWeight: FontWeight.bold)),
        content: Text("Are you sure you want to remove ${product.name} from your cart?"),
        actionsAlignment: MainAxisAlignment.spaceAround,
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("CANCEL", style: TextStyle(color: Theme.of(context).colorScheme.onSurfaceVariant)),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              context.read<Shop>().removeFromCart(product);
            },
            child: Text("REMOVE", style: TextStyle(color: Theme.of(context).colorScheme.error)),
          ),
        ],
      ),
    );
  }

  void payButtonPressed(BuildContext context) {
    // For a real app, this would navigate to a checkout flow or integrate with a payment SDK
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text("Checkout"),
        content: Text(
            "This is where the payment process would begin. For now, we'll simulate a successful step."),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("OK"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<Shop>().cart;
    final colorScheme = Theme.of(context).colorScheme;

    // Calculate total price
    double totalPrice = cart.fold(0, (sum, item) => sum + item.price);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent, // Minimalist app bar
        elevation: 0,
        foregroundColor: colorScheme.onSurface, // Adapts to theme
        title: Text(
          "My Cart",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
        ),
        centerTitle: true, // Common for modern look
      ),
      backgroundColor: colorScheme.surface,
      body: Column(
        children: [
          Expanded(
            child: cart.isEmpty
                ? _buildEmptyCartView(context)
                : _buildCartListView(context, cart, colorScheme),
          ),
          _buildCheckoutSection(context, totalPrice, colorScheme),
        ],
      ),
    );
  }

  Widget _buildEmptyCartView(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.shopping_bag_outlined,
            size: 80,
            color: colorScheme.onSurfaceVariant.withOpacity(0.5),
          ),
          SizedBox(height: 20),
          Text(
            "Your Cart is Empty",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: colorScheme.onSurface,
            ),
          ),
          SizedBox(height: 10),
          Text(
            "Looks like you haven't added anything yet.",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              color: colorScheme.onSurfaceVariant,
            ),
          ),
          SizedBox(height: 30),
          ElevatedButton( // More prominent than a TextButton for this action
            style: ElevatedButton.styleFrom(
              backgroundColor: colorScheme.primary,
              foregroundColor: colorScheme.onPrimary,
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12),
              textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            onPressed: () {
              // Navigate back to shop page or home
              if (Navigator.canPop(context)) {
                Navigator.pop(context); // Go back to the previous screen (likely shop)
              } else {
                // Fallback if there's no screen to pop, navigate to a defined shop route
                // Navigator.pushReplacementNamed(context, '/shop_page');
              }
            },
            child: Text("START SHOPPING",
            style: TextStyle(color: colorScheme.onSurface),),
          )
        ],
      ),
    );
  }

  Widget _buildCartListView(BuildContext context, List<Product> cart, ColorScheme colorScheme) {
    return ListView.separated(
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
      itemCount: cart.length,
      separatorBuilder: (context, index) => SizedBox(height: 16), // Spacing between items
      itemBuilder: (context, index) {
        final item = cart[index];
        return Container(
          decoration: BoxDecoration(
            color: colorScheme.surfaceVariant.withOpacity(0.5), // Subtle background for item
            borderRadius: BorderRadius.circular(12.0),
          ),
          padding: EdgeInsets.all(12.0),
          child: Row(
            children: [
              // Product Image
              ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.asset(
                  item.imagePath,
                  width: 70,
                  height: 70,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) { // Fallback for missing image
                    return Container(
                      width: 70,
                      height: 70,
                      color: colorScheme.secondaryContainer,
                      child: Icon(Icons.image_not_supported_outlined, color: colorScheme.onSecondaryContainer),
                    );
                  },
                ),
              ),
              SizedBox(width: 16),
              // Product Details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.name,
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                        color: colorScheme.onSurface,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 4),
                    Text(
                      '\$${item.price.toStringAsFixed(2)}',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: colorScheme.onSurface,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 10),
              // Remove Button
              IconButton(
                icon: Icon(Icons.delete_outline, color: colorScheme.error.withOpacity(0.8)),
                onPressed: () => removeItemFromCart(context, item),
                tooltip: "Remove item",
                splashRadius: 24, // Control splash effect size
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildCheckoutSection(BuildContext context, double totalPrice, ColorScheme colorScheme) {
    return Container(
      padding: EdgeInsets.only(left: 24, right: 24, top: 20, bottom: MediaQuery.of(context).padding.bottom + 20), // Handles notch
      decoration: BoxDecoration(
        color: colorScheme.surface, // Or colorScheme.surface for seamless look
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: Offset(0, -5), // Shadow upwards
          )
        ],
        // borderRadius: BorderRadius.only( // Optional: if you want a distinct panel
        //   topLeft: Radius.circular(24),
        //   topRight: Radius.circular(24),
        // ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Total:",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
              Text(
                '\$${totalPrice.toStringAsFixed(2)}',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: colorScheme.onSurface,
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          MyButton( // Assuming MyButton is already styled well for a modern look
            onTap: totalPrice > 0 ? () => payButtonPressed(context) : null, // Disable if cart is empty
            child: Padding( // Add padding inside the button for better text display
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: Text(
                "PROCEED TO CHECKOUT",
                style: TextStyle(
                  // Ensure MyButton's child TextStyle is appropriate
                  // For example:
                  fontWeight: FontWeight.bold,
                   fontSize: 16,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}