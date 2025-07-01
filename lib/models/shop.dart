import 'package:flutter/material.dart';
import 'package:mini_ecommerce_app/models/product.dart';

class Shop extends ChangeNotifier {
  //products for sale
  final List<Product> _shop = [
    //product 1
    Product(
        name: "Penne  Pasta",
        price: 99.99,
        description: "Get spicy penne pasta. A classic traditional Italian cooking.",
        imagePath: 'assets/santa.jpg'),
    //product 2
    Product(
        name: "Filet Mignon ",
        price: 99.99,
        description: "Luxurious beef. With satisfying flavor that is satisfying yet delicate, complemented by an unusually smooth texture and tenderness.",
        imagePath: 'assets/snowman.jpg'),
    //product 3
    Product(
        name: "Penne  Pasta",
        price: 99.99,
        description: "Get spicy penne pasta. A classic traditional Italian cooking.",
        imagePath: 'assets/santa.jpg'),
    //product 4
    Product(
        name: "Filet Mignon",
        price: 99.99,
        description: "Luxurious beef. With satisfying flavor that is satisfying yet delicate, complemented by an unusually smooth texture and tenderness.",
        imagePath: 'assets/snowman.jpg'),
    Product(
        name: "Pasta",
        price: 99.99,
        description: "Get spicy penne pasta. A classic traditional Italian cooking.",
        imagePath: 'assets/santa.jpg'),
    //product 2
    Product(
        name: "Filet ",
        price: 99.99,
        description: "Luxurious beef. With satisfying flavor that is satisfying yet delicate, complemented by an unusually smooth texture and tenderness.",
        imagePath: 'assets/snowman.jpg'),
    //product 3
    Product(
        name: "Penne_Pasta",
        price: 99.99,
        description: "Get spicy penne pasta. A classic traditional Italian cooking.",
        imagePath: 'assets/santa.jpg'),
    //product 4
    Product(
        name: "Filet_Mignon",
        price: 99.99,
        description: "Luxurious beef. With satisfying flavor that is satisfying yet delicate, complemented by an unusually smooth texture and tenderness.",
        imagePath: 'assets/snowman.jpg'),
        //To do: more products
  ];
 
  //user cart
  final List<Product> _cart = [];

  //get product list
  List<Product> get shop => _shop;

//get user cart
  List<Product> get cart => _cart;

  //add item to cart
  void addToCart(Product item) {
    _cart.add(item);
    notifyListeners();
  }

  //remove item from cart
  void removeFromCart(Product item) {
    _cart.remove(item);
    notifyListeners();
  }
}
