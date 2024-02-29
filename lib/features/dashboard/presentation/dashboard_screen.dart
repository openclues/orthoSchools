import 'dart:convert';

import 'package:azsoon/Core/colors.dart';
import 'package:azsoon/Core/network/request_helper.dart';
import 'package:azsoon/features/profile/bloc/profile_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../profile/data/my_profile_model.dart';

class DashBoardScreen extends StatefulWidget {
  static const routeName = '/dashboard';
  const DashBoardScreen({super.key});

  @override
  State<DashBoardScreen> createState() => _DashBoardScreenState();
}

List<String> groupsContainers = [
  "Users",
  "Spaces",
  "Blogs",
  "Articles",
  "Posts",
  "Categories",
];

List<VerifiedProRequest> verifiedProRequests = [];

// Future<
_getVerificationRequests() async {
  var response = await RequestHelper.get('verificationsRequests/');
  if (response.statusCode == 200) {
    var decodedData = jsonDecode(utf8.decode(response.bodyBytes));
    // setState(() {
    verifiedProRequests = decodedData
        .map<VerifiedProRequest>((e) => VerifiedProRequest.fromJson(e))
        .toList();
    // });
    return verifiedProRequests;
  }
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: primaryColor,
          actions: [
            IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed('/notifications');
              },
              icon: const Icon(Icons.notifications_active_outlined,
                  size: 30, color: Colors.white),
            )
          ],
          title: const Text('Dashboard', style: TextStyle(color: Colors.white)),
        ),
        body: BlocBuilder<ProfileBloc, ProfileState>(
          builder: (context, state) {
            if (state is ProfileLoaded) {
              if (state.profileModel.user!.groups!.isNotEmpty) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView(
                    children: [
                      FutureBuilder(
                        future: _getVerificationRequests(),
                        // initialData: InitialData,
                        builder:
                            (BuildContext context, AsyncSnapshot snapshot) {
                          return Card(
                            child: ListTile(
                              onTap: () {
                                Navigator.of(context)
                                    .push(MaterialPageRoute(builder: (context) {
                                  return VerificationRequestListScreenAdmin(
                                      verifiedProRequests: verifiedProRequests);
                                }));
                              },
                              title: const Text('Verification Requests'),
                              trailing: Text(
                                  verifiedProRequests.length.toString() ?? ''),
                            ),
                          );
                        },
                      ),
                      GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 10,
                                  mainAxisSpacing: 10,
                                  childAspectRatio: 1.5),
                          itemCount: groupsContainers.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                if (groupsContainers[index] == "Users") {
                                  Navigator.of(context).pushNamed('/users');
                                }
                              },
                              child: Card(
                                elevation: 5,
                                child: Center(
                                  child: Text(groupsContainers[index]),
                                ),
                              ),
                            );
                          })
                    ],
                  ),
                );
              } else {
                return const Center(
                  child: Text('You are not authorized to view this page'),
                );
              }
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ));
  }
}

class UsersScreen extends StatefulWidget {
  static const routeName = '/users';
  const UsersScreen({super.key});

  @override
  State<UsersScreen> createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {
  List<Profile> users = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: primaryColor,
          title: const Text('Users', style: TextStyle(color: Colors.white)),
        ),
        body: ListView(
          children: [
            //search bar

            Container(
              padding: const EdgeInsets.all(10),
              child: TextFormField(
                onChanged: (v) async {
                  var response =
                      await RequestHelper.get('manage/users/?search=$v');
                  if (response.statusCode == 200) {
                    var decodedData =
                        jsonDecode(utf8.decode(response.bodyBytes));
                    setState(() {
                      users = decodedData
                          .map<Profile>((e) => Profile.fromJson(e))
                          .toList();
                    });
                  }
                },
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(10),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                  // labelText: 'Search',
                  hintText: 'Search',
                ),
              ),
            ),

            //users list
            ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: users.length,
                itemBuilder: (context, index) {
                  return UserCard(user: users[index]);
                })
          ],
        ));
  }
}

class UserCard extends StatelessWidget {
  final Profile user;
  const UserCard({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListTile(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => ProfileCheckPage(profile: user)));
          },
          title: Text(
              "${user.user!.firstName ?? ''} ${user.user!.lastName! ?? ''}"),
          leading: CircleAvatar(
            backgroundImage: NetworkImage(user.profileImage ??
                'https://www.google.com/images/branding/googlelogo/1x/googlelogo_color_272x92dp.png'),
          ),
          subtitle: Text("${user.user!.email}"),
        ),
      ),
    );
  }
}

