import 'dart:convert';
import 'dart:io';

import 'package:azsoon/features/Auth/presentaiton/screens/reset_Password.dart';
import 'package:azsoon/features/blog/presentation/screens/articles_feed.dart';
import 'package:azsoon/features/blog/presentation/screens/blog_screen.dart';
import 'package:azsoon/features/space/presentation/comments_screen.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
// import 'package:intl_phone_number_input/intl_phone_number_input.dart';

import 'package:azsoon/Core/colors.dart';
import 'package:azsoon/common_widgets/Button.dart';
import 'package:azsoon/common_widgets/TextField.dart';
import 'package:http/http.dart';
import 'package:pinput/pinput.dart';

import '../Core/local_storage.dart';
import '../Core/network/request_helper.dart';
import '../features/Auth/presentaiton/introduction_animation/introduction_animation_screen.dart';
import '../features/become_premium/presentation/be_premium_screen.dart';
import '../features/profile/bloc/profile_bloc.dart';
import '../features/profile/data/my_profile_model.dart';
import '../features/space/bloc/cubit/verify_email_cubit.dart';
import '../features/space/cubit/firebase_phone_verification_cubit.dart';
import '../features/verification/persentation/screens/verification_pro_request_screen.dart';
import '../screens/NewProfile_page.dart';

