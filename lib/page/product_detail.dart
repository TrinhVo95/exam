import 'package:flutter/material.dart';
import 'package:exam/page/products.dart';

class ProductDetailPage extends StatelessWidget {
  final Products product;

  const ProductDetailPage({super.key, required this.product});

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
                Text(
                  product.category,
                  style: TextStyle(color: Colors.orange, fontSize: 12),
                ),
                Text(
                  product.title,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Container(
                  height: 300,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: Image.network(product.image, fit: BoxFit.cover),
                ),
                  Text(
                  '\$${product.price.toStringAsFixed(2)}',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Text(product.description),
              
              ],
            ),
          ),
        ),
      ),
    );
  }
}
