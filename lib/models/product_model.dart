class Product {
  Product({
    this.tableProduct,
    this.tableProduct1,
  });

  List<TableProduct>? tableProduct;
  List<TableProduct1>? tableProduct1;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        tableProduct: json["TableProduct"] == null
            ? []
            : List<TableProduct>.from(
                json["TableProduct"]!.map((x) => TableProduct.fromJson(x))),
        tableProduct1: json["TableProduct1"] == null
            ? []
            : List<TableProduct1>.from(
                json["TableProduct1"]!.map((x) => TableProduct1.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "TableProduct": tableProduct == null
            ? []
            : List<dynamic>.from(tableProduct!.map((x) => x.toJson())),
        "TableProduct1": tableProduct1 == null
            ? []
            : List<dynamic>.from(tableProduct1!.map((x) => x.toJson())),
      };
}

class TableProduct {
  TableProduct({
    this.no,
    this.productId,
    this.productName,
    this.productDescription,
    this.productValue,
    this.productType,
    this.productPhoto,
    this.productCount,
    this.productSize,
  });

  int? no;
  String? productId;
  String? productName;
  String? productDescription;
  String? productValue;
  String? productType;
  String? productPhoto;
  int? productCount;
  String? productSize;

  factory TableProduct.fromJson(Map<String, dynamic> json) => TableProduct(
        no: json["NO"],
        productId: json["productId"],
        productName: json["productName"],
        productDescription: json["productDescription"],
        productValue: json["productValue"],
        productType: json["productType"],
        productPhoto: json["productPhoto"],
        productCount: json["productCount"] ?? 0,
        productSize: json["productSize"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "NO": no,
        "productId": productId,
        "productName": productName,
        "productDescription": productDescription,
        "productValue": productValue,
        "productType": productType,
        "productPhoto": productPhoto,
        "productCount": productCount,
        "productSize": productSize,
      };
}

class TableProduct1 {
  TableProduct1({
    this.totalPage,
  });

  int? totalPage;

  factory TableProduct1.fromJson(Map<String, dynamic> json) => TableProduct1(
        totalPage: json["totalPage"],
      );

  Map<String, dynamic> toJson() => {
        "totalPage": totalPage,
      };
}
