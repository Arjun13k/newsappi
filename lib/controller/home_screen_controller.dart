import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:newsappi/model/news_api_model.dart';

class HomeScreenController with ChangeNotifier {
  List<String> category = [
    "business",
    "entertainment",
    "general",
    "health",
    "science",
    "sports",
    "technology"
  ];
  List<String> country = [
    "ae",
    "ar",
    "ata",
    "ub",
    "eb",
    "gb",
    "rc",
    "ach",
    "cn",
    "co",
    "cu",
    "cz",
    "de",
    "eg",
    "fr",
    "gb",
    "gr",
    "hk",
    "hu",
    "id",
    "ie",
    "il",
    "in",
    "it",
    "jp",
    "kr",
    "lt",
    "lv",
    "ma",
    "mx",
    "my",
    "ng",
    "nl",
    "no",
    "nz",
    "ph",
    "pl",
    "pt",
    "ro",
    "rs",
    "ru",
    "sa",
    "se",
    "sg",
    "sk",
    "th",
    "tr",
    "tw",
    "ua",
    "us",
    "ve",
    "za"
  ];
  NewsApiRestModel? restmodel;
  bool isLoading = false;

  NewsApiRestModel? restbyCategory;
  int categoryIndex = 0;
  NewsApiRestModel? restbyCounty;
  String CountryIndex = "ae";

  Future getCountyData() async {
    Uri url = Uri.parse(
        "https://newsapi.org/v2/top-headlines?country=${CountryIndex}&apiKey=76859884d96f4459b29d1c4a35da338b");

    var resp = await http.get(url);
    if (resp.statusCode == 200) {
      var decodedData = jsonDecode(resp.body);
      restbyCounty = NewsApiRestModel.fromJson(decodedData);
    } else {
      print("failed");
    }
    isLoading = false;
    notifyListeners();
  }

  getCOuntry(var value) {
    CountryIndex = value;
    getCategoryData();
    notifyListeners();
  }

  Future getCategoryData() async {
    isLoading = true;
    notifyListeners();
    Uri url = Uri.parse(
        "https://newsapi.org/v2/top-headlines?country=${CountryIndex}&category=${category[categoryIndex]}&apiKey=76859884d96f4459b29d1c4a35da338b");

// step 2
//  get uri with http
// api call
    var res = await http.get(url);

// step 3
// check the condition of status code
    if (res.statusCode == 200) {
      var decodeData = jsonDecode(res.body);

      // convert to model class
      restbyCategory = NewsApiRestModel.fromJson(decodeData);
      // state update
    } else {
      print("faild");
    }
    isLoading = false;
    notifyListeners();
  }

  getCategory(int value) {
    categoryIndex = value;
    getCategoryData();
    notifyListeners();
  }
//  step 1
//  get function for uri
//   getData() async {
//     isLoading = true;
//     notifyListeners();
//     Uri url = Uri.parse(
//         "https://newsapi.org/v2/everything?q=ipl&apiKey=76859884d96f4459b29d1c4a35da338b");

// // step 2
// //  get uri with http
// // api call
//     var res = await http.get(url);

// // step 3
// // check the condition of status code
//     if (res == 200) {
//       var decodeData = jsonDecode(res.body);

//       // convert to model class
//       restmodel = NewsApiRestModel.fromJson(decodeData);
//       // state update
//     } else {
//       print("faild");
//     }
//     isLoading = false;
//     notifyListeners();
//   }
}
