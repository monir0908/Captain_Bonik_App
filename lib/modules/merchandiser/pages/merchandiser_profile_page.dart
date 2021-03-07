import 'package:captain_bonik_app/common/utils/app.dart';
import 'package:captain_bonik_app/modules/merchandiser/widgets/navigator_menu_button_widget.dart';
import 'package:flutter/material.dart';

class MerchandiserProfilePage extends StatefulWidget {
  @override
  _MerchandiserProfilePageState createState() =>
      _MerchandiserProfilePageState();
}

class _MerchandiserProfilePageState extends State<MerchandiserProfilePage>
    with App {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: screen.padding.top + 16,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 24, right: 24),
            child: Icon(
              Icons.arrow_back,
              color: Color(0xff006A4E),
              size: 32,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 24, right: 24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(right: 24, top: 24, bottom: 24),
                  height: 108,
                  width: 108,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(asset.logoCaptainBanik),
                        fit: BoxFit.fitHeight,
                      ),
                      color: Colors.grey.withOpacity(.2),
                      shape: BoxShape.circle),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Emma Phillips',
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w800,
                          color: Color(0xff006A4E)),
                    ),
                    Text(
                      'Fashion Model',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: Color(0xff006A4E)),
                    ),
                  ],
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
                left: 24, right: 24, top: 16,),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                  Icon(
                    Icons.call,
                    color: Color(0xff006A4E),
                  ),
                SizedBox(width: 24,),
                Text(
                  '01911697056',
                  style: TextStyle(fontSize: 16, color: Color(0xff006A4E)),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
                left: 24, right: 24, top: 16, bottom: 24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(
                    Icons.email,
                    color: Color(0xff006A4E),
                  ),
                SizedBox(width: 24,),
                Text(
                  'tusharimranjhenaidah@gmail.com',
                  style: TextStyle(fontSize: 16, color: Color(0xff006A4E)),
                ),
              ],
            ),
          ),
          SizedBox(
              width: double.infinity,
              child: AspectRatio(
                  aspectRatio: 4.2,
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                          width: 1, color: Color(0xff006A4E).withOpacity(.1)),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                            child: Container(
                          decoration: BoxDecoration(
                            border: Border(
                              right: BorderSide(
                                color: Color(0xff006A4E).withOpacity(.1),
                                width: 1.0,
                              ),
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Tk. 140",
                                style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.w800,
                                    color: Color(0xff006A4E)),
                              ),
                              Text(
                                "Wallet",
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xff006A4E)),
                              )
                            ],
                          ),
                        )),
                        Expanded(
                            child: Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "12",
                                style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.w800,
                                    color: Color(0xff006A4E)),
                              ),
                              Text(
                                "Orders",
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xff006A4E)),
                              )
                            ],
                          ),
                        ))
                      ],
                    ),
                  ))),
          SizedBox(
            height: 16,
          ),
          NavigatorMenuButton(
            title: "Your Favorites",
            icon: Icons.favorite_border_outlined,
          ),
          NavigatorMenuButton(
            title: "Payment",
            icon: Icons.payment,
          ),
          NavigatorMenuButton(
            title: "Tell Your Friend",
            icon: Icons.mobile_friendly,
          ),
          NavigatorMenuButton(
            title: "Promotions",
            icon: Icons.mark_chat_read_outlined,
          ),
          NavigatorMenuButton(
            title: "Settings",
            icon: Icons.settings,
          ),
        Container(
          margin: EdgeInsets.only(bottom: 8,top: 24),
          decoration: BoxDecoration(
          border: Border.all(
              width: 1, color: Color(0xff006A4E).withOpacity(.1)),
        ),),
          NavigatorMenuButton(
            title: "Log out",
            icon: Icons.power_settings_new,
            color: Colors.red,
          ),
          SizedBox(height: 16,),
        ],
      ),
    );
  }
}