String birthDate = '';
String? name;
String? surname;
String? phoneNumber;
String? newPassword;

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});
  static const String routeName = '/settings';

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  TextEditingController searchController = TextEditingController();
  bool notification = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: bodyColor,
        body: ListView(
          children: [
            const SettingsHeaderWidget(),
            BlocBuilder<ProfileBloc, ProfileState>(
              builder: (context, state) {
                if (state is ProfileLoaded &&
                    state.profileModel.user!.isVerified == false &&
                    state.profileModel.user!.isVerifiedPro == false &&
                    state.profileModel.user!.userRole == 1) {
                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: primaryColor),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          offset: const Offset(0, 2),
                          blurRadius: 1,
                          spreadRadius: 0.2,
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 10.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              'Verify your account or you will be suspended in ${state.profileModel.user!.daysLeft} days',
                              textAlign: TextAlign.start,
                              style: const TextStyle(color: Colors.red),
                            ),
                          ),
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: primaryColor,
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (_) => BlocProvider.value(
                                    value: context.read<VerifyEmailCubit>(),
                                    child: const VerificationSteps(),
                                  ),
                                ));
                              },
                              child: const Text(
                                'Verify now',
                                style: TextStyle(color: Colors.white),
                              ))
                        ],
                      ),
                    ),
                  );
                } else {
                  return const SizedBox();
                }
              },
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  // BlocBuilder<ProfileBloc, ProfileState>(
                  //   builder: (context, state) {
                  //     if (state is ProfileLoaded) {
                  //       if (state.profileModel.user!.isVerified == false &&
                  //           state.profileModel.user!.isVerifiedPro == false &&
                  //           state.profileModel.user!.userRole == 1) {
                  //         return Column(
                  //           children: [
                  //             ListTile(
                  //               // subtitle: const Text(
                  //               //   'Verify your account or you will be suspended',
                  //               //   style: TextStyle(color: Colors.red),
                  //               // ),
                  //               leading: const Icon(Icons.check_circle_outline,
                  //                   color: Colors.grey),
                  //               title: const Row(
                  //                 children: [
                  //                   Text('Verification',
                  //                       style: TextStyle(
                  //                           color: Color(0xff666666))),
                  //                 ],
                  //               ),
                  //               trailing: const Text(
                  //                 'Verify now',
                  //                 style: TextStyle(color: Colors.red),
                  //               ),
                  //               onTap: () {
                  //                 Navigator.of(context)
                  //                     .pushNamed(My_Account_Settings.routeName);
                  //               },
                  //             ),
                  //           ],
                  //         );
                  //       } else {
                  //         return const SizedBox();
                  //       }
                  //     } else {
                  //       return const SizedBox();
                  //     }
                  //   },
                  // ),
                  // if()
                  // if ((context.read<ProfileBloc>().state as ProfileLoaded)
                  //             .profileModel
                  //             .user!
                  //             .isVerifiedPro ==
                  //         false &&
                  //     (context.read<ProfileBloc>().state as ProfileLoaded)
                  //             .profileModel
                  //             .user!
                  //             .userRole ==
                  //         1)
                  if ((context.read<ProfileBloc>().state as ProfileLoaded)
                              .profileModel
                              .user!
                              .isVerifiedPro ==
                          true &&
                      (context.read<ProfileBloc>().state as ProfileLoaded)
                              .profileModel
                              .blog !=
                          null)
                    ListTile(
                      leading: const Icon(Icons.check_circle_outline,
                          color: Colors.grey),
                      title: const Text('My Blog',
                          style: TextStyle(color: Color(0xff666666))),
                      trailing: const Icon(Icons.arrow_forward_ios),
                      onTap: () {
                        Navigator.of(context).pushNamed(BlogScreen.routeName,
                            arguments: (context.read<ProfileBloc>().state
                                    as ProfileLoaded)
                                .profileModel
                                .blog);
                      },
                    ),
                  if (context.read<ProfileBloc>().state is ProfileLoaded &&
                      (context.read<ProfileBloc>().state as ProfileLoaded)
                              .profileModel
                              .user!
                              .isVerifiedPro ==
                          true &&
                      (context.read<ProfileBloc>().state as ProfileLoaded)
                              .profileModel
                              .blog ==
                          null)
                    const CreateYourBlogIncourgement(),
                  if ((context.read<ProfileBloc>().state as ProfileLoaded)
                              .profileModel
                              .user!
                              .isVerifiedPro ==
                          false &&
                      (context.read<ProfileBloc>().state as ProfileLoaded)
                              .profileModel
                              .user!
                              .userRole ==
                          1)
                    BlocBuilder<ProfileBloc, ProfileState>(
                        builder: (context, state) {
                      return ListTile(
                        leading: Image.asset('assets/images/quality.png',
                            height: 25),
                        // color: Colors.grey);

                        title: const Text('Become a verified pro',
                            style: TextStyle(color: Color(0xff666666))),
                        trailing: const Icon(Icons.arrow_forward_ios),
                        onTap: () {
                          if (state is ProfileLoaded &&
                              state.profileModel.user!.isVerified == false) {
                            Fluttertoast.showToast(
                                msg: 'Verify your account first',
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.CENTER,
                                timeInSecForIosWeb: 1,
                                backgroundColor:
                                    const Color.fromARGB(255, 166, 221, 247),
                                textColor: Colors.black,
                                fontSize: 16.0);
                            return;
                          }
                          Navigator.of(context).pushNamed(
                              VerificationProRequestScreen.routeName);
                        },
                      );
                    }),
                  if ((context.read<ProfileBloc>().state as ProfileLoaded)
                          .profileModel
                          .user!
                          .userRole ==
                      1)
                    ListTile(
                      leading: Image.asset('assets/images/verified-account.png',
                          height: 25),
                      title: const Text('Become a premium',
                          style: TextStyle(color: Color(0xff666666))),
                      trailing: const Icon(Icons.arrow_forward_ios),
                      onTap: () {
                        Navigator.of(context).pushNamed(PartnerForm.routeName);
                      },
                    ),
                  ListTile(
                    leading: const Icon(Icons.lock_outline, color: Colors.grey),
                    title: const Text('Reset Password',
                        style: TextStyle(color: Color(0xff666666))),
                    trailing: const Icon(Icons.arrow_forward_ios),
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => const ResetPasswordSettings(),
                        ),
                      );
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.notifications_outlined,
                        color: Colors.grey),
                    title: const Text('Notifications',
                        style: TextStyle(color: Color(0xff666666))),
                    trailing: Switch(
                      value: notification,
                      onChanged: (value) {
                        setState(() {
                          notification = value;
                        });
                      },
                      activeColor: primaryColor,
                    ),
                  ),
                  //logout
                  ListTile(
                    leading: const Icon(Icons.logout, color: Colors.grey),
                    title: const Text('Log Out',
                        style: TextStyle(color: Colors.red)),
                    onTap: () async {
                      await LocalStorage.removeAuthToken();
                      DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

                      String deviceId = '';

                      if (Platform.isAndroid) {
                        AndroidDeviceInfo androidInfo =
                            await deviceInfo.androidInfo;
                        deviceId = androidInfo.id;
                      } else if (Platform.isIOS) {
                        IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
                        deviceId = iosInfo.identifierForVendor!;
                      }
                      await RequestHelper.post('unregister_device/', {
                        'device_id': deviceId,
                      });
                      if (context.mounted) {
                        Navigator.of(context).pushReplacementNamed(
                            IntroductionAnimationScreen.routeName);
                      }
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 50,
            ),
          ],
        )

        // Container(
        //   child: Column(
        //     children: [
        //       Expanded(
        //         child: SettingsList(
        //           lightTheme: const SettingsThemeData(
        //               settingsListBackground: Color.fromARGB(255, 251, 250, 250)),
        //           sections: [
        //             SettingsSection(
        //               tiles: <SettingsTile>[
        //                 SettingsTile(
        //                   title: Container(
        //                     decoration: BoxDecoration(
        //                       color: Colors.white,
        //                       borderRadius: BorderRadius.circular(10),
        //                       border: Border.all(color: Colors.white),
        //                       boxShadow: [
        //                         BoxShadow(
        //                           color: Colors.black.withOpacity(0.2),
        //                           offset: const Offset(0, 2),
        //                           blurRadius: 1,
        //                           spreadRadius: 0.2,
        //                         ),
        //                       ],
        //                     ),
        //                     child: SettingsTile.navigation(
        //                       onPressed: (_) {
        //                         Navigator.of(context)
        //                             .pushNamed('/myAccountSettings');
        //                       },
        //                       trailing: const Icon(Icons.arrow_forward_ios),
        //                       leading: const Icon(Icons.person_pin),
        //                       title: const Text('My Account Settings'),
        //                     ),
        //                   ),
        //                 ),
        //                 SettingsTile(
        //                   title: Container(
        //                       padding: const EdgeInsets.symmetric(
        //                           horizontal: 0, vertical: 0),
        //                       decoration: BoxDecoration(
        //                         color: Colors.white,
        //                         borderRadius: BorderRadius.circular(10),
        //                         border: Border.all(color: Colors.white),
        //                         boxShadow: [
        //                           BoxShadow(
        //                             color: Colors.black.withOpacity(0.2),
        //                             offset: const Offset(0, 2),
        //                             blurRadius: 1,
        //                             spreadRadius: 0.2,
        //                           ),
        //                         ],
        //                       ),
        //                       child: Column(
        //                         children: [
        //                           SettingsTile.switchTile(
        //                             enabled: false,
        //                             activeSwitchColor: const Color(0XFFA29CEC),
        //                             onToggle: (value) {},
        //                             initialValue: false,
        //                             leading: const Icon(Icons.dark_mode_outlined),
        //                             title: const Text('Dark mode'),
        //                           ),
        //                           SettingsTile.navigation(
        //                             trailing: const Icon(Icons.arrow_forward_ios),
        //                             leading: const Icon(Icons.language),
        //                             title: const Text('Language and Region'),
        //                           ),
        //                           SettingsTile.switchTile(
        //                             activeSwitchColor: const Color(0XFFA29CEC),
        //                             onToggle: (value) {},
        //                             initialValue: true,
        //                             leading:
        //                                 const Icon(Icons.notifications_outlined),
        //                             title: const Text('Notifications'),
        //                           ),
        //                         ],
        //                       )),
        //                 ),
        //                 SettingsTile(
        //                   title: Container(
        //                       padding: const EdgeInsets.symmetric(
        //                           horizontal: 0, vertical: 0),
        //                       decoration: BoxDecoration(
        //                         color: Colors.white,
        //                         borderRadius: BorderRadius.circular(10),
        //                         border: Border.all(color: Colors.white),
        //                         boxShadow: [
        //                           BoxShadow(
        //                             color: Colors.black.withOpacity(0.2),
        //                             offset: const Offset(0, 2),
        //                             blurRadius: 1,
        //                             spreadRadius: 0.2,
        //                           ),
        //                         ],
        //                       ),
        //                       child: Column(
        //                         children: [
        //                           SettingsTile.navigation(
        //                             trailing: const Icon(Icons.arrow_forward_ios),
        //                             leading: const Icon(Icons.lock_outline),
        //                             title: const Text('Privacy'),
        //                           ),
        //                           SettingsTile.navigation(
        //                             trailing: const Icon(Icons.arrow_forward_ios),
        //                             leading: const Icon(
        //                                 Icons.stacked_bar_chart_outlined),
        //                             title: const Text('Data and Permissions'),
        //                           ),
        //                           SettingsTile.navigation(
        //                             trailing: const Icon(Icons.arrow_forward_ios),
        //                             leading: const Icon(Icons.check_box_outlined),
        //                             title: const Text('Terms and Service'),
        //                           ),
        //                         ],
        //                       )),
        //                 ),
        //                 SettingsTile(
        //                   title: Container(
        //                       padding: const EdgeInsets.symmetric(
        //                           horizontal: 0, vertical: 0),
        //                       decoration: BoxDecoration(
        //                         color: Colors.white,
        //                         borderRadius: BorderRadius.circular(10),
        //                         border: Border.all(color: Colors.white),
        //                         boxShadow: [
        //                           BoxShadow(
        //                             color: Colors.black.withOpacity(0.2),
        //                             offset: const Offset(0, 2),
        //                             blurRadius: 1,
        //                             spreadRadius: 0.2,
        //                           ),
        //                         ],
        //                       ),
        //                       child: Column(
        //                         children: [
        //                           SettingsTile.navigation(
        //                             trailing: const Icon(Icons.arrow_forward_ios),
        //                             leading:
        //                                 const Icon(Icons.privacy_tip_outlined),
        //                             title: const Text('Help Center'),
        //                           ),
        //                           SettingsTile.navigation(
        //                             trailing: const Icon(Icons.arrow_forward_ios),
        //                             leading:
        //                                 const Icon(Icons.help_center_outlined),
        //                             title: const Text('FAQ'),
        //                           ),
        //                           SettingsTile.navigation(
        //                             trailing: const Icon(Icons.arrow_forward_ios),
        //                             leading: const Icon(Icons.logout),
        //                             title: const Text(
        //                               'Log Out',
        //                               style: TextStyle(color: Colors.red),
        //                             ),
        //                             onPressed: (_) async {
        //                               await LocalStorage.removeAuthToken();
        //                               if (context.mounted) {
        //                                 Navigator.of(context)
        //                                     .pushReplacementNamed(
        //                                         SignInScreen.routeName);
        //                               }
        //                             },
        //                           ),
        //                         ],
        //                       )),
        //                 ),
        //                 SettingsTile(
        //                   title: Container(
        //                     padding: const EdgeInsets.symmetric(
        //                         horizontal: 0, vertical: 0),
        //                     decoration: BoxDecoration(
        //                       color: const Color.fromARGB(255, 215, 82, 82),
        //                       borderRadius: BorderRadius.circular(10),
        //                       border: Border.all(
        //                         color: const Color.fromARGB(255, 215, 82, 82),
        //                       ),
        //                       boxShadow: [
        //                         BoxShadow(
        //                           color: Colors.black.withOpacity(0.2),
        //                           offset: const Offset(0, 2),
        //                           blurRadius: 1,
        //                           spreadRadius: 0.2,
        //                         ),
        //                       ],
        //                     ),
        //                     child: SettingsTile.navigation(
        //                       value: const Text(
        //                         '22 day left',
        //                         style: TextStyle(
        //                           color: Colors.white,
        //                         ),
        //                       ),
        //                       trailing: const Icon(
        //                         Icons.arrow_forward_ios,
        //                         color: Colors.white,
        //                       ),
        //                       leading: const Icon(
        //                         Icons.warning,
        //                         color: Colors.white,
        //                       ),
        //                       title: const Text(
        //                         'Verify your account !',
        //                         style: TextStyle(
        //                           color: Colors.white,
        //                         ),
        //                       ),
        //                     ),
        //                   ),
        //                 ),
        //               ],
        //             ),
        //           ],
        //         ),
        //       ),
        //     ],
        //   ),
        // ),

        );
  }
}

