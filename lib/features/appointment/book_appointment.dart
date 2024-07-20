import 'package:date_field/date_field.dart';
import 'package:flutter/material.dart';
import 'package:nursing_mother_medical_app/config/app_colors.dart';
import 'package:nursing_mother_medical_app/config/app_strings.dart';
import 'package:nursing_mother_medical_app/model/user.dart';
import 'package:nursing_mother_medical_app/reusables/LoadingView.dart';
import 'package:nursing_mother_medical_app/reusables/form/app_button.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../config/firestore_constants.dart';
import '../../model/appointment.dart';
import '../../provider/providers.dart';
import '../../reusables/form/input_decoration.dart';

class BookAppointment extends StatelessWidget {
  final User professional;

  const BookAppointment({super.key, required this.professional});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: AppBar(
        title: Text(
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
            Navigator.pop(context); // Go back to the previous page
          },
        ),
      ),
      body: BookAppointmentForm(professional: professional),
    );
  }
}

class BookAppointmentForm extends StatefulWidget {
  final User professional;

  const BookAppointmentForm({super.key, required this.professional});

  @override
  BookAppointmentFormState createState() {
    return BookAppointmentFormState();
  }
}

class BookAppointmentFormState extends State<BookAppointmentForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _reasonController = TextEditingController();
  late DateTime selectedDate;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _prefillUserData();
  }

  Future<void> _prefillUserData() async {
    final firestoreProvider = Provider.of<FirestoreProvider>(context, listen: false);
    SharedPreferences prefs = firestoreProvider.prefs;

    String? firstName = prefs.getString(FirestoreConstants.firstname);
    String? email = prefs.getString(FirestoreConstants.email);

    if (firstName != null) {
      _firstNameController.text = firstName;
    }
    if (email != null) {
      _emailController.text = email;
    }
  }

  @override
  Widget build(BuildContext context) {
    final appointmentProvider = Provider.of<AppointmentProvider>(context);

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
                  controller: _firstNameController,
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
                  controller: _emailController,
                  // The validator receives the text that the user has entered.
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Email cannot be empty";
                    }
                    if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]").hasMatch(value)) {
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
                  controller: _reasonController,
                  // The validator receives the text that the user has entered.
                  validator: (value) {
                    RegExp regex = RegExp(r'^.{6,}$');
                    if (value!.isEmpty) {
                      return "Reason cannot be empty";
                    }
                    if (!regex.hasMatch(value)) {
                      return "please enter valid reason min. 6 character";
                    } else {
                      return null;
                    }
                  },
                  decoration: buildInputDecoration(hintText: 'Reason For Appointment'),
                ),
                const SizedBox(
                  height: 20,
                ),
                _isLoading
                    ? const Center(child: LoadingView())
                    : AppElevatedButton(
                  onPressed: () async {
                    // Validate returns true if the form is valid, or false otherwise.
                    if (_formKey.currentState!.validate()) {
                      setState(() {
                        _isLoading = true;
                      });


                      String userId = appointmentProvider.firestoreProvider.prefs.getString(FirestoreConstants.id) ?? "";
                      String userPhoto = appointmentProvider.firestoreProvider.prefs.getString(FirestoreConstants.photoUrl) ?? "";

                      final appointmentId = DateTime.now().millisecondsSinceEpoch.toString();
                      final appointment = Appointment(
                        id: appointmentId,
                        userId: userId,
                        professionalId: widget.professional.id,
                        firstName: _firstNameController.text,
                        email: _emailController.text,
                        appointmentDate: selectedDate,
                        reason: _reasonController.text,
                        userPhotoUrl: userPhoto,
                        professionalPhotoUrl: widget.professional.photoUrl,
                      );

                      appointmentProvider.bookAppointment(appointment).then((_) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Appointment booked successfully')),
                        );
                        _firstNameController.clear();
                        _emailController.clear();
                        _reasonController.clear();
                      }).catchError((error) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Failed to book appointment: $error')),
                        );
                      }).whenComplete(() {
                        setState(() {
                          _isLoading = false;
                        });
                      });
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
