import 'dart:ui';
import 'package:shimmer/shimmer.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:weather/weather.dart';
import '../../services/api/api_service.dart';
import '../../utils/constants/assets.dart';

class SavedLocPage extends StatefulWidget {
  const SavedLocPage({super.key});

  @override
  State<SavedLocPage> createState() => _SavedLocPageState();
}

class _SavedLocPageState extends State<SavedLocPage> {
  List<String> cityNameList = ["Delhi", "Srinagar"];

  final TextEditingController _txtCtrl = TextEditingController();

  @override
  void dispose() {
    _txtCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text("Saved Locations"),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 8.0),
            child: Icon(Icons.search),
          ),
        ],
      ),
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFF3A1B4A),
                  Color(0xFF272170),
                  Color(0xFF3A1B4A),
                ],
              ),
            ),
            height: size.height,
            width: size.width,
          ),
          Column(
            children: [
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: cityNameList.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20.0),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaY: 15, sigmaX: 15),
                        child: Center(
                          child: Container(
                            padding: const EdgeInsets.all(8.0),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: const Color(0xFF655677).withOpacity(0.75),
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            child: FutureBuilder(
                              future: API.fetchWeatherByCity(
                                  cityName: cityNameList[index]),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return Container(
                                    child: Column(
                                      children: [
                                        ListTile(
                                          title: shimmerEffect(height: 20),
                                          subtitle: shimmerEffect(height: 15),
                                          trailing: shimmerEffect(height: 50),
                                        ),
                                        ListTile(
                                          title: shimmerEffect(height: 20),
                                          subtitle: shimmerEffect(height: 15),
                                          trailing: shimmerEffect(height: 35),
                                        ),
                                      ],
                                    ),
                                  );
                                } else if (snapshot.hasError) {
                                  return Text('Error: ${snapshot.error}');
                                } else {
                                  Weather weather = snapshot.data!;
                                  return Container(
                                    child: Column(
                                      children: [
                                        ListTile(
                                            title: Text(
                                              weather.areaName!,
                                              style: TextStyle(
                                                fontSize: 24,
                                                fontWeight: FontWeight.bold,
                                                shadows: [
                                                  Shadow(
                                                    offset: const Offset(1, 1),
                                                    blurRadius: 5.0,
                                                    color: Colors.grey.shade800,
                                                  ),
                                                  Shadow(
                                                    offset:
                                                        const Offset(-1, -1),
                                                    blurRadius: 5.0,
                                                    color: Colors.grey.shade800,
                                                  ),
                                                ],
                                              ),
                                            ),
                                            subtitle: Text(
                                              weather.weatherMain!,
                                              style:
                                                  const TextStyle(fontSize: 16),
                                            ),
                                            trailing: Lottie.asset(
                                                Assets.getAnimation(
                                                    code:
                                                        weather.weatherIcon!))),
                                        ListTile(
                                          title: Text(
                                              "Humidity ${weather.humidity}%"),
                                          subtitle: Text(
                                              "Wind ${weather.windSpeed}km/h"),
                                          trailing: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Text(
                                                '${(weather.temperature!.celsius)!.floor()}',
                                                style: TextStyle(
                                                  fontSize: 48,
                                                  shadows: [
                                                    Shadow(
                                                      offset:
                                                          const Offset(1, 1),
                                                      blurRadius: 5.0,
                                                      color:
                                                          Colors.grey.shade800,
                                                    ),
                                                    Shadow(
                                                      offset:
                                                          const Offset(-1, -1),
                                                      blurRadius: 5.0,
                                                      color:
                                                          Colors.grey.shade800,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Text(
                                                '°C',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontSize: 24,
                                                  shadows: [
                                                    Shadow(
                                                      offset:
                                                          const Offset(4, 4),
                                                      blurRadius: 20.0,
                                                      color:
                                                          Colors.grey.shade800,
                                                    ),
                                                    Shadow(
                                                      offset:
                                                          const Offset(-4, -4),
                                                      blurRadius: 20.0,
                                                      color:
                                                          Colors.grey.shade800,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
              GestureDetector(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return StatefulBuilder(
                        builder: (context, setState) {
                          return Dialog(
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Text(
                                    "Enter City Name",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 16.0),
                                  TextField(
                                    decoration: const InputDecoration(
                                      hintText: "City",
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          width: 1,
                                          color: Colors.white,
                                        ), //<-- SEE HERE
                                      ),
                                    ),
                                    controller: _txtCtrl,
                                    onSubmitted: (value) {
                                      setState(
                                          () => cityNameList.add(value.trim()));
                                      _txtCtrl.clear();
                                      Navigator.pop(context);
                                    },
                                  ),
                                  const SizedBox(height: 16.0),
                                  dialogButtons(save: () {
                                    setState(() =>
                                        cityNameList.add(_txtCtrl.text.trim()));
                                    _txtCtrl.clear();
                                    Navigator.pop(context);
                                  }),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                  );
                },
                child: Container(
                  margin: const EdgeInsets.all(8.0),
                  height: 50,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: const Color(0xFF655677).withOpacity(0.75),
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.add_box_outlined),
                      SizedBox(width: 8.0),
                      Text(
                        "Add new",
                        style: TextStyle(fontSize: 18),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget shimmerEffect({double height = 10.0, double width = 50.0}) {
    return SizedBox(
      width: width,
      height: height,
      child: Shimmer.fromColors(
        baseColor: const Color(0xFF3A1B4A),
        highlightColor: const Color(0xFF272170),
        child: Container(height: height, width: width, color: Colors.grey),
      ),
    );
  }

  /// Dialog Cancel and Save Buttons
  Widget dialogButtons({required void Function() save}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text(
            "Cancel",
            style: TextStyle(fontSize: 18),
          ),
        ),
        TextButton(
          onPressed: save,
          child: const Text(
            "Save",
            style: TextStyle(fontSize: 18),
          ),
        ),
      ],
    );
  }
}
