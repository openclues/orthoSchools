import 'package:azsoon/Core/network/request_helper.dart';
import 'package:azsoon/features/home_screen/presentation/pages/home_screen.dart';
import 'package:flutter/material.dart';
// import 'package:intl_phone_number_input/intl_phone_number_input.dart';

class PartnerForm extends StatefulWidget {
  static const routeName = '/partner-form';

  const PartnerForm({super.key});

  @override
  _PartnerFormState createState() => _PartnerFormState();
}

class _PartnerFormState extends State<PartnerForm> {
  // bool? isLoading = false;
  // Controllers for each text field
  late TextEditingController _fullNameController;
  late TextEditingController _professionalTitleController;
  late TextEditingController _licenseNumberController;
  late TextEditingController _phoneController;
  late TextEditingController _emailController;
  late TextEditingController _clinicNameController;
  late TextEditingController _clinicAddressController;
  late TextEditingController _educationController;
  late TextEditingController _graduationYearController;
  late TextEditingController _certificationsController;
  late TextEditingController _experienceController;

  // Step index to navigate through the stepper
  int _currentStep = 0;

  // List of steps/questions in the form
  late List<Step> steps;

  @override
  void initState() {
    super.initState();
    // Initialize the controllers and steps in the initState method
    _fullNameController = TextEditingController();
    _professionalTitleController = TextEditingController();
    _licenseNumberController = TextEditingController();
    _phoneController = TextEditingController();
    _emailController = TextEditingController();
    _clinicNameController = TextEditingController();
    _clinicAddressController = TextEditingController();
    _educationController = TextEditingController();
    _graduationYearController = TextEditingController();
    _certificationsController = TextEditingController();
    _experienceController = TextEditingController();

    steps = [
      Step(
        title: const Text('Personal and Professional Information'),
        content: Column(
          children: [
            TextFormField(
              controller: _fullNameController,
              decoration: const InputDecoration(labelText: 'Full Name'),
            ),
            TextFormField(
              controller: _professionalTitleController,
              decoration:
                  const InputDecoration(labelText: 'Professional Title'),
            ),
            TextFormField(
              keyboardType: TextInputType.number,
              controller: _licenseNumberController,
              decoration: const InputDecoration(labelText: 'License Number'),
            ),
            // TextFormField(
            //   controller: _contactInfoController,
            //   decoration:
            //       const InputDecoration(labelText: 'Contact Information'),
            // ),
            const SizedBox(
              height: 20,
            ),
            // InternationalPhoneNumberInput(
            //   onInputChanged: (PhoneNumber number) {
            //     _phoneController.text = number.phoneNumber!;
            //   },
            //   onInputValidated: (bool value) {
            //     print(value);
            //   },
            //   selectorConfig: const SelectorConfig(
            //     selectorType: PhoneInputSelectorType.DIALOG,
            //   ),
            // ),
            TextFormField(
              keyboardType: TextInputType.emailAddress,
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Email Address'),
            ),
            TextFormField(
              controller: _clinicNameController,
              decoration:
                  const InputDecoration(labelText: 'Clinic/Practice Name'),
            ),
            TextFormField(
              controller: _clinicAddressController,
              decoration:
                  const InputDecoration(labelText: 'Clinic/Practice Address'),
            ),
          ],
        ),
      ),
      Step(
        title: const Text('Education and Experience'),
        content: Column(
          children: [
            const Text(
                'Where did you complete your dental/orthodontic education?'),
            TextFormField(
              controller: _educationController,
              decoration: const InputDecoration(labelText: 'Study Place'),
            ),
            TextFormField(
              keyboardType: TextInputType.number,
              controller: _graduationYearController,
              decoration:
                  const InputDecoration(labelText: 'Year of Graduation'),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
                "Do you have any additional certifications or specializations in orthodontics? Please specify."),
            TextFormField(
              controller: _certificationsController,
              decoration: const InputDecoration(
                label: Text('Certifications'),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
                "How many years of experience do you have in orthodontics?"),
            TextFormField(
              controller: _experienceController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Experience '),
            ),
          ],
        ),
      ),
      // Add more steps for each section of the form
      // Repeat the Step widget structure for each section/question
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ParisAline Partnership Form'),
      ),
      body: Stepper(
        steps: steps,
        currentStep: _currentStep,
        onStepContinue: () {
          if (_currentStep < steps.length - 1) {
            if (_validateStep(_currentStep)) {
              setState(() {
                _currentStep++;
              });
            }
          } else {
            // Handle form submission here
            // Access the user inputs using controllers
            _printFormFields();
          }
        },
        onStepCancel: () {
          if (_currentStep > 0) {
            setState(() {
              _currentStep--;
            });
          }
        },
      ),
    );
  }

