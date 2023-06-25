import 'package:flutter/material.dart';
import 'package:shani_book_store/view/product_list_screen.dart';
import 'package:shani_book_store/view/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ProductListScreen(),
    );
  }
}
