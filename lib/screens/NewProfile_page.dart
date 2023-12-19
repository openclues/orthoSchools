import 'package:csc_picker/csc_picker.dart';
import 'package:flutter/material.dart';

import '../widgets/Button.dart';
import '../widgets/TextField.dart';

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

  final GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double coverHeight = screenHeight / 3.7;
    double profilePictureHeight = 70;
    double top = coverHeight - profilePictureHeight / 2;
    return Scaffold(
      appBar: AppBar(),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(right: 10.0, left: 10),
        child: CustomButton(
          width: double.infinity,
          buttonText: 'Save',
          buttonColor: Color(0XFF8174CC),
          borderColor: Color(0XFF8174CC),
          textColor: Colors.white,
          height: 45,
          onpress: () {
            globalKey.currentState?.save();
            print(firstName);
            print(lastName);
            print(phoneNumber);
            print(bio);
            print(workplace);
            print(birthDay);
            print(studyIn);
            print(selectedCountry);
            print(selectedCity);
            print(selectedState);
          },
        ),
      ),
      body: Form(
        key: globalKey,
        child: ListView(padding: EdgeInsets.symmetric(vertical: 20), children: [
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
          Padding(
            padding: EdgeInsets.only(right: 10, left: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextButton.icon(
                    onPressed: () {},
                    icon: Icon(
                      Icons.co_present_outlined,
                      color: Colors.black,
                    ),
                    label: Text(
                      '   Your are a...',
                      style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    )),
                Container(
                  padding:
                      EdgeInsets.only(right: 10, left: 10, bottom: 10, top: 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.white),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        offset: Offset(0, 2),
                        blurRadius: 1,
                        spreadRadius: 0.2,
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: ['Dr', 'Prof', 'None']
                            .map((e) => Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: GestureDetector(
                                      onTap: () {
                                        // setState(() {
                                        //   titleSelectd = e;
                                        // });
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            color: e == titleSelectd
                                                ? Color(0XFF8174CC)
                                                : Colors.transparent,
                                            border: Border.all(
                                              color: Color.fromARGB(
                                                  255, 204, 204, 205),
                                            )),
                                        child: Padding(
                                          padding: const EdgeInsets.all(7.0),
                                          child: Text(
                                            e,
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: e == titleSelectd
                                                    ? Colors.white
                                                    : Colors.black,
                                                fontSize: 17),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ))
                            .toList(),
                      ),
                    ],
                  ),
                ),
                Container(
                  child: Column(children: [
                    CustomTextField(
                      initialValue: '',
                      maxLines: 3,
                      onSaved: (value) {
                        bio = value;
                      },
                      obscureText: false,
                      labelText: 'Bio',
                      borderColor: Color.fromARGB(255, 204, 204, 205),
                      textfiledColor: Colors.white,
                      // controller: bioController,
                      hintText: '',
                    ),
                  ]),
                ),
                SizedBox(
                  height: 15,
                ),
                TextButton.icon(
                    onPressed: () {},
                    icon: Icon(
                      Icons.person,
                      color: Colors.black,
                    ),
                    label: Text(
                      'Basic Information',
                      style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    )),
                Container(
                  padding: EdgeInsets.only(right: 10, left: 10, bottom: 15),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.white),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        offset: Offset(0, 2),
                        blurRadius: 1,
                        spreadRadius: 0.2,
                      ),
                    ],
                  ),
                  child: Column(children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: CustomTextField(
                            initialValue: '',
                            onSaved: (value) {
                              firstName = value;
                            },
                            obscureText: false,
                            labelText: 'First Name',
                            borderColor:
                                const Color.fromARGB(255, 204, 204, 205),
                            textfiledColor: Colors.white,
                            // controller: firstNameController,
                            hintText: "",
                          ),
                        ),
                        const SizedBox(
                            width: 16), // Adjust the spacing between fields
                        Expanded(
                          child: CustomTextField(
                            initialValue: '',
                            onSaved: (value) {
                              lastName = value;
                            },
                            obscureText: false,
                            labelText: 'Last Name',
                            borderColor:
                                const Color.fromARGB(255, 204, 204, 205),
                            textfiledColor: Colors.white,
                            // controller: lastNameController,
                            hintText: "",
                          ),
                        ),
                      ],
                    ),
                    CustomTextField(
                      initialValue: '',
                      onSaved: (value) {
                        phoneNumber = value;
                      },
                      obscureText: false,
                      labelText: 'Phone number',
                      borderColor: const Color.fromARGB(255, 204, 204, 205),
                      textfiledColor: Colors.white,
                      // controller: phoneController,
                      hintText: "+90",
                    ),
                    CustomTextField(
                      initialValue: '',
                      onSaved: (value) {
                        birthDay = value;
                      },
                      obscureText: false,
                      labelText: 'Birth Day',
                      borderColor: const Color.fromARGB(255, 204, 204, 205),
                      textfiledColor: Colors.white,
                      // controller: dateOfBirsthController,
                      hintText: "3-5-2002",
                    ),
                  ]),
                ),
                TextButton.icon(
                    onPressed: () {},
                    icon: Icon(
                      Icons.location_city,
                      color: Colors.black,
                    ),
                    label: Text(
                      'Lives In',
                      style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    )),
                Container(
                  padding: EdgeInsets.only(right: 10, left: 10, bottom: 15),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.white),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        offset: Offset(0, 2),
                        blurRadius: 1,
                        spreadRadius: 0.2,
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 20, 0, 10),
                    child: CSCPicker(
                      dropdownDecoration: BoxDecoration(
                        border: Border.all(
                          color: Color.fromARGB(255, 204, 204, 205),
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      disabledDropdownDecoration: BoxDecoration(
                        color: Color.fromARGB(255, 239, 238, 238),
                        border: Border.all(
                          color: Color.fromARGB(255, 204, 204, 205),
                        ),
                        borderRadius: BorderRadius.circular(100),
                      ),
                      layout: Layout.vertical,
                      // flagState: CountryFlag.DISABLE,
                      onCountryChanged: (country) {
                        setState(() {
                          selectedCountry = country;
                        });
                      },
                      onStateChanged: (state) {
                        setState(() {
                          selectedState = state;
                        });
                      },
                      onCityChanged: (city) {
                        setState(() {
                          selectedCity = city;
                        });
                      },

                      countryDropdownLabel: "Country",
                      stateDropdownLabel: "State",
                      cityDropdownLabel: "City",
                      //dropdownDialogRadius: 30,
                      //searchBarRadius: 30,
                    ),
                  ),
                ),
                TextButton.icon(
                    onPressed: () {},
                    icon: Icon(
                      Icons.work,
                      color: Colors.black,
                    ),
                    label: Text(
                      'Professional Life',
                      style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    )),
                Container(
                  padding: EdgeInsets.only(right: 10, left: 10, bottom: 15),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.white),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        offset: Offset(0, 2),
                        blurRadius: 1,
                        spreadRadius: 0.2,
                      ),
                    ],
                  ),
                  child: Column(children: [
                    CustomTextField(
                      initialValue: '',
                      onSaved: (value) {
                        workplace = value;
                      },
                      obscureText: false,
                      labelText: 'Works At',
                      borderColor: const Color.fromARGB(255, 204, 204, 205),
                      textfiledColor: Colors.white,
                      // controller: workplaceController,
                      hintText: 'loyalty, merter',
                    ),
                    CustomTextField(
                      onSaved: (value) {
                        studyIn = value;
                      },
                      obscureText: false,
                      labelText: 'Study In',
                      borderColor: const Color.fromARGB(255, 204, 204, 205),
                      // controller: studyInController,
                      hintText: 'Uskudar university',
                      textfiledColor: Colors.white,
                    ),
                  ]),
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
