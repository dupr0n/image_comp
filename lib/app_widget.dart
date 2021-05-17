import 'package:flutter/material.dart';

import 'home_page.dart';

class AppWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Image Compression Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        primaryColor: Colors.blueGrey.shade800,
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.indigo.shade700),
                minimumSize: MaterialStateProperty.all(const Size(120, 60)))),
        textTheme: const TextTheme(
          headline3: TextStyle(fontFamily: 'OpenSans', fontWeight: FontWeight.w600),
          headline5: TextStyle(fontFamily: 'OpenSans', fontWeight: FontWeight.w600),
          headline6: TextStyle(fontFamily: 'OpenSans', fontStyle: FontStyle.italic),
        ),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: Colors.indigo.shade700,
          foregroundColor: Colors.white,
        ),
      ),
      home: const MyHomePage(title: 'Image Compression Demo'),
    );
  }
}
