// import 'dart:convert';
// import 'dart:io';
// import 'package:azsoon/Core/common-methods.dart';
// import 'package:azsoon/Providers/moreUserInfoProvider.dart';
// import 'package:azsoon/Providers/userInfoProvider.dart';
// import 'package:azsoon/screens/Home.dart';
// import 'package:file_picker/file_picker.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:provider/provider.dart';
// import '../widgets/Button.dart';
// import '../widgets/TextField.dart';
// import '../widgets/Button.dart';
// import 'package:text_area/text_area.dart';
// import 'package:progress_dialog_null_safe/progress_dialog_null_safe.dart';
// import 'package:http/http.dart' as http;
// import '../widgets/App-bar.dart' as appBar;
// import 'package:csc_picker/csc_picker.dart';

// class CreateProfileScreen extends StatefulWidget {
//   const CreateProfileScreen({super.key});

//   @override
//   State<CreateProfileScreen> createState() => _CreateProfileScreenState();
// }

// class _CreateProfileScreenState extends State<CreateProfileScreen> {
//   TextEditingController bioController = TextEditingController();
//   TextEditingController firstNameController = TextEditingController();
//   TextEditingController lastNameController = TextEditingController();
//   TextEditingController emailtController = TextEditingController();
//   TextEditingController phoneController = TextEditingController();
//   TextEditingController workplaceController = TextEditingController();
//   TextEditingController studyInController = TextEditingController();
//   TextEditingController cityController = TextEditingController();
//   TextEditingController dateOfBirsthController = TextEditingController();
//   TextEditingController fileNameController = TextEditingController();

//   TextEditingController firstNameControllerNEW = new TextEditingController();
//   TextEditingController emailControllerNEW = new TextEditingController();
//   TextEditingController lastNameControllerNEW = new TextEditingController();
//   TextEditingController bioControllerNew = new TextEditingController();

//   bool isToggleOn = false;
//   int selectedRadio = 0;
//   String titleVlaueSpeciality = '';
//   String? selectedCountry;
//   String? selectedState;
//   String? selectedCity;

//   List<String> cities = [];

//   var reasonValidation = true;
//   File? selectedBannerImage;
//   File? selectedProfileImage;
//   String? _firstName;
//   String? _lastName;
//   String? _email;
//   String? _phone;
//   String? _address;
//   String? _worksat;
//   String? titleSelectd;
//   String? study_at;

//   String? _bio;
//   List<Certificate>? _certificates = [];
//   final GlobalKey<FormState> globalKey = GlobalKey<FormState>();

//   // String? selectedDropValue;
//   // List<String> dropdwonItems = [
//   //   'dPHD',
//   //   'drPHD',
//   //   'drPH',
//   // ];

//   // @override
//   // void initState() {
//   //   // TODO: implement initState
//   //   firstNameController.text =
//   // }

//   @override
//   Widget build(BuildContext context) {
//     UserProvider userProvider =
//         Provider.of<UserProvider>(context, listen: false);
//     MoreInfoUserProvider moreInfoUserProvider =
//         Provider.of<MoreInfoUserProvider>(context, listen: false);
//     String? image = Provider.of<MoreInfoUserProvider>(context, listen: false)
//         .selectedProfileImage;

//     String? cover = Provider.of<MoreInfoUserProvider>(context, listen: false)
//         .selectedBannnerCover;

//     // String? userFname =
//     //     Provider.of<UserProvider>(context, listen: false).firstname;

//     double screenWidth = MediaQuery.of(context).size.width;
//     double screenHeight = MediaQuery.of(context).size.height;
//     return Scaffold(
//       backgroundColor: const Color.fromARGB(255, 230, 230, 230),
//       appBar: const appBar.AppBarWidget(),
//       body: WillPopScope(
//         onWillPop: () async {
//           if (moreInfoUserProvider.user.profileImage != image ||
//               moreInfoUserProvider.user.cover != cover) {
//             Provider.of<MoreInfoUserProvider>(context, listen: false)
//                 .setSelectedProfileImage(
//                     moreInfoUserProvider.user.profileImage);

//             Provider.of<MoreInfoUserProvider>(context, listen: false)
//                 .setSelectedBannerImage(moreInfoUserProvider.user.cover);

