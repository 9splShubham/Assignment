class CartModel {
  int? id;
  int? userId;
  String? date;
  List<Products>? products;
  int? iV;

  CartModel({this.id, this.userId, this.date, this.products, this.iV});

  CartModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
    date = json['date'];
    if (json['products'] != null) {
      products = <Products>[];
      json['products'].forEach((v) {
        products!.add(new Products.fromJson(v));
      });
    }
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['userId'] = this.userId;
    data['date'] = this.date;
    if (this.products != null) {
      data['products'] = this.products!.map((v) => v.toJson()).toList();
    }
    data['__v'] = this.iV;
    return data;
  }
}

class Products {
  int? productId;
  int? quantity;

  Products({this.productId, this.quantity});

  Products.fromJson(Map<String, dynamic> json) {
    productId = json['productId'];
    quantity = json['quantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['productId'] = this.productId;
    data['quantity'] = this.quantity;
    return data;
  }
}

class CartProdModel {
  int? id;
  String? title;
  dynamic price;
  String? description;
  String? category;
  String? image;
  Rating? rating;
  int? userId;
  String? date;
  List<Products>? products;
  int? iV;

  CartProdModel(
      {this.id,
      this.title,
      this.price,
      this.description,
      this.category,
      this.image,
      this.rating,
      this.userId,
      this.date,
      this.products,
      this.iV});

  CartProdModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    price = json['price'];
    description = json['description'];
    category = json['category'];
    image = json['image'];
    rating =
        json['rating'] != null ? new Rating.fromJson(json['rating']) : null;
    userId = json['userId'];
    date = json['date'];
    if (json['products'] != null) {
      products = <Products>[];
      json['products'].forEach((v) {
        products!.add(new Products.fromJson(v));
      });
    }
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['price'] = this.price;
    data['description'] = this.description;
    data['category'] = this.category;
    data['image'] = this.image;
    if (this.rating != null) {
      data['rating'] = this.rating!.toJson();
    }
    data['userId'] = this.userId;
    data['date'] = this.date;
    if (this.products != null) {
      data['products'] = this.products!.map((v) => v.toJson()).toList();
    }
    data['__v'] = this.iV;
    return data;
  }
}

class Rating {
  double? rate;
  int? count;

  Rating({this.rate, this.count});

  Rating.fromJson(Map<String, dynamic> json) {
    rate = json['rate'];
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['rate'] = this.rate;
    data['count'] = this.count;
    return data;
  }
}
