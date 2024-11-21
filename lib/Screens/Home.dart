import 'package:dayglow/Models/WeatherModel.dart';
import 'package:dayglow/Services/ApiService.dart';
import 'package:dayglow/widgets/BoxWidget.dart';
import 'package:dayglow/widgets/detailRow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:rive/rive.dart' as rive;

class Home extends StatefulWidget {
  final String city;
  final double lat;
  final double lng;

  const Home({
    Key? key,
    this.city = '',
    this.lng = 0.0,
    this.lat = 0.0,
  }) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // SunModel sunModel = SunModel();

  Map<String, String> getGreetingAndImage() {
    final currentTime = DateTime.now();
    final hour = currentTime.hour;

    if (hour < 18) {
      return {
        'greeting':
            'https://lottie.host/d949e802-595c-4d6c-a897-73bc64ad244e/PtKXCVZdbG.json',
        // Replace with your morning image asset
      };
    } else {
      return {
        'greeting':
            'https://lottie.host/fb3724ae-9014-4225-b9f2-f3600f1b5e93/jVEXh8QQTn.json',

        // Replace with your evening image asset
      };
    }
  }

  WeatherModel weatherModel = WeatherModel();
  bool loading = true;

  // String getBackgroundAnimation() {
  //   // Match weather condition to appropriate Lottie animation
  //   switch (weatherModel.weather!.single.main?.toLowerCase()) {
  //     case 'thunderstorm':
  //       return 'https://lottie.host/your-thunderstorm-animation-url.json'; // Replace with actual URL
  //     case 'rain':
  //       return 'https://lottie.host/your-rain-animation-url.json'; // Replace with actual URL
  //     case 'clear':
  //       return 'https://lottie.host/your-clear-sky-animation-url.json'; // Replace with actual URL
  //     default:
  //       return 'https://lottie.host/bed7f5d1-d540-49c1-af77-afba7943780f/NJhafLpJ7m.json'; // Default animation
  //   }
  // }

