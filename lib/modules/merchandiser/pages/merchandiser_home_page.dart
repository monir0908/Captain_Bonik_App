import 'package:captain_bonik_app/common/utils/app.dart';
import 'package:flutter/material.dart';

class MerchandiserHomePage extends StatefulWidget {
  @override
  _MerchandiserHomePageState createState() => _MerchandiserHomePageState();
}

class _MerchandiserHomePageState extends State<MerchandiserHomePage> with App {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(left: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: screen.padding.top+16,
            ),
            Row(
              children: [
                Image.asset(asset.logoCaptainBanik,
                  width: 52,
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 24,bottom: 24),
              child: Text('Title Demo',style: TextStyle(fontWeight: FontWeight.w700,fontSize: 20),),
            ),

          ],
        ),
      ),
    );
  }
}