import 'package:dayglow/Screens/Home.dart';
import 'package:dayglow/widgets/handleLocationbutton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geocoding/geocoding.dart';

class Currentlocationbutton extends StatefulWidget {
  const Currentlocationbutton({super.key});

  @override
  State<Currentlocationbutton> createState() => _CurrentlocationbuttonState();
}

class _CurrentlocationbuttonState extends State<Currentlocationbutton> {
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          loading = true;
        });
        determinePosition().then((value) async {
          print("Latitude of your location ${value.latitude}");
          print("Longitude of your location ${value.longitude}");

          List<Placemark> placemarks =
              await placemarkFromCoordinates(value.latitude, value.longitude);

          print("Your City ${placemarks[0].locality}");
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (ctx) => Home(
                  lat: value.latitude,
                  lng: value.longitude,
                  city: placemarks[0].locality ?? "",
                ),
              ));
          setState(() {
            loading = false;
          });
        }).onError((err, stackTrace) {
          print(err.toString());
          setState(() {
            loading = false;
          });
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Something went wrong'),
            backgroundColor: Colors.brown,
          ));
        });
      },
      child: Container(
        height: 50.h,
        margin: EdgeInsets.only(left: 20.w),
        width: 50.w,
        decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.brown),
        child: Icon(
          Icons.my_location,
          color: Colors.white,
        ),
      ),
    );
  }
}
