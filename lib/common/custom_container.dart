import 'package:flutter/cupertino.dart';
import 'package:saju/constants/colors.dart';
import 'package:saju/constants/data.dart';

class CustomContainer extends StatelessWidget {
  final child;
  const CustomContainer({required this.child, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: child,
      width: MediaQuery.of(context).size.width,
      height: heightRatio(56),
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(16)),
          color: OdoSajuColors.iceBlue),
    );
  }
}
