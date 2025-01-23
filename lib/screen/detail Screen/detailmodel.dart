import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:http/http.dart' as https;
class DetailModel extends BaseViewModel{
  List detailScreen=[];

 getDetailScreen(String id )async{
  detailScreen=[];
  notifyListeners();
    var url=Uri.parse("https://www.themealdb.com/api/json/v1/1/lookup.php?i=$id");
    var response = await https.get(url);
    var responsebody=jsonDecode(response.body);
    detailScreen=responsebody['meals'];
    print(detailScreen);
    notifyListeners();
  }
}

