import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:http/http.dart' as https;
class HomeModel extends ChangeNotifier {
  List  randomRec=[];
  List randomPasta=[];
  List searchList=[];
  List randomAll=[];
  List randomDessert=[];
  final TextEditingController controllerSearch=TextEditingController();
  final controller=PageController();
   bool isGetdata=true;
 Map <String,dynamic> userData={"email":"abc@gmail.com","name":"ABC"};
 final FirebaseFirestore firestore=FirebaseFirestore.instance;
//get user name
   getUsername()async{
   var user= FirebaseAuth.instance.currentUser!;
   if(user != null){
      DocumentSnapshot userDataSnapshot=await firestore.collection('users').doc(user.uid).get();
      userData={
        'email':userDataSnapshot['email']??'abc@gmail.com',
        'name':userDataSnapshot['name']??'ABC',
      };
   }
   notifyListeners();
   }

   //get Api for chicken
  getApi()async{
    var url=Uri.parse("https://www.themealdb.com/api/json/v1/1/search.php?s=Chicken");
    var response= await https.get(url);
    var body= jsonDecode(response.body);
    randomRec = body['meals'];
    print(randomRec);
    isGetdata=false;
    notifyListeners();
  }
  //get Api for pasta
  getApiPasta()async{
    var url=Uri.parse("https://www.themealdb.com/api/json/v1/1/filter.php?a=Canadian");
    var response= await https.get(url);
    var body= jsonDecode(response.body);
    randomPasta = body['meals'];
    print(randomPasta);
    isGetdata=false;
    notifyListeners();
  }  
  //get Api for burger
  getApiAll()async{
    var url=Uri.parse("https://www.themealdb.com/api/json/v1/1/search.php?f=a");
    var response= await https.get(url);
    var body= jsonDecode(response.body);
    randomAll = body['meals'];
    print(randomAll);
    isGetdata=false;
    notifyListeners();
  }
   //get Api for burger
  getApiDessert()async{
    var url=Uri.parse("https://www.themealdb.com/api/json/v1/1/filter.php?c=Dessert");
    var response= await https.get(url);
    var body= jsonDecode(response.body);
    randomDessert = body['meals'];
    print(randomDessert);
    isGetdata=false;
    notifyListeners();
  }
  //search Function
// filterData function:
void filterData(String query) {
  if (query.isEmpty) {
    searchList = []; // Clear the list when search query is empty
  } else {
    searchList = randomRec.where((data) {
      final title = data['strMeal']?.toLowerCase() ?? ''; // Safe null check
      return title.contains(query.toLowerCase());
    }).toList();
  }
  notifyListeners(); // Notify listeners so UI can update
}

final Set<String> favorites = {}; // Store favorite meal IDs

  void toggleFavorite(String mealId) {
    if (favorites.contains(mealId)) {
      favorites.remove(mealId); // Remove from favorites if it exists
    } else {
      favorites.add(mealId); // Add to favorites if it doesn't exist
    }
    notifyListeners(); // Update the UI
  }

}