//             return true;
//           }
//           return true;
//         },
//         child: SingleChildScrollView(
//           child: Form(
//             key: globalKey,
//             child: Container(
//               padding: const EdgeInsets.fromLTRB(10, 10, 10, 20),
//               // color: Color.fromARGB(255, 230, 230, 230),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Container(
//                     width: screenWidth,
//                     height: screenHeight / 4,
//                     decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(15),
//                         // color: selectedBannerImage == null ? Colors.grey : null,
//                         image: cover != null && cover.contains('http')
//                             ? DecorationImage(
//                                 image: NetworkImage(cover),
//                                 fit: BoxFit.cover,
//                               )
//                             : cover == null
//                                 ? const DecorationImage(
//                                     image:
//                                         AssetImage('assets/images/drimage.png'),
//                                     fit: BoxFit.cover,
//                                   )
//                                 : DecorationImage(
//                                     image: FileImage(File(cover)),
//                                     fit: BoxFit.cover,
//                                   )),
//                     child: Stack(
//                       children: [
//                         // if (selectedBannerImage == null)
//                         //   const Center(child: Text('Please select an image')),
//                         Positioned(
//                           bottom: 0,
//                           right: 5,
//                           child: Column(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               TextButton(
//                                 onPressed: () async {
//                                   print("clicked====================");
//                                   File? coverFile =
//                                       await picBannerImageFromGallery();

//                                   if (coverFile != null) {
//                                     print(coverFile);
//                                     Provider.of<MoreInfoUserProvider>(context,
//                                             listen: false)
//                                         .setSelectedBannerImage(
//                                       coverFile.path,
//                                     );
//                                   }
//                                 },
//                                 child: const Text(
//                                   'upload image',
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   //basic informaiton
//                   const SizedBox(height: 15),
//                   Container(
//                     padding: const EdgeInsets.all(20),
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.circular(15),
//                     ),
//                     child: Column(children: [
//                       const Align(
//                           alignment: Alignment.bottomLeft,
//                           child: Text(
//                             "Basic Information",
//                             style: TextStyle(
//                                 fontSize: 20,
//                                 fontWeight: FontWeight.bold,
//                                 color: Color.fromARGB(255, 71, 71, 71)),
//                           )),
//                       Container(
//                         // alignment: Alignment.topLeft,
//                         child: Padding(
//                           padding: const EdgeInsets.fromLTRB(0, 20, 0, 7),
//                           child: GestureDetector(
//                             onTap: () async {
//                               File? imageFile =
//                                   await picProfileImageFromGallery();
//                               if (imageFile != null) {
//                                 Provider.of<MoreInfoUserProvider>(context,
//                                         listen: false)
//                                     .setSelectedProfileImage(
//                                   imageFile.path,
//                                 );
//                               }
//                               //open the image for preview and have a button change image gallery and or take one (camera)
//                             },
//                             child: image != null && image.contains('https')
//                                 ? CircleAvatar(
//                                     radius: 75,
//                                     backgroundColor: Colors.grey,
//                                     backgroundImage: NetworkImage(image),
//                                   )
//                                 : image == null
//                                     ? const CircleAvatar(
//                                         radius: 75,
//                                         backgroundColor: Colors.grey,
//                                         backgroundImage: AssetImage(
//                                             'assets/images/drimage.png'),
//                                       )
//                                     : CircleAvatar(
//                                         radius: 75,
//                                         backgroundColor: Colors.grey,
//                                         backgroundImage: FileImage(
//                                           File(image),
//                                         ),
//                                       ),
//                           ),
//                         ),
//                       ),
//                       //radio buttons
//                       const SizedBox(height: 15),
//                       const Align(
//                           alignment: Alignment.topLeft,
//                           child: Text(
//                             'Title',
//                             style: TextStyle(
//                                 fontSize: 17,
//                                 fontWeight: FontWeight.bold,
//                                 color: Color.fromARGB(255, 71, 71, 71)),
//                           )),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                         children: ['Dr.', 'Prof.', 'None']
//                             .map((e) => Expanded(
//                                   child: Padding(
//                                     padding: const EdgeInsets.all(8.0),
//                                     child: GestureDetector(
//                                       onTap: () {
//                                         setState(() {
//                                           titleSelectd = e;
//                                         });
//                                       },
//                                       child: Container(
//                                         decoration: BoxDecoration(
//                                             borderRadius:
//                                                 BorderRadius.circular(10),
//                                             color: e == titleSelectd
//                                                 ? Colors.blue
//                                                 : Colors.transparent,
//                                             border:
//                                                 Border.all(color: Colors.blue)),
//                                         child: Padding(
//                                           padding: const EdgeInsets.all(8.0),
//                                           child: Text(
//                                             e,
//                                             style: TextStyle(
//                                                 color: e == titleSelectd
//                                                     ? Colors.white
//                                                     : Colors.blue,
//                                                 fontSize: 20),
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                 ))
//                             .toList(),
//                       )
//                       // Row(
//                       //   mainAxisAlignment: MainAxisAlignment.start,
//                       //   children: [
//                       //     CustomRadio(
//                       //       label: 'Doctor',
//                       //       value: 1,
//                       //       groupValue: selectedRadio,
//                       //       onChanged: (value) {
//                       //         setState(() {
//                       //           selectedRadio = value as int;
//                       //           titleVlaueSpeciality = 'Dr';
//                       //         });
//                       //       },
//                       //     ),
//                       //     CustomRadio(
//                       //       label: 'Prof',
//                       //       value: 2,
//                       //       groupValue: selectedRadio,
//                       //       onChanged: (value) {
//                       //         setState(() {
//                       //           selectedRadio = value as int;
//                       //           titleVlaueSpeciality = 'Prof';
//                       //         });
//                       //       },
//                       //     ),
//                       //     CustomRadio(
//                       //       label: 'Non',
//                       //       value: 3,
//                       //       groupValue: selectedRadio,
//                       //       onChanged: (value) {
//                       //         setState(() {
//                       //           selectedRadio = value as int;
//                       //           titleVlaueSpeciality = 'Non';
//                       //         });
//                       //       },
//                       //     ),
//                       //   ],
//                       // ),
//                       ,

