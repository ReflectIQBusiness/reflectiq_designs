import 'dart:math';

import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:reflectiq_designs/screens/e-restaurant/other_products/other_products.dart';
import 'package:reflectiq_designs/screens/e-restaurant/pizza/pizza.dart';
import 'package:reflectiq_designs/screens/e-restaurant/sushi/sushi.dart';

class Categories extends StatefulWidget {
  const Categories({super.key});

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> with SingleTickerProviderStateMixin {
  List<Map<String, String>> categories = [
    {
      'name': 'Burgers',
      'image': 'https://img.freepik.com/photos-gratuite/delicieux-burger-ingredients-frais_23-2150857908.jpg',
    },
    {
      'name': 'Pizza',
      'image':
          'https://img.freepik.com/photos-gratuite/pizza-fraichement-italienne-tranche-fromage-mozzarella-ia-generative_188544-12347.jpg',
    },
    {
      'name': 'Pasta',
      'image':
          'https://media.istockphoto.com/id/637214478/fr/photo/assiette-de-p%C3%A2tes.jpg?s=612x612&w=0&k=20&c=oQfrjLuRfmWVuL3Y-ByzR1aAS38vi15RQKoar_iLrvs=',
    },
    {
      'name': 'Salad',
      'image':
          'https://hips.hearstapps.com/hmg-prod/images/greek-salad-index-642f292397bbf.jpg?crop=0.888888888888889xw:1xh;center,top&resize=1200:*',
    },
    {
      'name': 'Dessert',
      'image': 'https://img.freepik.com/photos-gratuite/chocolat-creme-fouettee-baies-gourmandes-gogo-generees-par-ia_188544-9812.jpg',
    },
    {
      'name': 'Drinks',
      'image':
          'https://img.freepik.com/photos-gratuite/cocktails-frais-glace-citron-citron-vert-fruits-ia-generative_188544-12370.jpg?size=626&ext=jpg&ga=GA1.1.2116175301.1714176000&semt=sph',
    },
    {
      'name': 'Sushi & Asian Cuisine',
      'image': 'https://img.freepik.com/photos-gratuite/peinture-sushi-assiette-photo-poisson-dessus_188544-12221.jpg',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 44, 42, 42),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          toolbarHeight: 180,
          flexibleSpace: Stack(
            fit: StackFit.expand,
            clipBehavior: Clip.none,
            children: [
              Positioned(
                top: 50,
                left: 20,
                child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  ),
                ),
              ),
              Positioned(
                top: 50,
                right: 20,
                child: IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.shopping_cart,
                    color: Colors.deepOrange,
                  ),
                ),
              ),
              const Positioned(
                top: 100,
                left: 20,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Welcome to',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                    Text(
                      'E-Restaurant',
                      style: TextStyle(
                        color: Colors.deepOrange,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),

              // Search bar
              Positioned(
                top: 180,
                left: 20,
                right: 20,
                child: TextFormField(
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(10),
                    hintText: 'Search for food',
                    hintStyle: const TextStyle(
                      color: Colors.white,
                    ),
                    prefixIcon: const Icon(
                      Icons.search,
                      color: Colors.white,
                    ),
                    filled: true,
                    fillColor: Colors.black.withOpacity(0.3),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(100),
                      borderSide: const BorderSide(
                        color: Colors.transparent,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 20,
            ),
            child: StaggeredGrid.count(
              crossAxisCount: 2,
              children: List.generate(
                categories.length,
                (index) {
                  double height = generateHeight();
                  return InkWell(
                    onTap: () {
                      if (categories[index]['name']!.contains('Sushi')) {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => Sushi()));
                        return;
                      }
                      if (categories[index]['name']!.contains('Pizza')) {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => Pizza()));
                        return;
                      }
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const OtherProducts()));
                    },
                    child: FlipCard(
                      flipOnTouch: false,
                      direction: FlipDirection.VERTICAL,
                      autoFlipDuration: Duration(milliseconds: 500 * index),
                      front: Container(
                        height: height,
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        margin: const EdgeInsets.all(10),
                      ),
                      back: Container(
                        height: height,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(categories[index]['image']!),
                            fit: BoxFit.cover,
                            colorFilter: ColorFilter.mode(
                              Colors.black.withOpacity(0.38),
                              BlendMode.darken,
                            ),
                          ),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        margin: const EdgeInsets.all(10),
                        child: Align(
                          alignment: const Alignment(0, 0.8),
                          child: Text(
                            categories[index]['name']!,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ));
  }

  double generateHeight() => Random().nextInt(180).toDouble() + 200;
}
