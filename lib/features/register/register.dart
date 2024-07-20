import 'dart:io';
import 'package:date_field/date_field.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nursing_mother_medical_app/config/app_colors.dart';
import 'package:nursing_mother_medical_app/config/app_measurements.dart';
import 'package:nursing_mother_medical_app/config/app_strings.dart';
import 'package:nursing_mother_medical_app/reusables/form/app_button.dart';
import 'package:provider/provider.dart';
import '../../model/model.dart';
import '../../reusables/form/input_decoration.dart';
import '../../provider/auth_provider.dart';
import '../home/home.dart';
import '../login/login.dart';

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
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _firstnameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _hcpController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  DateTime? selectedDate;
  File? _image;

  @override
  void dispose() {
    _firstnameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _hcpController.dispose();
    _bioController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProviders>(context);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (authProvider.status.type == StatusType.authenticateError) {
        Fluttertoast.showToast(msg: authProvider.status.errorMessage ?? "Registration failed");
      } else if (authProvider.status.type == StatusType.authenticated) {
        Fluttertoast.showToast(msg: "Registration successful");
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const HomePage()));
      }
    });

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
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(color: AppColors.black),
                        ),
                        const SizedBox(height: 10),
                        GestureDetector(
                          onTap: _pickImage,
                          child: CircleAvatar(
                            radius: 40,
                            backgroundImage: _image != null ? FileImage(_image!) : null,
                            child: _image == null ? const Icon(Icons.add_a_photo, size: 40, color: AppColors.black) : null,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                if (widget.userType == "professional")
                  TextFormField(
                    controller: _hcpController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "HCP cannot be empty";
                      }
                      return null;
                    },
                    decoration: buildInputDecoration(hintText: 'HCP'),
                  ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _firstnameController,
                  validator: (value) {
                    RegExp regex = RegExp(r'^.{2,}$');
                    if (value!.isEmpty) {
                      return "First Name cannot be empty";
                    }
                    if (!regex.hasMatch(value)) {
                      return "Please enter a valid first name with at least 2 characters";
                    }
                    return null;
                  },
                  decoration: buildInputDecoration(hintText: 'First Name'),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _emailController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Email cannot be empty";
                    }
                    if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]").hasMatch(value)) {
                      return "Please enter a valid email";
                    }
                    return null;
                  },
                  decoration: buildInputDecoration(hintText: 'Email', icon: Icons.email),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _passwordController,
                  validator: (value) {
                    RegExp regex = RegExp(r'^.{6,}$');
                    if (value!.isEmpty) {
                      return "Password cannot be empty";
                    }
                    if (!regex.hasMatch(value)) {
                      return "Please enter a valid password with at least 6 characters";
                    }
                    return null;
                  },
                  decoration: buildInputDecoration(hintText: 'Password', icon: Icons.lock),
                  obscureText: true,
                ),
                const SizedBox(height: 20),
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
                const SizedBox(height: 20),
                TextFormField(
                  controller: _bioController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Bio cannot be empty";
                    }
                    if (value.length < 10) {
                      return "Please enter a valid bio with at least 10 characters";
                    }
                    return null;
                  },
                  decoration: buildInputDecoration(hintText: 'Bio'),
                ),
                const SizedBox(height: 20),
                authProvider.status.type == StatusType.authenticating
                    ? const Center(child: CircularProgressIndicator())
                    : AppElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      if (_image == null) {
                        Fluttertoast.showToast(msg: "Please upload a profile picture");
                        return;
                      }

                      Signup register = Signup(
                        firstname: _firstnameController.text,
                        email: _emailController.text,
                        password: _passwordController.text,
                        hcp: widget.userType == "professional" ? _hcpController.text : "",
                        dateofbirth: selectedDate?.toIso8601String() ?? "",
                        bio: _bioController.text, userType: widget.userType,
                      );

                      await authProvider.registerAndCreateUser(register, _image!);
                    }
                  },
                  buttonText: "Submit",
                ),
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Login(),
                      ),
                    );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Already have an account?",
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(color: AppColors.black),
                      ),
                      const SizedBox(width: 5),
                      Text(
                        "Sign In",
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(color: AppColors.primary),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
