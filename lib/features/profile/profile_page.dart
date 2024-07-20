import 'package:flutter/material.dart';
import 'package:nursing_mother_medical_app/config/app_colors.dart';
import 'package:nursing_mother_medical_app/config/app_strings.dart';
import 'package:nursing_mother_medical_app/features/supportlibrary/support_library.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../reusables/LoadingView.dart';
import '../appointment/my_appointment_page.dart';
import '../appointment/proffesional_appointment_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String? _firstName;
  String? _email;
  String? _bio;
  String? _photoUrl;
  String? _userType;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadUserProfile();
  }

  Future<void> _loadUserProfile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _firstName = prefs.getString('firstname') ?? '';
      _email = prefs.getString('email') ?? '';
      _bio = prefs.getString('bio') ?? '';
      _photoUrl = prefs.getString('photoUrl') ?? 'assets/images/profile_pic.png';
      _userType = prefs.getString('userType');
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          AppStrings.profile,
          style: Theme.of(context)
              .textTheme
              .titleSmall
              ?.copyWith(color: AppColors.black),
          textAlign: TextAlign.center,
        ),
        backgroundColor: AppColors.bgColor,
      ),
      body: _isLoading
          ? const Center(child: LoadingView())
          : Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: ClipOval(
                child: Image(
                  image: _photoUrl != null && _photoUrl!.startsWith('assets')
                      ? AssetImage(_photoUrl!) as ImageProvider
                      : NetworkImage(_photoUrl!),
                  width: 100,
                  height: 100,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Center(
              child: Text(
                _firstName ?? '',
                style: Theme.of(context)
                    .textTheme
                    .titleSmall
                    ?.copyWith(color: AppColors.black),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 10),
            Center(
              child: Text(
                _email ?? '',
                style: Theme.of(context)
                    .textTheme
                    .labelSmall
                    ?.copyWith(color: AppColors.black, decoration: TextDecoration.underline),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 15),
            Center(
              child: Text(
                _bio ?? '',
                style: Theme.of(context)
                    .textTheme
                    .labelSmall
                    ?.copyWith(color: AppColors.black),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 15),
            GestureDetector(
              child: CardItem(
                cardItem: const {
                  'title': 'My Appointments',
                  'image': 'assets/images/messaging_item_icon.png',
                },
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => _userType == 'professional'
                        ? const ProfessionalAppointmentPage()
                        : const MyAppointmentPage(),
                  ),
                );
              },
            ),
            const SizedBox(height: 5),
            GestureDetector(
              child: CardItem(
                cardItem: const {
                  'title': 'Suggest Chat Topic',
                  'image': 'assets/images/messaging_item_icon.png',
                },
              ),
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}