class SettingsHeaderWidget extends StatelessWidget {
  const SettingsHeaderWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
      margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        // border: Border.all(color: Colors.white),
      ),
      child: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          String? profileImage =
              state is ProfileLoaded && state.profileModel.profileImage != null
                  ? state.profileModel.profileImage
                  : null;

          return Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CommentProfileImage(profileImage: profileImage),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      state is ProfileLoaded
                          ? '${state.profileModel.user!.firstName} ${state.profileModel.user!.lastName}'
                          : '',
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    Text(
                        "${state is ProfileLoaded ? state.profileModel.user!.email : ''}",
                        style:
                            const TextStyle(fontSize: 15, color: Colors.grey)),
                  ],
                ),
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).pushNamed(NewProfile_Page.routeName);
                  },
                  child: const Text('Edit',
                      style: TextStyle(fontSize: 12, color: Colors.white)))
            ],
          );
        },
      ),
    );
  }
}

class My_Account_Settings extends StatefulWidget {
  static const String routeName = '/myAccountSettings';
  const My_Account_Settings({super.key});

  @override
  State<My_Account_Settings> createState() => _My_Account_SettingsState();
}

class _My_Account_SettingsState extends State<My_Account_Settings> {
  final GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  final GlobalKey<FormState> passwordKey = GlobalKey<FormState>();
  bool passwordVisibilty = true;

