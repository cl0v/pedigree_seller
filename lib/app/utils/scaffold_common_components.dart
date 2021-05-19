import 'package:flutter/material.dart';
import 'package:pedigree_seller/app/components/custom_button_widget.dart';
import 'package:pedigree_seller/constants.dart';

class ScaffoldCommonComponents {
  static BottomAppBar customBottomAppBar(
      String title, VoidCallback onPressed, BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BottomAppBar(
      color: Colors.transparent,
      elevation: 0,
      child: Padding(
        padding: EdgeInsets.fromLTRB(
          size.width * 0.1,
          0,
          size.width * 0.1,
          8,
        ),
        child: CustomButtonWidget(
          title: title,
          onPressed: onPressed,
        ),
      ),
    );
  }

  static AppBar customAppBar(String title, VoidCallback onLeadingPressed) {
    return AppBar(
      brightness: Brightness.light,
      backgroundColor: Colors.transparent,
      elevation: 0,
      centerTitle: true,
      title: Text(
        title,
        style: kTitleTextStyle,
      ),
      leading: Builder(builder: (BuildContext context) {
        return IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.grey[800],
          ),
          onPressed: onLeadingPressed,
        );
      }),
    );
  }
}
