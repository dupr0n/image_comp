import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import 'keys.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _orgImg = '';
  int _orgSize = 0;
  String _compImg = '';
  int _compSize = 0;
  final ref = FirebaseDatabase.instance.reference();

  Future<void> _refresh() async {
    final snap = await ref.orderByKey().once();
    final map = snap.value;
    setState(() {
      _orgImg = map[orgImgKey];
      _orgSize = map[orgSizeKey];
      _compImg = map[compImgKey];
      _compSize = map[compSizeKey];
      print('$_orgImg\n$_orgSize\n\n$_compImg\n$_compSize\n\n');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: FutureBuilder<DataSnapshot>(
        future: ref.once(),
        builder: (context, snap) {
          return snap.hasData
              ? StreamBuilder<DataSnapshot>(
                  stream: ref.onChildChanged.map((event) => event.snapshot),
                  initialData: snap.data,
                  builder: (context, snapshot) {
                    final map = snapshot.data.value;
                    _orgImg = map[orgImgKey];
                    _orgSize = map[orgSizeKey];
                    _compImg = map[compImgKey];
                    _compSize = map[compSizeKey];
                    return SingleChildScrollView(
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text('Original', style: Theme.of(context).textTheme.headline3),
                            Image.network(
                              _orgImg,
                              errorBuilder: (context, error, stackTrace) => Text(
                                '😢',
                                textScaleFactor: 20,
                              ),
                            ),
                            Text('Size = ${_orgSize.toDouble() / 1000} kb',
                                style: TextStyle(fontStyle: FontStyle.italic, fontSize: 20)),
                            Text('\nCompressed', style: Theme.of(context).textTheme.headline3),
                            Image.network(
                              _compImg,
                              errorBuilder: (context, error, stackTrace) => Text(
                                '😢',
                                textScaleFactor: 20,
                              ),
                            ),
                            Text('Size = ${_compSize.toDouble() / 1000} kb',
                                style: TextStyle(fontStyle: FontStyle.italic, fontSize: 20)),
                            Text(
                              '\nCompression Ratio = ${(((_orgSize - _compSize) / _orgSize) * 100).toStringAsFixed(2)}%\n',
                              style: Theme.of(context).textTheme.headline6,
                            )
                          ],
                        ),
                      ),
                    );
                  },
                )
              : const Center(
                  child: CircularProgressIndicator(),
                );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _refresh,
        tooltip: 'Refresh',
        child: Icon(Icons.refresh),
      ),
    );
  }
}
