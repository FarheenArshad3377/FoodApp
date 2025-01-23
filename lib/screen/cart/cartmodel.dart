import 'dart:convert';
import 'package:stacked/stacked.dart';
import 'package:http/http.dart' as https;

class Cartmodel extends BaseViewModel {
  List cartDetail = [];

  Future<void> getCartdata(String id) async {
    var url = Uri.parse("https://www.themealdb.com/api/json/v1/1/lookup.php?i=$id");
    var response = await https.get(url);
    var resBody = jsonDecode(response.body);

    var newItem = resBody['meals'][0]; // Add the fetched meal to the cart
 if(!cartDetail.any((item)=>item['idMeal']==newItem['idMeal'])){
     cartDetail.add(newItem);
     print("cart Detail :$cartDetail");
     }
     else{
      print("Already Added");
     }
    notifyListeners(); // Notify listeners to update the UI
  }

    Future<void> removeData(int index)async {
  await cartDetail.removeAt(index);
    notifyListeners(); // Notify listeners when an item is removed
  }
}

