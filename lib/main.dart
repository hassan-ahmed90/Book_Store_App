import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shani_book_store/provider/book_provider.dart';
import 'package:shani_book_store/view/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(create: (_)=>BookProvider(),
    child: Builder(builder: (BuildContext context){
      return  MaterialApp(
        home: SplashScreen(),
      );
    },),
    );

  }
}
