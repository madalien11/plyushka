import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class FullImageScreen extends StatelessWidget {
  final ImageProvider image;
  FullImageScreen({@required this.image});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        child: Center(
          child: PhotoView(imageProvider: image),
        ),
        onTap: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}
