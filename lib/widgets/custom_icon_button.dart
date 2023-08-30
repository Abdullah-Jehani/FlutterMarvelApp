import 'package:flutter/material.dart';
import 'package:marvel_app/helpers/const.dart';

class CustomIconButton extends StatefulWidget {
  const CustomIconButton(
      {super.key,
      required this.asset,
      required this.color,
      required this.onpressed});
  final String asset;
  final Color color;
  final Function onpressed;

  @override
  State<CustomIconButton> createState() => _CustomIconButtonState();
}

class _CustomIconButtonState extends State<CustomIconButton> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
                border: Border.all(color: primaryColor.withOpacity(.3)),
                borderRadius: BorderRadius.circular(10)),
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Image.asset(
                widget.asset,
                width: 24,
                height: 24,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
