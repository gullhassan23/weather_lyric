import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rive/rive.dart' as rive;

import 'package:dayglow/Models/GeoModel.dart';
import 'package:dayglow/Screens/Home.dart';
import 'package:dayglow/Services/ApiService.dart';
import 'package:dayglow/widgets/currentLocationButton.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({super.key});

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  GeoModel geoModel = GeoModel();
  final TextEditingController locationController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        Positioned.fill(
          child: SizedBox(
              height: 200, // Set the desired height
              width: 200, // Set the desired width
              child: rive.RiveAnimation.asset(
                "assets/animation/sky_rain.riv",
                fit: BoxFit.cover,
              )),
        ),
        // Positioned.fill(
        //   child: SizedBox(
        //     height: 200, // Set the desired height
        //     width: 200, // Set the desired width
        //     child: WeatherAnimation(
        //       weatherType: WeatherType.rainy,// Choose the desired weather type
        //       speed: 0.5, // Adjust animation speed
        //       intensity: 0.8, // Adjust animation intensity
        //     ),
        //   ),
        // ),
        // Positioned.fill(
        //   child: BackdropFilter(
        //     filter: ImageFilter.blur(
        //         sigmaX: 1.0, sigmaY: 1.0), // Adjust blur intensity
        //     child: Container(
        //       color:
        //           Colors.transparent, // Maintain transparency for blur effect
        //     ),
        //   ),
        // ),
        Container(
          // decoration: BoxDecoration(
          //   borderRadius: BorderRadius.circular(10),
          //   gradient: LinearGradient(
          //     begin: Alignment.topLeft,
          //     end: Alignment.bottomRight,
          //     colors: [
          //       Appcolor.foggy[0].withOpacity(0.6), // Adjust opacity
          //       Appcolor.foggy[1].withOpacity(0.6), // Adjust opacity
          //     ],
          //   ),
          // ),
          child: Padding(
            padding: EdgeInsets.only(left: 18.w, right: 18.w, top: 60.h),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: locationController,
                        style: TextStyle(color: Colors.white, fontSize: 20.sp),
                        decoration: InputDecoration(
                            hintText: "Enter Location",
                            hintStyle: TextStyle(
                                color: Colors.white, fontSize: 20.sp)),
                        onChanged: (String value) {
                          Apiservice().geoModel(value).then((value) {
                            geoModel = value!;

                            setState(() {});
                          }).onError((err, stackTrace) {
                            print(err.toString());
                          });
                        },
                      ),
                    ),
                    const Currentlocationbutton()
                  ],
                ),
                Expanded(
                  child: Visibility(
                    visible: locationController.text.isNotEmpty,
                    child: ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: geoModel.results?.length ?? 0,
                        itemBuilder: (ctx, index) {
                          return ListTile(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (ctx) => Home(
                                      lat: geoModel.results![index].latitude ??
                                          0.0,
                                      lng: geoModel.results![index].longitude ??
                                          0.0,
                                      city: geoModel.results![index].name ?? '',
                                    ),
                                  ));
                            },
                            leading: Icon(Icons.location_on_rounded),
                            title: Text(
                              geoModel.results![index].name ?? '',
                              style: TextStyle(
                                  color: Colors.black, fontSize: 22.sp),
                            ),
                            subtitle: Text(
                              geoModel.results![index].country ?? '',
                              style: TextStyle(color: Colors.white),
                            ),
                          );
                        }),
                  ),
                )
              ],
            ),
          ),
        )
      ],
    ));
  }
}
