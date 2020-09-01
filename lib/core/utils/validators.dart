class Validators {
  final emailRegExp = RegExp(
      r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$");

  String validateEmail(String email) {
    if (!emailRegExp.hasMatch(email.trim())) {
      return 'Enter a valid email address';
    }
    return null;
  }

  String validatePhoneNumber(String phoneNumber) {
    if (phoneNumber.length < 10) {
      return 'Enter a valid phone number';
    }
    return null;
  }

  String validatePassword(String password) {
    if (password.trim().isEmpty) {
      return 'Enter a password';
    } else if (password.trim().length < 6) {
      return 'Enter a valid password';
    }
    return null;
  }

  String validateName(String name) {
    if (name.trim().isEmpty) {
      return 'Enter a name';
    } else if (name.trim().length < 3) {
      return 'Enter a valid name';
    }
    return null;
  }

  String validateOTP(String otp) {
    if (otp.trim().isEmpty) {
      return 'Enter a otp';
    } else if (otp.trim().length < 6) {
      return 'Enter a valid otp';
    }
    return null;
  }
}
