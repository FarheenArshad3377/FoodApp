import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:stacked/stacked.dart';
import 'package:http/http.dart' as https;
class Favmodel extends BaseViewModel {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<Map<String, dynamic>> favThing = [];

  // Function to get a favorite by its ID
  Future<void> getFav(String id) async {
    var url = Uri.parse("https://www.themealdb.com/api/json/v1/1/lookup.php?i=$id");
    var response = await https.get(url);
    var resBody = jsonDecode(response.body);
    
    var newItem = resBody['meals'][0];

    // Avoid adding the same item again
    if (!favThing.any((item) => item['idMeal'] == newItem['idMeal'])) {
      favThing.add(newItem);
      print("Added to favorites: $favThing");
    } else {
      print("Already Added");
    }

    notifyListeners();  // Notify listeners to update the UI
  }
  Future<void>DeleteCart(int index)async{
    await favThing.removeAt(index);
    notifyListeners();
  }
}

