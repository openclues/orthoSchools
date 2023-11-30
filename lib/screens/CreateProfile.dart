import 'dart:convert';
import 'dart:io';
import 'package:azsoon/Core/common-methods.dart';
import 'package:azsoon/Providers/moreUserInfoProvider.dart';
import 'package:azsoon/Providers/userInfoProvider.dart';
import 'package:azsoon/screens/Home.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../widgets/Button.dart';
import '../widgets/TextField.dart';
import '../widgets/Button.dart';
import 'package:text_area/text_area.dart';
import 'package:progress_dialog_null_safe/progress_dialog_null_safe.dart';
import 'package:http/http.dart' as http;
import '../widgets/App-bar.dart' as appBar;
import 'package:csc_picker/csc_picker.dart';

class CreateProfileScreen extends StatefulWidget {
  const CreateProfileScreen({super.key});

  @override
  State<CreateProfileScreen> createState() => _CreateProfileScreenState();
}

class _CreateProfileScreenState extends State<CreateProfileScreen> {
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

  TextEditingController firstNameControllerNEW = new TextEditingController();
  TextEditingController emailControllerNEW = new TextEditingController();
  TextEditingController lastNameControllerNEW = new TextEditingController();

  bool isToggleOn = false;
  int selectedRadio = 0;
  String titleVlaueSpeciality = '';
  String? selectedCountry;
  String? selectedState;
  String? selectedCity;

  List<String> cities = [];

  var reasonValidation = true;
  File? selectedBannerImage;
  File? selectedProfileImage;
  List<Certificate>? _certificates = [];

