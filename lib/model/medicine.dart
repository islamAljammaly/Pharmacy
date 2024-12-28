class Medicine {
  String? id;
  String? name;
  String? category;
  String? price;
  String? image;
  String? details;

  Medicine({
    this.id,
    this.name,
    this.category,
    this.price,
    this.image,
    this.details,
  });


  Medicine.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    category = json['category'];
    price = json['price'];
    image = json['image'];
    details = json['details'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['category'] = category;
    data['price'] = price;
    data['image'] = image;
    data['details'] = details;
    return data;
  }
}
