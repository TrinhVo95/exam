import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:exam/provider/cart_model.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Row(
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
                  Expanded(
                    child: Center(
                      child: Text(
                        'Your Cart',
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              Expanded(
                child: Consumer<CartModel>(
                  builder: (context, cart, child) {
                    if (cart.products.isEmpty) {
                      return const Center(child: Text('Your cart is empty'));
                    }
                    return ListView.builder(
                      itemCount: cart.products.length,
                      itemBuilder: (context, index) {
                        final item = cart.products[index];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 16),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: 80,
                                height: 80,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: Colors.grey[200],
                                ),
                                clipBehavior: Clip.hardEdge,
                                child: Image.network(
                                  item.product.image,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) =>
                                      Icon(
                                        Icons.image,
                                        color: Colors.grey[400],
                                        size: 40,
                                      ),
                                ),
                              ),
                              const SizedBox(width: 16),
                              // Thông tin sản phẩm
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      item.product.title,
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    SizedBox(height: 4),
                                    Row(
                                      spacing: 4,
                                      children: [
                                        Text(
                                          '\$${item.product.price.toStringAsFixed(2)}',
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.orange,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        Text(
                                          'x ${item.quantity.toString()} = \$${(item.product.price * item.quantity).toStringAsFixed(2)}',
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.orange,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),

                                    Row(
                                      children: [
                                        IconButton(
                                          onPressed: () {
                                            if (item.quantity > 0) {
                                              cart.decreaseQuantity(
                                                item.product,
                                              );
                                            }
                                          },
                                          icon: Icon(
                                            Icons.remove_circle,
                                            size: 20,
                                            color: Colors.orange,
                                          ),
                                        ),
                                        Text(item.quantity.toString()),
                                        IconButton(
                                          onPressed: () {
                                            cart.increaseQuantity(item.product);
                                          },
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
                              ),
                              // Nút xóa
                              IconButton(
                                onPressed: () {
                                  cart.removeProduct(item.product);
                                },
                                icon: Icon(
                                  Icons.delete_outline,
                                  color: Colors.red,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