  bool _validateStep(int step) {
    // if (_fullNameController.text.isEmpty ||
    //     _professionalTitleController.text.isEmpty ||
    //     _licenseNumberController.text.isEmpty ||
    //     _phoneController.text.isEmpty ||
    //     _emailController.text.isEmpty ||
    //     _clinicNameController.text.isEmpty ||
    //     _clinicAddressController.text.isEmpty) {
    //   ScaffoldMessenger.of(context).showSnackBar(
    //     const SnackBar(
    //       content: Text('Please fill all the fields'),
    //     ),
    //   );
    //   return false;
    // }
    switch (step) {
      case 0:
        return true;
      case 1:
        return true;
      // Add additional cases for other steps as needed
      default:
        return true;
    }
  }

  void _printFormFields() async {
    //     full_name = request.data.get('full_name', None)
    // phone = request.data.get('phone', None)
    // email = request.data.get('email', None)
    // clinic_name = request.data.get('clinic_name', None)
    // clinic_address = request.data.get('clinic_address', None)
    // education = request.data.get('education', None)
    // graduation_year = request.data.get('graduation_year', None)
    // certifications = request.data.get('certifications', None)
    // experience = request.data.get('experience', None)
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => const AlertDialog(
        title: Text('Submitting Form'),
        content: Row(
          children: [
            CircularProgressIndicator(),
            SizedBox(
              width: 20,
            ),
            Text('Please wait...'),
          ],
        ),
      ),
    );
    var response = await RequestHelper.post('premieum/', {
      'full_name': _fullNameController.text,
      'phone': _phoneController.text,
      'email': _emailController.text,
      'professional_title': _professionalTitleController.text,
      'license_number': _licenseNumberController.text,
      'clinic_name': _clinicNameController.text,
      'clinic_address': _clinicAddressController.text,
      'education': _educationController.text,
      'graduation_year': _graduationYearController.text,
      'certifications': _certificationsController.text,
      'experience': _experienceController.text,
    });
    if (response.statusCode == 200) {
      showDialog(
        context: context,
        builder: (context) => const AlertDialog(
          title: Text('Success'),
          content: Text('Your form has been submitted successfully'),
        ),
      );
      Navigator.of(context)
          .pushNamedAndRemoveUntil(HomeScreenPage.routeName, (route) => false);
    }
    print('Full Name: ${_fullNameController.text}');
    print('Professional Title: ${_professionalTitleController.text}');
    print('License Number: ${_licenseNumberController.text}');
    // print('Contact Information: ${_contactInfoController.text}');
    print('Phone Number: ${_phoneController.text}');
    print('Email Address: ${_emailController.text}');
    print('Clinic/Practice Name: ${_clinicNameController.text}');
    print('Clinic/Practice Address: ${_clinicAddressController.text}');
    print('Education: ${_educationController.text}');
    print('Year of Graduation: ${_graduationYearController.text}');
    print('Certifications: ${_certificationsController.text}');
    print('Experience : ${_experienceController.text}');
    // Add print statements for other fields
  }
}
