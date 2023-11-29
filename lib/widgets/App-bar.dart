import 'package:flutter/material.dart';
import 'package:azsoon/Core/common-methods.dart';
import 'package:azsoon/screens/SplashScreen.dart';
import 'package:custom_pop_up_menu/custom_pop_up_menu.dart';
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
              backgroundImage: null,
              backgroundColor: Colors.grey,
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
                        ),
                        title: Text('Dr.Anhaf'),
                      ),
                      //user image avatar and name
                      popUpMenuItem(
                        popUpMenuController: popUpMenuController,
                        title: 'profile',
                        icon: Icons.person,
                        ontap: () {
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
                        ontap: () {
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
