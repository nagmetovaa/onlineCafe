class History {
  final int id;
  final String name;
  final String desk;
  final double price;

  History({
    required this.id,
    required this.name,
    required this.desk,
    required this.price,
  });

  factory History.fromMap(Map<String, dynamic> map) {
    return History(
      id: map['id'],
      name: map['name'],
      desk: map['desk'],
      price: map['price'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'desk': desk,
      'price': price,
    };
  }
}