//                       Column(
//                         children: [
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Expanded(
//                                 child: CustomTextField(
//                                   initialValue: userProvider.user.firstName,
//                                   onSaved: (v) {
//                                     _firstName = v;
//                                   },
//                                   obscureText: false,
//                                   labelText: 'First Name',
//                                   borderColor:
//                                       const Color.fromARGB(255, 176, 176, 176),
//                                   textfiledColor: Colors.white,
//                                   // controller: firstNameControllerNEW,
//                                   hintText: "",
//                                   // intialValue: userProvider.user.firstName,
//                                 ),
//                               ),
//                               const SizedBox(
//                                   width:
//                                       16), // Adjust the spacing between fields
//                               Expanded(
//                                 child: CustomTextField(
//                                   initialValue: userProvider.user.lastName,
//                                   onSaved: (v) {
//                                     _lastName = v;
//                                   },
//                                   obscureText: false,
//                                   labelText: 'Last Name',
//                                   borderColor:
//                                       const Color.fromARGB(255, 176, 176, 176),
//                                   textfiledColor: Colors.white,
//                                   controller: lastNameControllerNEW,
//                                   hintText: "",
//                                   // intialValue: userProvider.user.lastName,
//                                 ),
//                               ),
//                             ],
//                           ),

//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Expanded(
//                                 child: CustomTextField(
//                                   initialValue: userProvider.user.phone,
//                                   onSaved: (v) {
//                                     _phone = v;
//                                   },
//                                   obscureText: false,
//                                   labelText: 'Phone Number',
//                                   borderColor:
//                                       const Color.fromARGB(255, 176, 176, 176),
//                                   textfiledColor: Colors.white,
//                                   controller: phoneController,
//                                   hintText: "",
//                                 ),
//                               ),
//                               const SizedBox(
//                                   width:
//                                       16), // Adjust the spacing between fields
//                               // Expanded(
//                               //   child: CustomTextField(
//                               //     obscureText: false,
//                               //     labelText: 'Date Of Birth',
//                               //     borderColor:
//                               //         const Color.fromARGB(255, 176, 176, 176),
//                               //     textfiledColor: Colors.white,
//                               //     controller: dateOfBirsthController,
//                               //     hintText: "",
//                               //   ),
//                               // ),
//                             ],
//                           ),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Expanded(
//                                 child: CustomTextField(
//                                   initialValue: userProvider.user.address,
//                                   onSaved: (v) {
//                                     _address = v;
//                                   },
//                                   obscureText: false,
//                                   labelText: 'Location',
//                                   borderColor:
//                                       Color.fromARGB(255, 176, 176, 176),
//                                   textfiledColor: Colors.white,
//                                   // controller: phoneController,
//                                   hintText: "",
//                                 ),
//                               ),
// // / Adjust the spacing between fields
//                             ],
//                           ),
//                           /////////////////////////////////////////////////
//                           const SizedBox(height: 16),
//                           // CSCPicker(
//                           //   layout: Layout.vertical,
//                           //   // flagState: CountryFlag.DISABLE,
//                           //   onCountryChanged: (country) {
//                           //     setState(() {
//                           //       selectedCountry = country;
//                           //     });
//                           //   },
//                           //   onStateChanged: (state) {
//                           //     setState(() {
//                           //       selectedState = state;
//                           //     });
//                           //   },
//                           //   onCityChanged: (city) {
//                           //     setState(() {
//                           //       selectedCity = city;
//                           //     });
//                           //   },
//                           //   countryDropdownLabel: "Country",
//                           //   stateDropdownLabel: "State",
//                           //   cityDropdownLabel: "City",
//                           //   //dropdownDialogRadius: 30,
//                           //   //searchBarRadius: 30,
//                           // ),

//                           const SizedBox(height: 16),

//                           // Dropdown for selecting a city based on the selected country

//                           ////////////////////////////
//                           // Container(
//                           //   decoration: BoxDecoration(
//                           //     border: Border.all(
//                           //       color: Color(0xFFCFD6FF),
//                           //     ), // Set the border color here
//                           //     borderRadius: BorderRadius.circular(11.0),
//                           //     color: Colors.white,
//                           //   ),
//                           //   child: DropdownButton<String>(
//                           //     underline: Container(),
//                           //     // itemHeight: 50,
//                           //     iconSize: 35,
//                           //     padding:
//                           //         EdgeInsets.symmetric(vertical: 1, horizontal: 10),
//                           //     hint: Text('specialty'),
//                           //     isExpanded: true,
//                           //     value: selectedDropValue,
//                           //     items: dropdwonItems.map((String value) {
//                           //       return DropdownMenuItem<String>(
//                           //         value: value,
//                           //         child: Text(value),
//                           //       );
//                           //     }).toList(),
//                           //     onChanged: (newvalue) {
//                           //       setState(() {
//                           //         selectedDropValue = newvalue;
//                           //       });
//                           //     },
//                           //   ),
//                           // ),
//                         ],
//                       ),
//                     ]),
//                   ),
//                   const SizedBox(height: 15),
//                   //ABOUT me
//                   Container(
//                     padding: const EdgeInsets.all(20),
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.circular(15),
//                     ),
//                     child: Column(children: [
//                       const Align(
//                           alignment: Alignment.bottomLeft,
//                           child: Text(
//                             "About Me",
//                             style: TextStyle(
//                                 fontSize: 20,
//                                 fontWeight: FontWeight.bold,
//                                 color: Color.fromARGB(255, 71, 71, 71)),
//                           )),
//                       // const SizedBox(
//                       //   height: 5,
//                       // ),
//                       Column(
//                         children: [
//                           const Align(
//                             alignment: Alignment.topLeft,
//                             // child: Text(
//                             //   'Bio',
//                             //   style: TextStyle(
//                             //       fontSize: 17,
//                             //       fontWeight: FontWeight.w500,
//                             //       color: Color.fromARGB(255, 71, 71, 71)),
//                             // ),
//                           ),
//                           // const SizedBox(
//                           //   height: 4,
//                           // ),
//                           CustomTextField(
//                             initialValue: moreInfoUserProvider.user.bio,
//                             maxLines: 3,
//                             onSaved: (v) {
//                               _bio = v;
//                             },
//                             obscureText: false,
//                             labelText: 'Bio',
//                             borderColor:
//                                 const Color.fromARGB(255, 176, 176, 176),
//                             textfiledColor: Colors.white,
//                             controller: workplaceController,
//                             hintText: '',
//                           )
//                         ],
//                       ),
//                       CustomTextField(
//                         initialValue: moreInfoUserProvider.user.placeOfWork,
//                         onSaved: (n) {
//                           _worksat = n;
//                         },
//                         obscureText: false,
//                         labelText: 'Works At',
//                         borderColor: const Color.fromARGB(255, 176, 176, 176),
//                         textfiledColor: Colors.white,
//                         controller: workplaceController,
//                         hintText: '',
//                       ),
//                       CustomTextField(
//                         onSaved: (b) {
//                           study_at = b;
//                         },
//                         obscureText: false,
//                         labelText: 'Study In',
//                         borderColor: const Color.fromARGB(255, 176, 176, 176),
//                         controller: studyInController,
//                         hintText: '',
//                         textfiledColor: Colors.white,
//                       ),
//                     ]),
//                   ),
//                   const SizedBox(height: 15),
//                   //security
//                   Container(
//                     padding: const EdgeInsets.all(20),
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.circular(15),
//                     ),
//                     child: Column(children: [
//                       const Align(
//                           alignment: Alignment.bottomLeft,
//                           child: Text(
//                             "Security",
//                             style: TextStyle(
//                                 fontSize: 20,
//                                 fontWeight: FontWeight.bold,
//                                 color: Color.fromARGB(255, 71, 71, 71)),
//                           )),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Expanded(
//                             child: CustomTextField(
//                               obscureText: false,
//                               labelText: 'Change Passowrd',
//                               borderColor: Color.fromARGB(255, 176, 176, 176),
//                               textfiledColor: Colors.white,
//                               // controller:  ,
//                               hintText: "Old Passowrd",
//                             ),
//                           ),
//                           SizedBox(width: 16),
//                           Expanded(
//                             child: CustomTextField(
//                               obscureText: false,
//                               labelText: '',
//                               borderColor: Color.fromARGB(255, 176, 176, 176),
//                               textfiledColor: Colors.white,
//                               // controller:  ,
//                               hintText: "New Password",
//                             ),
//                           ),
//                         ],
//                       ),
//                       CustomTextField(
//                         obscureText: false,
//                         labelText: 'My Email',
//                         borderColor: const Color.fromARGB(255, 176, 176, 176),
//                         controller: emailControllerNEW,
//                         hintText: '',
//                         textfiledColor: Colors.white,
//                       ),
//                     ]),
//                   ),
//                   const SizedBox(height: 15),
//                   //my certificate
//                   // Container(
//                   //   width: screenWidth,
//                   //   padding: const EdgeInsets.all(20),
//                   //   decoration: BoxDecoration(
//                   //     color: Colors.white,
//                   //     borderRadius: BorderRadius.circular(15),
//                   //   ),
//                   //   child: Column(children: [
//                   //     const Align(
//                   //         alignment: Alignment.bottomLeft,
//                   //         child: Text(
//                   //           "My Certificate",
//                   //           style: TextStyle(
//                   //               fontSize: 20,
//                   //               fontWeight: FontWeight.bold,
//                   //               color: Color.fromARGB(255, 71, 71, 71)),
//                   //         )),
//                   //     const SizedBox(
//                   //       height: 20,
//                   //     ),
//                   //     Container(
//                   //       height: screenHeight * 0.1,
//                   //       child: ListView.builder(
//                   //         itemCount: _certificates!.length,
//                   //         itemBuilder: (context, index) {
//                   //           Certificate certificate = _certificates![index];

//                   //           return ListTile(
//                   //             trailing: TextButton(
//                   //               onPressed: () {
//                   //                 // Add logic to remove the certificate.
//                   //               },
//                   //               child: const Text('remove'),
//                   //             ),
//                   //             leading: const Icon(Icons.file_copy),
//                   //             title: Text(certificate.title),
//                   //             subtitle: Text(
//                   //                 certificate.file?.files.single.name ?? ''),
//                   //           );
//                   //         },
//                   //       ),
//                   //     ),
//                   //     const SizedBox(height: 16),
//                   //     CustomButton(
//                   //       buttonColor: Colors.white,
//                   //       textColor: const Color(0XFF2F7EDB),
//                   //       buttonText: 'Add Certificate',
//                   //       height: 35,
//                   //       onpress: () {
//                   //         showModalBottomSheet(
//                   //             isScrollControlled: true,
//                   //             shape: const RoundedRectangleBorder(
//                   //                 borderRadius: BorderRadius.vertical(
//                   //                     top: Radius.circular(20))),
//                   //             context: context,
//                   //             builder: (BuildContext context) {
//                   //               String fileName = "";
//                   //               return Container(
//                   //                 padding:
//                   //                     const EdgeInsets.fromLTRB(10, 0, 10, 5),
//                   //                 child: Padding(
//                   //                   padding: EdgeInsets.only(
//                   //                       bottom: MediaQuery.of(context)
//                   //                           .viewInsets
//                   //                           .bottom),
//                   //                   child: Wrap(
//                   //                     children: [
//                   //                       CustomTextField(
//                   //                         obscureText: false,
//                   //                         labelText: '',
//                   //                         borderColor: const Color(0xFFCFD6FF),
//                   //                         controller: fileNameController,
//                   //                         hintText: 'file name',
//                   //                         textfiledColor: Colors.white,
//                   //                       ),
//                   //                       Row(
//                   //                         children: [
//                   //                           Align(
//                   //                             alignment: Alignment.bottomRight,
//                   //                             child: CustomButton(
//                   //                               buttonColor:
//                   //                                   const Color(0XFF2F7EDB),
//                   //                               buttonText: 'Add',
//                   //                               height: 30,
//                   //                               onpress: () async {
//                   //                                 FilePickerResult? result =
//                   //                                     await _pickFiles();
//                   //                                 if (result != null) {
//                   //                                   setState(() {
//                   //                                     String fileName =
//                   //                                         fileNameController
//                   //                                             .text;
//                   //                                     _certificates!
//                   //                                         .add(Certificate(
//                   //                                       title: fileName,
//                   //                                       file: result,
//                   //                                     ));
//                   //                                   });
//                   //                                   fileNameController.clear();
//                   //                                   Navigator.pop(
//                   //                                       context); // Close the bottom sheet
//                   //                                 }
//                   //                               },
//                   //                             ),
//                   //                           ),
//                   //                           const SizedBox(width: 10),
//                   //                           // Align(
//                   //                           //   alignment: Alignment.bottomLeft,
//                   //                           //   child: CustomButton(
//                   //                           //     buttonColor: Colors.white,
//                   //                           //     textColor: Color(0XFF2F7EDB),
//                   //                           //     buttonText: 'choose file',
//                   //                           //     height: 30,
//                   //                           //     onpress: _pickFiles,
//                   //                           //   ),
//                   //                           // ),
//                   //                         ],
//                   //                       ),
//                   //                     ],
//                   //                   ),
//                   //                 ),
//                   //               );
//                   //             });
//                   //       },
//                   //     ),
//                   //   ]),
//                   // ),
//                   const SizedBox(height: 15),
//                   Align(
//                     alignment: Alignment.bottomRight,
//                     child: CustomButton(
//                       buttonColor: const Color(0XFF2F7EDB),
//                       buttonText: 'Update My Information',
//                       height: 40,
//                       onpress: () async {
//                         globalKey.currentState!.save();

//                         await createProfile(
//                             _bio,
//                             selectedProfileImage,
//                             workplaceController.text,
//                             titleVlaueSpeciality,
//                             selectedBannerImage,
//                             _firstName,
//                             _lastName,
//                             emailtController.text,
//                             _phone,
//                             _address);
//                         String? authToken = await CommonMethods.getAuthToken();
//                         // After updating the profile, refresh the user information
//                         await userProvider.refreshUser(authToken!);
//                         await moreInfoUserProvider
//                             .refreshMoreInfoUser(authToken);
//                       },
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Future picBannerImageFromCamera() async {
//     final returnedImage =
//         await ImagePicker().pickImage(source: ImageSource.camera);
//     if (returnedImage == null) return;
//     setState(() {
//       selectedBannerImage = File(returnedImage!.path);
//     });
//   }

//   Future<File?> picBannerImageFromGallery() async {
//     final returnedBannerImage =
//         await ImagePicker().pickImage(source: ImageSource.gallery);

//     if (returnedBannerImage == null) return null;
//     setState(() {
//       selectedBannerImage = File(returnedBannerImage!.path);
//     });
//     return selectedBannerImage;
//   }

//   Future<File?>? picProfileImageFromGallery() async {
//     final returnedProfileImage =
//         await ImagePicker().pickImage(source: ImageSource.gallery);

//     if (returnedProfileImage == null) return null;
//     setState(() {
//       selectedProfileImage = File(returnedProfileImage!.path);
//     });
//     return selectedProfileImage;
//   }

//   Future picProfileImageFromCamera() async {
//     final returnedProfileImage =
//         await ImagePicker().pickImage(source: ImageSource.camera);
//     if (returnedProfileImage == null) return;
//     setState(() {
//       selectedProfileImage = File(returnedProfileImage!.path);
//     });
//   }

//   Future<FilePickerResult?> _pickFiles() async {
//     try {
//       FilePickerResult? result = await FilePicker.platform.pickFiles(
//         type: FileType.custom,
//         allowedExtensions: ['pdf'],
//         withData: true,
//         allowMultiple: true,
//       );

//       return result;
//     } catch (e) {
//       print('Error picking files: $e');
//       return null;
//     }
//   }

//   Future<void> createProfile(
//       String? bio,
//       File? profileImage,
//       String? placeOfWork,
//       String? specialty,
//       File? banner,
//       String? firstName,
//       String? lastName,
//       String? email,
//       String? phone,
//       String? address) async {
//     print({
//       bio,
//       profileImage,
//       banner,
//       specialty,
//       placeOfWork,
//       firstName,
//       lastName,
//       email,
//       phone,
//       address
//     });
//     ProgressDialog pr = new ProgressDialog(context,
//         type: ProgressDialogType.normal, isDismissible: false, showLogs: true);

//     String? authToken = await CommonMethods.getAuthToken();
//     print("=============================${authToken}");

//     pr.show();
//     var request = http.MultipartRequest(
//         'PATCH', Uri.parse('https://orthoschools.com/profile/update/'));

//     // text fields
//     request.fields['bio'] = bio ?? "";
//     request.fields['place_of_work'] = placeOfWork ?? "";
//     request.fields['speciality'] = specialty ?? ""; //radio butoon value string
//     request.fields['first_name'] = firstName ?? "";
//     request.fields['last_name'] = lastName ?? "";
//     request.fields['email'] = email ?? "";
//     request.fields['phone'] = phone ?? "";
//     request.fields['address'] = address ?? "";

//     // file fields
//     if (profileImage != null) {
//       request.files.add(http.MultipartFile(
//           'profileImage',
//           http.ByteStream(Stream.castFrom(profileImage.openRead())),
//           await profileImage.length(),
//           filename: 'profileImage.jpg'));
//     }
//     if (banner != null) {
//       request.files.add(http.MultipartFile(
//           'cover',
//           http.ByteStream(Stream.castFrom(banner.openRead())),
//           await banner.length(),
//           filename: 'cover.jpg'));
//     }

//     //auth header
//     request.headers['Authorization'] = 'Token $authToken';

//     // request.headers['Content-Type'] = 'application/json';

//     //here i am sending the request
//     var response = await request.send();

//     if (response.statusCode == 200) {
//       print("=============================${response.statusCode}");
//       pr.hide();
//       //printing response
//       print(await response.stream.bytesToString());
//       ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
//           backgroundColor: Colors.green,
//           content: Text("Profile was updated successfully")));
//       //go to home after done
//       // Navigator.of(context).pushAndRemoveUntil(
//       //   MaterialPageRoute(builder: (context) => const HomeScreen()),
//       //   //show snackkbar info updted succfuly
//       //   (route) => false,
//       // );
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
//           backgroundColor: Colors.red,
//           content: Text("Something went wrong, try again later")));
//       print("=============================${response.statusCode}");
//       pr.hide();
//       print(
//           "==========================================${response.reasonPhrase}======================");
//     }
//   }
// }

// class CustomRadio extends StatelessWidget {
//   final String label;
//   final int value;
//   final int groupValue;
//   final ValueChanged<int>? onChanged;

//   const CustomRadio({
//     required this.label,
//     required this.value,
//     required this.groupValue,
//     required this.onChanged,
//   });

//   @override
//   Widget build(BuildContext context) {
//     UserProvider userProvider = Provider.of<UserProvider>(context);
//     MoreInfoUserProvider moreInfoUserProvider =
//         Provider.of<MoreInfoUserProvider>(context);
//     return InkWell(
//       onTap: () {
//         onChanged?.call(value);
//       },
//       child: Container(
//         margin: const EdgeInsets.fromLTRB(0, 10, 10, 15),
//         padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
//         decoration: BoxDecoration(
//           color: groupValue == value ? Colors.blue : Colors.transparent,
//           borderRadius: BorderRadius.circular(8.0),
//           border: Border.all(
//             color: groupValue == value
//                 ? Colors.blue
//                 : const Color.fromARGB(255, 176, 176, 176),
//           ),
//         ),
//         child: Text(
//           label,
//           style: TextStyle(
//             color: groupValue == value ? Colors.white : Colors.black,
//           ),
//         ),
//       ),
//     );
//   }
// }

// class Certificate {
//   final String title;
//   final FilePickerResult? file;

//   Certificate({
//     required this.title,
//     required this.file,
//   });
// }
