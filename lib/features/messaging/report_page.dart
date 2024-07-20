import 'package:flutter/material.dart';
import 'package:nursing_mother_medical_app/config/app_colors.dart';
import 'package:nursing_mother_medical_app/config/app_strings.dart';
import 'package:nursing_mother_medical_app/provider/firestore_provider.dart';
import 'package:nursing_mother_medical_app/reusables/LoadingView.dart';
import 'package:nursing_mother_medical_app/reusables/form/app_button.dart';
import 'package:provider/provider.dart';
import '../../config/firestore_constants.dart';
import '../../model/model.dart';
import '../../reusables/form/input_decoration.dart';


class ReportPage extends StatelessWidget {
   const ReportPage({super.key, required this.groupId});

  final String groupId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: AppBar(
        title: Text(
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
            Navigator.pop(context); // Go back to the previous page
          },
        ),
      ),
      body: ReportPageForm(groupId: groupId),
    );
  }
}

// Create a Form widget.
class ReportPageForm extends StatefulWidget {
  const ReportPageForm({super.key, required this.groupId});

  final String groupId;

  @override
  ReportPageFormState createState() {
    return ReportPageFormState();
  }
}

class ReportPageFormState extends State<ReportPageForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _personNameController = TextEditingController();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final firestoreProvider = Provider.of<FirestoreProvider>(context);

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
                controller: _descriptionController,
                validator: (value) {
                  RegExp regex = RegExp(r'^.{2,}$');
                  if (value!.isEmpty) {
                    return "Report description cannot be empty";
                  }
                  if (!regex.hasMatch(value)) {
                    return "Please enter a valid description (min. 2 characters)";
                  } else {
                    return null;
                  }
                },
                decoration: buildInputDecoration(hintText: 'What do you want to report?'),
                maxLines: 5,
                minLines: 3,
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: _personNameController,
                decoration: buildInputDecoration(hintText: 'Name of person you would like to report?'),
              ),
              const SizedBox(
                height: 30,
              ),
              _isLoading
                  ? const Center(child: LoadingView())
                  : AppElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    setState(() {
                      _isLoading = true;
                    });

                    final reportId = DateTime.now().millisecondsSinceEpoch.toString();
                    final report = Report(
                      groupId:  widget.groupId,
                      reportDescription: _descriptionController.text,
                      personName: _personNameController.text,
                      reportId: reportId,
                      reportDate: DateTime.now(),
                    );

                    firestoreProvider.saveDocument(
                      FirestoreConstants.pathReportCollection,
                      reportId,
                      report.toJson(),
                    ).then((_) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Report submitted successfully')),
                      );
                      _descriptionController.clear();
                      _personNameController.clear();
                    }).catchError((error) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Failed to submit report: $error')),
                      );
                    }).whenComplete(() {
                      setState(() {
                        _isLoading = false;
                      });
                    });
                  }
                },
                buttonText: "Report",
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
