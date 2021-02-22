import 'package:flutter/material.dart';

class RoundedCorner extends StatelessWidget {
  final Widget child;
  final String bgImageAsset;
  final AlignmentGeometry alignment;
  final BoxFit fit;
  const RoundedCorner({
    Key key,
    @required this.child,
    this.bgImageAsset,
    this.alignment = Alignment.topCenter,
    this.fit= BoxFit.fitWidth,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      resizeToAvoidBottomPadding: false,
      body: ClipRRect(
        clipBehavior: Clip.antiAlias,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          height: double.infinity,
          width: double.infinity,
          child: child,
          decoration: BoxDecoration(
            color: Colors.white,
            image: bgImageAsset != null ? DecorationImage(
              image: ExactAssetImage(bgImageAsset),
              alignment: alignment,
              fit: fit,
            ):null,
          ),
        ),
      ),
    );
  }
}
