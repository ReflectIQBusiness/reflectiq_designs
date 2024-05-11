import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:reflectiq_designs/screens/e-restaurant/sushi/detail_page.dart';

class Sushi extends StatefulWidget {
  const Sushi({super.key});

  @override
  State<Sushi> createState() => _SushiState();
}

class _SushiState extends State<Sushi> with SingleTickerProviderStateMixin {
  List products = [
    {
      'name': 'Sushi',
      'image': 'assets/food/Sushi.png',
      'description':
          'Sushi is a Japanese dish of prepared vinegared rice, usually with some sugar and salt, accompanying a variety of ingredients, such as seafood, vegetables, and occasionally tropical fruits. Styles of sushi and its presentation vary widely, but the one key ingredient is "sushi rice", also referred to as shari, or sumeshi.',
      'price': '120.99',
    },
    {
      'name': 'Poke Bowl',
      'image': 'assets/food/poke_bowl.png',
      'description':
          'Poke is a raw fish salad served as an appetizer in Hawaiian cuisine. Poke is the Hawaiian verb for "section" or "to slice or cut". Traditional forms are aku and he\'e. He\'e poke is usually called by its Japanese name Tako Poke, except in places like the island of Niʻihau where the Hawaiian language is spoken.',
      'price': '100.99',
    },
    {
      'name': 'Chicken curry',
      'image': 'assets/food/chicken.png',
      'description':
          'Curry is a variety of dishes originating in the Indian subcontinent that use a complex combination of spices or herbs, usually including ground turmeric, cumin, coriander, ginger, and fresh or dried chilies. Curry is generally prepared in a sauce.',
      'price': '100.00',
    }
  ];
  AnimationController? control;

  Animation<double>? rot;
  Animation<double>? trasl;
  @override
  void initState() {
    control = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    rot = Tween<double>(
      begin: -2 * pi,
      end: 2 * pi,
    ).animate(control!);

    control!.forward();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    trasl = Tween<double>(
      begin: -300,
      end: MediaQuery.of(context).size.width / 1.8 - MediaQuery.of(context).size.height / 8,
    ).animate(control!);
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
              icon: const Icon(
                Icons.shopping_cart,
                color: Colors.deepOrange,
              ),
            ),
          ],
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(
                vertical: 20,
                horizontal: 20,
              ),
              child: Text(
                'Sushi & Asian Cuisine',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: products.length,
                padding: const EdgeInsets.all(20),
                itemBuilder: (BuildContext context, int index) {
                  return Stack(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => DetailPage(
                                        products[index],
                                      )));
                        },
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 10),
                          padding: const EdgeInsets.all(20),
                          height: MediaQuery.of(context).size.height / 3.5,
                          width: MediaQuery.of(context).size.width / 1.85,
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 223, 143, 63),
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                offset: const Offset(0, 5),
                                blurRadius: 15,
                              ),
                            ],
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(products[index]['name'],
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      )),
                                  const Spacer(),
                                  IconButton(
                                    onPressed: () {},
                                    icon: const Icon(
                                      Icons.arrow_forward,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                              Text('${products[index]['price']} MAD',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  )),
                            ],
                          ),
                        ),
                      ),
                      AnimatedBuilder(
                        animation: control!,
                        builder: (_, child) => Positioned(
                          left: trasl!.value,
                          top: MediaQuery.of(context).size.height / 4.2 - MediaQuery.of(context).size.height / 5.5,
                          child: Transform.rotate(
                            angle: rot!.value,
                            child: Hero(
                              tag: 'image${products[index]['name']}',
                              child: Image.asset(
                                products[index]['image'],
                                height: MediaQuery.of(context).size.height / 4.8,
                                scale: 1.5,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            )
          ],
        ));
  }
}
