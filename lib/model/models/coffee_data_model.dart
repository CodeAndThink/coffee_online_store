class CoffeeDataModel {
  final String name;
  final double price;
  final String url;

  CoffeeDataModel({
    required this.name,
    required this.price,
    required this.url,
  });

  // Chuyển đổi CoffeeDataModel thành JSON
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'price': price,
      'url': url,
    };
  }

  // Chuyển từ JSON thành CoffeeDataModel
  factory CoffeeDataModel.fromJson(Map<String, dynamic> json) {
    return CoffeeDataModel(
      name: json['name'],
      price: json['price'],
      url: json['url'],
    );
  }
}
