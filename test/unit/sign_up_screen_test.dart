import 'package:flutter_test/flutter_test.dart';
import 'package:food_delivery/features/auth/presentation/pages/signup/sign_up.dart';

void main() {
  group('_updateRegisterButtonState', () {
    late SignUpScreenState signUpScreenState;

    setUp(() {
      signUpScreenState = SignUpScreenState();
      signUpScreenState.emailController.text = "sharobidinovasevinch@gmail.com";
      signUpScreenState.passwordController.text = '123456';
    });

    tearDown(() {
      signUpScreenState.emailController.dispose();
      signUpScreenState.passwordController.dispose();
    });

    test('Aktiv emas: email va parol boʻsh', () {
      signUpScreenState.updateRegisterButtonState();
      expect(signUpScreenState.isRegisterEnabled, false);
    });

    test('Aktiv emas: email notoʻgʻri formatda', () {
      signUpScreenState.emailController.text = 'not-an-email';
      signUpScreenState.passwordController.text = 'password123';
      signUpScreenState.updateRegisterButtonState();
      expect(signUpScreenState.isRegisterEnabled, false);
    });

    test('Aktiv emas: parol 6 belgidan qisqa', () {
      signUpScreenState.emailController.text = 'user@example.com';
      signUpScreenState.passwordController.text = '12345';
      signUpScreenState.updateRegisterButtonState();
      expect(signUpScreenState.isRegisterEnabled, false);
    });

    test('email va parol toʻgʻri', () {
      signUpScreenState.emailController.text = 'sharobidinovasevinch@gmail.com';
      signUpScreenState.passwordController.text = '123456';
      signUpScreenState.updateRegisterButtonState();
      expect(signUpScreenState.isRegisterEnabled, false);
    });
  });
}