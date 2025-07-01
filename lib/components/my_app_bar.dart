// lib/components/my_app_bar.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:badges/badges.dart' as badges;
import '../models/shop.dart'; // Your Shop model

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions; // Allow passing other actions
  final bool showCartIcon;

  const MyAppBar({
    super.key,
    required this.title,
    this.actions,
    this.showCartIcon = true, // Default to true
  });

  @override
  Widget build(BuildContext context) {
    // Access the number of items in the cart for the badge
    // This is the key: get cartItemCount INSIDE the build method of this widget
    final int cartItemCount = showCartIcon ? context.watch<Shop>().cart.length : 0;

    List<Widget> effectiveActions = [];

    if (showCartIcon) {
      effectiveActions.add(
        Padding(
          padding: const EdgeInsets.only(right: 12.0, top: 8.0),
          child: badges.Badge(
            badgeContent: Text(
              cartItemCount.toString(),
              style: TextStyle(color: Colors.white, fontSize: 10),
            ),
            showBadge: cartItemCount > 0,
            badgeStyle: badges.BadgeStyle(
              badgeColor: Theme.of(context).colorScheme.primary,
            ),
            position: badges.BadgePosition.topEnd(top: -12, end: -10),
            child: IconButton(
              icon: Icon(
                Icons.shopping_cart_outlined,
                size: 26,
              ),
              tooltip: 'Open Cart',
              onPressed: () {
                Navigator.pushNamed(context, '/cart_page');
              },
            ),
          ),
        ),
      );
    }

    if (actions != null) {
      effectiveActions.addAll(actions!); // Add any other custom actions
    }

    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      foregroundColor: Theme.of(context).colorScheme.onSurface,
      title: Text(title),
      centerTitle: true,
      actions: effectiveActions.isNotEmpty ? effectiveActions : null,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight); // Standard AppBar height
}