import 'dart:math';
import 'package:circle_list/circle_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reflectiq_designs/screens/e-restaurant/cart_provider.dart';
import 'package:reflectiq_designs/screens/e-restaurant/cart_widget.dart';

class Pizza extends StatefulWidget {
  const Pizza({Key? key}) : super(key: key);

  @override
  _PizzaState createState() => _PizzaState();
}

class _PizzaState extends State<Pizza> {
  List<Map<String, dynamic>> pizzas = [
    {
      'name': 'Margherita',
      'basePrice': 12.99,
      'size': 'S',
      'quantity': 1,
      'description': 'This pizza is made with fresh tomatoes, mozzarella cheese, fresh basil, salt, and extra-virgin olive oil.',
      'isSelected': true,
      'image':
          'https://www.foodandwine.com/thmb/7A7CYdDEKJUUhNcLSrlZ5N8wbHo=/750x0/filters:no_upscale():max_bytes(150000):strip_icc():format(webp)/mozzarella-pizza-margherita-FT-RECIPE0621-11fa41ceb1a5465d9036a23da87dd3d4.jpg',
      'category': 'pizza',
    },
    {
      'name': 'Pepperoni',
      'basePrice': 14.99,
      'size': 'S',
      'quantity': 1,
      'description': 'This pizza contains pepperoni, mozzarella cheese, and tomato sauce.',
      'isSelected': false,
      'image': 'https://admin.screaminsicilian.com/wp-content/uploads/2020/08/original_holypepperoni_overhead.png',
      'category': 'pizza',
    },
    {
      'name': 'Veggie Lovers',
      'basePrice': 20.99,
      'size': 'S',
      'quantity': 1,
      'description':
          'Veggie Lovers contains fresh tomatoes, mozzarella cheese, fresh basil, salt, and extra-virgin olive oil, fresh vegetables',
      'isSelected': false,
      'image': 'https://pizzrella.com/cdn/shop/files/Veg1-PhotoRoom.png-PhotoRoom.png?v=1690390795',
      'category': 'pizza',
    },
    {
      'name': 'Meat Lovers',
      'basePrice': 22.99,
      'size': 'S',
      'quantity': 1,
      'description': 'This pizza is made with fresh tomatoes, mozzarella cheese, fresh basil, salt, and extra-virgin olive oil.',
      'isSelected': false,
      'image': 'https://napolipizzalv.com/wp-content/uploads/2019/10/DSC_0956-min.png',
      'category': 'pizza',
    },
    {
      'name': 'BBQ Chicken',
      'basePrice': 24.99,
      'size': 'S',
      'quantity': 1,
      'description': 'This pizza is made with fresh tomatoes, mozzarella cheese, fresh basil, salt, and extra-virgin olive oil.',
      'isSelected': false,
      'image': 'https://serenetrail.com/wp-content/uploads/2022/11/Up-close-view-of-bbq-chicken-pizza.jpg',
      'category': 'pizza',
    },
    {
      'name': 'Supreme',
      'basePrice': 26.99,
      'size': 'S',
      'quantity': 1,
      'description': 'This pizza is made with fresh tomatoes, mozzarella cheese, fresh basil, salt, and extra-virgin olive oil.',
      'isSelected': false,
      'image': 'https://napolipizzalv.com/wp-content/uploads/2019/10/DSC_0905-min.png',
      'category': 'pizza',
    }
  ];

  List<Map<String, dynamic>> pizzaSizes = [
    {
      'size': 'Small',
      'symbol': 'S',
      'extraPrice': 0.00,
      'radius': 65,
      'isSelected': true,
    },
    {
      'size': 'Medium',
      'symbol': 'M',
      'extraPrice': 2.00,
      'radius': 80,
      'isSelected': false,
    },
    {
      'size': 'Large',
      'symbol': 'L',
      'extraPrice': 4.00,
      'radius': 95,
      'isSelected': false,
    }
  ];

  late Map<String, dynamic> selectedPizza;

  @override
  void initState() {
    selectedPizza = pizzas.firstWhere((element) => element['isSelected'] == true);
    super.initState();
  }

  double calculatePrice() {
    final selectedSize = pizzaSizes.firstWhere((element) => element['isSelected'] == true);
    return selectedPizza['basePrice'] + selectedSize['extraPrice'];
  }

