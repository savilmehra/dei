import 'dart:convert';

import 'package:objectbox/objectbox.dart';
import 'package:clean_framework/clean_framework_defaults.dart';

class ProductResponse extends JsonResponseModel {
  String? sTypename;
  Products? products;

  ProductResponse({this.sTypename, this.products});

  ProductResponse.fromJson(Map<String, dynamic> json) {
    sTypename = json['__typename'];
    products = json['products'] != null
        ? new Products.fromJson(json['products'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['__typename'] = this.sTypename;
    if (this.products != null) {
      data['products'] = this.products!.toJson();
    }
    return data;
  }

  @override
  List<Object?> get props => [sTypename, products];
}

@Entity()
class Products extends JsonResponseModel {
  String? sTypename;
  List<Items>? items;
  int? totalCount;
  @Id()
  int? id;

  Products({
    this.id = 0,
    this.sTypename,
    this.items,
    this.totalCount,
  });

  Products.fromJson(Map<String, dynamic> json) {
    sTypename = json['__typename'];
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items!.add(new Items.fromJson(v));
      });
    }
    totalCount = json['total_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['__typename'] = this.sTypename;
    if (this.items != null) {
      data['items'] = this.items!.map((v) => v.toJson()).toList();
    }
    data['total_count'] = this.totalCount;

    return data;
  }

  @override
  List<Object?> get props => [items, totalCount];
}

@Entity()

class Items {
  @Id()
  int? idDb;
  @Unique(onConflict: ConflictStrategy.replace)
  int? id;
  String? sku;
  String? name;
  String? urlKey;
  String? stockStatus;
  String? sTypename;
  @Transient()
  Image? thumbnail;

  List<String>? priceTiers;

  Items(
      {this.idDb = 0,
      this.id,
      this.sku,
      this.name,
      this.urlKey,
      this.stockStatus,
      this.sTypename,
      this.thumbnail,
      this.priceTiers});

  String? get dbImage => thumbnail == null ? null : json.encode(thumbnail);

  set dbImage(String? value) {
    if (value == null) {
      thumbnail = null;
    } else {
      thumbnail = Image.fromJson(jsonDecode(value));
    }
  }

  Items.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    sku = json['sku'];
    name = json['name'];
    urlKey = json['url_key'];
    stockStatus = json['stock_status'];
    sTypename = json['__typename'];
    thumbnail = json['thumbnail'] != null
        ? new Image.fromJson(json['thumbnail'])
        : null;

    if (json['price_tiers'] != null) {
      priceTiers = <String>[];
      json['price_tiers'].forEach((v) {
        priceTiers!.add("new String.fromJson(v)");
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['sku'] = this.sku;
    data['name'] = this.name;
    data['url_key'] = this.urlKey;
    data['stock_status'] = this.stockStatus;
    data['__typename'] = this.sTypename;

    if (this.thumbnail != null) {
      data['thumbnail'] = this.thumbnail!.toJson();
    }

    if (this.priceTiers != null) {
      data['price_tiers'] = this.priceTiers!.map((v) => "v.toJson()").toList();
    }
    return data;
  }
}

@Entity()

class Image {
  @Id()
  int? id;
  String? sTypename;
  String? url;
  String? label;
  String? position;


  Image({this.sTypename, this.url, this.label, this.position, this.id = 0});

  Image.fromJson(Map<String, dynamic> json) {
    sTypename = json['__typename'];
    url = json['url'];
    label = json['label'];
    position = json['position'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['__typename'] = this.sTypename;
    data['url'] = this.url;
    data['label'] = this.label;
    data['position'] = this.position;
    return data;
  }
}

class ProductImage {
  String? url;

  ProductImage({this.url});

  ProductImage.fromJson(Map<String, dynamic> json) {
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['url'] = this.url;
    return data;
  }
}
