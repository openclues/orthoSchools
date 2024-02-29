import 'package:azsoon/Core/colors.dart';
import 'package:azsoon/Core/network/request_helper.dart';
import 'package:azsoon/features/profile/bloc/profile_bloc.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:iconly/iconly.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../Core/snacbars/success_snacbar.dart';

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

  bool? loadingCardId = false;

  bool? loadingCertificate;

  bool? loadingSelfie;

  // loadProfileData() {}

  @override
  Widget build(BuildContext context) {
    // loadProfileData();

    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        if (state is ProfileInitial) {
          // context.read<ProfileBloc>().add(const LoadMyProfile());
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is ProfileLoaded) {
          isReadyForVerification() {
            if (state.profileModel.cardId == null ||
                state.profileModel.selfie == null ||
                state.profileModel.certificates == null ||
                state.profileModel.certificates!.isEmpty) {
              return false;
            } else {
              return true;
            }
          }

          return Scaffold(
              bottomNavigationBar: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        isReadyForVerification() ? primaryColor : Colors.grey,
                    // primary: Colors.blue,
                    // onPrimary: Colors.white,
                    shape: const RoundedRectangleBorder(
                        // borderRadius: BorderRadius.circular(32.0),
                        ),
                  ),
                  onPressed: () async {
                    if (!isReadyForVerification()) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text('Please upload all files')));
                      return;
                    } else {
                      var response = await RequestHelper.post(
                          'send/verification/request', {});

                      if (response.statusCode == 200) {
                        // context.read<ProfileBloc>().add(const LoadMyProfile());
                        SnackBarWidget.buildSnacBarSuccess(
                            'Verification Request Was Sent', context);
                        Navigator.pushNamed(context, '/');
                        // Navigator.pop(context);
                        // Navigator.pop(context);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Error')));
                      }
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: state.profileModel.verifiedProRequest != null &&
                            state.profileModel.verifiedProRequest!.status! ==
                                "pending"
                        ? const Text("You already have a pending request")
                        : const Text('Send Verification Request',
                            style:
                                TextStyle(fontSize: 16.0, color: Colors.white)),
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
                          child: Image.asset(
                              'assets/images/verified-account.png',
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
                    subtitle: Text(
                        'Get your own space to write and share your thoughts'),
                    title: Text('Create your own blog',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    trailing: Icon(FontAwesomeIcons.blog,
                        size: 25, color: primaryColor),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text(
                      'Information you provide will be used to verify your account:',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16.0),
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
                                '${state.profileModel.user!.firstName} ${state.profileModel.user!.lastName}'),
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
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Row(
                      children: [
                        const SizedBox(
                          width: 8.0,
                        ),
                        const Text('Speciality: ',
                            style: TextStyle(fontWeight: FontWeight.w500)),
                        Text('${state.profileModel.speciality}'),
                        const Spacer(),
                        const Icon(Icons.check_circle_outline,
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
                        style: TextStyle(
                            fontSize: 16.0, fontWeight: FontWeight.bold)),
                  ),
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
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
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20.0, vertical: 20),
                            child: Row(
                              children: [
                                const SizedBox(
                                  width: 8.0,
                                ),
                                const Text('Card ID: ',
                                    style:
                                        TextStyle(fontWeight: FontWeight.w500)),
                                if (state.profileModel.cardId != null)
                                  Expanded(
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => Scaffold(
                                                      appBar: AppBar(),
                                                      body: Image.network(state
                                                          .profileModel
                                                          .cardId!),
                                                    )));
                                      },
                                      child: Text(
                                        state.profileModel.cardId!
                                            .split('/')
                                            .last,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                            color: Colors.green),
                                      ),
                                    ),
                                  ),
                                state.profileModel.cardId != null
                                    ? Expanded(
                                        child: Text(
                                          state.profileModel.cardId!
                                              .split('/')
                                              .last,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                              color: Colors.green),
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
                                      XFile? file =
                                          await pickFile(ImageSource.gallery);
                                      if (file != null) {
                                        print(file.path);
                                        if (context.mounted) {
                                          setState(() {
                                            loadingCardId = true;
                                          });
                                          var response =
                                              await RequestHelper.post(
                                                  'user/cardid/', {},
                                                  files: [file],
                                                  filesKey: 'cardId');
                                          setState(() {
                                            loadingCardId = false;
                                          });

                                          // print(response.body);
                                          if (response.statusCode == 200) {
                                            // context
                                            //     .read<ProfileBloc>()
                                            //     .add(const LoadMyProfile());
                                          }
                                        }
                                      }
                                    },
                                    child: loadingCardId == false
                                        ? Icon(
                                            cardId != null
                                                ? IconlyBold.delete
                                                : IconlyLight.upload,
                                            color: primaryColor,
                                            size: 28)
                                        : const CircularProgressIndicator()),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 8.0,
                      ),
                      loadingCardId == true
                          ? const Center(
                              child: LinearProgressIndicator(
                                color: primaryColor,
                              ),
                            )
                          : const SizedBox(),
                      //show loading indicator
                    ],
                  ),
                  // const SizedBox(
                  //   height: 8.0,
                  // ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
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
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Row(
                              children: [
                                const SizedBox(
                                  width: 8.0,
                                ),
                                const Text('Certificate: ',
                                    style:
                                        TextStyle(fontWeight: FontWeight.w500)),
                                if (state.profileModel.certificates!.isEmpty)
                                  const Text('Not Uplodad',
                                      style: TextStyle(color: Colors.red)),
                                const Spacer(),
                                GestureDetector(
                                    onTap: () async {
                                      //UPLOAD CERTIFICATE

                                      XFile? file =
                                          await pickFile(ImageSource.gallery);
                                      if (file != null) {
                                        if (context.mounted) {
                                          setState(() {
                                            loadingCertificate = true;
                                          });
                                          var response =
                                              await RequestHelper.post(
                                                  'user/certficate/', {},
                                                  files: [file],
                                                  filesKey: 'certificate');

                                          print(response.body);
                                          setState(() {
                                            loadingCertificate = false;
                                          });

                                          // print(response.body);
                                          if (response.statusCode == 200) {
                                            // context
                                            //     .read<ProfileBloc>()
                                            //     .add(const LoadMyProfile());
                                          }
                                        }
                                      }
                                    },
                                    child: const Icon(IconlyLight.upload,
                                        color: primaryColor, size: 28)),
                              ],
                            ),
                          ),
                          if (state.profileModel.certificates!.isNotEmpty)
                            ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount:
                                  state.profileModel.certificates!.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Container(
                                  padding: const EdgeInsets.all(16.0),
                                  decoration: BoxDecoration(
                                    border: Border(
                                        bottom: BorderSide(
                                            color: Colors.grey.shade300)),
                                  ),
                                  child: Row(
                                    children: [
                                      IconButton(
                                          onPressed: () {},
                                          icon: const Icon(
                                              FontAwesomeIcons.graduationCap)),
                                      const SizedBox(
                                        width: 8.0,
                                      ),
                                      Text(
                                          state.profileModel
                                              .certificates![index].title!,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis),

                                      //REMOVE
                                      const Spacer(),
                                      GestureDetector(
                                          onTap: () async {
                                            //UPLOAD CERTIFICATE
                                            setState(() {
                                              loadingCertificate = true;
                                            });
                                            var response =
                                                await RequestHelper.post(
                                              'remove/certificate/',
                                              {
                                                "certificate_id": state
                                                    .profileModel
                                                    .certificates![index]
                                                    .id
                                              },
                                            );

                                            setState(() {
                                              loadingCertificate = false;
                                            });

                                            // print(response.body);
                                            if (response.statusCode == 200) {
                                              // context
                                              //     .read<ProfileBloc>()
                                              //     .add(const LoadMyProfile());
                                            }
                                          },
                                          child: const Icon(IconlyLight.delete,
                                              color: Colors.red, size: 28)),
                                    ],
                                  ),
                                );
                              },
                            ),
                          if (loadingCertificate == true)
                            const Center(
                              child: LinearProgressIndicator(
                                color: primaryColor,
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  Container(
                    margin: const EdgeInsets.all(8.0),
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
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            children: [
                              const SizedBox(
                                width: 8.0,
                              ),
                              const Text('Selfi: ',
                                  style:
                                      TextStyle(fontWeight: FontWeight.w500)),
                              state.profileModel.selfie == null
                                  ? const Text('Not Uplodad',
                                      style: TextStyle(color: Colors.red))
                                  : Expanded(
                                      child: GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      Scaffold(
                                                        appBar: AppBar(),
                                                        body: Image.network(
                                                            state.profileModel
                                                                .selfie!),
                                                      )));
                                        },
                                        child: Text(
                                          state.profileModel.selfie!
                                              .split('/')
                                              .last,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                            color: Colors.green,
                                          ),
                                        ),
                                      ),
                                    ),
                              const Spacer(),
                              if (state.profileModel.selfie == null)
                                GestureDetector(
                                    onTap: () async {
                                      //UPLOAD SELFIE

                                      XFile? file =
                                          await pickFile(ImageSource.gallery);
                                      if (file != null) {
                                        if (context.mounted) {
                                          setState(() {
                                            loadingSelfie = true;
                                          });
                                          var response =
                                              await RequestHelper.post(
                                                  'user/selfie/', {},
                                                  files: [file],
                                                  filesKey: 'selfie');

                                          print(response.body);
                                          setState(() {
                                            loadingSelfie = false;
                                          });

                                          // print(response.body);
                                          if (response.statusCode == 200) {
                                            context
                                                .read<ProfileBloc>()
                                                .add(const LoadMyProfile());
                                          }
                                        }
                                      }
                                    },
                                    child: const Icon(IconlyLight.upload,
                                        color: primaryColor, size: 28)),
                              if (state.profileModel.selfie != null)
                                IconButton(
                                    onPressed: () async {
                                      setState(() {
                                        loadingSelfie = true;
                                      });
                                      var response = await RequestHelper.post(
                                        'remove/selfie/',
                                        {},
                                      );
                                      setState(() {
                                        loadingSelfie = false;
                                      });
                                      if (response.statusCode == 200) {
                                        // context
                                        //     .read<ProfileBloc>()
                                        //     .add(const LoadMyProfile());
                                      }
                                    },
                                    icon: const Icon(IconlyBold.delete,
                                        color: Colors.red, size: 28)),
                            ],
                          ),
                        ),
                        if (loadingSelfie == true)
                          const Center(
                            child: LinearProgressIndicator(
                              color: primaryColor,
                            ),
                          ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                ],
              ));
        } else {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }
}

Future<XFile?> pickFile(ImageSource gallery) async {
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
  return null;
}