  @override
  void initState() {
    // context.read<ProfileBloc>().add(const LoadMyProfile());
    super.initState();
  }

  String? oldPassword;
  String? newPassword;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Verify your account"),
      ),
      body: Form(
        key: globalKey,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
          child: ListView(
            children: [
              BlocListener<VerifyEmailCubit, VerifyEmailState>(
                listener: (context, state) {
                  if (state is EmailVerificationLoading) {
                    Fluttertoast.showToast(
                        msg: 'Loading...',
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                        timeInSecForIosWeb: 1,
                        backgroundColor:
                            const Color.fromARGB(255, 166, 221, 247),
                        textColor: Colors.black,
                        fontSize: 16.0);
                  }
                  if (state is EmailVerified) {
                    Navigator.of(context).pop();
                  }
                  if (state is EmialCodeSent) {
                    Fluttertoast.showToast(
                        msg: 'Code sent to email',
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                        timeInSecForIosWeb: 1,
                        backgroundColor:
                            const Color.fromARGB(255, 166, 221, 247),
                        textColor: Colors.black,
                        fontSize: 16.0);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => BlocProvider.value(
                                  value: context.read<VerifyEmailCubit>(),
                                  child: SecondStep(
                                    email: (context.read<ProfileBloc>().state
                                            as ProfileLoaded)
                                        .profileModel
                                        .user!
                                        .email!,
                                    verifyEmail: true,
                                  ),
                                )));
                  }
                  if (state is EmailVerified) {
                    context.read<ProfileBloc>().add(const LoadMyProfile());
                  }
                },
                child: BlocBuilder<ProfileBloc, ProfileState>(
                  builder: (context, profileState) {
                    if (profileState is ProfileInitial) {
                      context.read<ProfileBloc>().add(const LoadMyProfile());
                    }
                    if (profileState is ProfileLoaded) {
                      return Container(
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.white),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              offset: const Offset(0, 2),
                              blurRadius: 1,
                              spreadRadius: 0.2,
                            ),
                          ],
                        ),
                        child: Theme(
                          data: ThemeData(
                            dividerColor: Colors.transparent,
                          ),
                          child: ExpansionTile(
                            trailing: const Icon(Icons.email_outlined),
                            title: const Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('E-mail'),
                              ],
                            ),
                            subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(profileState.profileModel.user!.email!),
                                  const SizedBox(
                                    height: 13,
                                  ),
                                  BlocListener<VerifyEmailCubit,
                                      VerifyEmailState>(
                                    listener: (context, state) {
                                      if (state is EmailVerificationFailed) {
                                        Fluttertoast.showToast(
                                            msg:
                                                'Email verification code is wrong',
                                            toastLength: Toast.LENGTH_SHORT,
                                            gravity: ToastGravity.CENTER,
                                            timeInSecForIosWeb: 1,
                                            backgroundColor:
                                                const Color.fromARGB(
                                                    255, 166, 221, 247),
                                            textColor: Colors.black,
                                            fontSize: 16.0);
                                      }
                                    },
                                    child: BlocBuilder<VerifyEmailCubit,
                                        VerifyEmailState>(
                                      builder: (context, state) {
                                        if (state is EmailVerificationLoading) {
                                          return const Row(
                                            children: [
                                              SizedBox(
                                                height: 20,
                                                width: 20,
                                                child:
                                                    CircularProgressIndicator(
                                                  color: primaryColor,
                                                ),
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                            ],
                                          );
                                        }
                                        if (state is EmailVerified) {
                                          return const Text('Email verified',
                                              style: TextStyle(
                                                  color: Colors.green,
                                                  fontSize: 12));
                                        }

                                        return profileState.profileModel.user!
                                                    .emailVerified ==
                                                false
                                            ? Row(
                                                children: [
                                                  const Text(
                                                      'Email not verified',
                                                      style: TextStyle(
                                                          color: Colors.red,
                                                          fontSize: 12)),
                                                  const Spacer(),
                                                  TextButton(
                                                      onPressed: () {
                                                        context
                                                            .read<
                                                                VerifyEmailCubit>()
                                                            .sendCodeToEmail();
                                                      },
                                                      child: const Text(
                                                          'Send code')),
                                                ],
                                              )
                                            : const Text('Email verified',
                                                style: TextStyle(
                                                    color: Colors.green,
                                                    fontSize: 12));
                                      },
                                    ),
                                  ),
                                ]),
                            children: const <Widget>[],
                          ),
                        ),
                      );
                    } else {
                      return const Center(child: CircularProgressIndicator());
                    }
                  },
                ),
              ),
              BlocBuilder<ProfileBloc, ProfileState>(builder: (context, state) {
                if (state is ProfileLoaded) {
                  // if (state.profileModel.bio == "" ||
                  //     state.profileModel.studyIn == null ||
                  //     state.profileModel.studyIn == "" ||
                  //     state.profileModel.placeOfWork == null ||
                  //     state.profileModel.placeOfWork == "") {
                  return GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, NewProfile_Page.routeName);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                          boxShadow: const [
                            BoxShadow(color: Colors.grey, blurRadius: 1)
                          ]),
                      child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (state.profileModel.isCompleted == false)
                                const Text(
                                  'Complete your profile',
                                  style: TextStyle(
                                      color: Colors.red,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                              if (state.profileModel.isCompleted == true)
                                const Text(
                                  'Your profile is completed',
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400),
                                ),
                              if (state.profileModel.isCompleted == false)
                                const Text(
                                  'Complete your profile to get the best experience',
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400),
                                ),
                            ],
                          )),
                    ),
                  );
                } else {
                  return const SizedBox();
                }
              }),

              BlocBuilder<ProfileBloc, ProfileState>(
                builder: (context, state) {
                  if (state is ProfileLoaded) {
                    return const YourWidget();
                  } else {
                    return const SizedBox();
                  }
                },
              ),
              Form(
                key: passwordKey,
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.white),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        offset: const Offset(0, 2),
                        blurRadius: 1,
                        spreadRadius: 0.2,
                      ),
                    ],
                  ),
                  child: Theme(
                    data: ThemeData(
                      dividerColor: Colors.transparent,
                    ),
                    child: const ExpansionTile(
                      trailing: Icon(Icons.edit_outlined),
                      title: Text('Password'),
                      subtitle: Text('********'),
                      children: <Widget>[],
                    ),
                  ),
                ),
              ),
              // SettingsList(
              //   physics: const NeverScrollableScrollPhysics(),
              //   shrinkWrap: true,
              //   sections: [
              //     SettingsSection(tiles: [
              //       SettingsTile(
              //         title: Container(
              //           padding: const EdgeInsets.symmetric(
              //               horizontal: 0, vertical: 0),
              //           decoration: BoxDecoration(
              //             color: const Color.fromARGB(255, 215, 82, 82),
              //             borderRadius: BorderRadius.circular(10),
              //             border: Border.all(
              //               color: const Color.fromARGB(255, 215, 82, 82),
              //             ),
              //             boxShadow: [
              //               BoxShadow(
              //                 color: Colors.black.withOpacity(0.2),
              //                 offset: const Offset(0, 2),
              //                 blurRadius: 1,
              //                 spreadRadius: 0.2,
              //               ),
              //             ],
              //           ),
              //           child: SettingsTile.navigation(
              //             value:(context.read<ProfileBloc>().state as ProfileLoaded).profileModel.user!.daysLeft == 0 ? SizedBox() :   Text(
              //               context.read<ProfileBloc>().state is ProfileLoaded
              //                   ? '${(} day left'
              //                   : '',
              //               style: TextStyle(
              //                 fontSize: 12,
              //                 color: Colors.white,
              //               ),
              //             ),
              //             title: const Text(
              //               'Verify your account !',
              //               style: TextStyle(
              //                 fontSize: 15,
              //                 color: Colors.white,
              //               ),
              //             ),
              //           ),
              //         ),
              //       ),
              //     ])
              //   ],
              // )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> selectDate() async {
    DateTime? selectedBirthDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2100));
    if (selectedBirthDate != null) {
      birthDate = selectedBirthDate.toString().split(" ")[0];
      setState(() {});
    }
  }
}

