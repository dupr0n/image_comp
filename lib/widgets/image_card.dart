import 'package:flutter/material.dart';

class ImageCard extends StatelessWidget {
  final String imgLink, title;
  final int imgSize;
  final bool isExpanded;

  const ImageCard({
    Key key,
    @required this.imgLink,
    @required this.imgSize,
    @required this.title,
    this.isExpanded = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
      child: Column(
        children: [
          if (isExpanded) Text(title, style: Theme.of(context).textTheme.headline3),
          if (isExpanded) const SizedBox(height: 20),
          Image.network(
            imgLink,
            frameBuilder: (context, child, frame, wasSynchronouslyLoaded) =>
                wasSynchronouslyLoaded ?? false
                    ? child
                    : AnimatedOpacity(
                        opacity: frame == null ? 0 : 1,
                        duration: const Duration(seconds: 1),
                        curve: Curves.easeOut,
                        child: child,
                      ),
            loadingBuilder: (context, child, loadingProgress) => loadingProgress == null
                ? child
                : SizedBox(
                    height: 100,
                    child: Center(
                      child: CircularProgressIndicator(
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded /
                                loadingProgress.expectedTotalBytes
                            : null,
                      ),
                    ),
                  ),
            errorBuilder: (context, error, stackTrace) => const Text(
              '😢',
              textScaleFactor: 20,
            ),
          ),
          if (isExpanded) const SizedBox(height: 20),
          if (isExpanded)
            Text('Size = ${imgSize.toDouble() / 1000} kb',
                style: Theme.of(context).textTheme.headline6),
        ],
      ),
    );
  }
}
