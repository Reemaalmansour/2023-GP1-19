import 'package:flutter/material.dart';
import '../../resources/assets_maneger.dart';
class TripScreen extends StatelessWidget {
  const TripScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Trip'),
      ),
     /* body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(ImageAssets.trip), fit: BoxFit.cover)),
      ),*/
    );
  }
}
