
class ExampleCandidateModel {
  final String name;
  final String image;
  final String link;
  final String price;
  final String brand;

  ExampleCandidateModel({
    required this.name,
    required this.image,
    required this.link,
    required this.price,
    required this.brand,
  });
  // Define a toMap method to convert the model object to a map
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'image': image,
      'link': link,
      'price': price,
      'brand': brand,
    };
  }
  

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ExampleCandidateModel &&
        other.name == name &&
        other.image == image &&
        other.link == link &&
        other.price == price &&
        other.brand == brand;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        image.hashCode ^
        link.hashCode ^
        price.hashCode ^
        brand.hashCode;
  }
}



