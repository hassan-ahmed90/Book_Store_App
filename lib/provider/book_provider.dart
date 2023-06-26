import 'package:flutter/material.dart';
import 'package:shani_book_store/helper/dbhelper.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Model/cart_model.dart';

class BookProvider with ChangeNotifier{

  DbHelper db = DbHelper();

int _counter =0;
int get counter =>_counter;

double _totalPrice =0.0;
double get totalPrice => _totalPrice;

late Future<List<Cart>> _bookModel;
Future<List<Cart>>get bookModel => _bookModel;

void _setPrefBook()async{
  SharedPreferences pref = await SharedPreferences.getInstance();
  pref.setInt("cart_item",_counter);
  pref.setDouble("total_price",_totalPrice);
  notifyListeners();
}
void _getPrefItem()async{
SharedPreferences pref = await SharedPreferences.getInstance();
_counter = pref.getInt("cart_item")??0;
_totalPrice = pref.getDouble("total_price")??0;
notifyListeners();
}

Future<List<Cart>>getDate()async{
_bookModel=db.getBookList();
return _bookModel;
}

void addCounter(){
  _counter++;
  _setPrefBook();
  notifyListeners();
}

void removeCounter(){
  _counter--;
  _setPrefBook();
  notifyListeners();
}

int getCounter(){
_getPrefItem();
return _counter;
}

void addTotalPrice(double productPrice){
_totalPrice = _totalPrice+productPrice;
_setPrefBook();
notifyListeners();
}
void removeTotalPrice(double productPrice){
  _totalPrice= _totalPrice-productPrice;
  _setPrefBook();
  notifyListeners();
}

double getTotalPrice(){
  _getPrefItem();
  return _totalPrice;
}


}