import 'package:flutter/material.dart';
import 'package:nursing_mother_medical_app/config/app_colors.dart';
import 'package:nursing_mother_medical_app/config/app_measurements.dart';
import 'package:nursing_mother_medical_app/config/app_strings.dart';
import 'package:nursing_mother_medical_app/features/register.dart';
import 'package:nursing_mother_medical_app/features/supportlibrary/support_library.dart';
import 'package:nursing_mother_medical_app/reusables/form/app_button.dart';

import '../../reusables/form/input_decoration.dart';
import '../home/home.dart';
//original


class LoginPlay extends StatelessWidget {
  const LoginPlay({super.key});

  @override
  Widget build(BuildContext context) {

    return const Scaffold(
        backgroundColor: AppColors.bgColor,
        body: MyCustomForm(),
      );
  }
}

// Create a Form widget.
class MyCustomForm extends StatefulWidget {
  const MyCustomForm({super.key});

  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

// Create a corresponding State class.
// This class holds data related to the form.
class MyCustomFormState extends State<MyCustomForm> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a GlobalKey<FormState>,
  // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return SafeArea(child:
      Form(
      key: _formKey,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20),
        margin: const EdgeInsets.all(20),
      child:
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(child: Container(
              padding:
              const EdgeInsets.symmetric(vertical: 20),
              child: Text(AppStrings.login, style: Theme.of(context).textTheme.titleLarge?.copyWith(color: AppColors.black))
          )),

          TextFormField(
            // The validator receives the text that the user has entered.
            validator: (value) {
              if (value!.isEmpty) {
                return "Email cannot be empty";
              }
              if (!RegExp(
                  "^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                  .hasMatch(value)) {
                return ("Please enter a valid email");
              } else {
                return null;
              }
            },
            decoration: buildInputDecoration(hintText: 'Email', icon: Icons.email),
          ),

          const SizedBox(
            height: 20,
          ),

          TextFormField(
            // The validator receives the text that the user has entered.
            validator: (value) {
              RegExp regex = new RegExp(r'^.{6,}$');
              if (value!.isEmpty) {
                return "Password cannot be empty";
              }
              if (!regex.hasMatch(value)) {
                return ("please enter valid password min. 6 character");
              } else {
                return null;
              }
            },
            decoration: buildInputDecoration(hintText: 'Password', icon: Icons.lock),
          ),

          const SizedBox(
            height: 20,
          ),

          AppElevatedButton(onPressed:  () {
            // Validate returns true if the form is valid, or false otherwise.
            if (_formKey.currentState!.validate()) {
              // If the form is valid, display a snackbar. In the real world,
              // you'd often call a server or save the information in a database.
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Processing Data')),
              );
            }
          }, buttonText: "Submit"),

          const SizedBox(
            height: 20,
          ),

            GestureDetector(onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>  const HomePage(),
              // const Register(userType: 'professional'),
                ),
              );
            },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                Text("Dont have an account?",
                    style:Theme.of(context).textTheme.labelSmall?.copyWith(color: AppColors.black)),
                  const SizedBox(
                    width: 5,
                  ),
                Text("Sign Up",
                    style:Theme.of(context).textTheme.labelSmall?.copyWith(color: AppColors.primary))
              ],)),

          const SizedBox(
            height: 10,
          ),

          GestureDetector(onTap: () {  },
              child:   Center(child:
              Text("Forgot Password",
                  style:Theme.of(context).textTheme.labelSmall?.copyWith(color: AppColors.black))
          )
          )
        ],
      ),
      )
    )
    );
  }
}