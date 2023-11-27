import 'dart:convert';
import 'dart:io';

import 'package:azsoon/Core/common-methods.dart';
import 'package:azsoon/screens/Home.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../widgets/Button.dart';
import '../widgets/TextField.dart';
import '../widgets/Button.dart';
import 'package:text_area/text_area.dart';
import 'package:progress_dialog_null_safe/progress_dialog_null_safe.dart';
import 'package:http/http.dart' as http;

class CreateProfileScreen extends StatefulWidget {
  const CreateProfileScreen({super.key});

  @override
  State<CreateProfileScreen> createState() => _CreateProfileScreenState();
}

class _CreateProfileScreenState extends State<CreateProfileScreen> {
  TextEditingController bioController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController emailtController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController workplaceController = TextEditingController();

  bool isToggleOn = false;

  var reasonValidation = true;
  File? selectedBannerImage;
  File? selectedProfileImage;

  String? selectedDropValue;
  List<String> dropdwonItems = [
    'dPHD',
    'drPHD',
    'drPH',
  ];

  void initState() {
    super.initState();
    // bioController.addListener(() {
    //   setState(() {
    //     reasonValidation = bioController.text.isEmpty;
    //   });
    // });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        ///////////////////only for testing
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back,
                color: Color(0XFF005F7E),
              ))
        ],

        ///////////////////only for testing
        title: Text(
          'Start by creating your profile !',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //banner image container
              Container(
                width: screenWidth,
                height: screenHeight / 4,
                decoration: BoxDecoration(
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
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color.fromARGB(255, 76, 76, 76),
                              shape: CircleBorder(),
                              padding: EdgeInsets.all(10.0),
                            ),
                            onPressed: () {
                              setState(() {
                                isToggleOn = !isToggleOn;
                              });
                            },
                            child: Icon(
                              Icons.more_vert,
                              size: 20,
                            ),
                          ),
                          // SizedBox(height: 20),
                          if (isToggleOn)
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Color(0XFF21A2C4),
                                    shape: CircleBorder(),
                                    padding: EdgeInsets.all(15.0),
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      isToggleOn = !isToggleOn;
                                    });
                                    picBannerImageFromCamera();
                                  },
                                  child: Icon(
                                    Icons.camera_alt,
                                    size: 15,
                                  ),
                                ),
                                SizedBox(width: 10),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Color(0XFF21A2C4),
                                    shape: CircleBorder(),
                                    padding: EdgeInsets.all(15.0),
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      isToggleOn = !isToggleOn;
                                    });
                                    picBannerImageFromGallery();
                                  },
                                  child: Icon(
                                    Icons.photo,
                                    size: 15,
                                  ),
                                ),
                              ],
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 0, 10),
                child: Container(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () {
                        picProfileImageFromGallery();
                        //open the image for preview and have a button change image gallery and or take one (camera)
                      },
                      child: CircleAvatar(
                        radius: 50,
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
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: Column(children: [
                  CustomTextField(
                    obscureText: false,
                    labelText: 'Name',
                    borderColor: Color(0xFFCFD6FF),
                    controller: userNameController,
                    hintText: 'name',
                    fieldicon:
                        Icon(Icons.person, color: Color(0XFF939199), size: 17),
                    textfiledColor: Colors.white,
                  ),

                  CustomTextField(
                    obscureText: false,
                    labelText: 'Email',
                    borderColor: Color(0xFFCFD6FF),
                    controller: emailtController,
                    hintText: 'email address',
                    fieldicon:
                        Icon(Icons.email, color: Color(0XFF939199), size: 15),
                    textfiledColor: Colors.white,
                  ),
                  CustomTextField(
                    obscureText: false,
                    labelText: 'Phone',
                    borderColor: Color(0xFFCFD6FF),
                    controller: phoneController,
                    hintText: 'phone number',
                    textfiledColor: Colors.white,
                    fieldicon:
                        Icon(Icons.phone, color: Color(0XFF939199), size: 15),
                  ),
                  CustomTextField(
                    obscureText: false,
                    labelText: 'Place Of Work',
                    borderColor: Color(0xFFCFD6FF),
                    controller: workplaceController,
                    hintText: 'work place',
                    fieldicon:
                        Icon(Icons.work, color: Color(0XFF939199), size: 17),
                    textfiledColor: Colors.white,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Color(0xFFCFD6FF),
                      ), // Set the border color here
                      borderRadius: BorderRadius.circular(11.0),
                      color: Colors.white,
                    ),
                    child: DropdownButton<String>(
                      underline: Container(),
                      // itemHeight: 50,
                      iconSize: 35,
                      padding:
                          EdgeInsets.symmetric(vertical: 1, horizontal: 10),
                      hint: Text('specialty'),
                      isExpanded: true,
                      value: selectedDropValue,
                      items: dropdwonItems.map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (newvalue) {
                        setState(() {
                          selectedDropValue = newvalue;
                        });
                      },
                    ),
                  ),

                  SizedBox(
                    height: 25,
                  ),
                  TextArea(
                    borderRadius: 10,
                    borderColor: const Color(0xFFCFD6FF),
                    textEditingController: bioController,
                    // suffixIcon: Icons.attach_file_rounded,
                    onSuffixIconPressed: () => {},
                    validation: reasonValidation,
                    // errorText: 'Please type a reason!',
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  CustomButton(
                    width: screenWidth,
                    height: 40,
                    buttonText: 'Confirm',
                    buttonColor: Color(0XFF21A2C4),
                    onpress: () async {
                      //take data and patch it
                      await createProfile(
                          bioController.text,
                          selectedProfileImage!,
                          selectedBannerImage!,
                          selectedDropValue!,
                          workplaceController.text);
                    },
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  //widget file uplad
                  Align(
                    alignment: Alignment.bottomRight,
                    child: InkWell(
                      child: Text(
                        'Skip',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w300,
                            decoration: TextDecoration.underline),
                      ),
                      onTap: () {
                        //skip and go to home page
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                                builder: (context) => HomeScreen()),
                            (route) => false);
                      },
                    ),
                  ),
                ]),
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

  Future<void> createProfile(String bio, File profileImage, File banner,
      String specialty, String placeOfWork) async {
    ProgressDialog pr = new ProgressDialog(context,
        type: ProgressDialogType.normal, isDismissible: false, showLogs: true);

    String? authToken = await CommonMethods.getAuthToken();
    print("=============================${authToken}");

    try {
      pr.show();
      var request = http.MultipartRequest(
          'PATCH', Uri.parse('https://orthoschools.com/profile/create'));

      // text fields
      request.fields['bio'] = bio;
      request.fields['place_of_work'] = placeOfWork;
      request.fields['speciality'] = specialty;

      // file fields
      request.files.add(http.MultipartFile(
          'profileImage',
          http.ByteStream(Stream.castFrom(profileImage.openRead())),
          await profileImage.length(),
          filename: 'profileImage.jpg'));
      request.files.add(http.MultipartFile(
          'cover',
          http.ByteStream(Stream.castFrom(banner.openRead())),
          await banner.length(),
          filename: 'cover.jpg'));

      //auth header
      request.headers['Authorization'] = 'Token $authToken';

      //here i am sending the request
      var response = await request.send();

      if (response.statusCode == 200) {
        pr.hide();
        //printing response
        print(await response.stream.bytesToString());
        //go to home after done
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => HomeScreen()),
          (route) => false,
        );
      } else {
        pr.hide();
        print(
            "==========================================${response.reasonPhrase}");
      }
    } catch (e) {
      pr.hide();
      print(e.toString());
    }
  }
}
