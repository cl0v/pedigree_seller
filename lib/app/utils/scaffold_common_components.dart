import 'package:flutter/material.dart';
import 'package:pedigree_seller/app/components/custom_button_widget.dart';
import 'package:pedigree_seller/app/utils/nav.dart';
import 'package:pedigree_seller/app/utils/screen_size.dart';
import 'package:pedigree_seller/constants.dart';

class ScaffoldCommonComponents {
  static AppBar customAppBarWithoutIcons(String title) {
    return AppBar(
      brightness: Brightness.light,
      backgroundColor: Colors.transparent,
      elevation: 0,
      centerTitle: true,
      automaticallyImplyLeading: false,
      title: Text(
        title,
        style: kTitleTextStyle,
      ),
    );
  }

  static BottomAppBar customBottomAppBar(
      String title, VoidCallback onPressed, BuildContext context) {
    Size size = getSize(context);
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
          title,
          onPressed: onPressed,
        ),
      ),
    );
  }

  static AppBar customAppBarWithDrawerAndAction(
    String title,
    IconData actionButtonIcon,
    VoidCallback onActionButtonPressed,
  ) {
    return AppBar(
      brightness: Brightness.light,
      backgroundColor: Colors.transparent,
      elevation: 0,
      title: Text(
        title,
        style: kTitleTextStyle,
      ),
      leading: Builder(builder: (BuildContext context) {
        return IconButton(
          icon: Icon(
            Icons.sort,
            color: Colors.grey[800],
          ),
          onPressed: () => Scaffold.of(context).openDrawer(),
          tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
        );
      }),
      actions: [
        Padding(
          padding: EdgeInsets.only(right: 16),
          child: IconButton(
            icon: Icon(
              actionButtonIcon,
              color: Colors.grey[800],
            ),
            onPressed: onActionButtonPressed,
          ),
        ),
      ],
    );
  }

  static AppBar customAppBarWithDrawerWithoutAction(
    String title,
  ) {
    return AppBar(
      brightness: Brightness.light,
      backgroundColor: Colors.transparent,
      elevation: 0,
      title: Text(
        title,
        style: kTitleTextStyle,
      ),
      leading: Builder(
        builder: (BuildContext context) {
          return IconButton(
            icon: Icon(
              Icons.sort,
              color: Colors.grey[800],
            ),
            onPressed: () => Scaffold.of(context).openDrawer(),
            tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
          );
        },
      ),
    );
  }

  static AppBar customAppBar(String title, VoidCallback? onLeadingPressed) {
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
