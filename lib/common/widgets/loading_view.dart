import 'package:flutter/material.dart';

import 'chasing_dots.dart';

class LoadingView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SpinKitChasingDots(
        color: Colors.blue.withOpacity(.3),
        size: 44,
      ),
    );
  }
}
