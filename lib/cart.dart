import 'package:flutter/material.dart';
import 'dart:math';
import 'FireServiceCart.dart';

class Cart extends StatefulWidget {
  final List<Map<String, String>> items;

  const Cart({super.key, required this.items});

  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  late List<Map<String, String>> cartItems;
  late double totalPrice;
  final FirestoreServiceCart firestoreServiceCart = FirestoreServiceCart();

  @override
  void initState() {
    super.initState();
    cartItems = List.from(widget.items); // Copy the original items to local state
    totalPrice = _calculateTotalPrice(); // Calculate the total price
  }

  // Function to calculate the total price of items in the cart
  double _calculateTotalPrice() {
    double total = 0.0;
    for (var item in cartItems) {
      total += double.tryParse(item['price'] ?? '0') ?? 0; // Add the price of each item
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "My Cart",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFF121481),
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(top: 10, bottom: 10),
            alignment: Alignment.topCenter,
            child: const Text(
              "Items in Your Cart",
              style: TextStyle(fontSize: 30, color: Colors.black),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  if (cartItems.isEmpty) ...[
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Text(
                        "No items in the cart",
                        style: TextStyle(fontSize: 18, color: Colors.grey),
                      ),
                    ),
                  ] else ...[
                    for (var item in cartItems) ...[
                      Container(
                        padding: const EdgeInsets.all(10),
                        child: Card(
                          elevation: 5,
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Service: ${item['service'] ?? "Service"}",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 8),
                                Text(
                                  "Date & Time: ${item['time'] ?? "No date and time available"}",
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                                SizedBox(height: 8),
                                Text(
                                  "Price: Rp ${item['price'] ?? "0"}",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.pinkAccent,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ],
                ],
              ),
            ),
          ),
          // Display the total price at the bottom
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: Text(
              "Total: Rp ${totalPrice.toStringAsFixed(0)}",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 16.0),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  await _handleCheckout(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.pinkAccent,
                  padding: EdgeInsets.symmetric(vertical: 15.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  elevation: 10,
                ),
                child: const Text(
                  "Done",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _handleCheckout(BuildContext context) async {
    bool allTimesAvailable = true;

    for (var item in cartItems) {
      bool isAvailable = await firestoreServiceCart.checkTimeAvailability(item['time'] ?? '');
      if (!isAvailable) {
        allTimesAvailable = false;
        break;
      }
    }

    if (!allTimesAvailable) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Waktu Sudah Dibooking"),
            content: Text("Satu atau lebih waktu yang dipilih telah dibooking. Silakan periksa kembali."),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text("OK"),
              ),
            ],
          );
        },
      );
      return;
    }

    // Proceed with checkout
    _showConfirmationDialog(context);
  }

  void _showConfirmationDialog(BuildContext context) {
    final randomNumber = Random().nextInt(1000000000);
    final virtualNumber = "8310$randomNumber";

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Center(
            child: Text(
              "Pembayaran Transaksi",
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                'img/qr.png',
                height: 250,
                width: 250,
                fit: BoxFit.cover,
              ),
              const SizedBox(height: 20),
              Text(
                "Virtual Number: $virtualNumber",
                style: const TextStyle(fontSize: 20),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () async {
                for (var item in cartItems) {
                  await firestoreServiceCart.addCartItem(
                    service: item['service'] ?? 'Unknown Service',
                    time: item['time'] ?? 'Unknown Time',
                    price: item['price'] ?? '0',
                  );
                }
                Navigator.of(context).pop();
                _resetCart();
                Navigator.of(context).pop();
              },
              child: const Text("OK"),
            ),
          ],
        );
      },
    );
  }

  void _resetCart() {
    setState(() {
      cartItems.clear();
      totalPrice = 0.0;
    });
  }
}