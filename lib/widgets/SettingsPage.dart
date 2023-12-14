import 'package:flutter/material.dart';
import 'package:settings_ui/settings_ui.dart';

import '../Core/local_storage.dart';
import '../features/loading/presentation/data/screens/loading_screen.dart';

//

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});
  static const String routeName = '/settings';

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 251, 250, 250),
      appBar: AppBar(
        title: Text(
          'Settings',
          style: TextStyle(
              color: Colors.black, fontSize: 25, fontWeight: FontWeight.w500),
        ),
      ),
      body: Container(
        child: Column(
          children: [
            Expanded(
              child: SettingsList(
                lightTheme: SettingsThemeData(
                    settingsListBackground: Color.fromARGB(255, 251, 250, 250)),
                sections: [
                  SettingsSection(
                    tiles: <SettingsTile>[
                      SettingsTile(
                        title: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.white),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                offset: Offset(0, 2),
                                blurRadius: 1,
                                spreadRadius: 0.2,
                              ),
                            ],
                          ),
                          child: SettingsTile.navigation(
                            trailing: Icon(Icons.arrow_forward_ios),
                            leading: Icon(Icons.person_pin),
                            title: Text('Account Settings'),
                          ),
                        ),
                      ),
                      SettingsTile(
                        title: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 0, vertical: 0),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Colors.white),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.2),
                                  offset: Offset(0, 2),
                                  blurRadius: 1,
                                  spreadRadius: 0.2,
                                ),
                              ],
                            ),
                            child: Column(
                              children: [
                                SettingsTile.switchTile(
                                  enabled: false,
                                  activeSwitchColor: Color(0XFFA29CEC),
                                  onToggle: (value) {},
                                  initialValue: false,
                                  leading: Icon(Icons.dark_mode_outlined),
                                  title: Text('Dark mode'),
                                ),
                                SettingsTile.navigation(
                                  trailing: Icon(Icons.arrow_forward_ios),
                                  leading: Icon(Icons.language),
                                  title: Text('Language and Region'),
                                ),
                                SettingsTile.switchTile(
                                  activeSwitchColor: Color(0XFFA29CEC),
                                  onToggle: (value) {},
                                  initialValue: true,
                                  leading: Icon(Icons.notifications_outlined),
                                  title: Text('Notifications'),
                                ),
                              ],
                            )),
                      ),
                      SettingsTile(
                        title: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 0, vertical: 0),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Colors.white),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.2),
                                  offset: Offset(0, 2),
                                  blurRadius: 1,
                                  spreadRadius: 0.2,
                                ),
                              ],
                            ),
                            child: Column(
                              children: [
                                SettingsTile.navigation(
                                  trailing: Icon(Icons.arrow_forward_ios),
                                  leading: Icon(Icons.lock_outline),
                                  title: Text('Privacy'),
                                ),
                                SettingsTile.navigation(
                                  trailing: Icon(Icons.arrow_forward_ios),
                                  leading:
                                      Icon(Icons.stacked_bar_chart_outlined),
                                  title: Text('Data and Permissions'),
                                ),
                                SettingsTile.navigation(
                                  trailing: Icon(Icons.arrow_forward_ios),
                                  leading: Icon(Icons.check_box_outlined),
                                  title: Text('Terms and Service'),
                                ),
                              ],
                            )),
                      ),
                      SettingsTile(
                        title: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 0, vertical: 0),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Colors.white),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.2),
                                  offset: Offset(0, 2),
                                  blurRadius: 1,
                                  spreadRadius: 0.2,
                                ),
                              ],
                            ),
                            child: Column(
                              children: [
                                SettingsTile.navigation(
                                  trailing: Icon(Icons.arrow_forward_ios),
                                  leading: Icon(Icons.privacy_tip_outlined),
                                  title: Text('Help Center'),
                                ),
                                SettingsTile.navigation(
                                  trailing: Icon(Icons.arrow_forward_ios),
                                  leading: Icon(Icons.help_center_outlined),
                                  title: Text('FAQ'),
                                ),
                                SettingsTile.navigation(
                                  trailing: Icon(Icons.arrow_forward_ios),
                                  leading: Icon(Icons.logout),
                                  title: Text(
                                    'Log Out',
                                    style: TextStyle(color: Colors.red),
                                  ),
                                  onPressed: (_) async {
                                    await LocalStorage.removeAuthToken();
                                    if (context.mounted) {
                                      Navigator.of(context)
                                          .pushReplacementNamed(
                                              LoadingScreen.routeName);
                                    }
                                  },
                                ),
                              ],
                            )),
                      ),
                      SettingsTile(
                        title: Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                          decoration: BoxDecoration(
                            color: Color.fromARGB(255, 215, 82, 82),
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: Color.fromARGB(255, 215, 82, 82),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                offset: Offset(0, 2),
                                blurRadius: 1,
                                spreadRadius: 0.2,
                              ),
                            ],
                          ),
                          child: SettingsTile.navigation(
                            value: Text(
                              '22 day left',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            trailing: Icon(
                              Icons.arrow_forward_ios,
                              color: Colors.white,
                            ),
                            leading: Icon(
                              Icons.warning,
                              color: Colors.white,
                            ),
                            title: Text(
                              'Verify your account !',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
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
    );
  }
}
