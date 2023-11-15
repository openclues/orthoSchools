import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../widgets/Button.dart';
import '../widgets/TextField.dart';
import '../widgets/Button.dart';
import 'package:text_area/text_area.dart';

class CreateProfileScreen extends StatefulWidget {
  const CreateProfileScreen({super.key});

  @override
  State<CreateProfileScreen> createState() => _CreateProfileScreenState();
}

class _CreateProfileScreenState extends State<CreateProfileScreen> {
  TextEditingController myTextController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController emailtController = TextEditingController();
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
    myTextController.addListener(() {
      setState(() {
        reasonValidation = myTextController.text.isEmpty;
      });
    });
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
                    borderColor: Color(0xFFCFD6FF),
                    controller: userNameController,
                    hintText: 'name',
                    fieldicon:
                        Icon(Icons.person, color: Color(0XFF939199), size: 17),
                    textfiledColor: Colors.white,
                  ),

                  CustomTextField(
                    borderColor: Color(0xFFCFD6FF),
                    controller: emailtController,
                    hintText: 'email address',
                    fieldicon:
                        Icon(Icons.email, color: Color(0XFF939199), size: 15),
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
                      hint: Text('title'),
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
                    textEditingController: myTextController,
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
                    buttonText: 'Save',
                    buttonColor: Color(0XFF21A2C4),
                    onpress: () {},
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
                      },
                    ),
                  ),
                  // PopupMenuButton<int>(
                  //   icon: Icon(Icons.more_vert), // Initial icon
                  //   onSelected: (value) {
                  //     // Handle item selection
                  //     switch (value) {
                  //       case 1:
                  //         // Handle the first item tap
                  //         print('Item 1 tapped');
                  //         break;
                  //       case 2:
                  //         // Handle the second item tap
                  //         print('Item 2 tapped');
                  //         break;
                  //     }
                  //   },
                  //   itemBuilder: (BuildContext context) => [
                  //     PopupMenuItem<int>(
                  //       value: 1,
                  //       child: CircleAvatar(
                  //         radius: 20,
                  //         backgroundColor: Colors.blue,
                  //         child: Icon(Icons.edit, color: Colors.white),
                  //       ),
                  //     ),
                  //     PopupMenuItem<int>(
                  //       value: 2,
                  //       child: Padding(
                  //         padding: const EdgeInsets.only(left: 8.0),
                  //         child: CircleAvatar(
                  //           radius: 20,
                  //           backgroundColor: Colors.red,
                  //           child: Icon(Icons.delete, color: Colors.white),
                  //         ),
                  //       ),
                  //     ),
                  //   ],
                  // ),

                  // Column(
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   children: [
                  //     ElevatedButton(
                  //       style: ElevatedButton.styleFrom(
                  //         shape: CircleBorder(),
                  //         padding: EdgeInsets.all(15.0),
                  //       ),
                  //       onPressed: () {
                  //         setState(() {
                  //           isToggleOn = !isToggleOn;
                  //         });
                  //       },
                  //       child: Icon(
                  //         Icons.more_vert,
                  //         size: 20,
                  //       ),
                  //     ),
                  //     SizedBox(height: 20),
                  //     if (isToggleOn)
                  //       Column(
                  //         mainAxisAlignment: MainAxisAlignment.center,
                  //         children: [
                  //           ElevatedButton(
                  //             style: ElevatedButton.styleFrom(
                  //               shape: CircleBorder(),
                  //               padding: EdgeInsets.all(15.0),
                  //             ),
                  //             onPressed: () {
                  //               picBannerImageFromCamera();
                  //             },
                  //             child: Icon(
                  //               Icons.camera_alt,
                  //               size: 15,
                  //             ),
                  //           ),
                  //           SizedBox(width: 10),
                  //           ElevatedButton(
                  //             style: ElevatedButton.styleFrom(
                  //               shape: CircleBorder(),
                  //               padding: EdgeInsets.all(15.0),
                  //             ),
                  //             onPressed: () {
                  //               picBannerImageFromGallery();
                  //             },
                  //             child: Icon(
                  //               Icons.photo,
                  //               size: 15,
                  //             ),
                  //           ),
                  //         ],
                  //       ),
                  //   ],
                  // ),
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
}