class ProfileCheckPage extends StatefulWidget {
  static const routeName = '/profile-check';
  final Profile profile;
  final int? verificationId;
  final bool? verificationRequest;
  const ProfileCheckPage(
      {super.key,
      required this.profile,
      this.verificationRequest,
      this.verificationId});

  @override
  State<ProfileCheckPage> createState() => _ProfileCheckPageState();
}

List<String> tabs = [
  'certificates',
  'comments',
  'likes',
  'followers',
  'following',
  'posts',
  'spaces',
];

class _ProfileCheckPageState extends State<ProfileCheckPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: widget.verificationRequest == true
          ? Row(
              children: [
                ElevatedButton(
                  onPressed: () async {
                    var response = await RequestHelper.post(
                        'verificationRequest/interact/', {
                      'request_id': widget.verificationId,
                      'status': 'approved'
                    });
                    print(response.body);
                    // if (response.statusCode == 201) {
                    //   Navigator.of(context).pop();
                    // }
                  },
                  child: const Text('Approve'),
                ),
                ElevatedButton(
                  onPressed: () async {
                    var response = await RequestHelper.post(
                      'verificationRequest/interact/', {
                      'request_id': widget.verificationId,
                      'status': 'rejected'
                    });
                    print(response.body);

                    if (response.statusCode == 201) {
                      Navigator.of(context).pop();
                    }
                  },
                  child: const Text('Reject'),
                )
              ],
            )
          : null,
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: const Text('Profile', style: TextStyle(color: Colors.white)),
      ),
      body: ListView(
        padding: const EdgeInsets.all(10),
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    children: [
                      CircleAvatar(
                        backgroundImage: NetworkImage(widget
                                .profile.profileImage ??
                            'https://www.google.com/images/branding/googlelogo/1x/googlelogo_color_272x92dp.png'),
                        radius: 50,
                      ),
                      const SizedBox(height: 10),
                      Text(
                          "${widget.profile.user!.firstName ?? ''} ${widget.profile.user!.lastName! ?? ''}"),
                      const SizedBox(height: 10),
                      Text("${widget.profile.user!.email}"),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                          "Verified pro: ${widget.profile.user!.isVerifiedPro}"),
                      Text(
                          "Verified pro: ${widget.profile.user!.isVerifiedPro}"),
                    ],
                  ),
                )
              ],
            ),
          ),
          //expandable List

          const SizedBox(height: 10),
          Container(
            height: MediaQuery.of(context).size.height * 0.06,
            child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemCount: tabs.length,
                // itemCount: widget.profile.certificates!.length,
                itemBuilder: (context, index) {
                  return Container(
                    // width: ,
                    // height: 60,
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(tabs[index]),
                      ),
                    ),
                  );
                }),
          )
        ],
      ),
    );
  }
}

class VerificationRequestListScreenAdmin extends StatefulWidget {
  List<VerifiedProRequest> verifiedProRequests = [];
  VerificationRequestListScreenAdmin(
      {super.key, required this.verifiedProRequests});

  @override
  State<VerificationRequestListScreenAdmin> createState() =>
      _VerificationRequestScreenAdminState();
}

class _VerificationRequestScreenAdminState
    extends State<VerificationRequestListScreenAdmin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: const Text('Verification Requests',
            style: TextStyle(color: Colors.white)),
      ),
      body: FutureBuilder(
        future: _getVerificationRequests(),
        // initialData: InitialData,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return ListView.builder(
              itemCount: verifiedProRequests.length,
              itemBuilder: (context, index) {
                return Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListTile(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => ProfileCheckPage(
                                verificationRequest: true,
                                verificationId: verifiedProRequests[index].id,
                                profile: verifiedProRequests[index].profile!)));
                      },
                      title: Text(
                          "${verifiedProRequests[index]!.profile!.user!.firstName}"),
                      subtitle: Text(
                          verifiedProRequests[index].profile!.user!.email!),
                      trailing: Text(verifiedProRequests[index].status!,
                          style: const TextStyle(color: Colors.green)),
                    ),
                  ),
                );
              });
        },
      ),
    );
  }
}
