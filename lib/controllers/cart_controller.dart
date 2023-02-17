import 'dart:convert';

import 'package:aos_test/models/cart_product_model.dart';
import 'package:aos_test/models/product_model.dart';
import 'package:aos_test/services/service.dart';
import 'package:aos_test/utils/constant.dart';
import 'package:aos_test/views/main_menu.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartController extends GetxController {
  var isLoading = false.obs;
  var isError = false.obs;
  var error = "".obs;
  var listCart = <TableProduct>[];
  var orderTotal = 0.0.obs;
  var grandTotal = 0.0.obs;
  var tax = 0.0.obs;

  void addProduct({required TableProduct dataCart}) {
    var contains = listCart.where((e) => e.productId == dataCart.productId);
    if (contains.isEmpty) {
      dataCart.productCount = 1;
      listCart.add(dataCart);
    }
  }

  void removeProduct({required TableProduct dataCart}) {
    listCart.removeWhere((e) => e.productId == dataCart.productId);
  }

  void summary() {
    orderTotal.value = 0.0;
    tax.value = 0.0;
    grandTotal.value = 0.0;
    for (var i in listCart) {
      orderTotal.value = orderTotal.value +
          ((double.parse(i.productValue!) / 15143) * i.productCount!);
    }
    tax.value = orderTotal * .1;
    grandTotal.value = orderTotal.value - tax.value;
  }

  void checkouts() async {
    isLoading(true);
    var list = <TableProductCart>[];
    for (var i in listCart) {
      list.add(
        TableProductCart(
          detail1: "${i.productId}",
          detail2: "${i.no}",
          detail3: "${i.productValue}",
          detail4: "",
        ),
      );
    }
    GlobalService().post(
      checkout,
      {
        "key": "YhNnM/2K++gp/FMWA+m0Pg==",
        "pmethod": "insert sales",
        "pdata1": "SO-1112",
        "pdata2": "Puri",
        "pdata3": "Grab Instan",
        "pdata4": "OVO",
        "pdata5": "JK",
        "pdata6": "1",
        "pdata7": "4",
        "pdata8": "",
        "pdata9": "",
        "pdata10": "",
        "pdataDetail": tableProductCartToJson(list),
        "pdevice": "",
        "pgcm_id": ""
      },
    ).then((v) {
      isLoading(false);
      isError(false);
      error.value = "";
      var body = jsonDecode(v.body);
      if (body["success"]) {
        Get.defaultDialog(
          title: "Success",
          titleStyle: TextStyle(color: Colors.green[400]),
          middleText: "Data has been sent",
          barrierDismissible: false,
          confirm: InkWell(
            onTap: () {
              listCart = [];
              summary();
              Get.offAll(
                const MainMenu(),
                transition: Transition.zoom,
              );
            },
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xffff7845),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Center(
                child: Text(
                  "Back to Home",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
        );
      } else {
        isError(true);
        error.value = "Terjadi Kesalahan1";
      }
    }).catchError((e) {
      print(e);
      isLoading(false);
      isError(true);
      error.value = "Terjadi Kesalahan2";
    });
  }
}
