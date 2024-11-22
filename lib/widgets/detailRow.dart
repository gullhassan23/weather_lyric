import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: must_be_immutable
class Detailrow extends StatelessWidget {
  String text;
  String data;
  Detailrow({
    Key? key,
    this.text = '',
    this.data = '',
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          text,
          style: TextStyle(fontSize: 23.sp, color: Colors.white),
        ),
        Text(data,
            style: GoogleFonts.roboto(fontSize: 20.sp, color: Colors.white))
      ],
    );
  }
}
