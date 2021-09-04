
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:food_search/model/food_model.dart';

class FoodService{
  List<FoodModel> foodList = [];
  Future<void> fetchData(search) async {
    foodList = [];
    Uri url = Uri.parse(
        "https://api.edamam.com/search?q=$search&app_id=a5b396f7&app_key=c77396450747c8e39124fa88269218f9");

    http.Response response = await http.get(url);

    if (response.statusCode == 200) {
      Map<String, dynamic> jsonData = json.decode(response.body);

      jsonData['hits'].forEach(
        (data) {
          FoodModel foodData = FoodModel.fromJson(data['recipe']);
          foodList.add(foodData);
        },
      );
    }
  }
}