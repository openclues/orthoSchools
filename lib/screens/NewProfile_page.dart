import 'dart:convert';

import 'package:azsoon/Core/network/request_helper.dart';
import 'package:azsoon/features/profile/bloc/profile_bloc.dart';
import 'package:azsoon/features/profile/data/my_profile_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../common_widgets/Button.dart';
import '../common_widgets/TextField.dart';

class NewProfile_Page extends StatefulWidget {
  static const routeName = '/newProfilePage';
  const NewProfile_Page({super.key});

  @override
  State<NewProfile_Page> createState() => _NewProfile_PageState();
}

class _NewProfile_PageState extends State<NewProfile_Page> {
  String? bio;
  String? firstName;
  String? lastName;
  String? phoneNumber;
  String? birthDay;
  String? workplace;
  String? studyIn;

  String? speciality;

  // TextEditingController bioController = TextEditingController();
  // TextEditingController firstNameController = TextEditingController();
  // TextEditingController lastNameController = TextEditingController();
  //  TextEditingController phoneController = TextEditingController();
  // TextEditingController workplaceController = TextEditingController();
  // TextEditingController studyInController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  // TextEditingController dateOfBirsthController = TextEditingController();
  TextEditingController fileNameController = TextEditingController();

  String? selectedCountry;
  String? selectedState;
  String? selectedCity;
  // List<Certificate>? _certificates = [];
  String? titleSelectd;

  bool? loading = false;

