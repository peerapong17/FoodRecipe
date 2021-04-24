import 'package:flutter/material.dart';
import 'package:food_search/ListTile/recipe_tile.dart';
import 'package:food_search/ListTile/web_view.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:get/get.dart';
import 'model/food_model.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<FoodModel> foodList = [];
  var jsonResponse;
  TextEditingController textEditingController = TextEditingController();

  fetchData(search) async {
    var url = Uri.parse(
        "https://api.edamam.com/search?q=$search&app_id=a5b396f7&app_key=c77396450747c8e39124fa88269218f9");

    var response = await http.get(url);

    if (response.statusCode == 200) {
      Map<String, dynamic> jsonData = convert.jsonDecode(response.body);

      jsonData['hits'].forEach(
        (data) {
          FoodModel foodData = FoodModel.fromJson(data['recipe']);
          foodList.add(foodData);
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          graDient(context),
          SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 50, horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Food',
                        style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      Text(
                        'Recipes',
                        style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Color(0xff47d1ff)),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Text(
                    'What will you cook Today?',
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  Text(
                    'Just enter ingredient you have and we will show you the best recipes',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  searchBar(),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    child: GridView(
                      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                          mainAxisSpacing: 50.0,
                          crossAxisSpacing: 10.0,
                          maxCrossAxisExtent: 200.0),
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      physics: ClampingScrollPhysics(),
                      children: List.generate(
                        foodList.length,
                        (index) {
                          return GridTile(
                            child: RecipieTile(
                              title: foodList[index].label,
                              imgUrl: foodList[index].image,
                              url: foodList[index].url,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Container graDient(BuildContext context) {
    return Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [
                  Color(0xff292929),
                  Color(0xff4a4a4a),
                  Color(0xff545454),
                  Color(0xff5c5c5c)
                ],
                begin: FractionalOffset.bottomLeft,
                end: FractionalOffset.topRight),
          ),
        );
  }

  Container searchBar() {
    return Container(
      child: Row(
        children: <Widget>[
          Expanded(
            child: TextField(
              controller: textEditingController,
              style: TextStyle(
                fontSize: 16,
                color: Colors.white,
              ),
              decoration: InputDecoration(
                hintText: "Enter Ingridients",
                hintStyle: TextStyle(
                    fontSize: 16,
                    color: Colors.white.withOpacity(0.3),
                    fontFamily: 'Overpass'),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
              ),
            ),
          ),
          SizedBox(
            width: 16,
          ),
          InkWell(
            onTap: () {
              if (textEditingController.text.isNotEmpty &&
                  textEditingController.text != null) {
                fetchData(textEditingController.text);
              }
            },
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  gradient: LinearGradient(
                      colors: [Color(0xffff2600), Color(0xffff9d00)],
                      begin: FractionalOffset.topRight,
                      end: FractionalOffset.bottomLeft)),
              padding: EdgeInsets.all(8),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Icon(Icons.search, size: 18, color: Colors.white),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}


