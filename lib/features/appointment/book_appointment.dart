import 'package:date_field/date_field.dart';
import 'package:flutter/material.dart';
import 'package:nursing_mother_medical_app/config/app_colors.dart';
import 'package:nursing_mother_medical_app/config/app_measurements.dart';
import 'package:nursing_mother_medical_app/config/app_strings.dart';
import 'package:nursing_mother_medical_app/reusables/form/app_button.dart';

import '../../reusables/form/input_decoration.dart';



class BookAppointment extends StatelessWidget {
  const BookAppointment({super.key});



  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: AppBar(
        title:  Text(
          AppStrings.appointment,
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
      body: const BookAppointmentForm(),
    );
  }
}

// Create a Form widget.
class BookAppointmentForm extends StatefulWidget {
  const BookAppointmentForm({super.key});


  @override
  BookAppointmentFormState createState() {
    return BookAppointmentFormState();
  }
}

class BookAppointmentFormState extends State<BookAppointmentForm> {
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

                DateTimeFormField(
                  decoration: buildInputDecoration(hintText: 'Date and Time'),
                  firstDate: DateTime.now().add(const Duration(days: 10)),
                  lastDate: DateTime.now().add(const Duration(days: 40)),
                  initialPickerDateTime: DateTime.now().add(const Duration(days: 20)),
                  onChanged: (DateTime? value) {
                    selectedDate = value!;
                  },
                  mode: DateTimeFieldPickerMode.dateAndTime,
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
                  decoration: buildInputDecoration(hintText: 'Reason For Appointment'),
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
                  buttonText: "Book Now",
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
