import 'package:captain_bonik_app/common/utils/app.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MerchandiserHeaderWidget extends StatefulWidget {
  // final DemoTitleAndColor demoObject;
  // const MerchandiserHeaderWidget({Key key, this.demoObject}) : super(key: key);
 final  Color color;

  const MerchandiserHeaderWidget({Key key, this.color}) : super(key: key);

  @override
  _MerchandiserHeaderWidgetState createState() =>
      _MerchandiserHeaderWidgetState();
}

class _MerchandiserHeaderWidgetState extends State<MerchandiserHeaderWidget>
    with App {

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 24),
      height: screen.size.width / 2.7,
      child: AspectRatio(
        aspectRatio: 1.4,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(12)),
            gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [ Color(0xff006A4E).withOpacity(.7),widget.color,])
          ),
          child: Padding(
            padding: const EdgeInsets.only(top: 10,bottom: 10,left: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              Image.asset(asset.logoCaptainBanik,
                  width: 32,
                ),
                Text('Title Demo Title',
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18,color: Colors.white),
                ),
                SizedBox(height: 8,),
                Text('This is demo 1, This is This is demo 1, This is ',overflow: TextOverflow.ellipsis
                    ,textAlign: TextAlign.start,style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400,color: Colors.white),),
            ],),
          ),
        ),
      ),
    );
  }
}
class DemoTitleAndColor {
  String title;
  Color color;

  DemoTitleAndColor({this.title, this.color});

  DemoTitleAndColor.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    color = json['color'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['color'] = this.color;
    return data;
  }
}