  final GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double coverHeight = screenHeight / 3.7;
    double profilePictureHeight = 70;
    double top = coverHeight - profilePictureHeight / 2;
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        if (state is ProfileInitial) {
          context.read<ProfileBloc>().add(const LoadMyProfile());

          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (state is ProfileLoading) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(
                color: Color(0XFF8174CC),
              ),
            ),
          );
        } else if (state is ProfileLoaded) {
          return Scaffold(
            appBar: AppBar(),
            bottomNavigationBar: Padding(
                padding: const EdgeInsets.only(right: 10.0, left: 10),
                child: loading == false
                    ? CustomButton(
                        width: double.infinity,
                        buttonText: 'Save',
                        buttonColor: const Color(0XFF8174CC),
                        borderColor: const Color(0XFF8174CC),
                        textColor: Colors.white,
                        height: 45,
                        onpress: () async {
                          globalKey.currentState?.save();

                          setState(() {
                            loading = true;
                          });
                          var response = await RequestHelper.post(
                            'update/profile/',
                            {
                              'bio': bio,
                              'first_name': firstName,
                              'last_name': lastName,
                              'phone': phoneNumber,
                              'birth_day': birthDay,
                              'place_of_work': workplace,
                              'study_in': studyIn,
                              'country': selectedCountry,
                              'state': selectedState,
                              'city': selectedCity,
                              'speciality': speciality,
                              'title': titleSelectd,
                            },
                          );
                          setState(() {
                            loading = false;
                          });
                          // print(response);
                          if (response.statusCode == 200) {
                            if (context.mounted) {
                              context.read<ProfileBloc>().add(
                                  UpdateProfileLocally(
                                      profileLoaded: context
                                          .read<ProfileBloc>()
                                          .state as ProfileLoaded,
                                      newProfile: Profile.fromJson(jsonDecode(
                                          utf8.decode(response.bodyBytes)))));
                            }

                            Fluttertoast.showToast(
                                msg: "Profile Updated Successfully",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                                backgroundColor:
                                    const Color.fromARGB(255, 204, 204, 205),
                                textColor: Colors.white,
                                fontSize: 16.0);
                          }
                        },
                      )
                    : const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                              height: 30,
                              width: 30,
                              child: CircularProgressIndicator()),
                        ],
                      )),
            body: Form(
              key: globalKey,
              child: ListView(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  children: [
                    // Stack(
                    //   clipBehavior: Clip.none,
                    //   alignment: Alignment.center,
                    //   children: [
                    //     Container(
                    //       child: Container(
                    //         // decoration: BoxDecoration(
                    //         //   borderRadius: BorderRadius.only(
                    //         //     bottomLeft: Radius.circular(15.0),
                    //         //     bottomRight: Radius.circular(15.0),
                    //         //   ),
                    //         // ),
                    //         child: Image.asset(
                    //           'assets/images/postImage.png',
                    //           width: double.infinity,
                    //           height: coverHeight,
                    //           fit: BoxFit.cover,
                    //         ),
                    //       ),
                    //     ),
                    //     Positioned(
                    //       top: top,
                    //       child: CircleAvatar(
                    //         radius: profilePictureHeight, // adjust the radius as needed
                    //         backgroundColor: const Color.fromARGB(
                    //             255, 223, 223, 223), // border color
                    //         child: CircleAvatar(
                    //           radius: profilePictureHeight -
                    //               4, // adjust the inner radius to leave room for the border
                    //           backgroundImage: AssetImage('assets/images/profile.jpeg'),
                    //         ),
                    //       ),
                    //     ),
                    //     Positioned(
                    //       top: top + top / 4,
                    //       right: 0,
                    //       child: IconButton(
                    //         icon: Icon(Icons.edit),
                    //         onPressed: () async {
                    //           // await editDialog();
                    //         },
                    //       ),
                    //     ),
                    //   ],
                    // ),
                    const Text("Edit Profile",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 10, left: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // TextButton.icon(
                          //     onPressed: () {},
                          //     icon: const Icon(
                          //       Icons.co_present_outlined,
                          //       color: Colors.black,
                          //     ),
                          //     label: const Text(
                          //       '   Your are a...',
                          //       style: TextStyle(
                          //           fontSize: 17,
                          //           fontWeight: FontWeight.bold,
                          //           color: Colors.black),
                          //     )),
                          // Container(
                          //   padding: const EdgeInsets.only(
                          //       right: 10, left: 10, bottom: 10, top: 10),
                          //   decoration: BoxDecoration(
                          //     color: Colors.white,
                          //     borderRadius: BorderRadius.circular(10),
                          //     border: Border.all(color: Colors.white),
                          //     boxShadow: [
                          //       BoxShadow(
                          //         color: Colors.black.withOpacity(0.2),
                          //         offset: const Offset(0, 2),
                          //         blurRadius: 1,
                          //         spreadRadius: 0.2,
                          //       ),
                          //     ],
                          //   ),
                          //   child: Column(
                          //     crossAxisAlignment: CrossAxisAlignment.start,
                          //     children: [
                          //       Row(
                          //         mainAxisAlignment:
                          //             MainAxisAlignment.spaceEvenly,
                          //         children: ['Dr', 'Prof', 'None']
                          //             .map((e) => Expanded(
                          //                   child: Padding(
                          //                     padding:
                          //                         const EdgeInsets.all(8.0),
                          //                     child: GestureDetector(
                          //                       onTap: () {
                          //                         setState(() {
                          //                           titleSelectd = e;
                          //                         });
                          //                       },
                          //                       child: Container(
                          //                         decoration: BoxDecoration(
                          //                             borderRadius:
                          //                                 BorderRadius.circular(
                          //                                     20),
                          //                             color: e == titleSelectd
                          //                                 ? const Color(
                          //                                     0XFF8174CC)
                          //                                 : Colors.transparent,
                          //                             border: Border.all(
                          //                               color: const Color
                          //                                   .fromARGB(
                          //                                   255, 204, 204, 205),
                          //                             )),
                          //                         child: Padding(
                          //                           padding:
                          //                               const EdgeInsets.all(
                          //                                   7.0),
                          //                           child: Text(
                          //                             e,
                          //                             textAlign:
                          //                                 TextAlign.center,
                          //                             style: TextStyle(
                          //                                 color: e ==
                          //                                         titleSelectd
                          //                                     ? Colors.white
                          //                                     : Colors.black,
                          //                                 fontSize: 17),
                          //                           ),
                          //                         ),
                          //                       ),
                          //                     ),
                          //                   ),
                          //                 ))
                          //             .toList(),
                          //       ),
                          //     ],
                          //   ),
                          // ),

                          TextButton.icon(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.person,
                                color: Colors.black,
                              ),
                              label: const Text(
                                'Basic Information',
                                style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              )),
                          Container(
                            padding: const EdgeInsets.only(
                                right: 10, left: 10, bottom: 15),
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
                            child: Column(children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: CustomTextField(
                                      initialValue:
                                          state.profileModel.user!.firstName,
                                      onSaved: (value) {
                                        firstName = value;
                                      },
                                      obscureText: false,
                                      labelText: 'First Name',
                                      borderColor: const Color.fromARGB(
                                          255, 204, 204, 205),
                                      textfiledColor: Colors.white,
                                      // controller: firstNameController,
                                      hintText: "",
                                    ),
                                  ),
                                  const SizedBox(
                                      width:
                                          16), // Adjust the spacing between fields
                                  Expanded(
                                    child: CustomTextField(
                                      initialValue:
                                          state.profileModel.user!.lastName,
                                      onSaved: (value) {
                                        lastName = value;
                                      },
                                      obscureText: false,
                                      labelText: 'Last Name',
                                      borderColor: const Color.fromARGB(
                                          255, 204, 204, 205),
                                      textfiledColor: Colors.white,
                                      // controller: lastNameController,
                                      hintText: "",
                                    ),
                                  ),
                                ],
                              ),
                              CustomTextField(
                                initialValue: state.profileModel.user!.phone,
                                onSaved: (value) {
                                  phoneNumber = value;
                                },
                                obscureText: false,
                                labelText: 'Phone number',
                                borderColor:
                                    const Color.fromARGB(255, 204, 204, 205),
                                textfiledColor: Colors.white,
                                // controller: phoneController,
                                hintText: "+90",
                              ),
                            ]),
                          ),
                          // TextButton.icon(
                          //     onPressed: () {},
                          //     icon: const Icon(
                          //       Icons.location_city,
                          //       color: Colors.black,
                          //     ),
                          //     label: const Text(
                          //       'Lives In',
                          //       style: TextStyle(
                          //           fontSize: 17,
                          //           fontWeight: FontWeight.bold,
                          //           color: Colors.black),
                          //     )),
                          // Container(
                          //   padding: const EdgeInsets.only(
                          //       right: 10, left: 10, bottom: 15),
                          //   decoration: BoxDecoration(
                          //     color: Colors.white,
                          //     borderRadius: BorderRadius.circular(10),
                          //     border: Border.all(color: Colors.white),
                          //     boxShadow: [
                          //       BoxShadow(
                          //         color: Colors.black.withOpacity(0.2),
                          //         offset: const Offset(0, 2),
                          //         blurRadius: 1,
                          //         spreadRadius: 0.2,
                          //       ),
                          //     ],
                          //   ),
                          //   child: Padding(
                          //     padding: const EdgeInsets.fromLTRB(0, 20, 0, 10),
                          //     child: CSCPicker(
                          //       dropdownDecoration: BoxDecoration(
                          //         border: Border.all(
                          //           color: const Color.fromARGB(
                          //               255, 204, 204, 205),
                          //         ),
                          //         borderRadius: BorderRadius.circular(10),
                          //       ),
                          //       disabledDropdownDecoration: BoxDecoration(
                          //         color:
                          //             const Color.fromARGB(255, 239, 238, 238),
                          //         border: Border.all(
                          //           color: const Color.fromARGB(
                          //               255, 204, 204, 205),
                          //         ),
                          //         borderRadius: BorderRadius.circular(100),
                          //       ),
                          //       layout: Layout.vertical,
                          //       // flagState: CountryFlag.DISABLE1,
                          //       currentCity: state.profileModel!.city,
                          //       currentCountry: state.profileModel!.country,
                          //       currentState: state.profileModel!.state,
                          //       onCountryChanged: (country) {
                          //         setState(() {
                          //           selectedCountry = country;
                          //         });
                          //       },
                          //       onStateChanged: (state) {
                          //         setState(() {
                          //           selectedState = state;
                          //         });
                          //       },
                          //       onCityChanged: (city) {
                          //         setState(() {
                          //           selectedCity = city;
                          //         });
                          //       },

                          //       countryDropdownLabel: "Country",
                          //       stateDropdownLabel: "State",
                          //       cityDropdownLabel: "City",
                          //       //dropdownDialogRadius: 30,
                          //       //searchBarRadius: 30,
                          //     ),
                          //   ),
                          // ),
                          Container(
                            child: Column(children: [
                              CustomTextField(
                                initialValue: state.profileModel.bio,
                                maxLines: 3,
                                onSaved: (value) {
                                  bio = value;
                                },
                                obscureText: false,
                                labelText: 'Bio',
                                borderColor:
                                    const Color.fromARGB(255, 204, 204, 205),
                                textfiledColor: Colors.white,
                                // controller: bioController,
                                hintText: 'Bio',
                              ),
                            ]),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          TextButton.icon(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.work,
                                color: Colors.black,
                              ),
                              label: const Text(
                                'Professional Life',
                                style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              )),

                          Container(
                            padding: const EdgeInsets.only(
                                right: 10, left: 10, bottom: 15, top: 10),
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
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text("Workplace",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 15,
                                        )),
                                    CustomTextField(
                                      initialValue:
                                          state.profileModel.placeOfWork,
                                      onSaved: (value) {
                                        workplace = value;
                                      },
                                      obscureText: false,
                                      labelText: 'Works At',
                                      borderColor: const Color.fromARGB(
                                          255, 204, 204, 205),
                                      textfiledColor: Colors.white,
                                      // controller: workplaceController,
                                      hintText: 'loyalty, merter',
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    const Text("Study",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 15,
                                        )),
                                    CustomTextField(
                                      initialValue: state.profileModel.studyIn,
                                      onSaved: (value) {
                                        studyIn = value;
                                      },
                                      obscureText: false,
                                      labelText: 'Study In',
                                      borderColor: const Color.fromARGB(
                                          255, 204, 204, 205),
                                      // controller: studyInController,
                                      hintText: 'Uskudar university',
                                      textfiledColor: Colors.white,
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    const Text("Speciality",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 15,
                                        )),
                                    CustomTextField(
                                      initialValue:
                                          state.profileModel.speciality,
                                      onSaved: (value) {
                                        speciality = value;
                                      },
                                      obscureText: false,
                                      labelText: 'Speciality',
                                      borderColor: const Color.fromARGB(
                                          255, 204, 204, 205),
                                      // controller: studyInController,
                                      hintText: 'Dentist',
                                      textfiledColor: Colors.white,
                                    ),
                                  ]),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ]),
            ),
          );
        } else {
          return const Center(
            child: Text('Error'),
          );
        }
      },
    );
  }
}
