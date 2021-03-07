import 'package:flutter/material.dart';

class NavigatorMenuButton extends StatefulWidget {
  final String title;
  final IconData icon;
  final Color color;

  const NavigatorMenuButton({Key key, this.title, this.icon, this.color}) : super(key: key);
  @override
  _NavigatorMenuButtonState createState() => _NavigatorMenuButtonState();
}

class _NavigatorMenuButtonState extends State<NavigatorMenuButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding:EdgeInsets.only(left: 24,right: 24),
      child: Row(
      children: [
        Icon(widget.icon, color: widget.color??Color(0xff006A4E),size: 28,),
        Padding(
          padding: const EdgeInsets.only(left: 22,top: 14,bottom: 24),
          child: Text(widget.title,
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w800,
                color: widget.color??Color(0xff006A4E)),
          ),
        ),
      ],
    ),);
  }
}
