// To parse this JSON data, do
//
//     final tableProductCart = tableProductCartFromJson(jsonString);

import 'dart:convert';

List<TableProductCart> tableProductCartFromJson(String str) =>
    List<TableProductCart>.from(
        json.decode(str).map((x) => TableProductCart.fromJson(x)));

String tableProductCartToJson(List<TableProductCart> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TableProductCart {
  TableProductCart({
    this.detail1,
    this.detail2,
    this.detail3,
    this.detail4,
  });

  String? detail1;
  String? detail2;
  String? detail3;
  String? detail4;

  factory TableProductCart.fromJson(Map<String, dynamic> json) =>
      TableProductCart(
        detail1: json["detail1"],
        detail2: json["detail2"],
        detail3: json["detail3"],
        detail4: json["detail4"],
      );

  Map<String, dynamic> toJson() => {
        "detail1": detail1,
        "detail2": detail2,
        "detail3": detail3,
        "detail4": detail4,
      };
}
