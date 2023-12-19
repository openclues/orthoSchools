import 'package:azsoon/screens/EditProfilePage.dart';
import 'package:csc_picker/csc_picker.dart';
import 'package:flutter/material.dart';

import '../widgets/TextField.dart';

class buildCoverImage extends StatefulWidget {
  const buildCoverImage({super.key});

  @override
  State<buildCoverImage> createState() => _buildCoverImageState();
}

class _buildCoverImageState extends State<buildCoverImage> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    final double coverHeight = screenHeight / 3.7;
    return Container(
      // decoration: BoxDecoration(
      //   borderRadius: BorderRadius.only(
      //     bottomLeft: Radius.circular(15.0),
      //     bottomRight: Radius.circular(15.0),
      //   ),
      // ),
      child: Image.asset(
        'assets/images/postImage.png',
        width: double.infinity,
        height: coverHeight,
        fit: BoxFit.cover,
      ),
    );
  }
}

class buildProfilePicture extends StatefulWidget {
  const buildProfilePicture({super.key});

  @override
  State<buildProfilePicture> createState() => _buildProfilePictureState();
}

class _buildProfilePictureState extends State<buildProfilePicture> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    final double coverHeight = screenHeight / 3.7;
    final double profilePictureHeight = 70;
    final double top = coverHeight - profilePictureHeight / 2;
    return CircleAvatar(
      radius: profilePictureHeight, // adjust the radius as needed
      backgroundColor: const Color.fromARGB(255, 223, 223, 223), // border color
      child: CircleAvatar(
        radius: profilePictureHeight -
            4, // adjust the inner radius to leave room for the border
        backgroundImage: AssetImage('assets/images/profile.jpeg'),
      ),
    );
  }
}

class about_me_content extends StatefulWidget {
  final GlobalKey<FormState> globalKey;
  const about_me_content({super.key, required this.globalKey});

  @override
  State<about_me_content> createState() => _about_me_content();
}

class _about_me_content extends State<about_me_content>
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
    _tabController = TabController(length: 3, vsync: this);
  }

  // final GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      child: ListView(
        children: [
          Form(
            key: widget.globalKey,
            child: Container(
              padding: EdgeInsets.only(bottom: 30),
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
          ),
        ],
      ),
    );
  }
}

class basic_info extends StatefulWidget {
  const basic_info({super.key});

  @override
  State<basic_info> createState() => _basic_infoState();
}

class _basic_infoState extends State<basic_info>
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
  final GlobalKey<FormState> globalKey2 = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 15),
      child: ListView(
        children: [
          Form(
            key: globalKey2,
            child: Container(
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
                                        borderRadius: BorderRadius.circular(20),
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
                        // onSaved: (v) {
                        //   _firstName = v;
                        // },
                        obscureText: false,
                        labelText: 'First Name',
                        borderColor: const Color.fromARGB(255, 204, 204, 205),
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
                        borderColor: const Color.fromARGB(255, 204, 204, 205),
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
                        borderColor: const Color.fromARGB(255, 204, 204, 205),
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
                        borderColor: const Color.fromARGB(255, 204, 204, 205),
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
          ),
        ],
      ),
    );
  }
}
