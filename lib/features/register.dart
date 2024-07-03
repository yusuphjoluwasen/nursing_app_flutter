import 'package:date_field/date_field.dart';
import 'package:flutter/material.dart';
import 'package:nursing_mother_medical_app/config/app_colors.dart';
import 'package:nursing_mother_medical_app/config/app_measurements.dart';
import 'package:nursing_mother_medical_app/config/app_strings.dart';
import 'package:nursing_mother_medical_app/reusables/form/app_button.dart';

import '../reusables/form/input_decoration.dart';



class Register extends StatelessWidget {
  const Register({super.key, required this.userType});

  final String userType;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: AppColors.bgColor,
      body: RegisterForm(userType: userType),
    );
  }
}

// Create a Form widget.
class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key, required this.userType});

  final String userType;

  @override
  RegisterFormState createState() {
    return RegisterFormState();
  }
}

class RegisterFormState extends State<RegisterForm> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a GlobalKey<FormState>,
  // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();
  late DateTime selectedDate;

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return SafeArea(
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 20),
            margin: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Column(
                      children: [
                        Text(
                          AppStrings.register,
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge
                              ?.copyWith(color: AppColors.black),
                        ),
                        const SizedBox(height: 10),
                        const Image(
                          image: AssetImage('assets/images/userprofile.png'),
                          width: 80,
                          height: 80,
                        ),
                      ],
                    ),
                  ),
                ),
                if (widget.userType != "professional")
                  TextFormField(
                    // The validator receives the text that the user has entered.
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Email cannot be empty";
                      }
                      if (!RegExp(
                          "^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                          .hasMatch(value)) {
                        return "Please enter a valid email";
                      } else {
                        return null;
                      }
                    },
                    decoration: buildInputDecoration(
                      hintText: 'Email',
                      icon: Icons.email,
                    ),
                  ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  // The validator receives the text that the user has entered.
                  validator: (value) {
                    RegExp regex = RegExp(r'^.{2,}$');
                    if (value!.isEmpty) {
                      return "First Name cannot be empty";
                    }
                    if (!regex.hasMatch(value)) {
                      return "please enter valid first name min. 2 character";
                    } else {
                      return null;
                    }
                  },
                  decoration: buildInputDecoration(hintText: 'First Name'),
                ),
                const SizedBox(
                  height: 20,
                ),

                TextFormField(
                  // The validator receives the text that the user has entered.
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Email cannot be empty";
                    }
                    if (!RegExp(
                        "^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                        .hasMatch(value)) {
                      return "Please enter a valid email";
                    } else {
                      return null;
                    }
                  },
                  decoration: buildInputDecoration(
                    hintText: 'Email',
                    icon: Icons.email,
                  ),
                ),

                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  // The validator receives the text that the user has entered.
                  validator: (value) {
                    RegExp regex = RegExp(r'^.{6,}$');
                    if (value!.isEmpty) {
                      return "Password cannot be empty";
                    }
                    if (!regex.hasMatch(value)) {
                      return "please enter valid password min. 6 character";
                    } else {
                      return null;
                    }
                  },
                  decoration: buildInputDecoration(
                    hintText: 'Password',
                    icon: Icons.lock,
                  ),
                ),

                const SizedBox(
                  height: 20,
                ),

                TextFormField(
                  // The validator receives the text that the user has entered.
                  validator: (value) {
                    RegExp regex = RegExp(r'^.{6,}$');
                    if (value!.isEmpty) {
                      return "Password cannot be empty";
                    }
                    if (!regex.hasMatch(value)) {
                      return "please enter valid password min. 6 character";
                    } else {
                      return null;
                    }
                  },
                  decoration: buildInputDecoration(hintText: 'Password'),
                ),

                const SizedBox(
                  height: 20,
                ),

                DateTimeFormField(
                  decoration: buildInputDecoration(hintText: 'Date of Birth'),
                  firstDate: DateTime.now().add(const Duration(days: 10)),
                  lastDate: DateTime.now().add(const Duration(days: 40)),
                  initialPickerDateTime: DateTime.now().add(const Duration(days: 20)),
                  onChanged: (DateTime? value) {
                    selectedDate = value!;
                  },
                  mode: DateTimeFieldPickerMode.date,
                ),

                const SizedBox(
                  height: 20,
                ),

                TextFormField(
                  // The validator receives the text that the user has entered.
                  validator: (value) {
                    RegExp regex = RegExp(r'^.{6,}$');
                    if (value!.isEmpty) {
                      return "Password cannot be empty";
                    }
                    if (!regex.hasMatch(value)) {
                      return "please enter valid password min. 6 character";
                    } else {
                      return null;
                    }
                  },
                  decoration: buildInputDecoration(hintText: 'Bio'),
                ),
                const SizedBox(
                  height: 20,
                ),
                AppElevatedButton(
                  onPressed: () {
                    // Validate returns true if the form is valid, or false otherwise.
                    if (_formKey.currentState!.validate()) {
                      // If the form is valid, display a snackbar. In the real world,
                      // you'd often call a server or save the information in a database.
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Processing Data')),
                      );
                    }
                  },
                  buttonText: "Submit",
                ),
                const SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () {},
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have an account?",
                        style: Theme.of(context)
                            .textTheme
                            .labelSmall
                            ?.copyWith(color: AppColors.black),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        "Sign Up",
                        style: Theme.of(context)
                            .textTheme
                            .labelSmall
                            ?.copyWith(color: AppColors.primary),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  onTap: () {},
                  child: Center(
                    child: Text(
                      "Forgot Password",
                      style: Theme.of(context)
                          .textTheme
                          .labelSmall
                          ?.copyWith(color: AppColors.black),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