class YourWidget extends StatefulWidget {
  const YourWidget({super.key});

  @override
  _YourWidgetState createState() => _YourWidgetState();
}

class _YourWidgetState extends State<YourWidget> {
  String phoneNumber = "";
  String enteredOtp = "";
  bool isOtpSent = false;
  //get phone nummber object from String
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.white),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            offset: const Offset(0, 2),
            blurRadius: 1,
            spreadRadius: 0.2,
          ),
        ],
      ),
      child: Theme(
        data: ThemeData(
          dividerColor: Colors.transparent,
        ),
        child: ExpansionTile(
          trailing: const Icon(Icons.edit_outlined),
          title: const Text('Phone Number'),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              phoneNumber.isNotEmpty
                  ? Text(phoneNumber)
                  : const Text("Add your phone number",
                      style: TextStyle(color: Colors.red, fontSize: 12)),
              if (isOtpSent)
                TextButton(
                  onPressed: () {
                    // Verify OTP logic here
                    if (enteredOtp.isNotEmpty) {
                      // You should implement your OTP verification logic here
                      print("Verifying OTP: $enteredOtp");
                    }
                  },
                  child: const Text('Verify OTP'),
                )
              else
                TextButton(
                  onPressed: () {
                    // Send OTP logic here
                    if (phoneNumber.isNotEmpty) {
                      // You should implement your OTP sending logic here
                      print("Sending OTP to $phoneNumber");

                      // Simulating OTP sent, set isOtpSent to true
                      setState(() {
                        isOtpSent = true;
                      });
                    }
                  },
                  child: const Text('Send OTP'),
                ),
            ],
          ),
          children: <Widget>[
            Container(
              padding: const EdgeInsets.only(left: 15, right: 15, bottom: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // InternationalPhoneNumberInput(
                  //   initialValue: PhoneNumber(
                  //       phoneNumber: "+905312255514",
                  //       dialCode: "",
                  //       isoCode: ""),
                  //   onInputChanged: (PhoneNumber number) {
                  //     phoneNumber = number.phoneNumber!;
                  //   },
                  //   onInputValidated: (bool value) {
                  //     print(value);
                  //   },
                  //   selectorConfig: const SelectorConfig(
                  //     selectorType: PhoneInputSelectorType.DIALOG,
                  //   ),
                  // ),
                  if (isOtpSent)
                    const SizedBox(height: 20)
                  else
                    const SizedBox(height: 10),
                  if (isOtpSent)
                    const Text(
                      'Enter OTP:',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  if (isOtpSent)
                    TextField(
                      onChanged: (otp) {
                        enteredOtp = otp;
                      },
                      decoration: const InputDecoration(
                        hintText: 'Enter OTP',
                      ),
                    ),
                  const SizedBox(height: 20),
                  CustomButton(
                    width: double.infinity,
                    buttonText: isOtpSent ? 'Verify OTP' : 'Send OTP',
                    height: 45,
                    onpress: () async {
                      if (isOtpSent) {
                        // Verify OTP logic here
                        if (enteredOtp.isNotEmpty) {
                          // You should implement your OTP verification logic here
                          print("Verifying OTP: $enteredOtp");
                        }
                      } else {
                        // Send OTP logic here
                        if (phoneNumber.isNotEmpty) {
                          // You should implement your OTP sending logic here
                          print("Sending OTP to $phoneNumber");

                          // Simulating OTP sent, set isOtpSent to true
                          setState(() {
                            isOtpSent = true;
                          });
                        }
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class VerificationStepsModel {
  final String title;
  final String subtitle;
  bool isCompleted;

  VerificationStepsModel({
    required this.title,
    required this.subtitle,
    required this.isCompleted,
  });
}

class VerificationSteps extends StatefulWidget {
  const VerificationSteps({Key? key}) : super(key: key);

  @override
  State<VerificationSteps> createState() => _VerificationStepsState();
}

class _VerificationStepsState extends State<VerificationSteps> {
  List<VerificationStepsModel> steps(Profile profile) {
    return [
      VerificationStepsModel(
          title: 'Complete Profile',
          subtitle: 'Complete your profile to get the best experience',
          isCompleted: profile.user!.firstName != null &&
              profile.user!.lastName != null &&
              profile.user!.email != null &&
              profile.user!.phone != null &&
              profile.speciality != null &&
              profile.studyIn != null &&
              profile.placeOfWork != null &&
              profile.user!.firstName != "" &&
              profile.user!.lastName != "" &&
              profile.user!.email != "" &&
              profile.user!.phone != "" &&
              profile.speciality != "" &&
              profile.studyIn != "" &&
              profile.placeOfWork != ""),
      VerificationStepsModel(
        title: 'Verify Email',
        subtitle: 'Verify your email to get the best experience',
        isCompleted: profile.user!.emailVerified!,
      ),
      VerificationStepsModel(
          title: 'Verify Phone',
          subtitle: 'Verify your phone to get the best experience',
          isCompleted: profile.user!.phoneVerified ?? false),
    ];
  }

  bool isStepClickable(int? index, Profile profile) {
    int? prevIndex = index != 0 ? index! - 1 : 0;

    if (steps(profile)[prevIndex].isCompleted ||
        (prevIndex == 0 && index == 0)) {
      return true;
    }
    return false;
    // if (index != null) {
    //   int? prevIndex = index != 0 ? index - 1 : 0;
    //   return steps(profile)[prevIndex].isCompleted;
    // }
    // return false;
  }

  void _navigateToStep(int index, Profile profile) async {
    if (isStepClickable(index, profile)) {
      final String routeName;
      switch (index) {
        case 0:
          Navigator.of(context).pushNamed(NewProfile_Page.routeName);
          break;
        case 1:
          await showModalBottomSheet(
              scrollControlDisabledMaxHeightRatio: 0.8,
              context: context,
              builder: (_) {
                return BlocProvider.value(
                  value: context.read<VerifyEmailCubit>(),
                  child: VerifyEmailBottomSheet(
                    profile: profile,
                  ),
                );
              });
          context.read<VerifyEmailCubit>().resetEmailVerification();
        // routeName = My_Account_Settings.routeName;
        case 2:
          await showModalBottomSheet(
              scrollControlDisabledMaxHeightRatio: 0.8,
              context: context,
              builder: (_) {
                return BlocProvider(
                  create: (context) => FirebasePhoneVerificationCubit(),
                  child: VerifyPhoneBottomSheet(
                    profile: profile,
                  ),
                );
              });
          break;

        case 3:
          await showModalBottomSheet(
              scrollControlDisabledMaxHeightRatio: 0.8,
              context: context,
              builder: (_) {
                return BlocProvider(
                  create: (context) => FirebasePhoneVerificationCubit(),
                  child: VerifyPhoneBottomSheet(
                    profile: profile,
                  ),
                );
              });
          break;
        default:
          return;
      }
      // Navigator.pushNamed(context, routeName).then((_) {
      //   // Update step completion status after navigating back
      //   // setState(() {
      //   //   // steps[index].isCompleted = true;
      //   // });
      // });
    }
  }

  @override
  void didChangeDependencies() {
    // if (context.read<ProfileBloc>().state is ProfileInitial) {
    context.read<ProfileBloc>().add(const LoadMyProfile());
    // }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Verification Steps'),
      ),
      body: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          if (state is ProfileInitial) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is ProfileLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is ProfileError) {
            return const Center(
              child: Text('An error occured'),
            );
          } else if (state is ProfileLoaded) {
            return ListView.builder(
              itemCount: steps((state as ProfileLoaded).profileModel).length,
              itemBuilder: (context, index) {
                return Builder(builder: (context) {
                  return ListTile(
                    title: Text(steps(state.profileModel)[index].title),
                    subtitle: Text(steps(state.profileModel)[index].subtitle),
                    onTap: () async {
                      _navigateToStep(index, state.profileModel);
                    },
                    enabled: isStepClickable(index, (state).profileModel),
                    trailing: steps(state.profileModel)[index].isCompleted
                        ? const Icon(Icons.check_circle, color: Colors.green)
                        : null,
                    // ? const Icon(Icons.check_circle, color: Colors.green)
                    // : null,
                  );
                });
              },
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}

class VerifyPhoneBottomSheet extends StatefulWidget {
  Profile? profile;
  VerifyPhoneBottomSheet({super.key, required this.profile});

  @override
  State<VerifyPhoneBottomSheet> createState() => _VerifyPhoneBottomSheetState();
}

class _VerifyPhoneBottomSheetState extends State<VerifyPhoneBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FirebasePhoneVerificationCubit,
        FirebasePhoneVerificationState>(
      listener: (context, state) async {
        if (state is FirebasePhoneVerificationSuccess) {
          var response = await RequestHelper.post('verify/phone/', {});
          print(response.body);
          print(response.statusCode);
          // if (response.statusCode == 200) {
          //   // context.read()
          //   context
          //       .read<ProfileBloc>()
          //       .add(const LoadMyProfile(withputLoading: true));
          //   Navigator.of(context).pop();
          // }
        }
      },
      builder: (context, state) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.8,
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Verify your phone',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              // if(state is )
              Text(
                'In order to verify your phone, we will send a verification code to your phone number. ${'${widget!.profile!.user!.phone}'}',
                textAlign: TextAlign.center,
              ),
              // const SizedBox(height: 20),
              const SizedBox(height: 20),
              if (state is FirebasePhoneVerificationCodeResent)
                Pinput(
                  length: 6,
                  keyboardType: TextInputType.text,
                  onClipboardFound: (b) {},
                  onCompleted: (v) {
                    context
                        .read<FirebasePhoneVerificationCubit>()
                        .verifyCode(state.verificationId, v);
                  },
                ),

              const SizedBox(
                height: 20,
              ),
              state is FirebasePhoneVerificationLoading
                  ? const Center(
                      child: CircularProgressIndicator(
                        color: primaryColor,
                      ),
                    )
                  : Container(
                      width: double.infinity,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: primaryColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onPressed: () {
                            context
                                .read<FirebasePhoneVerificationCubit>()
                                .sendCodeToPhone(widget.profile!.user!.phone!);
                            // if (state is EmialCodeSent) {
                            //   return;
                            // } else {
                            //   context.read<VerifyEmailCubit>().sendCodeToEmail();
                            // }
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: state is FirebasePhoneVerificationLoading
                                ? const Center(
                                    child: CircularProgressIndicator(),
                                  )
                                : const Text(' Send code',
                                    style: TextStyle(
                                        fontSize: 16, color: Colors.white)),
                          )),
                    ),
              // BlocBuilder<VerifyEmailCubit, VerifyEmailState>(
              //   builder: (context, state) {
              //     if (state is EmailVerificationLoading) {
              //       return const CircularProgressIndicator();
              //     } else if (state is EmailVerified) {
              //       return const Text(
              //         'Email verified',
              //         style: TextStyle(color: Colors.green),
              //       );
              //     } else {
              //       return const SizedBox();
              //     }
              //   },
              // ),
              const SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }
}

class VerifyEmailBottomSheet extends StatefulWidget {
  final Profile profile;
  const VerifyEmailBottomSheet({super.key, required this.profile});

  @override
  State<VerifyEmailBottomSheet> createState() => _VerifyEmailBottomSheetState();
}

class _VerifyEmailBottomSheetState extends State<VerifyEmailBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<VerifyEmailCubit, VerifyEmailState>(
      listener: (context, state) async {
        if (state is EmailVerified) {
          context.read<ProfileBloc>().add(const LoadMyProfile());
          await Future.delayed(const Duration(seconds: 2));
          Navigator.of(context).pop();
          // if(context.read<Profi>())
          // context.read<ProfileBloc>().add(UpdateProfileLocally(
          //     profileLoaded: context.read<ProfileBloc>().state as ProfileLoaded,
          //     newProfile: widget.profile
          //         .copyWith(user: widget.profile.user!.copyWith())));
        } else if (state is EmailVerificationFailed) {
          Fluttertoast.showToast(
              msg: 'Email verification code is wrong',
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: const Color.fromARGB(255, 166, 221, 247),
              textColor: Colors.black,
              fontSize: 16.0);
        }
      },
      child: BlocBuilder<VerifyEmailCubit, VerifyEmailState>(
        builder: (context, state) {
          return Container(
            height: MediaQuery.of(context).size.height * 0.8,
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Verify your email',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                // if(state is EmialCodeSent)

                Text(
                  state is EmialCodeSent
                      ? "We have sent the code to your email, please check your email"
                      : 'In order to verify your email, we will send a verification code to your email address. ${'${widget.profile.user!.email}'}',
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                const SizedBox(height: 20),
                if (state is EmailVerificationLoading)
                  const Center(
                    child: CircularProgressIndicator(),
                  ),
                if (state is EmialCodeSent)
                  Pinput(
                    length: 6,
                    keyboardType: TextInputType.text,
                    onClipboardFound: (b) {},
                    onCompleted: (v) {
                      // if (verifyEmail == true) {
                      context.read<VerifyEmailCubit>().verifyEmail(v);
                      //   // Navigator.of(context).pop();
                      //   return;
                      // // }
                      // Navigator.of(context).pushNamed('/thirdStep', arguments: {
                      //   'code': v,
                      //   'email': email,
                      // });
                    },
                  ),
                //  Fluttertoast.showToast(
                //           msg: 'Code sent to email',
                //           toastLength: Toast.LENGTH_SHORT,
                //           gravity: ToastGravity.CENTER,
                //           timeInSecForIosWeb: 1,
                //           backgroundColor:
                //               const Color.fromARGB(255, 166, 221, 247),
                //           textColor: Colors.black,
                //           fontSize: 16.0);
                const SizedBox(
                  height: 20,
                ),
                Container(
                  width: double.infinity,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: () {
                        if (state is EmialCodeSent) {
                          return;
                        } else {
                          context.read<VerifyEmailCubit>().sendCodeToEmail();
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Text(
                            state is EmailVerificationFailed
                                ? 'Resend code again'
                                : ' Send code',
                            style: const TextStyle(
                                fontSize: 16, color: Colors.white)),
                      )),
                ),
                // BlocBuilder<VerifyEmailCubit, VerifyEmailState>(
                //   builder: (context, state) {
                //     if (state is EmailVerificationLoading) {
                //       return const CircularProgressIndicator();
                //     } else if (state is EmailVerified) {
                //       return const Text(
                //         'Email verified',
                //         style: TextStyle(color: Colors.green),
                //       );
                //     } else {
                //       return const SizedBox();
                //     }
                //   },
                // ),
                const SizedBox(height: 20),
              ],
            ),
          );
        },
      ),
    );
  }
}

class ResetPasswordSettings extends StatefulWidget {
  const ResetPasswordSettings({super.key});

  @override
  State<ResetPasswordSettings> createState() => _ResetPasswordSettingsState();
}

class _ResetPasswordSettingsState extends State<ResetPasswordSettings> {
  @override
  String? oldPassword;
  String? newPassword;
  bool passwordVisibilty = true;
  GlobalKey<FormState> passwordKey = GlobalKey<FormState>();

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reset Password'),
      ),
      body: Container(
        padding: const EdgeInsets.only(left: 15, right: 15, bottom: 15),
        child: Form(
          key: passwordKey,
          child: ListView(
            // crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(
                height: 20,
              ),
              Image.asset(
                'assets/images/reset-password.png',
                height: 200,
              ),
              const SizedBox(
                height: 20,
              ),

              // const Text("Old Password", style: TextStyle(fontSize: 16)),
              // const SizedBox(
              //   height: 10,
              // ),
              Container(
                // padding: const EdgeInsets.symmetric(horizontal: 10),
                margin:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.white),
                ),
                child: TextFormField(
                  onSaved: (b) {
                    oldPassword = b;
                  },
                  obscureText: passwordVisibilty,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          passwordVisibilty = !passwordVisibilty;
                        });
                      },
                      padding: const EdgeInsetsDirectional.only(end: 12.0),
                      icon: passwordVisibilty
                          ? const Icon(Icons.visibility_off)
                          : const Icon(Icons.visibility),
                    ),
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      // borderSide: BorderSide(
                      //   color: primaryColor,
                      // ),
                    ),
                    hintText: "Old Password",
                  ),
                ),
              ),
              const SizedBox(
                  // height: 15,
                  ),
              Container(
                // padding: const EdgeInsets.symmetric(horizontal: 10),
                margin:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.white),
                ),
                child: TextFormField(
                  validator: (v) {
                    if (v == null || v.isEmpty || v!.length < 8) {
                      return "Password must be at least 8 characters";
                    }
                  },
                  onSaved: (v) {
                    newPassword = v;
                  },
                  obscureText: passwordVisibilty,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          passwordVisibilty = !passwordVisibilty;
                        });
                      },
                      padding: const EdgeInsetsDirectional.only(end: 12.0),
                      icon: passwordVisibilty
                          ? const Icon(Icons.visibility_off)
                          : const Icon(Icons.visibility),
                    ),
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      // borderSide: BorderSide(
                      //   color: primaryColor,
                      // ),
                    ),
                    hintText: "New Password",
                  ),
                ),
              ),
              // CustomTextField(
              //   onSaved: (b) {
              //     oldPassword = b;
              //   },
              //   obscureText: passwordVisibilty,
              //   labelText: 'Password',
              //   iconButton: IconButton(
              //     padding: const EdgeInsetsDirectional.only(end: 12.0),
              //     icon: passwordVisibilty
              //         ? const Icon(Icons.visibility_off)
              //         : const Icon(Icons.visibility),
              //     onPressed: () {
              //       setState(() {
              //         passwordVisibilty = !passwordVisibilty;
              //       });
              //     },
              //   ),
              //   borderColor: const Color.fromARGB(255, 176, 176, 176),
              //   textfiledColor: Colors.white,
              //   hintText: "Enter your current password to change it",
              // ),
              // CustomTextField(
              //   onSaved: (v) {
              //     newPassword = v;
              //   },
              //   obscureText: passwordVisibilty,
              //   labelText: 'New Password',
              //   borderColor: const Color.fromARGB(255, 176, 176, 176),
              //   textfiledColor: Colors.white,
              //   hintText: "Enter your new password",
              // ),

              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomButton(
                    width: double.infinity,
                    buttonText: 'Save',
                    height: 45,
                    onpress: () async {
                      passwordKey.currentState!.save();
                      var response = await RequestHelper.post(
                          'change/password/', {
                        'old_password': oldPassword,
                        'new_password': newPassword
                      });
                      print(response.body);
                      if (response.statusCode == 200) {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text('Password changed'),
                        ));
                      } else {
                        var message = jsonDecode(response.body)['message'];
                        Fluttertoast.showToast(
                            msg: message,
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.TOP,
                            timeInSecForIosWeb: 1,
                            backgroundColor:
                                const Color.fromARGB(255, 166, 221, 247),
                            textColor: Colors.black,
                            fontSize: 16.0);

                        // Fluttertoast(

                        // );
                        // ScaffoldMessenger.of(context)
                        //     .showSnackBar(SnackBar(
                        //   content: Text(message),
                        // ));
                      }
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
