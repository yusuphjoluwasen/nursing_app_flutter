import 'package:date_field/date_field.dart';
import 'package:flutter/material.dart';
import 'package:nursing_mother_medical_app/config/app_colors.dart';
import 'package:nursing_mother_medical_app/config/app_measurements.dart';
import 'package:nursing_mother_medical_app/config/app_strings.dart';
import 'package:nursing_mother_medical_app/reusables/form/app_button.dart';

import '../reusables/form/input_decoration.dart';



class ReportPage extends StatelessWidget {
  const ReportPage({super.key});


  @override
  Widget build(BuildContext context) {

    return  Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: AppBar(
        title:  Text(
          AppStrings.report,
          style: Theme.of(context)
              .textTheme
              .titleSmall
              ?.copyWith(color: AppColors.black),
          textAlign: TextAlign.center,

        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);  // Go back to the previous page
          },
        ),
      ),
      body: ReportPageForm(),
    );
  }
}

// Create a Form widget.
class ReportPageForm extends StatefulWidget {
  const ReportPageForm({super.key});


  @override
  ReportPageFormState createState() {
    return ReportPageFormState();
  }
}

class ReportPageFormState extends State<ReportPageForm> {
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
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 20),
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
                  decoration: buildInputDecoration(hintText: 'What do you want to report?'),
                  maxLines: 5, // Set the number of lines visible (adjust as needed)
                  minLines: 3,
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
                  decoration: buildInputDecoration(hintText: 'Name of person you will like to report?'),
                ),
                const SizedBox(
                  height: 30,
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
                  buttonText: "Book Now",
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
    );
  }
}
