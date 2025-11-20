import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/bloc/weather_bloc_bloc.dart';
import 'package:weather_app/core/utils/navigation_with_transition.dart';
import 'package:weather_app/core/widgets/reusable_text.dart';

import '../main.dart';
import 'others_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Widget getWeatherIcon(int code) {
    switch (code) {
      case >= 200 && < 300:
        return Image.asset('assets/1.png');
      case >= 300 && < 400:
        return Image.asset('assets/2.png');
      case >= 500 && < 600:
        return Image.asset('assets/3.png');
      case >= 600 && < 700:
        return Image.asset('assets/4.png');
      case >= 700 && < 800:
        return Image.asset('assets/5.png');
      case == 800:
        return Image.asset('assets/6.png');
      case > 800 && <= 804:
        return Image.asset('assets/7.png');
      default:
        return Image.asset('assets/7.png');
    }
  }

  String getGreeting() {
    final now = DateTime.now();
    if (now.hour >= 0 && now.hour < 12) {
      return 'Bonjour';
    } else {
      return 'Salut';
    }
  }

  @override
  void initState() {
    context.read<WeatherBlocBloc>().add(
        FetchWeather(SimplePosition(latitude: 37.275727, longitude: 9.864101)));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xff81d4fa).withOpacity(0.7),
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarBrightness: Brightness.dark,
          ),
          actions: [
            IconButton(
              onPressed: () {
                navigateToAnotherScreenWithSlideTransitionFromRightToLeft(
                    context, OthersScreen());
              },
              icon: Icon(
                Icons.person_rounded,
                color: Colors.white,
                size: 25.sp,
              ),
            ),
          ],
          leading: null,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(40, 1.2 * 30.h, 40, 10),
            child: SizedBox(
              // height: MediaQuery.of(context).size.height,
              child: Stack(
                children: [
                  BlocBuilder<WeatherBlocBloc, WeatherBlocState>(
                    builder: (context, state) {
                      if (state is WeatherBlocSuccess) {
                        return SizedBox(
                          // height: MediaQuery.of(context).size.height,
                          // width: MediaQuery.of(context).size.width,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // location
                              Text(
                                '${state.weather.areaName}',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              // greeting
                              Text(
                                getGreeting(),
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 25,
                                ),
                              ),
                              // image
                              //   getWeatherIcon(state.weather.weatherConditionCode!),
                              Center(
                                child: Text(
                                  '${state.weather.temperature!.celsius!.round()} °C',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 55,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              // weather type
                              Center(
                                child: Text(
                                  state.weather.weatherMain!.toUpperCase(),
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 25,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              // date
                              Center(
                                child: Text(
                                  DateFormat('EEEE dd MMMM', 'fr_FR')
                                      .add_Hm()
                                      .format(state.weather.date!),
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              // Sunset - Sunrise row
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      // sunrise row
                                      Image.asset(
                                        'assets/11.png',
                                        scale: 9,
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            width: 80.w,
                                            child: const Text(
                                              'lever du Soleil',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w300,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 3,
                                          ),
                                          Text(
                                            DateFormat('HH:mm', 'fr_FR')
                                                .format(state.weather.sunrise!),
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  // sunset row
                                  Row(
                                    children: [
                                      Image.asset(
                                        'assets/12.png',
                                        scale: 9,
                                      ),
                                      const SizedBox(
                                        width: 3,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            width: 80.w,
                                            child: const Text(
                                              'Coucher de soleil',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w300,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 3,
                                          ),
                                          Text(
                                            DateFormat('HH:mm', 'fr_FR')
                                                .format(state.weather.sunset!),
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              const Padding(
                                padding: EdgeInsetsDirectional.symmetric(
                                    vertical: 5.0),
                                child: Divider(
                                  color: Colors.grey,
                                ),
                              ),
                              // Min Temprature - Max Temprature row
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        'assets/wind.png',
                                        scale: 9,
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            width: 80.w,
                                            child: const Text(
                                              'Vitesse de vent',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w300,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 3,
                                          ),
                                          Text(
                                            '${state.weather.windSpeed!.round()} Km/h ',
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.07),
                                  // Min Temp row
                                  Row(
                                    children: [
                                      Image.asset(
                                        'assets/hum.png',
                                        scale: 10,
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            width: 60.w,
                                            child: const Text(
                                              'Humidité',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w300,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 3,
                                          ),
                                          Text(
                                            '${state.weather.humidity!.round()} %',
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              const Padding(
                                padding: EdgeInsetsDirectional.symmetric(
                                    vertical: 5.0),
                                child: Divider(
                                  color: Colors.grey,
                                ),
                              ),
                              // Bridge operations
                              ReusableText(
                                text: "Les temps où le pont est relevé",
                                textSize: 15.sp,
                                textColor: Colors.white,
                                textFontWeight: FontWeight.w700,
                              ),
                              SizedBox(height: 5.h),
                              Container(
                                height: 150.h,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  border: Border.all(
                                    color: Colors.white,
                                    width: 2,
                                  ),
                                ),
                                child: Column(
                                  children: [
                                    SizedBox(
                                        width: double.infinity,
                                        height: 120.h,
                                        child: Image.asset(
                                            "assets/bridge construction.png")),
                                    Text(
                                      "22:00",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 20.h),
                              Container(
                                height: 150.h,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  border: Border.all(
                                    color: Colors.white,
                                    width: 2,
                                  ),
                                ),
                                child: Column(
                                  children: [
                                    SizedBox(
                                        width: double.infinity,
                                        height: 120.h,
                                        child: Image.asset(
                                            "assets/bridge construction.png")),
                                    Text(
                                      "04:00",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 20.h),
                            ],
                          ),
                        );
                      } else {
                        return Container();
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
