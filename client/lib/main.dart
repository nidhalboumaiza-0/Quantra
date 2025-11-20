import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/authorisation/presentation%20layer/bloc/get_cached_user_info/get_cached_user_bloc.dart';
import 'package:weather_app/bloc/weather_bloc_bloc.dart';
import 'package:weather_app/screens/home_screen.dart';

import 'admin/presentation layer/cubit/bridge cubit/bridge__cubit.dart';
import 'authorisation/presentation layer/bloc/disable_account_bloc/disable_account_bloc.dart';
import 'authorisation/presentation layer/bloc/forget_password_bloc/forget_password_bloc.dart';
import 'authorisation/presentation layer/bloc/modify my information bloc/modify_my_information_bloc.dart';
import 'authorisation/presentation layer/bloc/reset_password_step_one_bloc/reset_password_step_one_bloc.dart';
import 'authorisation/presentation layer/bloc/reset_password_step_two_bloc/reset_password_step_two_bloc.dart';
import 'authorisation/presentation layer/bloc/sign_in_bloc/sign_in_bloc.dart';
import 'authorisation/presentation layer/bloc/sign_out_bloc/sign_out_bloc.dart';
import 'authorisation/presentation layer/bloc/sign_up_bloc/sign_up_bloc.dart';
import 'authorisation/presentation layer/bloc/update_user_password_bloc/update_user_password_bloc.dart';
import 'authorisation/presentation layer/cubit/confirm_password_visibility_reset_password_cubit/reset_confirm_password_visibility_cubit.dart';
import 'authorisation/presentation layer/cubit/password_visibility_reset_password_cubit/reset_password_visibility_cubit.dart';
import 'authorisation/presentation layer/cubit/password_visibility_sign_in_cubit/password_visibility_cubit.dart';
import 'authorisation/presentation layer/cubit/profile_pic_creation _cubit/profile_pic_creation__cubit.dart';
import 'authorisation/presentation layer/pages/sign_in_screen.dart';
import 'cubit/confirm new password cubit/confirm_new_password_cubit.dart';
import 'cubit/new password cubit/new_password_cubit.dart';
import 'cubit/old password cubit/old_password_cubit.dart';
import 'injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Future.wait([
  //   LocalNotificationService.init(),
  //   WorkManagerService().init(),
  // ]);
  await di.init();
  await dotenv.load(fileName: ".env");
  // await Firebase.initializeApp(
  //   options : DefaultFirebaseOptions.currentPlatform,
  // );
  OneSignal.Debug.setLogLevel(OSLogLevel.verbose);
  OneSignal.initialize("c337b164-017f-48ed-9b27-a2c7d90dee46");
  OneSignal.Notifications.requestPermission(true);

  final SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();
  final token = sharedPreferences.getString('token');
  Widget screen;
  if (token != null) {
    screen = const HomeScreen();
  } else {
    screen = const SignInScreen();
  }
  await initializeDateFormatting('fr_FR', null);
  runApp(MyApp(screen: screen));
}

class MyApp extends StatelessWidget {
  Widget screen;

  MyApp({super.key, required this.screen});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<SignInBloc>(
          create: (context) => di.sl<SignInBloc>(),
        ),
        BlocProvider<ForgetPasswordBloc>(
          create: (context) => di.sl<ForgetPasswordBloc>(),
        ),
        BlocProvider(create: (context) => di.sl<DisableAccountBloc>()),
        BlocProvider(create: (context) => di.sl<SignUpBloc>()),
        BlocProvider(create: (context) => di.sl<ResetPasswordStepOneBloc>()),
        BlocProvider(create: (context) => di.sl<ResetPasswordStepTwoBloc>()),
        BlocProvider(create: (context) => di.sl<SignOutBloc>()),
        BlocProvider(create: (create) => di.sl<UpdateUserPasswordBloc>()),
        BlocProvider(create: (create) => di.sl<PasswordVisibilityCubit>()),
        BlocProvider(create: (create) => di.sl<ResetPasswordVisibilityCubit>()),
        BlocProvider(
            create: (create) => di.sl<ResetConfirmPasswordVisibilityCubit>()),
        BlocProvider(create: (create) => di.sl<ProfilePicCreationCubit>()),
        BlocProvider(create: (create) => di.sl<GetCachedUserBloc>()),
        BlocProvider(create: (create) => di.sl<ModifyMyInformationBloc>()),
        BlocProvider(create: (create) => di.sl<ConfirmNewPasswordCubit>()),
        BlocProvider(create: (create) => di.sl<NewPasswordCubit>()),
        BlocProvider(create: (create) => di.sl<OldPasswordCubit>()),
        BlocProvider(create: (create) => di.sl<WeatherBlocBloc>()),
        BlocProvider(create: (create) => di.sl<BridgeCubit>()),
      ],
      child: ScreenUtilInit(
          designSize: const Size(360, 690),
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (_, child) {
            return GetMaterialApp(
                debugShowCheckedModeBanner: false,
                home: BlocProvider<WeatherBlocBloc>(
                  create: (context) => WeatherBlocBloc()
                    ..add(
                      FetchWeather(SimplePosition(
                          latitude: 37.275727, longitude: 9.864101)),
                    ),
                  child: screen, // screen
                )

                // FutureBuilder(
                //   future: _determinePosition(),
                //   builder: (context, snapshot) {
                //     if (snapshot.hasData) {
                //       return BlocProvider<WeatherBlocBloc>(
                //         create: (context) => WeatherBlocBloc()
                //           ..add(
                //             FetchWeather(snapshot.data as Position),
                //           ),
                //         child: const HomeScreen(),
                //       );
                //     } else {
                //       return const Scaffold(
                //         body: Center(
                //           child: CircularProgressIndicator(),
                //         ),
                //       );
                //     }
                //   },
                // ),
                );
          }),
    );
  }
}

/// Determine the current position of the device.
///
/// When the location services are not enabled or permissions
/// are denied the `Future` will return an error.
Future<Position> _determinePosition() async {
  bool serviceEnabled;
  LocationPermission permission;

  // Test if location services are enabled.
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    // Location services are not enabled don't continue
    // accessing the position and request users of the
    // App to enable the location services.
    return Future.error('Location services are disabled.');
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      // Permissions are denied, next time you could try
      // requesting permissions again (this is also where
      // Android's shouldShowRequestPermissionRationale
      // returned true. According to Android guidelines
      // your App should show an explanatory UI now.
      return Future.error('Location permissions are denied');
    }
  }

  if (permission == LocationPermission.deniedForever) {
    // Permissions are denied forever, handle appropriately.
    return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.');
  }

  // When we reach here, permissions are granted and we can
  // continue accessing the position of the device.
  return await Geolocator.getCurrentPosition();
}

class SimplePosition {
  final double latitude;
  final double longitude;

  SimplePosition({required this.latitude, required this.longitude});
}
