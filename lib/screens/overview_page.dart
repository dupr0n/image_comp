import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../widgets/image_card.dart';

const _url = 'https://itc-proj.herokuapp.com/';

class OverviewPage extends StatefulWidget {
  const OverviewPage({
    Key key,
    @required String orgImg,
    @required int orgSize,
    @required String orgTitle,
    @required String compImg,
    @required int compSize,
    @required String compTitle,
  })  : _orgImg = orgImg,
        _orgSize = orgSize,
        _orgTitle = orgTitle,
        _compImg = compImg,
        _compSize = compSize,
        _compTitle = compTitle,
        super(key: key);

  final String _orgImg;
  final int _orgSize;
  final String _orgTitle;
  final String _compImg;
  final int _compSize;
  final String _compTitle;

  @override
  _OverviewPageState createState() => _OverviewPageState();
}

class _OverviewPageState extends State<OverviewPage> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Center(
        child: OrientationBuilder(
          builder: (context, orientation) => Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ImageCard(imgLink: widget._orgImg, imgSize: widget._orgSize, title: widget._orgTitle),
              ImageCard(
                  imgLink: widget._compImg, imgSize: widget._compSize, title: widget._compTitle),
              // Padding(
              //   padding: const EdgeInsets.all(20),
              //   child: Text(
              //     '${widget._orgTitle} size = ${(widget._orgSize / 1000).toString()} kb',
              //     style: Theme.of(context).textTheme.headline5,
              //   ),
              // ),
              // Padding(
              //   padding: const EdgeInsets.all(20),
              //   child: Text(
              //     '${widget._compTitle} size = ${(widget._compSize / 1000).toString()} kb',
              //     style: Theme.of(context).textTheme.headline5,
              //   ),
              // ),
              if (orientation == Orientation.portrait)
                ElevatedButton(
                  onPressed: () async => launch(_url),
                  child: Text(
                    'Upload',
                    style: Theme.of(context).textTheme.headline4,
                  ),
                ),
              if (orientation == Orientation.portrait)
                Text(
                  '\nCompression Ratio = ${(((widget._orgSize - widget._compSize) / widget._orgSize) * 100).toStringAsFixed(2)}%\n',
                  style: Theme.of(context).textTheme.headline6,
                ),
            ],
          ),
        ),
      ),
    );
  }
}

// orientation == Orientation.portrait
//                 ? [
//                     Padding(
//                       padding: const EdgeInsets.all(20),
//                       child: Text(
//                         '${widget._orgTitle} size = ${(widget._orgSize / 1000).toString()} kb',
//                         style: Theme.of(context).textTheme.headline5,
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.all(20),
//                       child: Text(
//                         '${widget._compTitle} size = ${(widget._compSize / 1000).toString()} kb',
//                         style: Theme.of(context).textTheme.headline5,
//                       ),
//                     ),
//                     ElevatedButton(
//                       onPressed: () async => launch(_url),
//                       child: Text(
//                         'Upload',
//                         style: Theme.of(context).textTheme.headline4,
//                       ),
//                     ),
//                     Text(
//                       '\nCompression Ratio = ${(((widget._orgSize - widget._compSize) / widget._orgSize) * 100).toStringAsFixed(2)}%\n',
//                       style: Theme.of(context).textTheme.headline6,
//                     ),
//                   ]
//                 : [
//                     ImageCard(
//                         imgLink: widget._orgImg, imgSize: widget._orgSize, title: widget._orgTitle),
//                     ImageCard(
//                         imgLink: widget._compImg,
//                         imgSize: widget._compSize,
//                         title: widget._compTitle),
//                   ],
