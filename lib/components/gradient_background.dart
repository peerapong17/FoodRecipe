  import 'package:flutter/cupertino.dart';

Container gradient(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [
          Color(0xff292929),
          Color(0xff4a4a4a),
          Color(0xff545454),
          Color(0xff5c5c5c)
        ], begin: Alignment.bottomLeft, end: Alignment.topRight),
      ),
    );
  }