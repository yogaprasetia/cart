import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/view/cart_screen.dart';
import 'package:myapp/view/product_screen.dart';
import 'controller/bindings/cart_binding.dart';
import 'controller/bindings/product_binding.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Products',
      theme: ThemeData.dark(),
      getPages: [
        GetPage(
          name: '/product',
          page: () => ProductScreen(),
          binding: ProductBinding(),
        ),
        GetPage(
          name: '/cart',
          page: () => CartScreen(),
          binding: CartBinding(),
        )
      ],
      initialRoute: '/product',
    );
  }
}
