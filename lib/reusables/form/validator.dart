
String? validatePassword(String? value) {
  RegExp regex = RegExp(r'^.{6,}$');
  if (value!.isEmpty) {
    return "Password cannot be empty";
  }
  if (!regex.hasMatch(value)) {
    return "Please enter a valid password, minimum 6 characters";
  } else {
    return null;
  }
}