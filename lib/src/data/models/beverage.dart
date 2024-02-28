class Beverage {
  final int id;
  final String name;
  final double price;

  Beverage({
    required this.id,
    required this.name,
    required this.price,
  });

  factory Beverage.fromMap(Map<String, dynamic> map) {
    return Beverage(
      id: map['id'],
      name: map['name'],
      price: map['price'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'price': price,
    };
  }
}