  // String? selectedDropValue;
  // List<String> dropdwonItems = [
  //   'dPHD',
  //   'drPHD',
  //   'drPH',
  // ];

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   firstNameController.text =
  // }

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = Provider.of<UserProvider>(context);
    firstNameControllerNEW.text = userProvider.user.firstName;
    lastNameControllerNEW.text = userProvider.user.lastName;
    emailControllerNEW.text = userProvider.user.email;

    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 230, 230, 230),
      appBar: appBar.AppBarWidget(),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.fromLTRB(10, 10, 10, 20),
          // color: Color.fromARGB(255, 230, 230, 230),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: screenWidth,
                height: screenHeight / 4,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: selectedBannerImage == null ? Colors.grey : null,
                  image: selectedBannerImage != null
                      ? DecorationImage(
                          image: FileImage(selectedBannerImage!),
                          fit: BoxFit.cover,
                        )
                      : null,
                ),
                child: Stack(
                  children: [
                    if (selectedBannerImage == null)
                      Center(child: Text('Please select an image')),
                    Positioned(
                      bottom: 0,
                      right: 5,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(
                            onPressed: () {
                              picBannerImageFromGallery();
                            },
                            child: Text(
                              'upload image',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              //basic informaiton
              SizedBox(height: 15),
              Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(children: [
                  Align(
                      alignment: Alignment.bottomLeft,
                      child: Text(
                        "Basic Information",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 71, 71, 71)),
                      )),
                  Container(
                    // alignment: Alignment.topLeft,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 20, 0, 7),
                      child: GestureDetector(
                        onTap: () {
                          picProfileImageFromGallery();
                          //open the image for preview and have a button change image gallery and or take one (camera)
                        },
                        child: CircleAvatar(
                          radius: 75,
                          child: selectedProfileImage == null
                              ? Center(
                                  child: Icon(
                                  Icons.camera_alt_outlined,
                                  color: Colors.grey[800],
                                ))
                              : null,
                          backgroundColor:
                              selectedProfileImage == null ? Colors.grey : null,
                          backgroundImage: selectedProfileImage != null
                              ? FileImage(selectedProfileImage!)
                              : null,
                        ),
                      ),
                    ),
                  ),
                  //radio buttons
                  SizedBox(height: 15),
                  Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Title',
                        style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 71, 71, 71)),
                      )),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      CustomRadio(
                        label: 'Doctor',
                        value: 1,
                        groupValue: selectedRadio,
                        onChanged: (value) {
                          setState(() {
                            selectedRadio = value as int;
                            titleVlaueSpeciality = 'Dr';
                          });
                        },
                      ),
                      CustomRadio(
                        label: 'Prof',
                        value: 2,
                        groupValue: selectedRadio,
                        onChanged: (value) {
                          setState(() {
                            selectedRadio = value as int;
                            titleVlaueSpeciality = 'Prof';
                          });
                        },
                      ),
                      CustomRadio(
                        label: 'Non',
                        value: 3,
                        groupValue: selectedRadio,
                        onChanged: (value) {
                          setState(() {
                            selectedRadio = value as int;
                            titleVlaueSpeciality = 'Non';
                          });
                        },
                      ),
                    ],
                  ),

                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: CustomTextField(
                              obscureText: false,
                              labelText: 'First Name',
                              borderColor: Color.fromARGB(255, 176, 176, 176),
                              textfiledColor: Colors.white,
                              controller: firstNameControllerNEW,
                              hintText: "",
                              // intialValue: userProvider.user.firstName,
                            ),
                          ),
                          SizedBox(
                              width: 16), // Adjust the spacing between fields
                          Expanded(
                            child: CustomTextField(
                              obscureText: false,
                              labelText: 'Last Name',
                              borderColor: Color.fromARGB(255, 176, 176, 176),
                              textfiledColor: Colors.white,
                              controller: lastNameControllerNEW,
                              hintText: "",
                              // intialValue: userProvider.user.lastName,
                            ),
                          ),
                        ],
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: CustomTextField(
                              obscureText: false,
                              labelText: 'Phone Number',
                              borderColor: Color.fromARGB(255, 176, 176, 176),
                              textfiledColor: Colors.white,
                              controller: phoneController,
                              hintText: "",
                            ),
                          ),
                          SizedBox(
                              width: 16), // Adjust the spacing between fields
                          Expanded(
                            child: CustomTextField(
                              obscureText: false,
                              labelText: 'Date Of Birth',
                              borderColor: Color.fromARGB(255, 176, 176, 176),
                              textfiledColor: Colors.white,
                              controller: dateOfBirsthController,
                              hintText: "",
                            ),
                          ),
                        ],
                      ),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //   children: [
                      //     Expanded(
                      //       child: CustomTextField(
                      //         obscureText: false,
                      //         labelText: 'Location',
                      //         borderColor: Color.fromARGB(255, 176, 176, 176),
                      //         textfiledColor: Colors.white,
                      //         // controller: phoneController,
                      //         hintText: "",
                      //       ),
                      //     ),
                      //     SizedBox(
                      //         width: 16), // Adjust the spacing between fields
                      //     Expanded(
                      //       child: CustomTextField(
                      //         obscureText: false,
                      //         labelText: 'City',
                      //         borderColor: Color.fromARGB(255, 176, 176, 176),
                      //         textfiledColor: Colors.white,
                      //         controller: cityController,
                      //         hintText: "",
                      //       ),
                      //     ),
                      //   ],
                      // ),
                      /////////////////////////////////////////////////
                      SizedBox(height: 16),
                      CSCPicker(
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

                      SizedBox(height: 16),

                      // Dropdown for selecting a city based on the selected country

                      ////////////////////////////
                      // Container(
                      //   decoration: BoxDecoration(
                      //     border: Border.all(
                      //       color: Color(0xFFCFD6FF),
                      //     ), // Set the border color here
                      //     borderRadius: BorderRadius.circular(11.0),
                      //     color: Colors.white,
                      //   ),
                      //   child: DropdownButton<String>(
                      //     underline: Container(),
                      //     // itemHeight: 50,
                      //     iconSize: 35,
                      //     padding:
                      //         EdgeInsets.symmetric(vertical: 1, horizontal: 10),
                      //     hint: Text('specialty'),
                      //     isExpanded: true,
                      //     value: selectedDropValue,
                      //     items: dropdwonItems.map((String value) {
                      //       return DropdownMenuItem<String>(
                      //         value: value,
                      //         child: Text(value),
                      //       );
                      //     }).toList(),
                      //     onChanged: (newvalue) {
                      //       setState(() {
                      //         selectedDropValue = newvalue;
                      //       });
                      //     },
                      //   ),
                      // ),
                    ],
                  ),
                ]),
              ),
              SizedBox(height: 15),
              //ABOUT me
              Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(children: [
                  Align(
                      alignment: Alignment.bottomLeft,
                      child: Text(
                        "About Me",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 71, 71, 71)),
                      )),
                  SizedBox(
                    height: 20,
                  ),
                  Column(
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          'Bio',
                          style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w500,
                              color: Color.fromARGB(255, 71, 71, 71)),
                        ),
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      TextArea(
                        borderRadius: 10,
                        borderColor: Color.fromARGB(255, 176, 176, 176),
                        textEditingController: bioController,
                        // suffixIcon: Icons.attach_file_rounded,
                        onSuffixIconPressed: () => {},
                        validation: reasonValidation,
                        // errorText: 'Please type a reason!',
                      )
                    ],
                  ),
                  CustomTextField(
                    obscureText: false,
                    labelText: 'Works At',
                    borderColor: Color.fromARGB(255, 176, 176, 176),
                    textfiledColor: Colors.white,
                    controller: workplaceController,
                    hintText: '',
                  ),
                  CustomTextField(
                    obscureText: false,
                    labelText: 'Study In',
                    borderColor: Color.fromARGB(255, 176, 176, 176),
                    controller: studyInController,
                    hintText: '',
                    textfiledColor: Colors.white,
                  ),
                ]),
              ),
              SizedBox(height: 15),
              //security
              Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(children: [
                  Align(
                      alignment: Alignment.bottomLeft,
                      child: Text(
                        "Security",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 71, 71, 71)),
                      )),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: CustomTextField(
                          obscureText: false,
                          labelText: 'Change Passowrd',
                          borderColor: Color.fromARGB(255, 176, 176, 176),
                          textfiledColor: Colors.white,
                          // controller:  ,
                          hintText: "Old Passowrd",
                        ),
                      ),
                      SizedBox(width: 16),
                      Expanded(
                        child: CustomTextField(
                          obscureText: false,
                          labelText: '',
                          borderColor: Color.fromARGB(255, 176, 176, 176),
                          textfiledColor: Colors.white,
                          // controller:  ,
                          hintText: "New Password",
                        ),
                      ),
                    ],
                  ),
                  CustomTextField(
                    obscureText: false,
                    labelText: 'My Email',
                    borderColor: Color.fromARGB(255, 176, 176, 176),
                    controller: emailControllerNEW,
                    hintText: '',
                    textfiledColor: Colors.white,
                  ),
                ]),
              ),
              SizedBox(height: 15),
              //my certificate
              Container(
                width: screenWidth,
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(children: [
                  Align(
                      alignment: Alignment.bottomLeft,
                      child: Text(
                        "My Certificate",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 71, 71, 71)),
                      )),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: screenHeight * 0.1,
                    child: ListView.builder(
                      itemCount: _certificates!.length,
                      itemBuilder: (context, index) {
                        Certificate certificate = _certificates![index];

                        return ListTile(
                          trailing: TextButton(
                            onPressed: () {
                              // Add logic to remove the certificate.
                            },
                            child: Text('remove'),
                          ),
                          leading: Icon(Icons.file_copy),
                          title: Text(certificate.title),
                          subtitle:
                              Text(certificate.file?.files.single.name ?? ''),
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 16),
                  CustomButton(
                    buttonColor: Colors.white,
                    textColor: Color(0XFF2F7EDB),
                    buttonText: 'Add Certificate',
                    height: 35,
                    onpress: () {
                      showModalBottomSheet(
                          isScrollControlled: true,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(20))),
                          context: context,
                          builder: (BuildContext context) {
                            String fileName = "";
                            return Container(
                              padding: EdgeInsets.fromLTRB(10, 0, 10, 5),
                              child: Padding(
                                padding: EdgeInsets.only(
                                    bottom: MediaQuery.of(context)
                                        .viewInsets
                                        .bottom),
                                child: Wrap(
                                  children: [
                                    CustomTextField(
                                      obscureText: false,
                                      labelText: '',
                                      borderColor: Color(0xFFCFD6FF),
                                      controller: fileNameController,
                                      hintText: 'file name',
                                      textfiledColor: Colors.white,
                                    ),
                                    Row(
                                      children: [
                                        Align(
                                          alignment: Alignment.bottomRight,
                                          child: CustomButton(
                                            buttonColor: Color(0XFF2F7EDB),
                                            buttonText: 'Add',
                                            height: 30,
                                            onpress: () async {
                                              FilePickerResult? result =
                                                  await _pickFiles();
                                              if (result != null) {
                                                setState(() {
                                                  String fileName =
                                                      fileNameController.text;
                                                  _certificates!
                                                      .add(Certificate(
                                                    title: fileName,
                                                    file: result,
                                                  ));
                                                });
                                                fileNameController.clear();
                                                Navigator.pop(
                                                    context); // Close the bottom sheet
                                              }
                                            },
                                          ),
                                        ),
                                        SizedBox(width: 10),
                                        // Align(
                                        //   alignment: Alignment.bottomLeft,
                                        //   child: CustomButton(
                                        //     buttonColor: Colors.white,
                                        //     textColor: Color(0XFF2F7EDB),
                                        //     buttonText: 'choose file',
                                        //     height: 30,
                                        //     onpress: _pickFiles,
                                        //   ),
                                        // ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          });
                    },
                  ),
                ]),
              ),
              SizedBox(height: 15),
              Align(
                alignment: Alignment.bottomRight,
                child: CustomButton(
                  buttonColor: Color(0XFF2F7EDB),
                  buttonText: 'Update My Information',
                  height: 40,
                  onpress: () async {
                    await createProfile(
                      bioController.text,
                      selectedProfileImage,
                      workplaceController.text,
                      titleVlaueSpeciality,
                      selectedBannerImage,
                      fileNameController.text,
                      lastNameController.text,
                      emailtController.text,
                      phoneController.text,
                      '${selectedCountry} / ${selectedState} / ${selectedCity}',
                    );
                    String? authToken = await CommonMethods.getAuthToken();
                    // After updating the profile, refresh the user information
                    await userProvider.refreshUser(authToken!);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future picBannerImageFromGallery() async {
    final returnedBannerImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (returnedBannerImage == null) return;
    setState(() {
      selectedBannerImage = File(returnedBannerImage!.path);
    });
  }

  Future picBannerImageFromCamera() async {
    final returnedImage =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (returnedImage == null) return;
    setState(() {
      selectedBannerImage = File(returnedImage!.path);
    });
  }

  Future picProfileImageFromGallery() async {
    final returnedProfileImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (returnedProfileImage == null) return;
    setState(() {
      selectedProfileImage = File(returnedProfileImage!.path);
    });
  }

  Future picProfileImageFromCamera() async {
    final returnedProfileImage =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (returnedProfileImage == null) return;
    setState(() {
      selectedProfileImage = File(returnedProfileImage!.path);
    });
  }

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

  //saving profile data patch

  // Future<void> createProfile(String bio, String profileImage, String banner,
  //     String specialty, String placeOfWork) async {
  //   ProgressDialog pr = new ProgressDialog(context,
  //       type: ProgressDialogType.normal, isDismissible: false, showLogs: true);
  //   String? authToken = await CommonMethods.getAuthToken();
  //   print("=============================${authToken}");
  //   try {
  //     pr.show();
  //     var response = await http.patch(
  //       Uri.parse('https://orthoschools.com/profile/create'),
  //       body: {
  //         "bio": bio,
  //         "profileImage": profileImage,
  //         "place_of_work": placeOfWork,
  //         "speciality": specialty,
  //         "cover": banner,
  //       },
  //       headers: {"Authorization": "Token $authToken"},
  //     );
  //     print("=============================${response.body}");
  //     pr.hide();
  //     if (response.statusCode == 201) {
  //       Map<String, dynamic> responseData = json.decode(response.body);
  //       if (responseData.containsKey('token')) {
  //         print(responseData.containsKey('token'));
  //         //go to home after he press save or skip
  //         Navigator.of(context).pushAndRemoveUntil(
  //             MaterialPageRoute(builder: (context) => HomeScreen()),
  //             (route) => false);
  //       } else {
  //         print("==========================================no token");
  //       }
  //     } else {
  //       print("==========================================${response.body}");
  //     }
  //   } catch (e) {
  //     pr.hide();
  //     print(e.toString());
  //   }
  // }

  Future<void> createProfile(
      String? bio,
      File? profileImage,
      String? placeOfWork,
      String? specialty,
      File? banner,
      String? firstName,
      String? lastName,
      String? email,
      String? phone,
      String? address) async {
    print({
      bio,
      profileImage,
      banner,
      specialty,
      placeOfWork,
      firstName,
      lastName,
      email,
      phone,
      address
    });
    ProgressDialog pr = new ProgressDialog(context,
        type: ProgressDialogType.normal, isDismissible: false, showLogs: true);

    String? authToken = await CommonMethods.getAuthToken();
    print("=============================${authToken}");

    pr.show();
    var request = http.MultipartRequest(
        'PATCH', Uri.parse('https://orthoschools.com/profile/update/'));

    // text fields
    request.fields['bio'] = bio ?? "";
    request.fields['place_of_work'] = placeOfWork ?? "";
    request.fields['speciality'] = specialty ?? ""; //radio butoon value string
    request.fields['first_name'] = firstName ?? "";
    request.fields['last_name'] = lastName ?? "";
    request.fields['email'] = email ?? "";
    request.fields['phone'] = phone ?? "";
    request.fields['address'] = address ?? "";

    // file fields
    if (profileImage != null) {
      request.files.add(http.MultipartFile(
          'profileImage',
          http.ByteStream(Stream.castFrom(profileImage.openRead())),
          await profileImage.length(),
          filename: 'profileImage.jpg'));
    }
    if (banner != null) {
      request.files.add(http.MultipartFile(
          'cover',
          http.ByteStream(Stream.castFrom(banner.openRead())),
          await banner.length(),
          filename: 'cover.jpg'));
    }

    //auth header
    request.headers['Authorization'] = 'Token $authToken';

    // request.headers['Content-Type'] = 'application/json';

    //here i am sending the request
    var response = await request.send();

    if (response.statusCode == 200) {
      print("=============================${response.statusCode}");
      pr.hide();
      //printing response
      print(await response.stream.bytesToString());
      //go to home after done
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => HomeScreen()),
        //show snackkbar info updted succfuly
        (route) => false,
      );
    } else {
      print("=============================${response.statusCode}");
      pr.hide();
      print(
          "==========================================${response.reasonPhrase}======================");
    }
  }
}

class CustomRadio extends StatelessWidget {
  final String label;
  final int value;
  final int groupValue;
  final ValueChanged<int>? onChanged;

  const CustomRadio({
    required this.label,
    required this.value,
    required this.groupValue,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = Provider.of<UserProvider>(context);
    MoreInfoUserProvider moreInfoUserProvider =
        Provider.of<MoreInfoUserProvider>(context);
    return InkWell(
      onTap: () {
        onChanged?.call(value);
      },
      child: Container(
        margin: EdgeInsets.fromLTRB(0, 10, 10, 15),
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
        decoration: BoxDecoration(
          color: groupValue == value ? Colors.blue : Colors.transparent,
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(
            color: groupValue == value
                ? Colors.blue
                : const Color.fromARGB(255, 176, 176, 176),
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: groupValue == value ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
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
