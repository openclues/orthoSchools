import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:settings_ui/settings_ui.dart';

import 'package:azsoon/Core/colors.dart';
import 'package:azsoon/widgets/Button.dart';
import 'package:azsoon/widgets/TextField.dart';

import '../Core/local_storage.dart';
import '../features/loading/presentation/data/screens/loading_screen.dart';

String birthDate = '';
String? name;
String? surname;
String? phoneNumber;
String? newPassword;

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
      backgroundColor: const Color.fromARGB(255, 251, 250, 250),
      appBar: AppBar(
        title: const Text(
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
                lightTheme: const SettingsThemeData(
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
                                offset: const Offset(0, 2),
                                blurRadius: 1,
                                spreadRadius: 0.2,
                              ),
                            ],
                          ),
                          child: SettingsTile.navigation(
                            onPressed: (_) {
                              Navigator.of(context)
                                  .pushNamed('/myAccountSettings');
                            },
                            trailing: Icon(Icons.arrow_forward_ios),
                            leading: Icon(Icons.person_pin),
                            title: Text('My Account Settings'),
                          ),
                        ),
                      ),
                      SettingsTile(
                        title: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 0, vertical: 0),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Colors.white),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.2),
                                  offset: const Offset(0, 2),
                                  blurRadius: 1,
                                  spreadRadius: 0.2,
                                ),
                              ],
                            ),
                            child: Column(
                              children: [
                                SettingsTile.switchTile(
                                  enabled: false,
                                  activeSwitchColor: const Color(0XFFA29CEC),
                                  onToggle: (value) {},
                                  initialValue: false,
                                  leading: const Icon(Icons.dark_mode_outlined),
                                  title: const Text('Dark mode'),
                                ),
                                SettingsTile.navigation(
                                  trailing: const Icon(Icons.arrow_forward_ios),
                                  leading: const Icon(Icons.language),
                                  title: const Text('Language and Region'),
                                ),
                                SettingsTile.switchTile(
                                  activeSwitchColor: const Color(0XFFA29CEC),
                                  onToggle: (value) {},
                                  initialValue: true,
                                  leading: const Icon(Icons.notifications_outlined),
                                  title: const Text('Notifications'),
                                ),
                              ],
                            )),
                      ),
                      SettingsTile(
                        title: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 0, vertical: 0),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Colors.white),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.2),
                                  offset: const Offset(0, 2),
                                  blurRadius: 1,
                                  spreadRadius: 0.2,
                                ),
                              ],
                            ),
                            child: Column(
                              children: [
                                SettingsTile.navigation(
                                  trailing: const Icon(Icons.arrow_forward_ios),
                                  leading: const Icon(Icons.lock_outline),
                                  title: const Text('Privacy'),
                                ),
                                SettingsTile.navigation(
                                  trailing: const Icon(Icons.arrow_forward_ios),
                                  leading:
                                      const Icon(Icons.stacked_bar_chart_outlined),
                                  title: const Text('Data and Permissions'),
                                ),
                                SettingsTile.navigation(
                                  trailing: const Icon(Icons.arrow_forward_ios),
                                  leading: const Icon(Icons.check_box_outlined),
                                  title: const Text('Terms and Service'),
                                ),
                              ],
                            )),
                      ),
                      SettingsTile(
                        title: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 0, vertical: 0),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Colors.white),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.2),
                                  offset: const Offset(0, 2),
                                  blurRadius: 1,
                                  spreadRadius: 0.2,
                                ),
                              ],
                            ),
                            child: Column(
                              children: [
                                SettingsTile.navigation(
                                  trailing: const Icon(Icons.arrow_forward_ios),
                                  leading: const Icon(Icons.privacy_tip_outlined),
                                  title: const Text('Help Center'),
                                ),
                                SettingsTile.navigation(
                                  trailing: const Icon(Icons.arrow_forward_ios),
                                  leading: const Icon(Icons.help_center_outlined),
                                  title: const Text('FAQ'),
                                ),
                                SettingsTile.navigation(
                                  trailing: const Icon(Icons.arrow_forward_ios),
                                  leading: const Icon(Icons.logout),
                                  title: const Text(
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
                              const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 215, 82, 82),
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: const Color.fromARGB(255, 215, 82, 82),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                offset: const Offset(0, 2),
                                blurRadius: 1,
                                spreadRadius: 0.2,
                              ),
                            ],
                          ),
                          child: SettingsTile.navigation(
                            value: const Text(
                              '22 day left',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            trailing: const Icon(
                              Icons.arrow_forward_ios,
                              color: Colors.white,
                            ),
                            leading: const Icon(
                              Icons.warning,
                              color: Colors.white,
                            ),
                            title: const Text(
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

class My_Account_Settings extends StatefulWidget {
  static const String routeName = '/myAccountSettings';
  const My_Account_Settings({super.key});

  @override
  State<My_Account_Settings> createState() => _My_Account_SettingsState();
}

class _My_Account_SettingsState extends State<My_Account_Settings> {
  final GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  bool passwordVisibilty = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Form(
        key: globalKey,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 15),
          child: ListView(
            children: [
              Container(
                margin: EdgeInsets.symmetric(vertical: 10),
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
                child: Theme(
                  data: ThemeData(
                    dividerColor: Colors.transparent,
                  ),
                  child: ExpansionTile(
                    trailing: Icon(Icons.edit_outlined),
                    title: Text('Name Surname'),
                    subtitle: Text('Sara kaya'),
                    children: <Widget>[
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            CustomTextField(
                              textfiledColor: Colors.white, // Use Colors.white
                              borderColor: Colors.grey,
                              obscureText: false,
                              labelText: 'Name',
                            ),
                            CustomTextField(
                              textfiledColor: Colors.white, // Use Colors.white
                              obscureText: false,
                              borderColor: Colors.grey,
                              labelText: 'Surname',
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            CustomButton(
                              width: double.infinity,
                              buttonText: 'Save',
                              height: 45,
                              onpress: () {},
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10),
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
                child: Theme(
                  data: ThemeData(
                    dividerColor: Colors.transparent,
                  ),
                  child: ExpansionTile(
                    trailing: Icon(Icons.email_outlined),
                    title: Text('E-mail'),
                    subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('sara.kaya@gmail.com'),
                          SizedBox(
                            height: 13,
                          ),
                          CustomButton(
                            buttonText: 'E-mail address confirm',
                            height: 45,
                            onpress: () {},
                          ),
                        ]),
                    children: <Widget>[],
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10),
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
                child: Theme(
                  data: ThemeData(
                    dividerColor: Colors.transparent,
                  ),
                  child: ExpansionTile(
                    trailing: Icon(Icons.edit_outlined),
                    title: Text('Password'),
                    subtitle: Text('********'),
                    children: <Widget>[
                      Container(
                        padding:
                            EdgeInsets.only(left: 15, right: 15, bottom: 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            CustomTextField(
                              obscureText: passwordVisibilty,
                              labelText: 'Password',
                              iconButton: IconButton(
                                padding:
                                    const EdgeInsetsDirectional.only(end: 12.0),
                                icon: passwordVisibilty
                                    ? const Icon(Icons.visibility_off)
                                    : const Icon(Icons.visibility),
                                onPressed: () {
                                  setState(() {
                                    passwordVisibilty = !passwordVisibilty;
                                  });
                                },
                              ),
                              borderColor:
                                  const Color.fromARGB(255, 176, 176, 176),
                              textfiledColor: Colors.white,
                              hintText:
                                  "password must be at least 8 characters.",
                            ),
                            CustomTextField(
                              obscureText: passwordVisibilty,
                              labelText: 'Confirm Password',
                              borderColor: Color.fromARGB(255, 176, 176, 176),
                              textfiledColor: Colors.white,
                              hintText: "both passwords must match",
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            CustomButton(
                              width: double.infinity,
                              buttonText: 'Save',
                              height: 45,
                              onpress: () {},
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10),
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
                child: Theme(
                  data: ThemeData(
                    dividerColor: Colors.transparent,
                  ),
                  child: ExpansionTile(
                    trailing: Icon(Icons.edit_outlined),
                    title: Text('Birth Date'),
                    subtitle: Text(birthDate),
                    children: <Widget>[
                      Container(
                        padding:
                            EdgeInsets.only(left: 15, right: 15, bottom: 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            CustomTextField(
                              readOnly: true,
                              obscureText: passwordVisibilty,
                              labelText: 'Birh Date',
                              borderColor: Color.fromARGB(255, 176, 176, 176),
                              textfiledColor: Colors.white,
                              hintText: birthDate,
                              onSaved: (date) {
                                birthDate = date!;
                              },
                              onTap: () {
                                selectDate();
                              },
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            CustomButton(
                              width: double.infinity,
                              buttonText: 'Save',
                              height: 45,
                              onpress: () {},
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10),
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
                child: Theme(
                  data: ThemeData(
                    dividerColor: Colors.transparent,
                  ),
                  child: ExpansionTile(
                    trailing: Icon(Icons.edit_outlined),
                    title: Text('Phone Number'),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('+90 55 23 684 008'),
                        TextButton(onPressed: () {}, child: Text('Confirmed'))
                      ],
                    ),
                    children: <Widget>[
                      Container(
                        padding:
                            EdgeInsets.only(left: 15, right: 15, bottom: 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            
                            InternationalPhoneNumberInput(
                              onInputChanged: (PhoneNumber number) {
                                print(number.phoneNumber);
                              },
                              onInputValidated: (bool value) {
                                print(value);
                              },
                              selectorConfig: SelectorConfig(
                                selectorType: PhoneInputSelectorType.DIALOG,
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            CustomButton(
                              width: double.infinity,
                              buttonText: 'Save',
                              height: 45,
                              onpress: () {},
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> selectDate() async {
    DateTime? selectedBirthDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2100));
    if (selectedBirthDate != null) {
      birthDate = selectedBirthDate.toString().split(" ")[0];
      setState(() {});
    }
  }
}
