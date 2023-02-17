import 'package:aos_test/controllers/cart_controller.dart';
import 'package:aos_test/models/product_model.dart';
import 'package:aos_test/views/home.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Cart extends StatefulWidget {
  const Cart({Key? key, this.dataProduct}) : super(key: key);
  final TableProduct? dataProduct;
  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  final CartController cartController = Get.put(CartController());

  @override
  void initState() {
    super.initState();
    if (widget.dataProduct != null) {
      cartController.addProduct(dataCart: widget.dataProduct!);
      cartController.summary();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Expanded(
                child: cartController.listCart.isEmpty
                    ? const Center(child: Text("Kosong"))
                    : ListView(
                        children: cartController.listCart.map<Widget>((e) {
                          return Container(
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(16),
                            ),
                            margin: const EdgeInsets.only(bottom: 16),
                            child: Padding(
                              padding: const EdgeInsets.all(16),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(16),
                                    child: Image.network(
                                      e.productPhoto!,
                                      width: 88,
                                      height: 88,
                                    ),
                                  ),
                                  const SizedBox(width: 16),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          e.productName!,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        const SizedBox(height: 16),
                                        Text(
                                          "\$ ${(double.parse(e.productValue!) / 15143).toStringAsFixed(1)}",
                                          style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        const SizedBox(height: 16),
                                        Text("Size: ${e.productSize}"),
                                      ],
                                    ),
                                  ),
                                  Column(
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          setState(() {
                                            e.productCount =
                                                e.productCount! + 1;
                                          });
                                          cartController.summary();
                                        },
                                        child: const Icon(Icons.add_box),
                                      ),
                                      const SizedBox(height: 16),
                                      Text("${e.productCount}"),
                                      const SizedBox(height: 16),
                                      InkWell(
                                        onTap: () {
                                          setState(() {
                                            e.productCount =
                                                e.productCount! - 1;
                                          });
                                          if (e.productCount! < 1) {
                                            setState(() => e.productCount = 1);
                                            Get.defaultDialog(
                                              title: "Delete",
                                              middleText:
                                                  "Remove this product?",
                                              radius: 12,
                                              confirm: InkWell(
                                                onTap: () {
                                                  setState(() {
                                                    cartController
                                                        .removeProduct(
                                                            dataCart: e);
                                                    cartController.summary();
                                                  });
                                                  Get.back();
                                                },
                                                child: Container(
                                                  padding:
                                                      const EdgeInsets.all(16),
                                                  decoration: BoxDecoration(
                                                    color:
                                                        const Color(0xffff7845),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                  ),
                                                  child: const Center(
                                                    child: Text(
                                                      "Yes",
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              cancel: InkWell(
                                                onTap: () => Get.back(),
                                                child: Container(
                                                  padding:
                                                      const EdgeInsets.all(16),
                                                  decoration: BoxDecoration(
                                                    color: Colors.grey[200],
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                  ),
                                                  child: const Center(
                                                    child: Text("No"),
                                                  ),
                                                ),
                                              ),
                                            );
                                          }
                                          cartController.summary();
                                        },
                                        child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(2),
                                              border: Border.all(),
                                            ),
                                            child: const Icon(
                                              Icons.remove,
                                              size: 16,
                                            )),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        }).toList(),
                      ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Billing Information"),
                      const SizedBox(height: 32),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("Order Total"),
                          Text(
                            "\$ ${cartController.orderTotal.value.toStringAsFixed(1)}",
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("Tax"),
                          Text(
                            "\$ ${cartController.tax.value.toStringAsFixed(1)}",
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 32),
                      Row(
                        children: [
                          const Expanded(flex: 16, child: SizedBox()),
                          ...List.generate(
                              160 ~/ 10,
                              (index) => Expanded(
                                    child: Container(
                                      color: index % 2 == 0
                                          ? Colors.transparent
                                          : Colors.grey,
                                      height: 1.5,
                                    ),
                                  )),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("Grand Total"),
                          Text(
                            "\$ ${cartController.grandTotal.value.toStringAsFixed(1)}",
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Obx(() {
                return InkWell(
                  onTap: cartController.listCart.isEmpty
                      ? () {}
                      : () {
                          cartController.checkouts();
                        },
                  child: Container(
                    decoration: BoxDecoration(
                      color: cartController.listCart.isEmpty
                          ? Colors.grey[200]
                          : const Color(0xffff7845),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: ListTile(
                      leading: !cartController.isLoading.value
                          ? Icon(
                              Icons.add_shopping_cart_rounded,
                              color: cartController.listCart.isEmpty
                                  ? Colors.grey
                                  : Colors.white,
                            )
                          : const SizedBox(),
                      title: Center(
                        child: !cartController.isLoading.value
                            ? const Text("Checkout")
                            : const CircularProgressIndicator(
                                color: Colors.white,
                              ),
                      ),
                      textColor: cartController.listCart.isEmpty
                          ? Colors.grey
                          : Colors.white,
                      trailing: const SizedBox(),
                    ),
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
