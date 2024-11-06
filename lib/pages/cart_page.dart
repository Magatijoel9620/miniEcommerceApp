import 'package:flutter/material.dart';
import 'package:mini_ecommerce_app/components/my_button.dart';
import 'package:provider/provider.dart';
import '../models/product.dart';
import '../models/shop.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

//remove item from cart method
  void removeItemFromCart(BuildContext context, Product product) {
    //show dialog to remove item from your cart

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: const Text("Remove this item to your cart?"),
        actions: [
          //cancel button
          MaterialButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("cancel"),
          ),
          //yes button
          MaterialButton(
            onPressed: () {
              //pop dialog box
              Navigator.pop(context);
              //add to cart
              context.read<Shop>().removeFromCart(product);
            },
            child: const Text("yes"),
          ),
        ],
      ),
    );
  }

  //user pressed pay button
  void payButtonPressed(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => const AlertDialog(
              content: Text(
                  "User wants to pay! Connect This app to your payment backed"),
            ));
  }

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<Shop>().cart;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Cart Page"),
      ),
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Column(
        children: [
          //Cart list
          Expanded(
            child: cart.isEmpty
                ? const Center(
                    child: Text("Your cart is empty.."),
                  )
                : ListView.builder(
                    itemCount: cart.length,
                    itemBuilder: (context, index) {
                      //get individual item in cart
                      final item = cart[index];
                      //return as a cart tile ui
                      return ListTile(
                        title: Text(item.name),
                        subtitle: Text(item.price.toStringAsFixed(2)),
                        trailing: IconButton(
                          icon: const Icon(Icons.remove),
                          onPressed: () => removeItemFromCart(context, item),
                        ),
                      );
                    },
                  ),
          ),
          //pay now
          Padding(
            padding: const EdgeInsets.all(50.0),
            child: MyButton(
                onTap: () => payButtonPressed(context), child: const Text("PAY NOW")),
          )
        ],
      ),
    );
  }
}
