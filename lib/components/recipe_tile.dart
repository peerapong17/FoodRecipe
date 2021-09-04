import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_search/components/web_view.dart';

class FoodListTile extends StatefulWidget {
  final String? title, image, url;

  FoodListTile({this.title, this.image, this.url});

  @override
  _FoodListTileState createState() => _FoodListTileState();
}

class _FoodListTileState extends State<FoodListTile> {
  String noImageFound =
      "https://lh3.googleusercontent.com/proxy/h-DAiiuIbtxpp6P41fno-TVHsgmeMzXVeC7w-h2qoYHeDSytCSIhSPOHjlBsiuX_jMJRcs4G1AlLAfZwN7JcXALXbdxccIJlrLTUV8TdtoxyQ50FBTDYX1zP9kPrYlboVSM";

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: <Widget>[
        GestureDetector(
          onTap: widget.url != null
              ? () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) {
                        return RecipeView(
                          postUrl: widget.url!,
                        );
                      },
                    ),
                  );
                }
              : () {},
          child: Container(
            margin: EdgeInsets.all(8),
            child: Stack(
              children: <Widget>[
                Image.network(
                  widget.image ?? noImageFound,
                  height: 200,
                  width: 200,
                  fit: BoxFit.cover,
                ),
                Container(
                  width: 200,
                  alignment: Alignment.bottomLeft,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [Colors.white30, Colors.white],
                          begin: FractionalOffset.centerRight,
                          end: FractionalOffset.centerLeft)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          widget.title ?? "No Title",
                          style: TextStyle(
                              fontSize: 13,
                              color: Colors.black54,
                              fontFamily: 'Overpass'),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
