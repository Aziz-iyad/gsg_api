import 'package:gsg_api/Data/db_helper.dart';

class ProductResponse {
  int id;
  String title;
  var price;
  String description;
  String category;
  String image;
  Rating rating;

  ProductResponse(
      {this.id,
      this.title,
      this.price,
      this.description,
      this.category,
      this.image,
      this.rating});

  ProductResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    price = json['price'];
    description = json['description'];
    category = json['category'];
    image = json['image'];
    rating =
        json['rating'] != null ? new Rating.fromJson(json['rating']) : null;
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
      data['rating'] = this.rating.toJson();
    }
    return data;
  }

  ProductResponse.fromMap(Map map) {
    this.id = map[DbHelper.idColumnName];
    this.title = map[DbHelper.titleColumnName];
    this.description = map[DbHelper.descriptionColumnName];
    this.price = map[DbHelper.priceColumnName];
    this.category = map[DbHelper.categoryColumnName];
    this.image = map[DbHelper.imageColumnName];
  }
  toMap() {
    return {
      DbHelper.titleColumnName: this.title,
      DbHelper.descriptionColumnName: this.description,
      DbHelper.priceColumnName: this.price,
      DbHelper.categoryColumnName: this.category,
      DbHelper.imageColumnName: this.image,
    };
  }
}

class Rating {
  num rate;
  String count;

  Rating({this.rate, this.count});

  Rating.fromJson(Map<String, dynamic> json) {
    rate = json['rate'];
    count = json['count'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['rate'] = this.rate;
    data['count'] = this.count;
    return data;
  }
}
