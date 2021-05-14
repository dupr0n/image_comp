import 'package:flutter/material.dart';

class NavButton extends StatelessWidget {
  const NavButton({
    Key key,
    @required this.controller,
    @required this.title,
    @required this.page,
    @required this.iconData,
  }) : super(key: key);

  final PageController controller;
  final String title;
  final int page;
  final IconData iconData;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        iconData,
        color: Colors.white.withOpacity(0.85),
      ),
      iconSize: 33,
      onPressed: () async => controller.animateToPage(page,
          duration: const Duration(milliseconds: 1000), curve: Curves.fastLinearToSlowEaseIn),
      tooltip: title,
    );
  }
}
