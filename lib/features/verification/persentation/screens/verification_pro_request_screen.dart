import 'package:azsoon/Core/colors.dart';
import 'package:azsoon/features/loading/bloc/bloc/loading_bloc_bloc.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:iconly/iconly.dart';
import 'package:image_picker/image_picker.dart';

import '../../../profile/data/my_profile_model.dart';
import '../../bloc/verification_bloc.dart';

class VerificationProRequestScreen extends StatefulWidget {
  static const routeName = '/verificationProRequestScreen';
  const VerificationProRequestScreen({super.key});

  @override
  State<VerificationProRequestScreen> createState() =>
      _VerificationProRequestScreenState();
}

class _VerificationProRequestScreenState
    extends State<VerificationProRequestScreen> {
  XFile? cardId;
  XFile? speciality;

  loadProfileData() {
    if (context.read<VerificationBloc>().state is VerificationLoaded) {
      return;
    } else {
      context.read<VerificationBloc>().add(const LoadProfileData());
    }
  }

  @override
  Widget build(BuildContext context) {
    loadProfileData();

    var verificationState = context.watch<VerificationBloc>().state;
    if (verificationState is VerificationLoaded) {
      var profile = verificationState.profile;
      return Scaffold(
          bottomNavigationBar: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryColor,
                // primary: Colors.blue,
                // onPrimary: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(32.0),
                ),
              ),
              onPressed: () {},
              child: const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text('Send Verification Request',
                    style: TextStyle(fontSize: 16.0, color: Colors.white)),
              )),
          appBar: AppBar(
            title: const Text('Verification Pro'),
          ),
          body: ListView(
            children: [
              ListTile(
                title: Row(
                  children: [
                    const Text('Verification Pro'),
                    const SizedBox(
                      width: 8.0,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                        boxShadow: const [
                          BoxShadow(
                              color: Colors.grey,
                              offset: Offset(0, 0.5),
                              blurRadius: 1)
                        ],
                      ),
                      child: Image.asset('assets/images/verified-account.png',
                          height: 25),
                    ),
                  ],
                ),
                subtitle: const Text('Get verified as a professional'),
              ),
              ListTile(
                subtitle: const Text(
                    'Get a special badge to give your profile a professional look'),
                horizontalTitleGap: 0,
                title: const Text('Get your special badge',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                trailing: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                    boxShadow: const [
                      BoxShadow(
                          color: Colors.grey,
                          offset: Offset(0, 0.5),
                          blurRadius: 1)
                    ],
                  ),
                  child: Image.asset('assets/images/verified-account.png',
                      height: 25),
                ),
              ),
              const ListTile(
                subtitle:
                    Text('Get your own space to write and share your thoughts'),
                title: Text('Create your own blog',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                trailing:
                    Icon(FontAwesomeIcons.blog, size: 25, color: primaryColor),
              ),
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  'Information you provide will be used to verify your account:',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        const SizedBox(
                          width: 8.0,
                        ),
                        const Text('Name: ',
                            style: TextStyle(fontWeight: FontWeight.w500)),
                        Text(
                            '${profile.user!.firstName} ${profile.user!.lastName}'),
                        const Spacer(),
                        const Icon(Icons.info_outline,
                            color: primaryColor, size: 28),
                      ],
                    ),

                    //upload card id
                  ],
                ),
              ),
              const SizedBox(
                height: 8.0,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  children: [
                    SizedBox(
                      width: 8.0,
                    ),
                    Text('Speciality: ',
                        style: TextStyle(fontWeight: FontWeight.w500)),
                    Text('Dentist'),
                    Spacer(),
                    Icon(Icons.check_circle_outline,
                        color: primaryColor, size: 28),
                  ],
                ),
              ),
              const SizedBox(
                height: 16.0,
              ),
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text("Files To Upload:",
                    style:
                        TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
              ),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Row(
                      children: [
                        const SizedBox(
                          width: 8.0,
                        ),
                        const Text('Card ID: ',
                            style: TextStyle(fontWeight: FontWeight.w500)),
                        if (profile.cardId != null)
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Scaffold(
                                              appBar: AppBar(),
                                              body: Container(
                                                  // height: 300,
                                                  // width: 300,
                                                  child: Image.network(
                                                      profile.cardId!)),
                                            )));
                              },
                              child: Text(
                                profile.cardId!.split('/').last,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(color: Colors.green),
                              ),
                            ),
                          ),
                        cardId != null
                            ? Expanded(
                                child: Text(
                                  cardId!.path.split('/').last,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(color: Colors.green),
                                ),
                              )
                            : const Text('Not Uplodad',
                                style: TextStyle(color: Colors.red)),
                        const Spacer(),
                        GestureDetector(
                            onTap: () async {
                              if (cardId != null) {
                                setState(() {
                                  cardId = null;
                                });

                                return;
                              }
                              XFile? file = await pickFile();
                              if (file != null) {
                                if (context.mounted) {
                                  context
                                      .read<VerificationBloc>()
                                      .add(UpdateProfileEvent(
                                        cardId: file,
                                      ));
                                }
                              }

                              //pick file
                            },
                            child: Icon(
                                cardId != null
                                    ? IconlyBold.delete
                                    : IconlyLight.upload,
                                color: primaryColor,
                                size: 28)),
                      ],
                    ),
                  ),
                  //show loading indicator
                ],
              ),
              const SizedBox(
                height: 8.0,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  children: [
                    SizedBox(
                      width: 8.0,
                    ),
                    Text('Certificate: ',
                        style: TextStyle(fontWeight: FontWeight.w500)),
                    Text('Not Uplodad', style: TextStyle(color: Colors.red)),
                    Spacer(),
                    Icon(IconlyLight.upload, color: primaryColor, size: 28),
                  ],
                ),
              ),
              const SizedBox(
                height: 8.0,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  children: [
                    SizedBox(
                      width: 8.0,
                    ),
                    Text('Selfi: ',
                        style: TextStyle(fontWeight: FontWeight.w500)),
                    Text('Not Uplodad', style: TextStyle(color: Colors.red)),
                    Spacer(),
                    Icon(IconlyLight.upload, color: primaryColor, size: 28),
                  ],
                ),
              ),
            ],
          ));
    } else {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
  }

  Future<XFile?> pickFile() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles();

      if (result != null) {
        // File picked successfully
        XFile file = XFile(result.files.single.path!);
        return file;
        // Do something with the picked file, e.g., upload it to a server
      } else {
        // User canceled the file picking
        print('File picking canceled.');
      }
    } catch (e) {
      // Handle exceptions if any
      print('Error picking file: $e');
    }
  }
}
