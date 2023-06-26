import 'package:flutter/material.dart';
import 'package:badges/badges.dart'as badge;
import 'package:provider/provider.dart';
import 'package:shani_book_store/helper/dbhelper.dart';
import 'package:shani_book_store/view/product_list_screen.dart';
import '../Model/cart_model.dart';
import '../provider/book_provider.dart';
class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}
final Color myColor= Color(0xffC4E7ED);

class _CartScreenState extends State<CartScreen> {

  DbHelper db = DbHelper();

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<BookProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: myColor,
        title: Text("Cart Screen",style: TextStyle(color: Colors.black,fontFamily: 'Satisfy',),),
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
          FutureBuilder(
            future: cart.getDate(),
              builder: (context,AsyncSnapshot <List<Cart>>snapshot){
            if(snapshot.hasData){
              if (snapshot.data!.isEmpty) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Center(
                      child: Image(
                          image: NetworkImage(
                              'https://cdni.iconscout.com/illustration/premium/thumb/empty-cart-4816550-4004141.png')),
                    ),
                    const Text(
                      'Looks like you haven'
                      r't added anything to your cart',
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const ProductListScreen()));
                        },
                        child: const Text(
                          'Explore now',
                          style: TextStyle(
                            color: Colors.blue,
                            decoration: TextDecoration.underline,
                          ),
                          selectionColor: Colors.lightBlue,
                        ))
                  ],
                );
              }
              return Expanded(
                  child: ListView.builder(
                  itemCount: snapshot.data!.length,
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
                                image: NetworkImage(snapshot.data![index].image.toString()),
                              ),
                              SizedBox(width: 30,),
                              Expanded(child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(snapshot.data![index].productName.toString(),style: TextStyle(fontWeight: FontWeight.bold),),
                                      InkWell(
                                          onTap: (){
                                            db.delete(snapshot.data![index].id!);
                                            cart.removeCounter();
                                            cart.removeTotalPrice(double.parse(snapshot.data![index].productPrice.toString()));

                                          },
                                          child: Icon(Icons.delete)),
                                    ],
                                  ),
                                  SizedBox(height: 10,),
                                  Text(snapshot.data![index].productPrice.toString()+" Rs"),
                                  SizedBox(height: 20,),
                                  InkWell(
                                    onTap: (){

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

                          Text(snapshot.data![index].productAuthor.toString()),
                        ],
                      ),
                    );
                  }));

            }else{
              return Text("h");
              
            }

          }),
          Consumer<BookProvider>(builder: (context,value,child){
            return Visibility(
              visible: value.getTotalPrice().toStringAsFixed(2)=="0.0" ? false:true,
              child: Column(
                children: [
                  Center(child: Reusable(title: " Subtotal ", value: value.getTotalPrice().toStringAsFixed(2)))
                ],
              ),
            );
          })
        ],
      ),

    );
  }
}

class Reusable extends StatelessWidget {
  const Reusable({Key? key,required this.title,required this.value}) : super(key: key);
  final String title, value;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        width: double.infinity,
        height: 50,
        color: myColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title,style: TextStyle(fontWeight: FontWeight.bold,),),
          Text(value,style: TextStyle(fontWeight: FontWeight.bold,),)
        ],
        ),
      ),
    );
}}
