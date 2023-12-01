import 'package:azsoon/Providers/moreUserInfoProvider.dart';
import 'package:azsoon/Providers/userInfoProvider.dart';
import 'package:flutter/material.dart';
import 'package:azsoon/Core/common-methods.dart';
import 'package:azsoon/screens/SplashScreen.dart';
import 'package:custom_pop_up_menu/custom_pop_up_menu.dart';
import 'package:provider/provider.dart';
import '../model/userinfoClass.dart';

class AppBarWidget extends StatefulWidget implements PreferredSizeWidget {
  // final User user;
  const AppBarWidget({super.key});

  @override
  State<AppBarWidget> createState() => _AppBarWidgetState();

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

class _AppBarWidgetState extends State<AppBarWidget> {
  CustomPopupMenuController popUpMenuController = CustomPopupMenuController();

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = Provider.of<UserProvider>(context);
    MoreInfoUserProvider moreInfoUserProvider =
        Provider.of<MoreInfoUserProvider>(context);

    return AppBar(
      iconTheme: IconThemeData(color: Colors.white),
      elevation: 0,
      centerTitle: true,
      backgroundColor: Color(0XFF2F7EDB),
      // title: Text(
      //   'ORTH-UNI',
      //   style: TextStyle(color: Colors.black),
      // ),
      actions: [
        IconButton(
            onPressed: () async {
              //navigatie to notificaitons
            },
            icon: Icon(Icons.notifications)),
        IconButton(
            onPressed: () async {
              await CommonMethods.logOut();
              if (context.mounted) {
                //to make sure that the logout await is done
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => SplashScreen()),
                    (route) => false);
              }
            },
            icon: Icon(Icons.login)),
        IconButton(
            onPressed: () async {
              Navigator.of(context).pushNamed('createProfile');
            },
            icon: Icon(
              Icons.person,
            )),
        Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: CustomPopupMenu(
            arrowColor: Colors.white,
            controller: popUpMenuController,
            child: CircleAvatar(
              radius: 20,
              backgroundColor: Colors.grey,
              backgroundImage: moreInfoUserProvider.user.profileImage != null
                  ? NetworkImage(moreInfoUserProvider.user.profileImage)
                  : null,
              child: moreInfoUserProvider.user.profileImage == null
                  ? Center(
                      child: Image.asset('assets/images/drimage.png'),
                    )
                  : null, // Remove Center widget if profileImage is not null
            ),
            menuBuilder: () => ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Container(
                color: Colors.white,
                child: IntrinsicWidth(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      ListTile(
                        leading: CircleAvatar(
                          radius: 20,
                          backgroundColor: Colors.grey,
                          backgroundImage:
                              moreInfoUserProvider.user.profileImage != null
                                  ? NetworkImage(
                                      moreInfoUserProvider.user.profileImage)
                                  : null,
                          child: moreInfoUserProvider.user.profileImage == null
                              ? Center(
                                  child:
                                      Image.asset('assets/images/drimage.png'),
                                )
                              : null, // Remove Center widget if profileImage is not null
                        ),
                        title: Text(
                            "${moreInfoUserProvider.user.speciality}  ${userProvider.user.firstName}"),
                        // subtitle: Text(moreInfoUserProvider.user.speciality),
                      ),
                      //user image avatar and name
                      popUpMenuItem(
                        popUpMenuController: popUpMenuController,
                        title: 'profile',
                        icon: Icons.person,
                        ontap: () {
                          Navigator.of(context).pushNamed('createProfile');
                          popUpMenuController.hideMenu();
                        },
                      ),
                      popUpMenuItem(
                        popUpMenuController: popUpMenuController,
                        title: 'saved',
                        icon: Icons.save_alt_outlined,
                        ontap: () {
                          popUpMenuController.hideMenu();
                        },
                      ),
                      Divider(
                        indent: 3,
                        endIndent: 3,
                        thickness: 1,
                      ),
                      popUpMenuItem(
                        popUpMenuController: popUpMenuController,
                        title: 'log out',
                        icon: Icons.logout,
                        ontap: () async {
                          await CommonMethods.logOut();
                          if (context.mounted) {
                            //to make sure that the logout await is done
                            Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                    builder: (context) => SplashScreen()),
                                (route) => false);
                          }
                          popUpMenuController.hideMenu();
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
            pressType: PressType.singleClick,
          ),
        ),
      ],
    );
  }
}

class popUpMenuItem extends StatelessWidget {
  final String? title;
  final IconData? icon;
  final Function()? ontap;
  const popUpMenuItem({
    super.key,
    this.title,
    this.icon,
    this.ontap,
    required this.popUpMenuController,
  });

  final CustomPopupMenuController popUpMenuController;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: ontap,
      child: Container(
        height: 40,
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          children: <Widget>[
            Icon(
              icon,
              size: 15,
              color: Colors.black,
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.only(left: 10),
                padding: EdgeInsets.symmetric(
                  vertical: 10,
                ),
                child: Text(
                  title!,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 12,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
