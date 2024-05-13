import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reflectiq_designs/screens/e-restaurant/cart/cart.dart';
import 'cart_provider.dart';

class CartIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<CartProvider>(
      builder: (context, cartProvider, child) => IconButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => Cart(),
            ),
          );
        },
        icon: Badge(
          label: Text(
            cartProvider.getTotalQuantity().toString(),
            style: const TextStyle(color: Colors.white),
          ),
          child: const Icon(Icons.shopping_cart, color: Colors.deepOrange),
        ),
      ),
    );
  }
}
