import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OtherProducts extends StatefulWidget {
  const OtherProducts({super.key});

  @override
  State<OtherProducts> createState() => _OtherProductsState();
}

class _OtherProductsState extends State<OtherProducts> {
  final List<Map<String, dynamic>> pastas = [
    {
      'name': 'Spaghetti Carbonara',
      'image': 'https://www.aheadofthyme.com/wp-content/uploads/2021/01/spaghetti-carbonara.jpg',
      'price': '12.99',
      'quantity': 1,
      'description':
          'Spaghetti Carbonara is a classic pasta dish that is creamy, rich, and comforting. The sauce is made with pancetta, eggs, and cheese. It is a simple and delicious recipe that is perfect for a weeknight dinner.',
      'isFavourite': false
    },
    {
      'name': 'Penne Arrabiata',
      'image': 'https://www.saltandlavender.com/wp-content/uploads/2019/04/easy-pasta-arrabiata-recipe-1-768x1152.jpg',
      'price': '10.99',
      'quantity': 1,
      'description':
          'Penne Arrabiata is a spicy pasta dish that is made with penne pasta, tomatoes, garlic, and red pepper flakes. It is a simple and delicious recipe that is perfect for a weeknight dinner.',
      'isFavourite': false,
    },
    {
      'name': 'Fettuccine Alfredo',
      'image': 'https://www.modernhoney.com/wp-content/uploads/2018/08/Fettuccine-Alfredo-Recipe-1-1200x1182.jpg',
      'price': '14.99',
      'quantity': 1,
      'description':
          'Fettuccine Alfredo is a classic pasta dish that is made with fettuccine pasta, butter, cream, and Parmesan cheese. It is a simple and delicious recipe that is perfect for a weeknight dinner.',
      'isFavourite': false,
    },
    {
      'name': 'Lasagna',
      'image': 'https://us.silverfernfarms.com/cdn/shop/articles/Beef-and-Spinach-Lasagna_3024x.png?v=1599186173',
      'price': '15.99',
      'quantity': 1,
      'description':
          'Lasagna is a classic pasta dish that is made with layers of pasta, meat sauce, and cheese. It is a simple and delicious recipe that is perfect for a weeknight dinner.',
      'isFavourite': false,
    },
    {
      'name': 'Ravioli',
      'image': 'https://cdn11.bigcommerce.com/s-cjh14ahqln/product_images/uploaded_images/cheese-ravioli-2-web.jpg',
      'price': '13.99',
      'quantity': 1,
      'description':
          'Ravioli is a classic pasta dish that is made with pasta dough and a filling of meat, cheese, or vegetables. It is a simple and delicious recipe that is perfect for a weeknight dinner.',
      'isFavourite': false,
    },
    {
      'name': 'Pasta Primavera',
      'image': 'https://thecozycook.com/wp-content/uploads/2024/02/Pasta-Primavera-1-.jpg',
      'price': '11.99',
      'quantity': 1,
      'description':
          'Pasta Primavera is a classic pasta dish that is made with pasta, vegetables, and a light cream sauce. It is a simple and delicious recipe that is perfect for a weeknight dinner.',
      'isFavourite': false,
    }
  ];

  final List<Map<String, dynamic>> cart = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 44, 42, 42),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back, color: Colors.white),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Badge(
              label: Text(
                cart.isEmpty ? '0' : cart.map((e) => e['quantity']).reduce((value, element) => value + element).toString(),
                style: const TextStyle(color: Colors.white),
              ),
              child: const Icon(Icons.shopping_cart, color: Colors.deepOrange),
            ),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            child: Text(
              'Enjoy your meal',
              style: TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              itemCount: pastas.length,
              separatorBuilder: (context, index) =>
                  const Divider(color: Colors.grey, indent: 30, endIndent: 30, height: 0.6, thickness: 0.6),
              itemBuilder: (context, index) {
                final pasta = pastas[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: GestureDetector(
                    onTap: () => showPastaDetails(context, index),
                    child: Row(
                      children: [
                        Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(image: NetworkImage(pasta['image']), fit: BoxFit.cover),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(pasta['name'], style: const TextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.bold)),
                              Text(
                                pasta['description'],
                                style: const TextStyle(color: Colors.grey, fontSize: 12),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                              ),
                              Text('${pasta['price']} MAD',
                                  style: const TextStyle(color: Colors.orangeAccent, fontWeight: FontWeight.bold, fontSize: 18)),
                            ],
                          ),
                        ),
                        Column(
                          children: [
                            IconButton(
                              onPressed: () => toggleFavourite(index),
                              icon: Icon(
                                pasta['isFavourite'] ? CupertinoIcons.heart_fill : CupertinoIcons.heart,
                                color: pasta['isFavourite'] ? Colors.red : Colors.white,
                                size: 28,
                              ),
                            ),
                            IconButton(
                              onPressed: () => addToCart(index),
                              icon: const Icon(CupertinoIcons.add_circled, size: 28, color: Colors.white),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void showPastaDetails(BuildContext context, int index) {
    final pasta = pastas[index];
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      constraints: const BoxConstraints(maxHeight: 500),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 20),
                    width: 50,
                    height: 5,
                    decoration: BoxDecoration(color: Colors.grey, borderRadius: BorderRadius.circular(10)),
                  ),
                  Container(
                    width: 200,
                    height: 200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(image: NetworkImage(pasta['image']), fit: BoxFit.cover),
                    ),
                  ),
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(pasta['name'], style: const TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold)),
                      Text('${pasta['price']} MAD',
                          style: const TextStyle(color: Colors.orangeAccent, fontSize: 20, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(pasta['description'], style: const TextStyle(color: Colors.black, fontSize: 15)),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      IconButton(
                        onPressed: () => setState(() {
                          if (pasta['quantity'] > 1) pasta['quantity']--;
                        }),
                        icon: const Icon(CupertinoIcons.minus_circle, color: Colors.black, size: 30),
                      ),
                      Text(pasta['quantity'].toString(),
                          style: const TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold)),
                      IconButton(
                        onPressed: () => setState(() {
                          pasta['quantity']++;
                        }),
                        icon: const Icon(CupertinoIcons.add_circled, color: Colors.black, size: 30),
                      ),
                      const Spacer(),
                      ElevatedButton(
                        onPressed: () {
                          addOrUpdateCart(index);
                          Navigator.pop(context);
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(Colors.orangeAccent),
                          padding: MaterialStateProperty.all(const EdgeInsets.symmetric(horizontal: 50, vertical: 10)),
                        ),
                        child: const Text('Add to Cart', style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  void toggleFavourite(int index) {
    setState(() {
      pastas[index]['isFavourite'] = !pastas[index]['isFavourite'];
    });
  }

  void addToCart(int index) {
    setState(() {
      cart.add(pastas[index]);
    });
  }

  void addOrUpdateCart(int index) {
    final existingItemIndex = cart.indexWhere((item) => item['name'] == pastas[index]['name']);
    if (existingItemIndex != -1) {
      setState(() {
        cart[existingItemIndex]['quantity'] = pastas[index]['quantity'];
      });
    } else {
      setState(() {
        cart.add(Map.from(pastas[index]));
      });
    }
  }
}
