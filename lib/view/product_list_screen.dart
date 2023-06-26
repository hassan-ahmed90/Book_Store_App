import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badge;
import 'package:provider/provider.dart';
import 'package:shani_book_store/Model/cart_model.dart';
import 'package:shani_book_store/helper/dbhelper.dart';
import 'package:shani_book_store/provider/book_provider.dart';
import 'package:shani_book_store/view/cart_screen.dart';
class ProductListScreen extends StatefulWidget {
  const ProductListScreen({Key? key}) : super(key: key);

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {

  final Color myColor= Color(0xffC4E7ED);
  List<int> productPrice = [10, 20, 30, 40, 50, 60, 70, 90, 66, 43];
  List<String> bookAuthor = [
    "Khaled Hosseini",
    "Mark Manson",
    "James Clear",
    "Harper Lee",
    "J.K Rowling",
    "Elif Shafak",
    "Carl Sagan",
    "Conan Doyle",
    "Stephen Hawking",
    "Joshua Foer",
  ];
  List<String> bookNames = [
    "A thousand\nsplendid Suns",
    "The subtle art \nof not giving\n a fuck",
    "Atomic Habits",
    "To kill\na mocking bird",
    "Harry Potter\n S1",
    "The forty\nrules of love",
    "Cosmos",
    "A study in scarlet",
    "The great design",
    "Moonwalking\n with Einstein",
  ];
  List<String> bookCovers = [
    "https://www.libertybooks.com/image/cache/catalog/9781526604767-8-313x487.jpg?q6",
    "https://www.libertybooks.com/image/cache/catalog/fuck-640x996.jpg?q6",
    "https://images.squarespace-cdn.com/content/v1/5e34962e0a9a7332891cac30/1591399219133-0CSBL3BQS1TA2WE5ZWV1/Screen+Shot+2020-06-05+at+4.11.57+PM.png?format=1000w",
    "https://m.media-amazon.com/images/M/MV5BNmVmYzcwNzMtMWM1NS00MWIyLThlMDEtYzUwZDgzODE1NmE2XkEyXkFqcGdeQXVyNzkwMjQ5NzM@._V1_FMjpg_UX1000_.jpg", //tokillmockingbird
    "https://res.cloudinary.com/bloomsbury-atlas/image/upload/w_360,c_scale/jackets/9781408855652.jpg", //hp
    "https://kbimages1-a.akamaihd.net/4e1e8de5-d6ab-4d23-9509-31c0f1e8b96e/353/569/90/False/the-forty-rules-of-love.jpg", //fol
    "https://www.libertybooks.com/image/cache/catalog/9780349107035-640x996.jpg?q6", //cosmos
    "https://m.media-amazon.com/images/I/41jNoiUgf3L.jpg", //studyinscarlet
    "https://upload.wikimedia.org/wikipedia/en/1/10/The_grand_design_book_cover.jpg",
    "https://kbimages1-a.akamaihd.net/6c5ec830-036d-4d17-a7f4-67cb981f493c/353/569/90/False/moonwalking-with-einstein.jpg", //mw
  ];
  final seachController= TextEditingController();
  @override
  Widget build(BuildContext context) {
    DbHelper db = DbHelper();
    final cart = Provider.of<BookProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: myColor,
        title: Text("Books Store",style: TextStyle(color: Colors.black,fontFamily: 'Satisfy'),),
        centerTitle: true,
        actions: [
          Center(
            child: InkWell(
              onTap: (){ Navigator.push(context, MaterialPageRoute(builder: (context)=>CartScreen()));},
              child: badge.Badge(
                child: Icon(Icons.shopping_cart,color: Colors.black,),
                badgeContent: Consumer<BookProvider>(
                  builder: (context,value,child){
                    return Text(value.getCounter().toString(),style: TextStyle(color: Colors.white));
                  },
                ),

              ),
            ),
          ),
          SizedBox(width: 20,),
        ],
      ),
      body: Column(
        children: [
          SizedBox(height: 10,),
          Padding(padding: EdgeInsets.all(10),
          child: TextFormField(
            controller: seachController,
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.search),
              contentPadding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
              hintText: "Seach Book",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(50),
              )
            ),
          ),),
          SizedBox(height: 15,),
         Expanded(
             child: ListView.builder(
             itemCount: bookCovers.length,
             itemBuilder: (context,index){
           return Card(
             child: Column(
               mainAxisAlignment: MainAxisAlignment.center,
               crossAxisAlignment: CrossAxisAlignment.start,
               children: [
                 Row(
                   mainAxisAlignment: MainAxisAlignment.start,
                   crossAxisAlignment: CrossAxisAlignment.center,
                   children: [
                    Image(
                      fit: BoxFit.fill,
                      height:150,
                      width: 100,
                      image: NetworkImage(bookCovers[index].toString()),
                    ),
                     SizedBox(width: 30,),
                     Expanded(child: Column(
                       mainAxisAlignment: MainAxisAlignment.start,
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                         Text(bookNames[index].toString(),style: TextStyle(fontWeight: FontWeight.bold),),
                         SizedBox(height: 10,),
                         Text(productPrice[index].toString()+" Rs"),
                         SizedBox(height: 20,),
                         InkWell(
                           onTap: (){
                             db.insert(Cart(
                                 id: index,
                                 productPrice: productPrice[index],
                                 image: bookCovers[index].toString(),
                                 productName: bookNames[index].toString(),
                                 initialPrice: productPrice[index],
                                 quantity: 1,
                                 productId: index.toString(),
                                  productAuthor: bookAuthor[index].toString())).then((value) {
                                    cart.addTotalPrice(double.parse(productPrice[index].toString()));
                                    cart.addCounter();
                                    print('Item added');
                                        }).onError((error, stackTrace) {
                               print(error.toString());
                                        });
                           },
                           child: Container(
                             decoration: BoxDecoration(
                               color: myColor,
                               borderRadius: BorderRadius.circular(50),
                             ),
                             height: 35,
                             width: 220,
                             child: Center(child: Text("Add to Cart"),),
                           ),
                         )
                       ],
                     ))
                   ],

                 ),

                 Text("Author: "+bookAuthor[index].toString()),
               ],
             ),
           );
         })
         )
        ],
      )
    );
  }
}
