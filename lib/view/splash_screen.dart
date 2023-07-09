import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shani_book_store/view/product_list_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(
        const Duration(
          seconds: 3,
        ), () {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const ProductListScreen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xffC4E7ED),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Container(
                height: 160,
                width: 160,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: const DecorationImage(
                    image: NetworkImage(
                        'https://images-platform.99static.com//o5_Q8pUagynJuidDta7JRMJ7_K8=/311x281:1652x1622/fit-in/590x590/99designs-contests-attachments/74/74026/attachment_74026482'),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50),
              child: Divider(
                height: 10,
                color: Colors.grey.shade900,
              ),
            ),
            const Text(
              'The Story Shop',
              style: TextStyle(
                fontSize: 30,
                color: Color(0xff586972),
                fontFamily: 'HarryPotter-ov4z',
              ),
            ),
          ],
        ));
  }
}