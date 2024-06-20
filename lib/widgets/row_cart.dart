import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:myapp/controller/cart_controller.dart';
import 'package:myapp/models/airsoft.dart';

// ignore: must_be_immutable
class RowCart extends StatelessWidget {
  late CartController controller;
  late int index;

  final Airsoft airsoft;
  RowCart({
    super.key,
    required this.index,
    required this.airsoft,
  });

  @override
  Widget build(BuildContext context) {
    controller = Get.find<CartController>();

    return SizedBox(
      height: 120.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  airsoft.name,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
                ),
                const SizedBox(height: 10.0),
                Text(
                  "Rp. ${NumberFormat.currency(decimalDigits: 0, symbol: '').format(airsoft.price)}",
                ),
                const SizedBox(height: 10.0),
                Text(
                  "Total • Rp. ${NumberFormat.currency(decimalDigits: 0, symbol: '').format(airsoft.price * airsoft.qty)}",
                ),
                Expanded(child: _buildQty()),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQty() {
    return Row(
      children: [
        ElevatedButton.icon(
          icon: const Icon(Icons.delete),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
          ),
          onPressed: () => controller.removeSelectedItemFromCart(airsoft.id),
          label: const Text("Remove"),
        ),
        Row(
          children: [
            IconButton(
              onPressed: () =>
                  controller.decreaseQtyOfSelectedItemInCart(index, airsoft),
              icon: const Icon(Icons.remove),
            ),
            Text(airsoft.qty.toString()),
            IconButton(
              onPressed: () =>
                  controller.increaseQtyOfSelectedItemInCart(index),
              icon: const Icon(Icons.add),
            ),
          ],
        )
      ],
    );
  }
}