  void getWeather() {
    Apiservice().weatherModel(widget.lng, widget.lat).then((value) {
      weatherModel = value!;
      loading = false;
      // Mock data for the graph (You can replace it with real-time data)

      setState(() {});
    }).onError((err, stackTrace) {
      print(err.toString());
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Something went wrong'),
        backgroundColor: Colors.brown,
      ));
    });
  }

  @override
  void initState() {
    getWeather();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String sunriseTime = (weatherModel.sys?.sunrise != null)
        ? DateTime.fromMillisecondsSinceEpoch(
                (weatherModel.sys!.sunrise ?? 0) * 1000)
            .toLocal()
            .toString()
            .substring(11, 16)
        // Extracts hours and minutes
        : "N/A";
    String sunSetTime = (weatherModel.sys?.sunset != null)
        ? DateTime.fromMillisecondsSinceEpoch(
                (weatherModel.sys!.sunrise ?? 0) * 1000)
            .toLocal()
            .toString()
            .substring(11, 16)
        // Extracts hours and minutes
        : "N/A";
    String weatherTemp = (weatherModel.main?.temp != null)
        ? ((weatherModel.main!.temp ?? 0.0) - 273.15).toStringAsFixed(1) + "°"
        : "N/A";
    String feelsLike = (weatherModel.main?.feelsLike != null)
        ? ((weatherModel.main!.feelsLike ?? 0.0) - 273.15).toStringAsFixed(1) +
            "°"
        : "N/A";
    String visibilityWeather = (weatherModel.visibility != null)
        ? ((weatherModel.visibility ?? 0.0) / 1000).toStringAsFixed(1) + "km"
        : "N/A";
    String weatherTempMAX = (weatherModel.main?.tempMax != null)
        ? ((weatherModel.main!.tempMax ?? 0.0) - 273.15).toStringAsFixed(1) +
            "°"
        : "N/A";
    String weatherTempMIN = (weatherModel.main?.tempMin != null)
        ? ((weatherModel.main!.tempMin ?? 0.0) - 273.15).toStringAsFixed(1) +
            "°"
        : "N/A";
    String seaLevel = (weatherModel.main?.seaLevel != null)
        ? ((weatherModel.main!.seaLevel ?? 0.0) - 273.15).toStringAsFixed(1) +
            "°"
        : "N/A";
    String groundLevel = (weatherModel.main?.grndLevel != null)
        ? ((weatherModel.main!.grndLevel ?? 0.0) - 273.15).toStringAsFixed(1) +
            "°"
        : "N/A";
    String temperature =
        weatherModel.weather != null && weatherModel.weather!.isNotEmpty
            ? weatherModel.weather!.single.main.toString()
            : 'N/A';

    // Default text when weather data is not available
    return SafeArea(
      child: Scaffold(
        body: Visibility(
            visible: !loading,
            replacement: Center(
              child: CircularProgressIndicator(
                color: Colors.green,
              ),
            ),
            child: Stack(
              children: [
                // Lottie Animation as the background

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
                //   child: BackdropFilter(
                //     filter: ImageFilter.blur(
                //         sigmaX: 5.0, sigmaY: 5.0), // Adjust blur intensity
                //     child: Container(
                //       color: Colors
                //           .transparent, // Maintain transparency for blur effect
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
                    padding:
                        EdgeInsets.only(top: 20.h, left: 20.w, right: 20.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          weatherModel.name ?? " Unknown Location",
                          style:
                              TextStyle(color: Colors.white, fontSize: 30.sp),
                        ),
                        Divider(
                          thickness: 2,
                          color: Colors.white,
                          // 25% from left
                          endIndent: MediaQuery.of(context).size.width *
                              0.7, // 25% from right
                        ),
                        Text(
                          temperature,
                          style:
                              TextStyle(color: Colors.white, fontSize: 25.sp),
                        ),
                        Row(
                          children: [
                            SizedBox(
                              height: 120.h,
                              width: 120.w,
                              child: Lottie.network(
                                getGreetingAndImage()['greeting'] ?? "",
                              ),
                            ),
                            Text(
                              weatherTemp,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 49.sp,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.only(right: 20.w),
                          child: Align(
                            alignment: Alignment
                                .centerRight, // Align the row to the right
                            child: Row(
                              mainAxisSize: MainAxisSize
                                  .min, // Ensure the row doesn't take up full width
                              children: [
                                Text(
                                  "Feels like ",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 23.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  feelsLike,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 23.sp,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Text(
                          "Details",
                          style:
                              TextStyle(color: Colors.white, fontSize: 18.sp),
                        ),
                        Divider(
                          thickness: 2,
                        ),
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                children: [
                                  Column(
                                    children: [
                                      Boxwidget(
                                        icon: Icon(
                                          Icons.air,
                                          color: Colors.grey,
                                        ),
                                        text: "Wind",
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        "${weatherModel.wind?.speed ?? 0.0} Km/h",
                                        style: TextStyle(fontSize: 23.sp),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Column(
                                    children: [
                                      Boxwidget(
                                        icon: Icon(
                                          Icons.water_drop,
                                          color: Colors.grey,
                                        ),
                                        text: "Humidity",
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        "${weatherModel.main?.humidity ?? 0}%",
                                        style: TextStyle(fontSize: 23.sp),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  Column(
                                    children: [
                                      Boxwidget(
                                        icon: Icon(
                                          Icons.speed,
                                          color: Colors.grey,
                                        ),
                                        text: "Pressure",
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        "${weatherModel.main?.pressure ?? 0} hPa",
                                        style: TextStyle(fontSize: 23.sp),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Column(
                                    children: [
                                      Boxwidget(
                                        icon: Icon(
                                          Icons.visibility,
                                          color: Colors.grey,
                                        ),
                                        text: "visibility",
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        visibilityWeather,
                                        style: TextStyle(fontSize: 23.sp),
                                      )
                                    ],
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                        Divider(),
                        Container(
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Sunrise",
                                    style: TextStyle(fontSize: 23.sp),
                                  ),
                                  Text(
                                    "${sunriseTime} AM",
                                    style: TextStyle(fontSize: 23.sp),
                                  )
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Sun-Set",
                                    style: TextStyle(fontSize: 23.sp),
                                  ),
                                  Text(
                                    "${sunSetTime} PM",
                                    style: TextStyle(fontSize: 23.sp),
                                  )
                                ],
                              ),
                              Detailrow(
                                text: "temp-max",
                                data: weatherTempMAX,
                              ),
                              Detailrow(
                                text: "temp-min",
                                data: weatherTempMIN,
                              ),
                              Detailrow(
                                text: "sea-level",
                                data: seaLevel,
                              ),
                              Detailrow(
                                text: "ground-level",
                                data: groundLevel,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
