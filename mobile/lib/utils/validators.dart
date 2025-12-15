class Validators {
  static String? validatePhone(String? value) {
    if (value == null || value.isEmpty) return 'Phone is required';
    if (value.length != 10) return 'Phone must be 10 digits';
    return null;
  }

  static String? validateOTP(String? value) {
    if (value == null || value.length != 6) {
      return 'OTP must be 6 digits';
    }
    return null;
  }
}
