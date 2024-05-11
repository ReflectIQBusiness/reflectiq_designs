import 'dart:math';

import 'package:circle_list/circle_list.dart';
import 'package:flutter/material.dart';

class Pizza extends StatefulWidget {
  const Pizza({Key? key}) : super(key: key);

  @override
  _PizzaState createState() => _PizzaState();
}

class _PizzaState extends State<Pizza> {
  List pizzas = [
    {
      'name': 'Margherita',
      'price': 12.99,
      'quantity': 1,
      'description': 'This pizza is made with fresh tomatoes,mozzarella cheese, fresh basil, salt, and extra-virgin olive oil.',
      'isSelected': true,
      'image':
          'https://www.foodandwine.com/thmb/7A7CYdDEKJUUhNcLSrlZ5N8wbHo=/750x0/filters:no_upscale():max_bytes(150000):strip_icc():format(webp)/mozzarella-pizza-margherita-FT-RECIPE0621-11fa41ceb1a5465d9036a23da87dd3d4.jpg',
    },
    {
      'name': 'Pepperoni',
      'price': 14.99,
      'quantity': 1,
      'description': 'This pizza contains pepperoni, mozzarella cheese, and tomato sauce.',
      'isSelected': false,
      'image': 'https://admin.screaminsicilian.com/wp-content/uploads/2020/08/original_holypepperoni_overhead.png',
    },
    {
      'name': 'Veggie Lovers',
      'price': 20.99,
      'quantity': 1,
      'description':
          'Veggie Lovers contains fresh tomatoes,mozzarella cheese, fresh basil, salt, and extra-virgin olive oil, fresh vegetables',
      'isSelected': false,
      'image': 'https://pizzrella.com/cdn/shop/files/Veg1-PhotoRoom.png-PhotoRoom.png?v=1690390795',
    },
    {
      'name': 'Meat Lovers',
      'price': 22.99,
      'quantity': 1,
      'description': 'This pizza is made with fresh tomatoes,mozzarella cheese, fresh basil, salt, and extra-virgin olive oil.',
      'isSelected': false,
      'image': 'https://napolipizzalv.com/wp-content/uploads/2019/10/DSC_0956-min.png',
    },
    {
      'name': 'BBQ Chicken',
      'price': 24.99,
      'quantity': 1,
      'description': 'This pizza is made with fresh tomatoes,mozzarella cheese, fresh basil, salt, and extra-virgin olive oil.',
      'isSelected': false,
      'image': 'https://serenetrail.com/wp-content/uploads/2022/11/Up-close-view-of-bbq-chicken-pizza.jpg',
    },
    {
      'name': 'Supreme',
      'price': 26.99,
      'quantity': 1,
      'description': 'This pizza is made with fresh tomatoes,mozzarella cheese, fresh basil, salt, and extra-virgin olive oil.',
      'isSelected': false,
      'image': 'https://napolipizzalv.com/wp-content/uploads/2019/10/DSC_0905-min.png',
    }
  ];
  List cart = [];
  List pizzaSizes = [
    {
      'size': 'Small',
      'symbol': 'S',
      'price': 0.00,
      'radius': 65,
      'isSelected': true,
    },
    {
      'size': 'Medium',
      'symbol': 'M',
      'price': 15.00,
      'radius': 80,
      'isSelected': false,
    },
    {
      'size': 'Large',
      'symbol': 'L',
      'price': 20.00,
      'radius': 95,
      'isSelected': false,
    }
  ];
  var selectedPizza;
  @override
  void initState() {
    selectedPizza = pizzas.firstWhere((element) => element['isSelected'] == true);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  addPrice(int index) {
    print(selectedPizza['price']);
    return selectedPizza['price'] + pizzaSizes[index]['price'];
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
          IconButton(
            onPressed: () {},
            icon: Badge(
              label: Text(
                cart.isEmpty ? '0' : cart.map((e) => e['quantity']).reduce((value, element) => value + element).toString(),
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
              child: const Icon(
                Icons.shopping_cart,
                color: Colors.white,
              ),
            ),
          ),
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
                double angle = updateCoord.angle % (2 * pi); // Ensure angle is within [0, 2*pi)
                int selectedIndex = ((angle / (2 * pi)) * pizzas.length).round() % pizzas.length;

                setState(() {
                  for (int i = 0; i < pizzas.length; i++) {
                    pizzas[i]['isSelected'] = i == selectedIndex;
                  }
                  selectedPizza = pizzas[selectedIndex];
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
                      selectedPizza = pizzas[index];
                      pizzas.forEach((element) {
                        element['isSelected'] = false;
                      });
                      pizzas[index]['isSelected'] = true;
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
                          setState(() {
                            pizzaSizes.forEach((element) {
                              element['isSelected'] = false;
                            });
                            pizzaSizes[index]['isSelected'] = true;
                          });
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
                              )),
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
                        "${(addPrice(
                              pizzaSizes.indexWhere((element) => element['isSelected'] == true),
                            ) * selectedPizza['quantity']).toStringAsFixed(2)} MAD",
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
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color.fromARGB(255, 223, 143, 63),
                          ),
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
                          )),
                      const SizedBox(width: 10), // SizedBox
                      Text(
                        selectedPizza['quantity'].toString(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 10), // SizedBox

                      IconButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color.fromARGB(255, 223, 143, 63),
                          ),
                          onPressed: () {
                            setState(() {
                              selectedPizza['quantity']++;
                            });
                          },
                          icon: const Icon(
                            Icons.add,
                            color: Colors.white,
                          )),
                      const Spacer(),
                      ElevatedButton(
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
                        onPressed: () {
                          setState(() {
                            addToCartOrUpdate(selectedPizza);
                          });
                        },
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

  void addToCartOrUpdate(selectedPizza) {
    var pizza = cart.firstWhere(
        (element) =>
            element['name'] == selectedPizza['name'] &&
            element['size'] == pizzaSizes.firstWhere((element) => element['isSelected'] == true)['size'],
        orElse: () => null);
    if (pizza != null) {
      pizza['quantity'] += selectedPizza['quantity'];
    } else {
      cart.add(selectedPizza);
    }
  }
}
