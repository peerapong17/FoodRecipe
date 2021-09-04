import 'package:flutter/material.dart';
import 'package:food_search/services/food_service.dart';
import 'components/gradient_background.dart';
import 'components/recipe_tile.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  FoodService foodService = new FoodService();
  TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          gradient(context),
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
                        children: [
                          ...foodService.foodList.map(
                            (food) {
                              return GridTile(
                                child: FoodListTile(
                                  title: food.label,
                                  image: food.image,
                                  url: food.url,
                                ),
                              );
                            },
                          ),
                        ]
                        // children: List.generate(
                        //   foodList.length,
                        //   (index) {
                        //     return GridTile(
                        //       child: RecipieTile(
                        //         title: foodList[index].label,
                        //         imgUrl: foodList[index].image,
                        //         url: foodList[index].url,
                        //       ),
                        //     );
                        //   },
                        // ),

                        // children: [
                        //   ListView.builder(
                        //     itemCount: foodList.length,
                        //     itemBuilder: (context, index) {
                        //       return GridTile(
                        //         child: RecipieTile(
                        //           title: foodList[index].label,
                        //           imgUrl: foodList[index].image,
                        //           url: foodList[index].url,
                        //         ),
                        //       );
                        //     },
                        //   ),
                        // ],
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
            onTap: () async {
              if (textEditingController.text.trim().isNotEmpty &&
                  textEditingController.text.trim() != '') {
                await foodService.fetchData(textEditingController.text);
                setState(() {});
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
