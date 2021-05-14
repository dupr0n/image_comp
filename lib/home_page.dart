import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import 'keys.dart';
import 'screens/compressed_image_page.dart';
import 'screens/original_image_page.dart';
import 'screens/overview_page.dart';
import 'widgets/custom_bottom_app_bar.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final ref = FirebaseDatabase.instance.reference();
  final controller = PageController(initialPage: 1);

  @override
  Widget build(BuildContext context) {
    const _orgTitle = 'Original';
    const _compTitle = 'Compressed';
    return OrientationBuilder(
      builder: (context, orientation) => Scaffold(
        appBar: AppBar(
          centerTitle: true,
          toolbarHeight: 60,
          title: Text(
            orientation == Orientation.portrait ? widget.title : 'Comparison',
            style: const TextStyle(
              fontFamily: 'DancingScript',
              fontWeight: FontWeight.w700,
              fontSize: 35,
            ),
          ),
          backgroundColor: Colors.transparent,
        ),
        floatingActionButton: orientation == Orientation.portrait
            ? FloatingActionButton(
                onPressed: () => controller.animateToPage(
                  1,
                  duration: const Duration(milliseconds: 1000),
                  curve: Curves.fastLinearToSlowEaseIn,
                ),
                child: const Icon(Icons.compare),
              )
            : null,
        bottomNavigationBar: orientation == Orientation.portrait
            ? CustomBottomAppBar(
                controller: controller,
                title1: _orgTitle,
                title2: _compTitle,
              )
            : null,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        body: StreamBuilder<DataSnapshot>(
          stream: ref.onValue.map((event) => event.snapshot),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting ||
                snapshot.connectionState == ConnectionState.none) {
              return const Center(child: CircularProgressIndicator());
            } else {
              final map = snapshot.data.value;
              final _orgImg = map[orgImgKey] as String;
              final _compImg = map[compImgKey] as String;
              final _orgSize = map[orgSizeKey] as int;
              final _compSize = map[compSizeKey] as int;
              return PageView(
                physics: const BouncingScrollPhysics(),
                controller: controller,
                children: orientation == Orientation.portrait
                    ? [
                        OriginalImagePage(
                          imgLink: _orgImg,
                          imgSize: _orgSize,
                          title: _orgTitle,
                        ),
                        OverviewPage(
                          orgImg: _orgImg,
                          orgSize: _orgSize,
                          orgTitle: _orgTitle,
                          compImg: _compImg,
                          compSize: _compSize,
                          compTitle: _compTitle,
                        ),
                        CompressedImagePage(
                          imgLink: _compImg,
                          imgSize: _compSize,
                          title: _compTitle,
                        ),
                      ]
                    : [
                        OverviewPage(
                          orgImg: _orgImg,
                          orgSize: _orgSize,
                          orgTitle: _orgTitle,
                          compImg: _compImg,
                          compSize: _compSize,
                          compTitle: _compTitle,
                        ),
                      ],
              );
            }
          },
        ),
      ),
    );
  }
}
