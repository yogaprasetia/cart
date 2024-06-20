import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:myapp/controller/product_controller.dart';
import 'package:myapp/models/airsoft.dart';

// ignore: must_be_immutable
class RowProduct extends StatelessWidget {
  Airsoft airsoft;
  ProductController controller;

  RowProduct({
    super.key,
    required this.airsoft,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(width: 20.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                airsoft.name,
                style: const TextStyle(
                  fontSize: 15.0,
                  fontWeight: FontWeight.bold,
                ),
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 10.0),
              Text(
                "Rp. ${NumberFormat.currency(decimalDigits: 0, symbol: '').format(airsoft.price)}",
              ),
              Obx(() {
                Airsoft? selectedModel = controller.cart.firstWhereOrNull(
                    (Airsoft selectedItem) => selectedItem.id == airsoft.id);

                if (selectedModel == null) {
                  return ElevatedButton(
                    onPressed: () => controller.addItemToCart(airsoft),
                    child: const Text("Add To Cart"),
                  );
                } else {
                  return _buildQty(selectedModel);
                }
              }),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildQty(Airsoft selectedModel) {
    return Row(
      children: [
        ElevatedButton.icon(
          icon: const Icon(Icons.delete),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
          ),
          onPressed: () =>
              controller.removeSelectedItemFromCart(selectedModel.id),
          label: const Text("Remove"),
        ),
        Row(
          children: [
            IconButton(
              onPressed: () => controller.decreaseQtyOfItemInCart(airsoft),
              icon: const Icon(Icons.remove),
            ),
            Text(selectedModel.qty.toString()),
            IconButton(
              onPressed: () => controller.increaseQtyOfItemInCart(airsoft),
              icon: const Icon(Icons.add),
            ),
          ],
        )
      ],
    );
  }
}
