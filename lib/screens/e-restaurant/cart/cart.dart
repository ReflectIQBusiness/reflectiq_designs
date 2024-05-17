import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:reflectiq_designs/screens/e-restaurant/cart/checkout_page.dart';
import 'package:reflectiq_designs/screens/e-restaurant/cart_provider.dart';
import 'package:reflectiq_designs/screens/e-restaurant/shimmer_arrows.dart';

class Cart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 44, 42, 42),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(
              vertical: 20,
              horizontal: 20,
            ),
            child: Text(
              'Your cart',
              style: TextStyle(
                color: Colors.white,
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: Consumer<CartProvider>(
              builder: (context, cartProvider, child) {
                final cart = cartProvider.cart;

                return cart.isEmpty
                    ? Center(
                        child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset('assets/cart.svg', width: 200, height: 200, color: Colors.white),
                          const Text('Your cart is empty', style: TextStyle(fontSize: 18, color: Colors.white)),
                        ],
                      ))
                    : ListView.builder(
                        itemCount: cart.length,
                        itemBuilder: (context, index) {
                          final item = cart[index];
                          return GestureDetector(
                            onTap: () {
                              // Define your action when an item is tapped here
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      backgroundColor: const Color.fromARGB(255, 44, 42, 42),
                                      elevation: 0,
                                      title: Text(item['name'],
                                          style: const TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          )),
                                      content: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          item['image'].contains('http')
                                              ? Image.network(
                                                  item['image'],
                                                  width: 200,
                                                  height: 200,
                                                )
                                              : Image.asset(
                                                  item['image'],
                                                  width: 200,
                                                  height: 200,
                                                ),
                                          const SizedBox(height: 10),
                                          if (item['size'] != null)
                                            Text('Size: ${item['size']}',
                                                style: const TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white,
                                                )),
                                          const Divider(
                                            color: Colors.grey,
                                          ),
                                          Text(
                                            '${item['description']}',
                                            style: const TextStyle(
                                              fontSize: 18,
                                              color: Colors.white,
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                        ],
                                      ),
                                      actions: [
                                        TextButton(
                                          style: TextButton.styleFrom(
                                            side: const BorderSide(color: Colors.deepOrange, width: 1),
                                          ),
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: const Text('Close', style: TextStyle(color: Colors.deepOrange)),
                                        ),
                                      ],
                                    );
                                  });
                            },
                            child: Dismissible(
                              key: Key(item['name']),
                              direction: DismissDirection.endToStart,
                              onDismissed: (direction) {
                                cartProvider.removeFromCart(item['name'], item['category'], size: item['size']);

                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('${item['name']} removed from cart'),
                                    duration: const Duration(seconds: 2),
                                  ),
                                );
                              },
                              background: Container(
                                color: Colors.red,
                                alignment: Alignment.centerRight,
                                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                                child: const Icon(Icons.delete, color: Colors.white),
                              ),
                              child: ListTile(
                                leading: item['image'].contains('http')
                                    ? Image.network(
                                        item['image'],
                                        width: 50,
                                        height: 50,
                                        fit: BoxFit.cover,
                                      )
                                    : Image.asset(
                                        item['image'],
                                        width: 50,
                                        height: 50,
                                        fit: BoxFit.cover,
                                      ),
                                title: Text(item['name'],
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    )),
                                subtitle: Text('Price: ${item['price'].toStringAsFixed(2)} MAD',
                                    style: const TextStyle(
                                      fontSize: 16,
                                      color: Colors.white,
                                    )),
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(
                                      icon: const Icon(Icons.remove_circle_outline, color: Colors.white),
                                      onPressed: () {
                                        if (item['quantity'] > 1) {
                                          cartProvider.updateQuantity(item['name'], item['category'], item['quantity'] - 1,
                                              size: item['size']);
                                        } else {
                                          cartProvider.removeFromCart(item['name'], item['category'], size: item['size']);
                                        }
                                      },
                                    ),
                                    Text(item['quantity'].toString(), style: const TextStyle(fontSize: 18, color: Colors.deepOrange)),
                                    IconButton(
                                      icon: const Icon(Icons.add_circle_outline, color: Colors.white),
                                      onPressed: () {
                                        //peint type of quantity
                                        print(item['quantity'].runtimeType);
                                        cartProvider.updateQuantity(item['name'], item['category'], item['quantity'] + 1,
                                            size: item['size']);
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.deepOrange,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Consumer<CartProvider>(
          builder: (context, cartProvider, child) {
            final totalPrice = cartProvider.getTotalPrice();
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Total: ${totalPrice.toStringAsFixed(2)} MAD',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    )),
                Consumer<CartProvider>(builder: (context, cartProvider, child) {
                  final cart = cartProvider.cart;
                  return (cart.isNotEmpty)
                      ? ElevatedButton(
                          onPressed: () {
                            //CheckoutPage
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => const CheckoutPage(),
                              ),
                            );
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(const Color.fromARGB(255, 44, 42, 42)),
                            padding: MaterialStateProperty.all(const EdgeInsets.symmetric(horizontal: 30, vertical: 15)),
                          ),
                          child: ThreeShimmerArrows(),
                        )
                      : const SizedBox(
                          height: 30,
                        );
                }),
              ],
            );
          },
        ),
      ),
    );
  }
}
