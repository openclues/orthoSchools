import 'dart:convert';

import 'package:azsoon/Core/local_storage.dart';
import 'package:azsoon/Core/network/request_helper.dart';
import 'package:azsoon/features/profile/bloc/profile_bloc.dart';
import 'package:azsoon/features/profile/data/my_profile_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

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
            appBar: AppBar(
              title: const Text('Edit Profile',
                  style: TextStyle(fontSize: 20, color: Colors.white)),
              centerTitle: true,
              backgroundColor: const Color(0XFF8174CC),
            ),
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
                          if (!globalKey.currentState!.validate()) {
                            return;
                          }
                          globalKey.currentState!.save();
                          print('firstName: $firstName');
                          print('lastName: $lastName');
                          print('phoneNumber: $phoneNumber');
                          print('birthDay: $birthDay');
                          print('workplace: $workplace');
                          print('studyIn: $studyIn');
                          print('selectedCountry: $selectedCountry');
                          print('selectedState: $selectedState');
                          print('selectedCity: $selectedCity');
                          print('speciality: $speciality');
                          print('titleSelectd: $titleSelectd');
                          print('bio: $bio');
                          print('bio: $bio');

                          setState(() {
                            loading = true;
                          });
                          var response = await RequestHelper.post(
                            'update/profile/',
                            {
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
                          // // print(response);
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
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                key: globalKey,
                child: ListView(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 10, left: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text("First Name",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 15,
                                )),
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: Colors.white),
                              ),
                              child: TextFormField(
                                validator: (v) {
                                  if (v!.isEmpty) {
                                    return 'First Name is required';
                                  }
                                },
                                decoration: InputDecoration(
                                  hintText: 'First Name',
                                  hintStyle: const TextStyle(
                                    color: Color.fromARGB(255, 194, 193, 199),
                                    fontSize: 14.0,
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: const BorderSide(
                                      color: Colors.transparent,
                                    ),
                                  ),
                                  contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 15,
                                      vertical:
                                          10), //symmetric(vertical: 17, horizontal: 10),
                                  filled: true,
                                  fillColor: Colors.white,
                                ),
                                initialValue:
                                    state.profileModel.user!.firstName,
                                onSaved: (value) {
                                  firstName = value;
                                },
                                obscureText: false,
                              ),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            const Text("Last Name",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 15,
                                )),
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: Colors.white),
                              ),
                              child: TextFormField(
                                validator: (v) {
                                  if (v!.isEmpty) {
                                    return 'Last Name is required';
                                  }
                                },
                                decoration: InputDecoration(
                                  hintText: 'Last Name',
                                  hintStyle: const TextStyle(
                                    color: Color.fromARGB(255, 194, 193, 199),
                                    fontSize: 14.0,
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: const BorderSide(
                                      color: Colors.transparent,
                                    ),
                                  ),
                                  contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 15,
                                      vertical:
                                          10), //symmetric(vertical: 17, horizontal: 10),
                                  filled: true,
                                  fillColor: Colors.white,
                                ),
                                initialValue: state.profileModel.user!.lastName,
                                onSaved: (value) {
                                  lastName = value;
                                },
                                obscureText: false,
                              ),
                            ),
                            // CustomTextField(

                            //   readOnly:
                            //       state.profileModel.user!.isVerifiedPro == true,
                            //   initialValue: state.profileModel.user!.firstName,
                            //   onSaved: (value) {
                            //     firstName = value;
                            //   },
                            //   obscureText: false,
                            //   labelText: 'First Name',
                            //   borderColor:
                            //       const Color.fromARGB(255, 204, 204, 205),
                            //   textfiledColor: Colors.white,
                            //   // controller: firstNameController,
                            //   hintText: "",
                            // ),
                            // const SizedBox(
                            //     width: 20), // Adjust the spacing between fields
                            // CustomTextField(
                            const SizedBox(
                              height: 20,
                            ),
                            // const Text(
                            //   "Phone Number",
                            //   textAlign: TextAlign.center,
                            //   style: TextStyle(
                            //     fontSize: 15,
                            //   ),
                            // ),
                            PhoneNumberPicker(
                              onInputChanged: (PhoneNumber number) {
                                phoneNumber = number.phoneNumber;
                              },
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

                            const SizedBox(
                              height: 15,
                            ),

                            const Text("Workplace",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 15,
                                )),
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: Colors.white),
                              ),
                              child: TextFormField(
                                initialValue: state.profileModel.placeOfWork,
                                validator: (v) {
                                  if (v!.isEmpty) {
                                    return 'Workplace is required';
                                  }
                                },
                                onSaved: (value) {
                                  workplace = value;
                                },
                                obscureText: false,
                                decoration: InputDecoration(
                                  hintText: 'Works At',
                                  hintStyle: const TextStyle(
                                    color: Color.fromARGB(255, 194, 193, 199),
                                    fontSize: 14.0,
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: const BorderSide(
                                      color: Colors.transparent,
                                    ),
                                  ),
                                  contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 15,
                                      vertical:
                                          10), //symmetric(vertical: 17, horizontal: 10),
                                  filled: true,
                                  fillColor: Colors.white,
                                ),
                              ),
                            ),

                            const SizedBox(
                              height: 15,
                            ),
                            const Text("Studied At",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 15,
                                )),
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: Colors.white),
                              ),
                              child: TextFormField(
                                initialValue: state.profileModel.studyIn,
                                validator: (v) {
                                  if (v!.isEmpty) {
                                    return 'Studied At is required';
                                  }
                                },
                                onSaved: (value) {
                                  studyIn = value;
                                },
                                obscureText: false,
                                decoration: InputDecoration(
                                  hintText: 'Studied At',
                                  hintStyle: const TextStyle(
                                    color: Color.fromARGB(255, 194, 193, 199),
                                    fontSize: 14.0,
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: const BorderSide(
                                      color: Colors.transparent,
                                    ),
                                  ),
                                  contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 15,
                                      vertical:
                                          10), //symmetric(vertical: 17, horizontal: 10),
                                  filled: true,
                                  fillColor: Colors.white,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            const Text("Speciality",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 15,
                                )),
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: Colors.white),
                              ),
                              child: TextFormField(
                                initialValue: state.profileModel.speciality,
                                validator: (v) {
                                  if (v!.isEmpty) {
                                    return 'Speciality is required';
                                  }
                                },
                                onSaved: (value) {
                                  speciality = value;
                                },
                                obscureText: false,
                                decoration: InputDecoration(
                                  hintText: 'Aesthetic dentistry',
                                  hintStyle: const TextStyle(
                                    color: Color.fromARGB(255, 194, 193, 199),
                                    fontSize: 14.0,
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: const BorderSide(
                                      color: Colors.transparent,
                                    ),
                                  ),
                                  contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 15,
                                      vertical:
                                          10), //symmetric(vertical: 17, horizontal: 10),
                                  filled: true,
                                  fillColor: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ]),
              ),
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

