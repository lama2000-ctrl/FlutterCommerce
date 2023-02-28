class Product{
 int? _totalSize;
 int? _typeId;
 int? _offSet;
 late List<ProductModel> _products;
List<ProductModel> get products =>_products;
  Product({required totalSize, required typeId,required offSet,required products}){
this._totalSize=totalSize;
this._typeId=typeId;
this._offSet=offSet;
this._products=products;
  }
  Product.fromJson(Map<String,dynamic> json){
    _totalSize=json["totalSize"];
    _typeId=json["typeId"];
    _offSet=json["offSet"];
    if(json["products"]!=null){
      _products=<ProductModel>[];
      json["products"].forEach((v){
        _products.add(ProductModel.fromJson(v));
      });
    }
  }

}

class ProductModel{
  int? id;
  String? name;
  String? description;
  int? price;
  int? stars;
  String? img;
  String? location;
  String? createdAt;
  String? updatedAt;
  int? typeId;
ProductModel({this.id,
this.name,this.description,this.location,
this.img,this.price,this.stars});
ProductModel.fromJson(Map<String,dynamic> json){
id=json["id"];
name=json["name"];
description=json["description"];
price=json["price"];
stars=json["stars"];
location=json["location"];
img=json["img"];
createdAt=json["created_at"];
updatedAt=json["updated_at"];
typeId=json["typeId"];
}
Map<String,dynamic> toJson()
{
  return{
  "id": this.id,
  "name": this.name,
  "price": this.price,
  "img":this.img,
  "location": this.location,
  "createdAt":this.createdAt,
  "updatedAt":this.updatedAt,
  "typeId":this.typeId,
  };
}
}