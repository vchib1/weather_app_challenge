import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter_svg/svg.dart';
import 'package:weather/weather.dart';
import 'package:animate_do/animate_do.dart';
import 'package:weather_app_contest/utils/extensions/double.dart';
import 'package:weather_app_contest/utils/extensions/datetime.dart';
import '../../services/api/api_service.dart';
import '../../utils/constants/assets.dart';
import '../saved_location_page/saved_location_page.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<Weather>>(
        future: API.fetchFiveDayWeather(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            /// LOADING ANIMATION
            return Center(child: Lottie.asset(Assets.loadingAnimationJson));
          } else if (snapshot.hasError) {
            Object? map = snapshot.error;
            return Center(child: Text(map.toString()));
          } else if (snapshot.hasData) {
            List<Weather> weather = snapshot.data!;
            return Scaffold(
              extendBodyBehindAppBar: true,
              appBar: PreferredSize(
                preferredSize: const Size.fromHeight(kToolbarHeight),
                child: appBar(cityName: weather[0].areaName),
              ),
              body: Container(
                padding: const EdgeInsets.only(top: kToolbarHeight),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    opacity: 0.75,
                    image: AssetImage(
                      Assets.getWeatherBackground(code: weather[0].weatherIcon),
                    ),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const SizedBox(height: kToolbarHeight / 2),

                    /// DATE AND UPDATE TIME
                    Column(
                      children: [
                        Text(
                          weather[0].date!.toDayMonth(),
                          style: const TextStyle(
                            fontSize: 36,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          "Updated as of ${weather[0].date!.toDateTimeString()}",
                          style: const TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ],
                    ),

                    /// WEATHER TEMP & CONDITION
                    Column(
                      children: [
                        Lottie.asset(
                          Assets.getAnimation(code: weather[0].weatherIcon),
                          height: 96,
                        ),
                        Text(
                          '${weather[0].weatherMain}',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 36,
                            fontWeight: FontWeight.w700,
                            shadows: [
                              Shadow(
                                offset: const Offset(4, 4),
                                blurRadius: 20.0,
                                color: Colors.grey.shade800,
                              ),
                              Shadow(
                                offset: const Offset(-4, -4),
                                blurRadius: 20.0,
                                color: Colors.grey.shade800,
                              ),
                            ],
                          ),
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${(weather[0].temperature!.celsius)!.floor()}',
                              style: TextStyle(
                                fontSize: 48,
                                fontWeight: FontWeight.bold,
                                shadows: [
                                  Shadow(
                                    offset: const Offset(4, 4),
                                    blurRadius: 20.0,
                                    color: Colors.grey.shade800,
                                  ),
                                  Shadow(
                                    offset: const Offset(-4, -4),
                                    blurRadius: 20.0,
                                    color: Colors.grey.shade800,
                                  ),
                                ],
                              ),
                            ),
                            Text(
                              '°C',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                shadows: [
                                  Shadow(
                                    offset: const Offset(4, 4),
                                    blurRadius: 20.0,
                                    color: Colors.grey.shade800,
                                  ),
                                  Shadow(
                                    offset: const Offset(-4, -4),
                                    blurRadius: 20.0,
                                    color: Colors.grey.shade800,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),

                    /// HUMIDITY , WIND , FEELS LIKE
                    FadeIn(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          weatherInfoWidget(
                            svgUrl: Assets.humiditySvg,
                            title: "HUMIDITY",
                            weatherText: "${weather[0].humidity}%",
                          ),
                          weatherInfoWidget(
                            svgUrl: Assets.windSvg,
                            title: "WIND",
                            weatherText:
                                "${(weather[0].windSpeed!.toWindSpeedKpm())}km/h",
                          ),
                          weatherInfoWidget(
                            svgUrl: Assets.feelsLikeSvg,
                            title: "FEELS LIKE",
                            weatherText:
                                "${(weather[0].tempFeelsLike!.celsius)!.floor()}°",
                          ),
                        ],
                      ),
                    ),

                    /// FUTURE WEATHER INFO
                    FadeInUp(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(30),
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaY: 15, sigmaX: 15),
                            child: Container(
                              padding: const EdgeInsets.all(16.0),
                              decoration: BoxDecoration(
                                color: Colors.grey.shade600.withOpacity(0.25),
                                borderRadius: BorderRadius.circular(30),
                              ),
                              alignment: Alignment.center,
                              height: MediaQuery.of(context).size.height * .275,
                              width: MediaQuery.of(context).size.width,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: weather.length - 1,
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  return Container(
                                    alignment: Alignment.center,
                                    width:
                                        MediaQuery.of(context).size.width / 4 -
                                            16.0,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Text(
                                          weather[index + 1].date!.toDayMonth(),
                                          style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.normal,
                                            color: Colors.white,
                                          ),
                                        ),
                                        Image.asset(Assets.getWeatherIcon(
                                            code: weather[index + 1]
                                                .weatherIcon!)),
                                        Text(
                                          "${weather[index + 1].temperature!.celsius!.floor()}°",
                                          style: const TextStyle(
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.normal,
                                            color: Colors.white,
                                          ),
                                        ),
                                        const SizedBox(height: 4.0),
                                        Text(
                                          "${weather[index + 1].windSpeed!.toStringAsFixed(1)}\nkm/h",
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.w400,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else {
            return const Text('No data available');
          }
        },
      ),
    );
  }

  Widget appBar({required String? cityName}) {
    return AppBar(
      backgroundColor: Colors.transparent,
      title: ListTile(
        contentPadding: EdgeInsets.zero,
        visualDensity: const VisualDensity(vertical: -4, horizontal: -4),
        leading: const Icon(Icons.location_on_rounded, color: Colors.white),
        title: Text(
          "$cityName",
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.normal,
            color: Colors.white,
          ),
        ),
        trailing: GestureDetector(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const SavedLocPage()));
          },
          child: const Icon(Icons.menu, color: Colors.white),
        ),
      ),
    );
  }

  Widget weatherInfoWidget(
      {required String title,
      required String svgUrl,
      required String weatherText}) {
    return Column(
      children: [
        SvgPicture.asset(
          svgUrl,
          colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
        ),
        Text(
          title,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.normal,
            shadows: [
              Shadow(
                offset: const Offset(1, 1),
                blurRadius: 20.0,
                color: Colors.grey.shade800,
              ),
              Shadow(
                offset: const Offset(-1, -1),
                blurRadius: 20.0,
                color: Colors.grey.shade800,
              ),
            ],
          ),
        ),
        Text(
          weatherText,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            shadows: [
              Shadow(
                offset: const Offset(1, 1),
                blurRadius: 10.0,
                color: Colors.grey.shade800,
              ),
              Shadow(
                offset: const Offset(-1, -1),
                blurRadius: 10.0,
                color: Colors.grey.shade800,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