class PhoneNumberPicker extends StatefulWidget {
  String? phoneNumber;
  PhoneNumberPicker(
      {super.key, required this.onInputChanged, this.phoneNumber});
  final Function(PhoneNumber)? onInputChanged;

  @override
  _PhoneNumberPickerState createState() => _PhoneNumberPickerState();
}

class _PhoneNumberPickerState extends State<PhoneNumberPicker> {
  PhoneNumber? phoneNumber;
  @override
  void initState() {
    if (widget.phoneNumber != null) {
      var ph = LocalStorage.extractCountryCode(widget.phoneNumber!);

      phoneNumber = PhoneNumber(
        phoneNumber:
            widget.phoneNumber!.replaceAll(ph.keys.first.toString(), ""),
        isoCode: ph.values.first.toString().toUpperCase(),
      );
    }
    // var ph = LocalStorage.extractCountryCode("+905312255514");

    // phoneNumber = PhoneNumber(
    //   phoneNumber: "+905312255514".replaceAll(ph.keys.first.toString(), ""),
    //   isoCode: ph.values.first.toString().toUpperCase(),
    // );
    // Map<String, String> phone =
    //     LocalStorage.extractCountryCode("+905312255514");
    // phoneNumber = PhoneNumber(
    //   phoneNumber:
    //       "+905312255514".replaceAll(phone['countryCode'].toString(), ""),
    //   isoCode: phone['countryName'].toString(),
    // );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(right: 10, left: 10, bottom: 15),
      // height: 60,
      child: InternationalPhoneNumberInput(
        initialValue: phoneNumber,
        validator: (v) {
          if (v!.isEmpty) {
            return 'Phone Number is required';
          }
        },
        onInputChanged: widget.onInputChanged,
        onInputValidated: (bool value) {
          print(value); // Print whether the phone number is valid or not
        },
        selectorConfig: const SelectorConfig(
          selectorType: PhoneInputSelectorType.DIALOG,
        ),
        ignoreBlank: false,
        // autoValidateMode: AutovalidateMode.onUserInteraction,
        selectorTextStyle: const TextStyle(color: Colors.black),
        textFieldController: TextEditingController(),
        formatInput: true,
        keyboardType:
            const TextInputType.numberWithOptions(signed: true, decimal: true),
        // inputBorder: const OutlineInputBorder(
        //   borderRadius: BorderRadius.all(Radius.circular(10)),
        //   borderSide: BorderSide(
        //     color: Colors.transparent,
        //   ),
        // ),
      ),
    );
  }
}
