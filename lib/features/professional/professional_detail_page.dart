import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../config/app_colors.dart';
import '../../config/firestore_constants.dart';
import '../../model/model.dart';
import '../../reusables/form/app_button.dart';
import '../appointment/book_appointment.dart';

class ProfessionalDetailPage extends StatefulWidget {
  final User professional;

  const ProfessionalDetailPage({required this.professional, super.key});

  @override
  State<ProfessionalDetailPage> createState() => _ProfessionalDetailPageState();
}

class _ProfessionalDetailPageState extends State<ProfessionalDetailPage> {
  String? _userId;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadUserId();
  }

  Future<void> _loadUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _userId = prefs.getString(FirestoreConstants.id);
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Scaffold(
        appBar: AppBar(),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    bool isProfessional = _userId == widget.professional.id;

    return Scaffold(
      appBar: AppBar(
        title: Text(''),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);  // Go back to the previous page
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: ClipOval(
                child: Image.network(
                  widget.professional.photoUrl,
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              widget.professional.firstname,
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .titleSmall
                  ?.copyWith(color: AppColors.black),
            ),
            Text(
              widget.professional.hcp,
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .labelSmall
                  ?.copyWith(color: AppColors.black),
            ),
            const SizedBox(height: 16),
            Text(
              widget.professional.bio,
              textAlign: TextAlign.start,
              style: const TextStyle(
                  fontSize: 12,
                  color: AppColors.greyTextColor,
                  fontWeight: FontWeight.w300
              ),
            ),
            const SizedBox(height: 40),
            if (!isProfessional)
              AppElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BookAppointment(
                        professional: widget.professional,
                      ),
                    ),
                  );
                },
                buttonText: "Book Appointment",
              ),
          ],
        ),
      ),
    );
  }
}
