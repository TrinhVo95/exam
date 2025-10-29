import 'package:flutter/material.dart';
import 'package:exam/page/products.dart';
import 'package:exam/page/cart.dart';
import 'package:provider/provider.dart';
import 'package:exam/provider/cart_model.dart';

class ProductDetailPage extends StatefulWidget {
  final Products product;

  const ProductDetailPage({super.key, required this.product});

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
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
                    Consumer<CartModel>(
                      builder: (context, cart, child) {
                        return Stack(
                          clipBehavior: Clip.none,
                          children: [
                            IconButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => CartPage(),
                                  ),
                                );
                              },
                              icon: const Icon(
                                Icons.shopping_cart_checkout,
                                color: Colors.orange,
                              ),
                            ),
                            if (cart.products.isNotEmpty)
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
                                      cart.products.length.toString(),
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
                        );
                      },
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
                    Consumer<CartModel>(
                      builder: (context, cart, child) {
                        final existingItemIndex = cart.products.indexWhere(
                          (item) => item.product.id == widget.product.id,
                        );
                        final existingItem = existingItemIndex >= 0 
                            ? cart.products[existingItemIndex]
                            : CartItem(product: widget.product, quantity: 0);
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          spacing: 20,
                          children: [
                            IconButton(
                              onPressed: () {
                                if (existingItem.quantity > 0) {
                                  cart.decreaseQuantity(widget.product);
                                }
                              },
                              icon: Icon(
                                Icons.remove_circle,
                                size: 20,
                                color: Colors.orange,
                              ),
                            ),
                            Text(existingItem.quantity.toString()),
                            IconButton(
                              onPressed: () {
                                final exists = cart.products.any(
                                  (item) =>
                                      item.product.id == widget.product.id,
                                );
                                if (!exists) {
                                  cart.addProduct(widget.product);
                                } else {
                                  cart.increaseQuantity(widget.product);
                                }
                              },
                              icon: Icon(
                                Icons.add_circle,
                                size: 20,
                                color: Colors.orange,
                              ),
                            ),
                          ],
                        );
                      },
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
