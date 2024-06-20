import 'package:badges/badges.dart' as badges;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/controller/product_controller.dart';
import 'package:myapp/widgets/row_product.dart';

// ignore: must_be_immutable
class ProductScreen extends StatelessWidget {
  late ProductController controller;

  ProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    controller = Get.find<ProductController>();

    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: const Text(
          'Montirin',
          style: TextStyle(
            color: Colors.white,
            fontFamily: "Roboto",
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          Obx(
            () => controller.cart.isNotEmpty
                ? InkWell(
                    onTap: () => Get.toNamed('/cart'),
                    child: badges.Badge(
                      badgeColor: Colors.red,
                      badgeContent: Padding(
                        padding: const EdgeInsets.all(4),
                        child: Text(
                          '${controller.cart.length}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      child: const Icon(Icons.shopping_cart),
                    ),
                  )
                : const Icon(Icons.shopping_cart),
          ),
          const SizedBox(width: 20.0),
        ],
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(10.0),
        separatorBuilder: (_, __) => const Divider(color: Colors.white),
        itemCount: controller.list.length,
        itemBuilder: (context, index) {
          return RowProduct(
            airsoft: controller.list[index],
            controller: controller,
          );
        },
      ),
    );
  }
}
