import 'package:flutter/material.dart';
import 'package:badges/badges.dart'as badge;
import 'package:provider/provider.dart';
import '../Model/cart_model.dart';
import '../provider/book_provider.dart';
class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final Color myColor= Color(0xffC4E7ED);
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<BookProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: myColor,
        title: Text("Books",style: TextStyle(color: Colors.black),),
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
                                  Text(snapshot.data![index].productName.toString(),style: TextStyle(fontWeight: FontWeight.bold),),
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
            return Column(
              children: [
                Reusable(title: "Subtotal", value: value.getTotalPrice().toStringAsFixed(2))
              ],
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
    return Padding(padding: EdgeInsets.all(10),
    child: Row(
      children: [
        Text(title),
        Text(value),

      ],
    ),
    );
}}
