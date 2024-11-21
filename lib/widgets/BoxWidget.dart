import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Boxwidget extends StatefulWidget {
  String text;
  Icon icon;
  Boxwidget({
    Key? key,
    this.text = '',
    required this.icon,
  }) : super(key: key);

  @override
  State<Boxwidget> createState() => _BoxwidgetState();
}

class _BoxwidgetState extends State<Boxwidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: 100,
      decoration: BoxDecoration(
          color: Color(0xffD3D3D3), borderRadius: BorderRadius.circular(40)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          widget.icon,
          Text(
            widget.text,
            style: TextStyle(color: Colors.blueAccent),
          )
        ],
      ),
    );
  }
}


