class Dog{
  String? name,des,image,breed;
  int? price;
  int? id;
  Dog({
    this.id,
    this.name,
    this.des,
    this.image,
    this.breed,
    this.price,
  });

  Map<String, dynamic> toJson() {
    return {
      'id':this.id,
      'name': this.name,
      'des': this.des,
      'image': this.image,
      'breed': this.breed,
      'price': this.price,
    };
  }

  factory Dog.fromJson(Map<String, dynamic> map) {
    return Dog(
      name: map['name'] as String,
      des: map['des'] as String,
      image: map['image'] as String,
      breed: map['breed'] as String,
      price: map['price'] as int,
      id:map['id'] as int
    );
  }
}