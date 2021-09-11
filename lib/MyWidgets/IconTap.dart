import 'package:flutter/material.dart';
import 'package:gsg_api/services/constants.dart';

class IconTap extends StatelessWidget {
  IconData icon;
  String title;
  Color color;
  Color iconColor;
  Function function;
  IconTap({this.icon, this.title, this.color, this.iconColor, this.function});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Column(
        children: <Widget>[
          GestureDetector(
            onTap: function,
            child: Material(
              color: color,
              elevation: 8,
              borderRadius: BorderRadius.circular(20),
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Icon(
                  icon,
                  size: 30,
                  color: iconColor,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 12,
          ),
          Text(
            title,
            style: TextStyle(
              color: kMainColor,
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}
