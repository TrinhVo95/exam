import 'package:exam/page/product_detail.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

import 'package:flutter/material.dart';

Future<List<Products>> fetchProductsList() async {
  try {
    final response = await http
        .get(Uri.parse('https://fakestoreapi.com/products'))
        .timeout(Duration(seconds: 15)); // Tăng lên 15 giây nếu mạng chậm

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = jsonDecode(response.body);

      // Map từng phần tử JSON thành đối tượng Products
      return jsonList.map((json) => Products.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load products: ${response.statusCode}');
    }
  } catch (e) {
    throw Exception('Network error: $e');
  }
}

class Products {
  final int id;
  final String title;
  final num price;
  final String description;
  final String category;
  final String image;

  const Products({
    required this.id,
    required this.title,
    required this.category,
    required this.description,
    required this.price,
    required this.image,
  });

  factory Products.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'id': int id,
        'title': String title,
        'price': num price,
        'description': String description,
        'category': String category,
        'image': String image,
      } =>
        Products(
          id: id,
          title: title,
          price: price,
          description: description,
          category: category,
          image: image,
        ),
      _ => throw const FormatException('Failed to load product.'),
    };
  }
}

class ProductsPage extends StatefulWidget {
  const ProductsPage({super.key});

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  late Future<List<Products>> futureProducts;

  @override
  void initState() {
    super.initState();
    futureProducts = fetchProductsList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            spacing: 20,
            children: [
              Text(
                'Products',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              Expanded(
                child: FutureBuilder(
                  future: futureProducts,
                  builder: (context, result) {
                    if (result.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (result.hasError) {
                      return Center(child: Text('Error: ${result.error}'));
                    } else if (result.hasData) {
                      final productsList = result.data!;
                      return GridView.builder(
                        itemCount: productsList.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 20,
                          mainAxisSpacing: 20,
                        ),
                        itemBuilder: (context, index) {
                          final product = productsList[index];
                          return InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      ProductDetailPage(product: product),
                                ),
                              );
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(color: Color(0xFFE5E5E5)),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(12),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      height: 50,
                                      width: double.infinity,
                                      child: Image.network(
                                        product.image,
                                        fit: BoxFit.contain,
                                        errorBuilder:
                                            (context, error, stackTrace) =>
                                                Container(
                                                  color: Colors.grey[200],
                                                  child: Icon(
                                                    Icons.image,
                                                    color: Colors.grey[400],
                                                    size: 40,
                                                  ),
                                                ),
                                      ),
                                    ),

                                    Text(
                                      product.title,
                                      maxLines: 3,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                    SizedBox(height: 8),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          '\$${product.price.toStringAsFixed(2)}',
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Icon(
                                          Icons.add_circle,
                                          size: 20,
                                          color: Colors.orange,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    } else {
                      return const Center(child: Text('No data'));
                    }
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
