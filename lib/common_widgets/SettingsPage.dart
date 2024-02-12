import 'package:azsoon/features/profile/data/my_profile_model.dart';
import 'package:azsoon/features/space/presentation/comments_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:iconly/iconly.dart';
// import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:settings_ui/settings_ui.dart';

import 'package:azsoon/Core/colors.dart';
import 'package:azsoon/common_widgets/Button.dart';
import 'package:azsoon/common_widgets/TextField.dart';

import '../Core/local_storage.dart';
import '../Core/network/request_helper.dart';
import '../features/become_premium/presentation/be_premium_screen.dart';
import '../features/profile/bloc/profile_bloc.dart';
import '../features/space/bloc/cubit/verify_email_cubit.dart';
import '../features/verification/persentation/screens/verification_pro_request_screen.dart';

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
            Container(
              margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  ListTile(
                    subtitle: Text(
                      context.read<ProfileBloc>().state is ProfileLoaded &&
                              (context.read<ProfileBloc>().state
                                          as ProfileLoaded)
                                      .profileModel
                                      .user!
                                      .isVerified ==
                                  false
                          ? 'You have to verify your account to avoid account suspension'
                          : '',
                      style: const TextStyle(color: Colors.red),
                    ),
                    leading: const Icon(Icons.check_circle_outline,
                        color: Colors.grey),
                    title: const Text('Verification',
                        style: TextStyle(color: Color(0xff666666))),
                    trailing: const Icon(Icons.arrow_forward_ios),
                    onTap: () {
                      Navigator.of(context)
                          .pushNamed(My_Account_Settings.routeName);
                    },
                  ),
                  ListTile(
                    leading:
                        Image.asset('assets/images/quality.png', height: 25),
                    // color: Colors.grey),
                    title: const Text('Become a verified pro',
                        style: TextStyle(color: Color(0xff666666))),
                    trailing: const Icon(Icons.arrow_forward_ios),
                    onTap: () {
                      Navigator.of(context)
                          .pushNamed(VerificationProRequestScreen.routeName);
                    },
                  ),
                  ListTile(
                    leading: Image.asset('assets/images/verified-account.png',
                        height: 25),
                    title: const Text('Become a premium member',
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
                      Navigator.of(context)
                          .pushNamed(My_Account_Settings.routeName);
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
                ],
              ),
            )
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
                    Navigator.of(context)
                        .pushNamed(My_Account_Settings.routeName);
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
      appBar: AppBar(),
      body: Form(
        key: globalKey,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
          child: ListView(
            children: [
              BlocListener<VerifyEmailCubit, VerifyEmailState>(
                listener: (context, state) {
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
                                // if (profileState
                                //         .profileModel.user!.emailVerified ==
                                //     false )
                                //   const Expanded(
                                //     child: Padding(
                                //       padding: EdgeInsets.only(left: 8.0),
                                //       child: Text(
                                //           "You have to confirm your email address",
                                //           style: TextStyle(
                                //               color: Colors.red, fontSize: 12)),
                                //     ),
                                //   ),
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
                                              Text('Sending code to email',
                                                  style: TextStyle(
                                                      color: Colors.green,
                                                      fontSize: 12)),
                                            ],
                                          );
                                        }
                                        if (state is EmailVerified) {
                                          return const Text('Email verified',
                                              style: TextStyle(
                                                  color: Colors.green,
                                                  fontSize: 12));
                                        }
                                        if (state is EmialCodeSent) {
                                          GlobalKey<FormState> globalKey =
                                              GlobalKey<FormState>();
                                          String? code;
                                          return Form(
                                            key: globalKey,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Expanded(
                                                  child: Container(
                                                    // height: 20,
                                                    decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5),
                                                      border: Border.all(
                                                          color: Colors.grey),
                                                    ),
                                                    child: TextFormField(
                                                      validator: (value) => value!
                                                              .isEmpty
                                                          ? 'Please enter code'
                                                          : null,
                                                      decoration:
                                                          InputDecoration(
                                                        contentPadding:
                                                            const EdgeInsets
                                                                .all(10),
                                                        hintText: 'Enter code',
                                                        border:
                                                            OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(5),
                                                        ),
                                                      ),
                                                      onSaved: (value) {
                                                        code = value!;
                                                      },
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  width: 10,
                                                ),
                                                TextButton(
                                                    onPressed: () {
                                                      if (globalKey
                                                          .currentState!
                                                          .validate()) {
                                                        globalKey.currentState!
                                                            .save();
                                                        context
                                                            .read<
                                                                VerifyEmailCubit>()
                                                            .verifyEmail(code!);
                                                      }
                                                    },
                                                    child:
                                                        const Text('Verify')),
                                              ],
                                            ),
                                          );
                                        }

                                        return profileState.profileModel.user!
                                                    .isVerified ==
                                                false
                                            ? CustomButton(
                                                buttonText:
                                                    'Send code to email',
                                                height: 40,
                                                onpress: () {
                                                  context
                                                      .read<VerifyEmailCubit>()
                                                      .sendCodeToEmail();
                                                },
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
                    child: ExpansionTile(
                      trailing: const Icon(Icons.edit_outlined),
                      title: const Text('Password'),
                      subtitle: const Text('********'),
                      children: <Widget>[
                        Container(
                          padding: const EdgeInsets.only(
                              left: 15, right: 15, bottom: 15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              CustomTextField(
                                onSaved: (b) {
                                  oldPassword = b;
                                },
                                obscureText: passwordVisibilty,
                                labelText: 'Password',
                                iconButton: IconButton(
                                  padding: const EdgeInsetsDirectional.only(
                                      end: 12.0),
                                  icon: passwordVisibilty
                                      ? const Icon(Icons.visibility_off)
                                      : const Icon(Icons.visibility),
                                  onPressed: () {
                                    setState(() {
                                      passwordVisibilty = !passwordVisibilty;
                                    });
                                  },
                                ),
                                borderColor:
                                    const Color.fromARGB(255, 176, 176, 176),
                                textfiledColor: Colors.white,
                                hintText:
                                    "Enter your current password to change it",
                              ),
                              CustomTextField(
                                onSaved: (v) {
                                  newPassword = v;
                                },
                                obscureText: passwordVisibilty,
                                labelText: 'New Password',
                                borderColor:
                                    const Color.fromARGB(255, 176, 176, 176),
                                textfiledColor: Colors.white,
                                hintText: "Enter your new password",
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              CustomButton(
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

                                    if (response.statusCode == 200) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                        content: Text('Password changed'),
                                      ));
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                        content: Text('Password not changed'),
                                      ));
                                    }
                                  }),
                            ],
                          ),
                        ),
                      ],
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
