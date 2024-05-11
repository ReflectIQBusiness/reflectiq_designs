import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class DetailPage extends StatefulWidget {
  final product;
  const DetailPage(
    this.product, {
    super.key,
  });

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  List cart = [];
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
                cart.length.toString(),
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
              child: Stack(
            fit: StackFit.expand,
            children: [
              Align(
                alignment: Alignment(-0.7, 0),
                child: Container(
                    height: MediaQuery.of(context).size.height / 2,
                    width: MediaQuery.of(context).size.width / 1.5,
                    margin: const EdgeInsets.only(
                      top: 100,
                    ),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 223, 143, 63),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 20,
                          right: 20,
                          top: 110,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.product['name'],
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              widget.product['description'],
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              widget.product['price'] + ' MAD',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ])),
              ),
              Positioned(
                left: MediaQuery.of(context).size.width / 2.4,
                top: MediaQuery.of(context).size.height / 8,
                child: Hero(
                  tag: 'image${widget.product['name']}',
                  child: Image.asset(
                    widget.product['image'],
                    height: MediaQuery.of(context).size.height / 4.8,
                    scale: 1.5,
                  ),
                ),
              ),
              Positioned(
                left: MediaQuery.of(context).size.width / 1.75,
                bottom: MediaQuery.of(context).size.height / 8.5,

                //child Add to cart button
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xffE7ECEF),
                    foregroundColor: Colors.black,
                    elevation: 4,
                    padding: EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 30,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100),
                    ),
                  ),
                  onPressed: () {
                    setState(() {
                      cart.add(widget.product);
                    });
                  },
                  child: const Text('Add to cart',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      )),
                ),
              )
            ],
          )),
        ],
      ),
    );
  }
}
