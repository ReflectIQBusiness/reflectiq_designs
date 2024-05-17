import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:reflectiq_designs/screens/e-restaurant/cart_provider.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({Key? key}) : super(key: key);

  @override
  _CheckoutPageState createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _phoneController = TextEditingController();
  late String _selectedAddress;
  List<String> addresses = [
    '123 Main St, Cityville',
    '456 Elm St, Townsville',
    // Add more sample addresses or fetch from a provider
  ];

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _selectedAddress = addresses[0];
    super.initState();
  }

  void _confirmOrder() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.green,
          content: Text('Order confirmed!'),
          duration: Duration(seconds: 2),
        ),
      );
      Provider.of<CartProvider>(context, listen: false).clearCart();
      Navigator.of(context).pop();
    }
  }

  void _navigateToAddAddress() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => AddAddressPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
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
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 20,
                horizontal: 20,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Confirm your order',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Enter your phone number:',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.orange,
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: _phoneController,
                    //accepts only numbers
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    decoration: const InputDecoration(
                      labelText: 'Phone Number',
                      prefix: Text('+212 ',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                          )),
                      labelStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                      ),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 15,
                      ),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.white,
                          ),
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          )),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.deepOrange, width: 0.5),
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                    ),
                    style: const TextStyle(color: Colors.white),
                    keyboardType: TextInputType.phone,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your phone number';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Select the delivery address:',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.orange),
                  ),
                  const SizedBox(height: 10),
                  ListView.separated(
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    itemCount: addresses.length,
                    separatorBuilder: (context, index) => const Divider(
                      color: Colors.grey,
                      indent: 20,
                      endIndent: 20,
                    ),
                    itemBuilder: (context, index) {
                      return RadioListTile(
                        contentPadding: EdgeInsets.zero,
                        controlAffinity: ListTileControlAffinity.trailing,
                        title: Text(
                          addresses[index],
                          style: const TextStyle(color: Colors.white),
                        ),
                        groupValue: _selectedAddress,
                        value: addresses[index],
                        secondary: const Icon(
                          CupertinoIcons.location,
                          color: Colors.white,
                        ),
                        onChanged: (String? value) {
                          setState(() {
                            // Handle radio button selection
                            _selectedAddress = value!;
                          });
                        },
                      );
                    },
                  ),
                  TextButton(
                    onPressed: _navigateToAddAddress,
                    child: const Text('Add Address',
                        style: TextStyle(color: Colors.orange, decoration: TextDecoration.underline, decorationColor: Colors.orange)),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.all(30),
                    decoration: BoxDecoration(
                      color: Colors.white12,
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.16),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Order Summary:',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.orange,
                          ),
                        ),
                        Consumer<CartProvider>(
                          builder: (context, cartProvider, child) {
                            final cart = cartProvider.cart;
                            return ListView.builder(
                              itemCount: cart.length,
                              padding: EdgeInsets.zero,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                final item = cart[index];
                                return ListTile(
                                  title: Text('x${item['quantity']} ${item['name']}',
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      )),
                                  trailing: Text(' ${item['price'].toStringAsFixed(2)} MAD',
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 14,
                                      )),
                                );
                              },
                            );
                          },
                        ),
                        const SizedBox(height: 20),
                        const Divider(color: Colors.grey),
                        Consumer<CartProvider>(
                          builder: (context, cartProvider, child) {
                            final totalPrice = cartProvider.getTotalPrice();
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Total',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  '$totalPrice MAD',
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Center(
                    child: ElevatedButton(
                      onPressed: _confirmOrder,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange,
                        foregroundColor: Colors.white,
                        minimumSize: Size(MediaQuery.of(context).size.width, 60),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: const Text('Confirm Order',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          )),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 44, 42, 42),
      ),
    );
  }
}

class AddAddressPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Address'),
        backgroundColor: const Color.fromARGB(255, 44, 42, 42),
      ),
      body: const Center(
        child: Text('Map Screen Placeholder', style: TextStyle(fontSize: 24, color: Colors.white)),
        // Implement your map screen here
      ),
      backgroundColor: const Color.fromARGB(255, 44, 42, 42),
    );
  }
}
