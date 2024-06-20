import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:myapp/controller/cart_controller.dart';
import 'package:myapp/widgets/row_cart.dart';

// ignore: must_be_immutable
class CartScreen extends StatelessWidget {
  late CartController controller;

  CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    controller = Get.find<CartController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Cart"),
      ),
      body: Container(
        margin: const EdgeInsets.all(20.0),
        child: Obx(
          () => controller.cart.isEmpty
              ? const Center(
                  child: Text("Your cart is empty"),
                )
              : Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Column(
                    children: [
                      Expanded(
                        child: ListView.separated(
                          itemCount: controller.cart.length,
                          separatorBuilder: (_, __) => const Divider(),
                          itemBuilder: (context, index) {
                            return RowCart(
                              airsoft: controller.cart[index],
                              index: index,
                            );
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "Grand Total : Rp. ${NumberFormat.currency(
                                decimalDigits: 0,
                                symbol: '',
                              ).format(
                                controller.grandTotal.value,
                              )}",
                            ),
                            ElevatedButton(
                              onPressed: () {
                                _confirmationDialog();
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.yellow,
                              ),
                              child: const SizedBox(
                                width: double.infinity,
                                child: Center(
                                  child: Text(
                                    "Proceed",
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
        ),
      ),
    );
  }

  void _confirmationDialog() {
    Get.defaultDialog(
      title: "Really want to proceed ?",
      actions: [
        ElevatedButton(
            style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all(Colors.black)),
            onPressed: () {
              Get.back();
            },
            child: const Text("Cancel")),
        ElevatedButton(
            style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all(Colors.yellow)),
            onPressed: () {
              controller.transactionCompleted();
            },
            child: const Text(
              "Confirm",
              style: TextStyle(color: Colors.black),
            ))
      ],
      backgroundColor: const Color(0xff4D4D4D),
      titleStyle: const TextStyle(
          color: Colors.white,
          fontFamily: 'Poppins',
          fontSize: 17,
          fontWeight: FontWeight.bold),
      content: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 300,
            height: 200,
            child: ListView.separated(
              separatorBuilder: (_, i) => const Divider(),
              itemCount: controller.cart.length,
              itemBuilder: (_, index) {
                return ListTile(
                  leading: Text(
                    controller.cart[index].name,
                    style: const TextStyle(
                        color: Colors.white,
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.bold,
                        fontSize: 12),
                  ),
                  subtitle: Text(
                    "Rp. ${NumberFormat.currency(decimalDigits: 0, symbol: '')
                            .format(controller.cart[index].price)} x ${controller.cart[index].qty}",
                    style: const TextStyle(
                        fontFamily: "Poppins",
                        color: Colors.white,
                        fontSize: 10),
                  ),
                );
              },
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            "Total Rp. ${NumberFormat.currency(decimalDigits: 0, symbol: '')
                    .format(controller.grandTotal.value)}",
            style: const TextStyle(
                color: Colors.white,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.bold,
                fontSize: 12),
          )
        ],
      ),
    );
  }
}
