import 'package:flutter/widgets.dart';

import '../widgets/image_card.dart';

class OriginalImagePage extends StatelessWidget {
  final String imgLink, title;
  final int imgSize;

  const OriginalImagePage({
    Key key,
    @required this.imgLink,
    @required this.title,
    @required this.imgSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: ImageCard(imgLink: imgLink, imgSize: imgSize, title: title, isExpanded: true),
    );
  }
}
