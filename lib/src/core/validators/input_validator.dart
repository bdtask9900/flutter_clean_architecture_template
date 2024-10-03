class InputValidator {
  static String? validateEmail(String? email) {
    if (email == null || email.isEmpty) {
      return 'Email cannot be empty';
    } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(email)) {
      return 'Enter a valid email';
    }
    return null;
  }

  static String? validatePassword(String? password) {
    if (password == null || password.isEmpty) {
      return 'Password cannot be empty';
    } else if (password.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }

  static String? confirmPassword(String? password, String? confirmPassword) {
    if (password != confirmPassword) {
      return 'Passwords do not match';
    }
    return null;
  }
}
