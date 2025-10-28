import 'package:flutter/material.dart';
import 'package:exam/page/products.dart';
import 'package:exam/page/cart.dart';

class ProductDetailPage extends StatefulWidget {
  final Products product;

  const ProductDetailPage({super.key, required this.product});

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  int quantity = 0;

  void _increaseQuantity() {
    setState(() {
      quantity++;
    });
  }

  void _decreaseQuantity() {
    setState(() {
      if (quantity > 0) {
        quantity--;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 10,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        shape: const CircleBorder(),
                        backgroundColor: Colors.orange,
                      ),
                      child: const Icon(Icons.arrow_back, color: Colors.white),
                    ),
                    Stack(
                      clipBehavior:
                          Clip.none, 
                      children: [
                        IconButton(
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => CartPage()));
                          },
                          icon: const Icon(
                            Icons.shopping_cart_checkout,
                            color: Colors.orange,
                          ),
                        ),
                        if (quantity > 0)
                          Positioned(
                            right: -4,
                            top: -4,
                            child: Container(
                              padding: const EdgeInsets.all(4),
                              decoration: const BoxDecoration(
                                color: Colors.orange,
                                shape: BoxShape.circle,
                              ),
                              constraints: const BoxConstraints(
                                minWidth: 18,
                                minHeight: 18,
                              ),
                              child: Center(
                                child: Text(
                                  quantity.toString(),
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
                Text(
                  widget.product.category,
                  style: TextStyle(color: Colors.orange, fontSize: 12),
                ),
                Text(
                  widget.product.title,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Container(
                  height: 300,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: Image.network(widget.product.image, fit: BoxFit.cover),
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '\$${widget.product.price.toStringAsFixed(2)}',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      spacing: 20,
                      children: [
                        IconButton(
                          onPressed: _decreaseQuantity,
                          icon: Icon(
                            Icons.remove_circle,
                            size: 20,
                            color: Colors.orange,
                          ),
                        ),
                        Text(quantity.toString()),
                        IconButton(
                          onPressed: _increaseQuantity,
                          icon: Icon(
                            Icons.add_circle,
                            size: 20,
                            color: Colors.orange,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Text(widget.product.description),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
