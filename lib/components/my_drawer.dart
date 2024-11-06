// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:mini_ecommerce_app/components/my_list_tile.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.surface,
      child:
          Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Column(
          children: [
            //drawer_Header: logo
            DrawerHeader(
              child: Center(
                child: Icon(
                  Icons.shopping_bag,
                  size: 72,
                  color: Theme.of(context).colorScheme.inversePrimary,
                ),
              ),
            ),
            const SizedBox(height: 25),
            //shop tile
            MyListTile(
              text: "Shop",
              icon: Icons.home,
              onTap: () => Navigator.pop(context),
            ),

            //cart tile
            MyListTile(
              text: "Cart",
              icon: Icons.shopping_bag,
              onTap: () => {
                //pop drawer first
                Navigator.pop(context),
                //go to cart
                Navigator.pushNamed(context, '/cart_page')
              },
            ),
          ],
        ),

        //exit shop tile
        Padding(
          padding: const EdgeInsets.only(bottom: 25.0),
          child: MyListTile(
            text: "Exit",
            icon: Icons.logout,
            onTap: () => Navigator.pushNamedAndRemoveUntil(context, '/intro_page',  (route) => false),
          ),
        ),
      ]),
    );
  }
}