  void addToCart() {
    final selectedSize = pizzaSizes.firstWhere((element) => element['isSelected'] == true);
    final cartProduct = {
      'name': selectedPizza['name'],
      'price': calculatePrice(),
      'size': selectedSize['symbol'],
      'quantity': selectedPizza['quantity'],
      'category': selectedPizza['category'],
      'image': selectedPizza['image'],
      'description': selectedPizza['description'],
    };

    Provider.of<CartProvider>(context, listen: false).addOrUpdateCart(cartProduct);
  }

  void resetSizeAndQuantity() {
    setState(() {
      for (var size in pizzaSizes) {
        size['isSelected'] = size['symbol'] == 'S';
      }
      selectedPizza['size'] = 'S';
      selectedPizza['quantity'] = 1;
    });
  }

  void selectSize(String sizeSymbol) {
    setState(() {
      for (var size in pizzaSizes) {
        size['isSelected'] = size['symbol'] == sizeSymbol;
      }
      selectedPizza['size'] = sizeSymbol;
      selectedPizza['quantity'] = 1; // Reset quantity when size changes
    });
  }

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
        actions: [
          CartIcon(),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(
                vertical: 20,
                horizontal: 20,
              ),
              child: Text(
                'Pizza & Delice lovers',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            CircleList(
              origin: const Offset(0, 0),
              innerRadius: pizzaSizes.firstWhere((element) => element['isSelected'] == true)['radius'].toDouble(),
              onDragUpdate: (PolarCoord updateCoord) {
                double angle = updateCoord.angle % (2 * pi);
                int selectedIndex = ((angle / (2 * pi)) * pizzas.length).round() % pizzas.length;

                setState(() {
                  for (int i = 0; i < pizzas.length; i++) {
                    pizzas[i]['isSelected'] = i == selectedIndex;
                  }
                  selectedPizza = pizzas[selectedIndex];
                  resetSizeAndQuantity();
                });
              },
              centerWidget: CircleAvatar(
                radius: pizzaSizes.firstWhere((element) => element['isSelected'] == true)['radius'].toDouble(),
                backgroundImage: NetworkImage(
                  selectedPizza['image'],
                ),
              ),
              children: List.generate(pizzas.length, (index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      for (int i = 0; i < pizzas.length; i++) {
                        pizzas[i]['isSelected'] = false;
                      }
                      pizzas[index]['isSelected'] = true;
                      selectedPizza = pizzas[index];
                      resetSizeAndQuantity();
                    });
                  },
                  child: CircleAvatar(
                    radius: 60,
                    backgroundImage: NetworkImage(pizzas[index]['image']),
                  ),
                );
              }),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 20,
                right: 20,
                top: 50,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: List.generate(pizzaSizes.length, (index) {
                      return GestureDetector(
                        onTap: () {
                          selectSize(pizzaSizes[index]['symbol']);
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: CircleAvatar(
                            backgroundColor: pizzaSizes[index]['isSelected'] ? Colors.orange : Colors.white,
                            child: Text(
                              pizzaSizes[index]['symbol'],
                              style: TextStyle(
                                color: pizzaSizes[index]['isSelected'] ? Colors.white : Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        selectedPizza['name'],
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "${(calculatePrice() * selectedPizza['quantity']).toStringAsFixed(2)} MAD",
                        style: const TextStyle(
                          color: Color.fromARGB(255, 223, 143, 63),
                          fontSize: 20,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(
                    selectedPizza['description'],
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          setState(() {
                            if (selectedPizza['quantity'] > 1) {
                              selectedPizza['quantity']--;
                            }
                          });
                        },
                        icon: const Icon(
                          Icons.remove,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        selectedPizza['quantity'].toString(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 10),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            selectedPizza['quantity']++;
                          });
                        },
                        icon: const Icon(
                          Icons.add,
                          color: Colors.white,
                        ),
                      ),
                      const Spacer(),
                      ElevatedButton(
                        onPressed: addToCart,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromARGB(255, 223, 143, 63),
                          foregroundColor: Colors.white,
                          elevation: 4,
                          padding: const EdgeInsets.symmetric(
                            vertical: 10,
                            horizontal: 30,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(100),
                          ),
                        ),
                        child: const Row(
                          children: [
                            Text('Add to cart',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                )),
                            SizedBox(width: 10),
                            Icon(
                              Icons.shopping_cart,
                              color: Colors.white,
                            ),
                          ],
                        ),
                      ),
                    ],
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
