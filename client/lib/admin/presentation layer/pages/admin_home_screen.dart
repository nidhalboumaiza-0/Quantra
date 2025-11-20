import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weather_app/core/widgets/my_customed_button.dart';

import '../../../authorisation/presentation layer/bloc/sign_out_bloc/sign_out_bloc.dart';
import '../../../authorisation/presentation layer/pages/creation account/password_creation_screen.dart';
import '../../../authorisation/presentation layer/pages/sign_in_screen.dart';
import '../../../core/colors.dart';
import '../../../core/utils/navigation_with_transition.dart';
import '../../../screens/others_screen.dart';
import '../cubit/bridge cubit/bridge__cubit.dart';

class AdminHomeScreen extends StatefulWidget {
  const AdminHomeScreen({super.key});

  @override
  State<AdminHomeScreen> createState() => _AdminHomeScreenState();
}

class _AdminHomeScreenState extends State<AdminHomeScreen> {
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
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(40, 1.2 * 30.h, 40, 10),
            child: SizedBox(
              // height: MediaQuery.of(context).size.height,
              child: Stack(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: 200.h),
                      BlocConsumer<BridgeCubit, BridgeState>(
                        listener: (context, state) {
                          if (state is BridgeRaiseSuccess) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content:
                                    Text('Opération effectuée avec succès'),
                                backgroundColor: Colors.green,
                              ),
                            );
                          } else if (state is BridgeErreur) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(state.message),
                                backgroundColor: Colors.red,
                              ),
                            );
                          } else if (state is BridgeOffline) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Pas de connexion internet'),
                                backgroundColor: Colors.red,
                              ),
                            );
                          }
                        },
                        builder: (context, state) {
                          if (state is BridgeUnauthorized) {
                            return handleUnauthorizedAccessLogic(context);
                          } else {
                            return MyCustomButton(
                              width: double.infinity,
                              height: 50.h,
                              function: () {
                                context
                                    .read<BridgeCubit>()
                                    .operationBridge(true);
                              },
                              buttonColor: primaryColorLight,
                              text: 'Lever urgent du pont',
                              circularRadious: 15.sp,
                              textButtonColor: Colors.white,
                              fontSize: 17.sp,
                              fontWeight: FontWeight.w700,
                              widget: const SizedBox(),
                            );
                          }
                        },
                      ),
                      SizedBox(height: 30.h),
                      BlocConsumer<BridgeCubit, BridgeState>(
                        listener: (context, state) {
                          if (state is BridgeCloseSuccess) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content:
                                    Text('Opération effectuée avec succès'),
                                backgroundColor: Colors.green,
                              ),
                            );
                          } else if (state is BridgeErreur) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(state.message),
                                backgroundColor: Colors.redAccent,
                              ),
                            );
                          } else if (state is BridgeOffline) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Pas de connexion internet'),
                                backgroundColor: Colors.redAccent,
                              ),
                            );
                          }
                        },
                        builder: (context, state) {
                          if (state is BridgeUnauthorized) {
                            return handleUnauthorizedAccessLogic(context);
                          } else {
                            return MyCustomButton(
                              textWidth: 200.h,
                              width: double.infinity,
                              height: 50.h,
                              function: () {
                                context
                                    .read<BridgeCubit>()
                                    .operationBridge(false);
                              },
                              buttonColor: primaryColorLight,
                              text: "Rendre pont à l'état normal.",
                              circularRadious: 15.sp,
                              textButtonColor: Colors.white,
                              fontSize: 17.sp,
                              fontWeight: FontWeight.w700,
                              widget: const SizedBox(),
                            );
                          }
                        },
                      ),
                    ],
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

// Make sure to import all necessary files

Widget handleUnauthorizedAccessLogic(BuildContext context) {
  BlocProvider.of<SignOutBloc>(context).add(SignOutMyAccountEventPressed());
  return BlocConsumer<SignOutBloc, SignOutState>(
    builder: (context, state) {
      if (state is SignOutLoading) {
        return ReusablecircularProgressIndicator(
          height: 20.h,
          width: 20.w,
          indicatorColor: primaryColor,
        );
      } else {
        return const Text("errrorororororor");
      }
    },
    listener: (context, state) {
      if (state is SignOutSuccess) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Votre session a expiré , veuillez vous reconnecter"),
            backgroundColor: Colors.red,
          ),
        );
        navigateToAnotherScreenWithSlideTransitionFromRightToLeftPushReplacement(
          context,
          SignInScreen(),
        );
      } else if (state is SignOutError) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(state.message),
            backgroundColor: Colors.red,
          ),
        );
      }
    },
  );
}
