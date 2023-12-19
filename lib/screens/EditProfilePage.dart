import 'package:azsoon/screens/editProfile_funcions.dart';
import 'package:azsoon/widgets/Button.dart';
import 'package:azsoon/widgets/IndicatorShape.dart';
import 'package:azsoon/widgets/TextField.dart';
import 'package:csc_picker/csc_picker.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

String? bio;

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<EditProfilePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  TextEditingController bioController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailtController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController workplaceController = TextEditingController();
  TextEditingController studyInController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController dateOfBirsthController = TextEditingController();
  TextEditingController fileNameController = TextEditingController();

  String? selectedCountry;
  String? selectedState;
  String? selectedCity;
  List<Certificate>? _certificates = [];
  String? titleSelectd;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  final GlobalKey<FormState> globalKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    final double coverHeight = screenHeight / 3.7;
    final double profilePictureHeight = 70;
    final double top = coverHeight - profilePictureHeight / 2;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      body: Form(
        key: globalKey,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: ListView(children: [
            Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.center,
              children: [
                Container(
                  child: buildCoverImage(),
                ),
                Positioned(
                  top: top,
                  child: buildProfilePicture(),
                ),
                Positioned(
                  top: top + top / 4,
                  right: 0,
                  child: IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () async {
                      // await editDialog();
                    },
                  ),
                ),
              ],
            ),
            //tabs
            tab_bar_tabs(),
            //view of the tabs
            tab_sections_view(),
            Padding(
              padding: const EdgeInsets.only(right: 8.0, left: 8.0),
              child: CustomButton(
                buttonText: 'Save',
                buttonColor: Color(0XFF8174CC),
                borderColor: Color(0XFF8174CC),
                textColor: Colors.white,
                height: 45,
                onpress: () {
                  //saving edited data
                  globalKey.currentState
                      ?.save(); // Add this line to trigger onSaved callbacks
                  print(bioController.text);
                  print(firstNameController.text);
                },
              ),
            ),
          ]),
        ),
      ),
    );
  }

  // Future editDialog() {
  //   return showDialog(
  //     context: context,
  //     builder: (context) => AlertDialog(
  //       content: Column(
  //         children: [
  //           TextButton(
  //               onPressed: () {},
  //               child: Text(
  //                 'edit profile photo',
  //                 style: TextStyle(color: Colors.black),
  //               )),
  //           TextButton(
  //               onPressed: () {},
  //               child: Text(
  //                 'edit cover image',
  //                 style: TextStyle(color: Colors.black),
  //               )),
  //         ],
  //       ),
  //       actions: [
  //         TextButton(
  //             onPressed: () {
  //               Navigator.of(context).pop();
  //             },
  //             child: Text(
  //               'cancle',
  //               style: TextStyle(color: Colors.red),
  //             ))
  //       ],
  //     ),
  //   );
  // }

  Container tab_sections_view() {
    return Container(
      width: double.maxFinite,
      height: 300,
      child: TabBarView(
        controller: _tabController,
        children: [
          //content of about
          // about_me_content(
          //   globalKey: globalKey,
          // ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            child: ListView(
              children: [
                Container(
                  padding: EdgeInsets.only(bottom: 30),
                  child: Column(children: [
                    CustomTextField(
                      initialValue: '',
                      maxLines: 3,
                      onSaved: (value) {
                        bioController.text = value ?? '';
                      },
                      obscureText: false,
                      labelText: 'Bio',
                      borderColor: Color.fromARGB(255, 204, 204, 205),
                      textfiledColor: Colors.white,
                      controller: bioController,
                      hintText: '',
                    ),
                    CustomTextField(
                      initialValue: '',
                      // onSaved: (n) {
                      //   _worksat = n;
                      // },
                      obscureText: false,
                      labelText: '',
                      borderColor: const Color.fromARGB(255, 204, 204, 205),
                      textfiledColor: Colors.white,
                      controller: workplaceController,
                      hintText: 'Works At',
                    ),
                    CustomTextField(
                      // onSaved: (b) {
                      //   study_at = b;
                      // },
                      obscureText: false,
                      labelText: '',
                      borderColor: const Color.fromARGB(255, 204, 204, 205),
                      controller: studyInController,
                      hintText: 'Study In',
                      textfiledColor: Colors.white,
                    ),
                  ]),
                ),
              ],
            ),
          ),
          //content of basic info
          // basic_info(),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 15),
            child: ListView(
              children: [
                Container(
                  child: Column(children: [
                    Padding(
                      padding: EdgeInsets.only(top: 30, bottom: 30),
                      child: Row(
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
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: CustomTextField(
                            initialValue: '',
                            onSaved: (value) {
                              firstNameController.text = value ?? '';
                            },
                            obscureText: false,
                            labelText: 'First Name',
                            borderColor:
                                const Color.fromARGB(255, 204, 204, 205),
                            textfiledColor: Colors.white,
                            controller: firstNameController,
                            hintText: "",
                          ),
                        ),
                        const SizedBox(
                            width: 16), // Adjust the spacing between fields
                        Expanded(
                          child: CustomTextField(
                            initialValue: '',
                            // onSaved: (v) {
                            //   _lastName = v;
                            // },
                            obscureText: false,
                            labelText: 'Last Name',
                            borderColor:
                                const Color.fromARGB(255, 204, 204, 205),
                            textfiledColor: Colors.white,
                            controller: lastNameController,
                            hintText: "",
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: CustomTextField(
                            initialValue: '',
                            // onSaved: (v) {
                            //   _phone = v;
                            // },
                            obscureText: false,
                            labelText: 'Phone Number',
                            borderColor:
                                const Color.fromARGB(255, 204, 204, 205),
                            textfiledColor: Colors.white,
                            controller: phoneController,
                            hintText: "",
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: CustomTextField(
                            initialValue: '',
                            // onSaved: (v) {
                            //   _dateOfBirth = v;
                            // },
                            obscureText: false,
                            labelText: 'Date Of Birth',
                            borderColor:
                                const Color.fromARGB(255, 204, 204, 205),
                            textfiledColor: Colors.white,
                            controller: dateOfBirsthController,
                            hintText: "",
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 40, 0, 40),
                      child: CSCPicker(
                        dropdownDecoration: BoxDecoration(
                          border: Border.all(
                            color: Color.fromARGB(255, 204, 204, 205),
                          ),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        disabledDropdownDecoration: BoxDecoration(
                          color: Color.fromARGB(255, 239, 238, 238),
                          border: Border.all(
                            color: Color.fromARGB(255, 204, 204, 205),
                          ),
                          borderRadius: BorderRadius.circular(20),
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
                  ]),
                ),
              ],
            ),
          ),
          //content of certificates
          // certificates(),
          //content of securirty
          // security(),
        ],
      ),
    );
  }

//do a form with global key
  Padding tab_bar_tabs() {
    return Padding(
      padding: EdgeInsets.only(top: 120),
      child: TabBar(
        unselectedLabelColor: Color.fromARGB(255, 156, 156, 156),
        padding: EdgeInsets.only(left: 20, right: 20),
        indicatorColor: Color(0XFF8174CC),
        indicator: DotIndicator(),
        controller: _tabController,
        labelColor: Colors.black,
        labelStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
        tabs: [
          Tab(
            icon: Icon(
              Icons.person,
              size: 20,
            ),
            text: 'About Me',
          ),
          Tab(
            icon: Icon(
              Icons.info,
              size: 20,
            ),
            text: 'Basic Info',
          ),
          // Tab(
          //   icon: Icon(
          //     Icons.badge,
          //     size: 20,
          //   ),
          //   text: 'Certificates',
          // ),
          // Tab(
          //   icon: Icon(
          //     Icons.security,
          //     size: 20,
          //   ),
          //   text: 'Security',
          // ),
        ],
      ),
    );
  }

//done
  // Widget buildCoverImage(double coverHight) {
  //   return Container(
  //     // decoration: BoxDecoration(
  //     //   borderRadius: BorderRadius.only(
  //     //     bottomLeft: Radius.circular(15.0),
  //     //     bottomRight: Radius.circular(15.0),
  //     //   ),
  //     // ),
  //     child: Image.asset(
  //       'assets/images/postImage.png',
  //       width: double.infinity,
  //       height: coverHight,
  //       fit: BoxFit.cover,
  //     ),
  //   );
  // }
//done
  // Widget buildProfilePicture(double profilePictureHeight) {
  //   return CircleAvatar(
  //     radius: profilePictureHeight, // adjust the radius as needed
  //     backgroundColor: const Color.fromARGB(255, 223, 223, 223), // border color
  //     child: CircleAvatar(
  //       radius: profilePictureHeight -
  //           4, // adjust the inner radius to leave room for the border
  //       backgroundImage: AssetImage('assets/images/profile.jpeg'),
  //     ),
  //   );
  // }

//done
  // Widget about_me_content() {
  //   return Padding(
  //     padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
  //     child: ListView(
  //       children: [
  //         Form(
  //           key: globalKey,
  //           child: Container(
  //             padding: EdgeInsets.only(bottom: 30),
  //             child: Column(children: [
  //               CustomTextField(
  //                 initialValue: '',
  //                 maxLines: 3,
  //                 // onSaved: (v) {
  //                 //   _bio = v;
  //                 // },
  //                 obscureText: false,
  //                 labelText: 'Bio',
  //                 borderColor: Color.fromARGB(255, 204, 204, 205),
  //                 textfiledColor: Colors.white,
  //                 controller: workplaceController,
  //                 hintText: '',
  //               ),
  //               CustomTextField(
  //                 initialValue: '',
  //                 // onSaved: (n) {
  //                 //   _worksat = n;
  //                 // },
  //                 obscureText: false,
  //                 labelText: '',
  //                 borderColor: const Color.fromARGB(255, 204, 204, 205),
  //                 textfiledColor: Colors.white,
  //                 controller: workplaceController,
  //                 hintText: 'Works At',
  //               ),
  //               CustomTextField(
  //                 // onSaved: (b) {
  //                 //   study_at = b;
  //                 // },
  //                 obscureText: false,
  //                 labelText: '',
  //                 borderColor: const Color.fromARGB(255, 204, 204, 205),
  //                 controller: studyInController,
  //                 hintText: 'Study In',
  //                 textfiledColor: Colors.white,
  //               ),
  //             ]),
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

//done
  // Widget basic_info() {
  //   return Padding(
  //     padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 15),
  //     child: ListView(
  //       children: [
  //         Form(
  //           key: globalKey,
  //           child: Container(
  //             child: Column(children: [
  //               Padding(
  //                 padding: EdgeInsets.only(top: 30, bottom: 30),
  //                 child: Row(
  //                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //                   children: ['Dr', 'Prof', 'None']
  //                       .map((e) => Expanded(
  //                             child: Padding(
  //                               padding: const EdgeInsets.all(8.0),
  //                               child: GestureDetector(
  //                                 onTap: () {
  //                                   // setState(() {
  //                                   //   titleSelectd = e;
  //                                   // });
  //                                 },
  //                                 child: Container(
  //                                   decoration: BoxDecoration(
  //                                       borderRadius: BorderRadius.circular(20),
  //                                       color: e == titleSelectd
  //                                           ? Color(0XFF8174CC)
  //                                           : Colors.transparent,
  //                                       border: Border.all(
  //                                         color: Color.fromARGB(
  //                                             255, 204, 204, 205),
  //                                       )),
  //                                   child: Padding(
  //                                     padding: const EdgeInsets.all(7.0),
  //                                     child: Text(
  //                                       e,
  //                                       textAlign: TextAlign.center,
  //                                       style: TextStyle(
  //                                           color: e == titleSelectd
  //                                               ? Colors.white
  //                                               : Colors.black,
  //                                           fontSize: 17),
  //                                     ),
  //                                   ),
  //                                 ),
  //                               ),
  //                             ),
  //                           ))
  //                       .toList(),
  //                 ),
  //               ),
  //               Row(
  //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                 children: [
  //                   Expanded(
  //                     child: CustomTextField(
  //                       initialValue: '',
  //                       // onSaved: (v) {
  //                       //   _firstName = v;
  //                       // },
  //                       obscureText: false,
  //                       labelText: 'First Name',
  //                       borderColor: const Color.fromARGB(255, 204, 204, 205),
  //                       textfiledColor: Colors.white,
  //                       controller: firstNameController,
  //                       hintText: "",
  //                     ),
  //                   ),
  //                   const SizedBox(
  //                       width: 16), // Adjust the spacing between fields
  //                   Expanded(
  //                     child: CustomTextField(
  //                       initialValue: '',
  //                       // onSaved: (v) {
  //                       //   _lastName = v;
  //                       // },
  //                       obscureText: false,
  //                       labelText: 'Last Name',
  //                       borderColor: const Color.fromARGB(255, 204, 204, 205),
  //                       textfiledColor: Colors.white,
  //                       controller: lastNameController,
  //                       hintText: "",
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //               SizedBox(
  //                 height: 10,
  //               ),
  //               Row(
  //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                 children: [
  //                   Expanded(
  //                     child: CustomTextField(
  //                       initialValue: '',
  //                       // onSaved: (v) {
  //                       //   _phone = v;
  //                       // },
  //                       obscureText: false,
  //                       labelText: 'Phone Number',
  //                       borderColor: const Color.fromARGB(255, 204, 204, 205),
  //                       textfiledColor: Colors.white,
  //                       controller: phoneController,
  //                       hintText: "",
  //                     ),
  //                   ),
  //                   const SizedBox(width: 16),
  //                   Expanded(
  //                     child: CustomTextField(
  //                       initialValue: '',
  //                       // onSaved: (v) {
  //                       //   _dateOfBirth = v;
  //                       // },
  //                       obscureText: false,
  //                       labelText: 'Date Of Birth',
  //                       borderColor: const Color.fromARGB(255, 204, 204, 205),
  //                       textfiledColor: Colors.white,
  //                       controller: dateOfBirsthController,
  //                       hintText: "",
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //               Padding(
  //                 padding: const EdgeInsets.fromLTRB(0, 40, 0, 40),
  //                 child: CSCPicker(
  //                   dropdownDecoration: BoxDecoration(
  //                     border: Border.all(
  //                       color: Color.fromARGB(255, 204, 204, 205),
  //                     ),
  //                     borderRadius: BorderRadius.circular(20),
  //                   ),
  //                   disabledDropdownDecoration: BoxDecoration(
  //                     color: Color.fromARGB(255, 239, 238, 238),
  //                     border: Border.all(
  //                       color: Color.fromARGB(255, 204, 204, 205),
  //                     ),
  //                     borderRadius: BorderRadius.circular(20),
  //                   ),
  //                   layout: Layout.vertical,
  //                   // flagState: CountryFlag.DISABLE,
  //                   onCountryChanged: (country) {
  //                     setState(() {
  //                       selectedCountry = country;
  //                     });
  //                   },
  //                   onStateChanged: (state) {
  //                     setState(() {
  //                       selectedState = state;
  //                     });
  //                   },
  //                   onCityChanged: (city) {
  //                     setState(() {
  //                       selectedCity = city;
  //                     });
  //                   },

  //                   countryDropdownLabel: "Country",
  //                   stateDropdownLabel: "State",
  //                   cityDropdownLabel: "City",
  //                   //dropdownDialogRadius: 30,
  //                   //searchBarRadius: 30,
  //                 ),
  //               ),
  //             ]),
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  // Widget certificates() {
  //   return Padding(
  //     padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
  //     child: ListView(
  //       children: [
  //         Form(
  //           key: globalKey,
  //           child: Container(
  //             child: Column(children: [
  //               Column(children: [
  //                 CustomButton(
  //                   buttonColor: Colors.white,
  //                   textColor: const Color(0XFF2F7EDB),
  //                   buttonText: 'Add Certificate',
  //                   height: 35,
  //                   onpress: () {
  //                     showModalBottomSheet(
  //                         isScrollControlled: true,
  //                         shape: const RoundedRectangleBorder(
  //                             borderRadius: BorderRadius.vertical(
  //                                 top: Radius.circular(20))),
  //                         context: context,
  //                         builder: (BuildContext context) {
  //                           String fileName = "";
  //                           return Container(
  //                             padding: const EdgeInsets.fromLTRB(10, 0, 10, 5),
  //                             child: Padding(
  //                               padding: EdgeInsets.only(
  //                                   bottom: MediaQuery.of(context)
  //                                       .viewInsets
  //                                       .bottom),
  //                               child: Wrap(
  //                                 children: [
  //                                   CustomTextField(
  //                                     obscureText: false,
  //                                     labelText: '',
  //                                     borderColor: const Color(0xFFCFD6FF),
  //                                     controller: fileNameController,
  //                                     hintText: 'file name',
  //                                     textfiledColor: Colors.white,
  //                                   ),
  //                                   Row(
  //                                     children: [
  //                                       Align(
  //                                         alignment: Alignment.bottomRight,
  //                                         child: CustomButton(
  //                                           buttonColor:
  //                                               const Color(0XFF2F7EDB),
  //                                           buttonText: 'Add',
  //                                           height: 30,
  //                                           onpress: () async {
  //                                             FilePickerResult? result =
  //                                                 await _pickFiles();
  //                                             if (result != null) {
  //                                               setState(() {
  //                                                 String fileName =
  //                                                     fileNameController.text;
  //                                                 _certificates!
  //                                                     .add(Certificate(
  //                                                   title: fileName,
  //                                                   file: result,
  //                                                 ));
  //                                               });
  //                                               fileNameController.clear();
  //                                               Navigator.pop(
  //                                                   context); // Close the bottom sheet
  //                                             }
  //                                           },
  //                                         ),
  //                                       ),
  //                                       const SizedBox(width: 10),
  //                                     ],
  //                                   ),
  //                                 ],
  //                               ),
  //                             ),
  //                           );
  //                         });
  //                   },
  //                 ),
  //               ]),
  //             ]),
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

//we will change this///
  // Widget security() {
  //   return Padding(
  //     padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
  //     child: ListView(
  //       children: [
  //         Form(
  //           key: globalKey,
  //           child: Container(
  //             child: Column(children: [
  //               Row(
  //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                 children: [
  //                   Expanded(
  //                     child: CustomTextField(
  //                       obscureText: false,
  //                       labelText: 'Change Passowrd',
  //                       borderColor: const Color.fromARGB(255, 204, 204, 205),
  //                       textfiledColor: Colors.white,
  //                       // controller:  ,
  //                       hintText: "Old Passowrd",
  //                     ),
  //                   ),
  //                   SizedBox(width: 16),
  //                   Expanded(
  //                     child: CustomTextField(
  //                       obscureText: false,
  //                       labelText: '',
  //                       borderColor: const Color.fromARGB(255, 204, 204, 205),
  //                       textfiledColor: Colors.white,
  //                       // controller:  ,
  //                       hintText: "New Password",
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //               CustomTextField(
  //                 obscureText: false,
  //                 labelText: 'My Email',
  //                 borderColor: const Color.fromARGB(255, 204, 204, 205),
  //                 controller: emailtController,
  //                 hintText: '',
  //                 textfiledColor: Colors.white,
  //               ),
  //             ]),
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

//////////////////
  Future<FilePickerResult?> _pickFiles() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf'],
        withData: true,
        allowMultiple: true,
      );

      return result;
    } catch (e) {
      print('Error picking files: $e');
      return null;
    }
  }
}

class Certificate {
  final String title;
  final FilePickerResult? file;

  Certificate({
    required this.title,
    required this.file,
  });
}
