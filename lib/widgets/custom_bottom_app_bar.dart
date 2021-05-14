import 'package:flutter/material.dart';

import 'nav_button.dart';

class CustomBottomAppBar extends StatelessWidget {
  final PageController controller;
  final String title1, title2;

  const CustomBottomAppBar({
    Key key,
    @required this.controller,
    this.title1,
    this.title2,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: Theme.of(context).primaryColor,
      shape: const CircularNotchedRectangle(),
      child: ClipRRect(
        child: SizedBox(
          height: 50,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              NavButton(
                controller: controller,
                iconData: Icons.cloud_upload_outlined,
                page: 0,
                title: title1,
              ),
              NavButton(
                controller: controller,
                iconData: Icons.cloud_download_outlined,
                page: 2,
                title: title2,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
