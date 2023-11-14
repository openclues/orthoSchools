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
                      child: Row(
                        children: [
                          CustomButton(
                            height: 25,
                            buttonText: 'Add Cover',
                            buttonColor: Color.fromARGB(255, 194, 194, 194),
                            onpress: () {
                              picBannerImageFromGallery();
                            },
                          ),
                          SizedBox(
                            width: 4,
                          ),
                          CustomButton(
                            height: 25,
                            buttonText: 'Take cover',
                            buttonColor: const Color.fromARGB(255, 74, 74, 74),
                            onpress: () {
                              picBannerImageFromCamera();
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 0, 30),
                child: Container(
                  alignment: Alignment.topLeft,
                  child: GestureDetector(
                    onTap: () {
                      picProfileImageFromGallery();
                      //open the image for preview and have a button change image gallery and or take one (camera)
                    },
                    child: CircleAvatar(
                      radius: 60,
                      backgroundColor:
                          selectedProfileImage == null ? Colors.grey : null,
                      backgroundImage: selectedProfileImage != null
                          ? FileImage(selectedProfileImage!)
                          : null,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(20),
                child: Column(children: [
                  CustomTextField(
                    controller: userNameController,
                    hintText: 'name',
                    fieldicon:
                        Icon(Icons.person, color: Color(0XFF939199), size: 17),
                    textfiledColor: Colors.white,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  CustomTextField(
                    controller: emailtController,
                    hintText: 'email address',
                    fieldicon:
                        Icon(Icons.email, color: Color(0XFF939199), size: 15),
                    textfiledColor: Colors.white,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                    ),
                    child: DropdownButton<String>(
                      dropdownColor: Colors.white,
                      hint: Text('select your degree'),
                      isExpanded: true,
                      value: selectedDropValue,
                      items: dropdwonItems.map((String value) {
                        return DropdownMenuItem<String>(
                            value: value, child: Text(value));
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

                  //widget file uplad
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      CustomButton(
                        height: 30,
                        buttonText: 'Save',
                        buttonColor: const Color.fromARGB(255, 64, 153, 67),
                        onpress: () {},
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      CustomButton(
                        height: 30,
                        buttonText: 'Skip',
                        buttonColor: const Color.fromARGB(255, 32, 123, 198),
                        onpress: () {},
                      ),
                    ],
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
}
