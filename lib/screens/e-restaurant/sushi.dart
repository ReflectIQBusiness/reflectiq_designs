import 'package:flutter/material.dart';

class Sushi extends StatefulWidget {
  const Sushi({super.key});

  @override
  State<Sushi> createState() => _SushiState();
}

class _SushiState extends State<Sushi> {
  List products = [
    {
      'name': 'Sushi',
      'image': 'assets/food/Sushi.png',
      'price': '120.99',
    },
    {
      'name': 'Poke Bowl',
      'image': 'assets/food/poke_bowl.png',
      'price': '100.99',
    },
    {
      'name': 'Chicken curry',
      'image': 'assets/food/chicken.png',
      'price': '100.00',
    }
  ];

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
                      Container(
                        margin: const EdgeInsets.only(bottom: 10),
                        padding: const EdgeInsets.all(20),
                        height: MediaQuery.of(context).size.height / 3.5,
                        width: MediaQuery.of(context).size.width / 1.85,
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 223, 143, 63),
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              offset: Offset(0, 5),
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
                      Positioned(
                        left: MediaQuery.of(context).size.width / 1.8 - MediaQuery.of(context).size.height / 8,
                        top: MediaQuery.of(context).size.height / 4.2 - MediaQuery.of(context).size.height / 5.5,
                        child: Image.asset(
                          products[index]['image'],
                          height: MediaQuery.of(context).size.height / 4.8,
                          scale: 1.5,
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
