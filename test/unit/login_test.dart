import 'package:flutter_test/flutter_test.dart';

bool isSignInEnabled(String email, String password) {
  return email.isNotEmpty && password.isNotEmpty;
}

String? passwordValidator(String? value) {
  if (value == null || value.isEmpty) return 'Please enter password';
  if (value.length < 6) return 'Password too short';
  return null;
}

void main() {
  group('Sign In Button Enable Logic', () {
    test('Returns false when email is empty', () {
      expect(isSignInEnabled('', 'password123'), false);
    });

    test('Returns false when password is empty', () {
      expect(isSignInEnabled('test@example.com', ''), false);
    });

    test('Returns true when email and password are not empty', () {
      expect(isSignInEnabled('test@example.com', 'password123'), true);
    });
  });

  group('Password Validator', () {
    test('Returns error when password is null', () {
      expect(passwordValidator(null), 'Please enter password');
    });

    test('Returns error when password is empty', () {
      expect(passwordValidator(''), 'Please enter password');
    });

    test('Returns error when password is too short', () {
      expect(passwordValidator('123'), 'Password too short');
    });

    test('Returns null when password is valid', () {
      expect(passwordValidator('password123'), null);
    });
  });
}
