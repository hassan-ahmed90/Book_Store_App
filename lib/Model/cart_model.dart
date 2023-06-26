class Cart{

  late final int? id;
  final int? productPrice;
  final int?initialPrice;
  final int?quantity;
  final String?productAuthor;
  final String?image;
  final String?productName;
  final String?productId;

  Cart({required this.id,
  required this.productPrice,
  required this.image,
  required this.productName,
  required this.initialPrice,
  required this.quantity,
  required this.productId,
  required this.productAuthor});

  Cart.fromMap(Map<dynamic,dynamic> res):
        id = res['id'],
  productId= res['productId'],
  productName= res['productName'],
  productPrice=res['productPrice'],
  quantity=res['quantity'],
  productAuthor= res['productAuthor'],
  image= res['image'],
  initialPrice= res['initialPrice'];

  Map<String,Object?> toMap(){
    return{
      'id':id,
      'productId':productId,
      'productName':productName,
      'productPrice':productPrice,
      'initialPrice':initialPrice,
      'quantity':quantity,
      "productAuthor":productAuthor,
      'image':image
    };
  }

}