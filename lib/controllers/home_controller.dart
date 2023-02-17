import 'dart:convert';

import 'package:aos_test/models/product_model.dart';
import 'package:aos_test/services/service.dart';
import 'package:aos_test/utils/constant.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  var isLoading = false.obs;
  var isError = false.obs;
  var error = "".obs;
  var list = <TableProduct>[];

  void init() {
    isLoading(false);
    isError(false);
    error.value = "";
    list = <TableProduct>[];
  }

  void getProduct() async {
    isLoading(true);
    GlobalService().post(
      getproduct,
      {
        "key": "YhNnM/2K++gp/FMWA+m0Pg==",
        "pmethod": "Get Product",
        "pemail": "JK",
        "pwhere1": "",
        "pwhere2": "",
        "pwhere3": "",
        "pwhere4": "",
        "pwhere5": "",
        "pwhere6": "1",
        "pwhere7": "4",
        "pwhere8": "",
        "pdevice": "",
        "pgcm_id": "",
        "pversion": ""
      },
    ).then((v) {
      isLoading(false);
      isError(false);
      error.value = "";
      var body = jsonDecode(v.body);
      if (body["success"]) {
        list = (jsonDecode(body['data'])['Table'] as List)
            .map<TableProduct>((e) => TableProduct.fromJson(e))
            .toList();
      } else {
        isError(true);
        error.value = "Terjadi Kesalahan";
      }
    }).catchError((e) {
      print(e);
      isLoading(false);
      isError(true);
      error.value = "$e";
    });
  }
}
