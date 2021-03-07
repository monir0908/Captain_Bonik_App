import 'package:captain_bonik_app/common/utils/app.dart';
import 'package:flutter/material.dart';

class MerchandiserSubHeaderWidget extends StatefulWidget {
  @override
  _MerchandiserSubHeaderWidgetState createState() =>
      _MerchandiserSubHeaderWidgetState();
}

class _MerchandiserSubHeaderWidgetState extends State<MerchandiserSubHeaderWidget>
    with App {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 16),
      height: screen.size.width / 2.4,
      child: AspectRatio(
        aspectRatio: .7,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(12)),
            color: Colors.grey.withOpacity(.09),
          ),
          child: Column(
            children: [
            Padding(
              padding: const EdgeInsets.only(top: 16,bottom: 8),
              child: Image.asset(asset.logoCaptainBanik,
                width: 42,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 12,right: 12),
              child: Text('This is demo 1, This is ',textAlign: TextAlign.center,style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500),),
            ),
          ],),
        ),
      ),
    );
  }
}
