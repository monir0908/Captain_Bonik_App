import 'dart:convert';

import 'package:captain_bonik_app/common/utils/app.dart';
import 'package:captain_bonik_app/modules/merchandiser/widgets/merchandiser_header_widget.dart';
import 'package:captain_bonik_app/modules/merchandiser/widgets/merchandiser_sub_header_widget.dart';
import 'package:flutter/material.dart';

class MerchandiserHomePage extends StatefulWidget {
  @override
  _MerchandiserHomePageState createState() => _MerchandiserHomePageState();
}

class _MerchandiserHomePageState extends State<MerchandiserHomePage> with App {
  List titleDemo = [
    {
      "title": "Title Demo Title 1",
      "color": "Color(0xff7EA3F3)"
    },
    {
      "title": "Title Demo Title 2",
      "color": "Color(0xffEE9F5C)"
    },
    {
      "title": "Title Demo Title 3",
      "color": "Color(0xffEB5874)"
    },
    {
      "title": "Title Demo Title 4",
      "color": "Color(0xff68E2B9)"
    }
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: screen.padding.top +16,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 24),
            child: Row(
              children: [
                Image.asset(
                  asset.logoCaptainBanik,
                  width: 41,
                ),
              ],
            ),
          ),
          Row(children: [Padding(
            padding: const EdgeInsets.only(top: 8, bottom: 24, left: 24),
            child: Text(
              'Title Demo',
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
            ),
          ),
          ],
              ),
          Padding(
            padding: const EdgeInsets.only(bottom: 24, left: 24),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                  // children: titleDemo.map((e) => MerchandiserHeaderWidget(demoObject: DemoTitleAndColor.fromJson(e))).toList()
              children: [
                // MerchandiserHeaderWidget(color: Color(0xff006A4E),),
                MerchandiserHeaderWidget(color: Color(0xff7EA3F3),),
                MerchandiserHeaderWidget(color: Color(0xffEE9F5C),),
                MerchandiserHeaderWidget(color: Color(0xffEB5874),),
              ],
              ),
              ),
            ),
          Container(
            height: screen.padding.top / 3.5,
            color: Colors.grey.withOpacity(.2),
          ),
          Row(children: [Padding(
            padding: const EdgeInsets.only(left: 24,top: 24),
            child: Text(
              'Title Demo',
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
            ),
          ),
            Spacer(),
            Text('See all',
              style: TextStyle(fontWeight: FontWeight.w400, fontSize: 18),
            ),
            SizedBox(width: 12,),
            Icon(Icons.arrow_forward_ios)
            ,SizedBox(width: 16,)
          ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 24, bottom: 24, left: 24),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  MerchandiserSubHeaderWidget(),
                  MerchandiserSubHeaderWidget(),
                  MerchandiserSubHeaderWidget(),
                  MerchandiserSubHeaderWidget(),
                  MerchandiserSubHeaderWidget(),
                  MerchandiserSubHeaderWidget(),
                ],
              ),
            ),
          ),
          Container(
            height: screen.padding.top / 3.5,
            color: Colors.grey.withOpacity(.2),
          ),
          Row(children: [Padding(
            padding: const EdgeInsets.only(left: 24,top: 24,),
            child: Text(
              'Title Demo',
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
            ),
          ),
            Spacer(),
            Text('See all',
              style: TextStyle(fontWeight: FontWeight.w400, fontSize: 18),
            ),
            SizedBox(width: 12,),
            Icon(Icons.arrow_forward_ios),
            SizedBox(width: 16,)
          ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 24, bottom: 24, left: 24),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  MerchandiserSubHeaderWidget(),
                  MerchandiserSubHeaderWidget(),
                  MerchandiserSubHeaderWidget(),
                  MerchandiserSubHeaderWidget(),
                  MerchandiserSubHeaderWidget(),
                  MerchandiserSubHeaderWidget(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
