import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../dumb_widgets/authentication_layout.dart';
import 'login_view_model.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final model = LoginViewModel();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => model,
      child: Consumer<LoginViewModel>(
        builder: (context, model, child) => Scaffold(
            body: AuthenticationLayout(
          busy: model.isBusy,
          onMainButtonTapped: ()=> model.loginWithEmail(email: emailController.text, passowrd: passwordController.text),
          onCreateAccountTapped: model.navigateToCreateAccount,
          validationMessage: model.validationMessage,
          title: 'Welcome',
          subtitle: 'Enter your email address to sign in. Enjoy your food',
          mainButtonTitle: 'SIGN IN',
          form: Column(
            children: [
              TextField(
                decoration: const InputDecoration(labelText: 'Email'),
                controller: emailController,
              ),
              TextField(
                decoration: const InputDecoration(labelText: 'Password'),
                controller: passwordController,
              ),
            ],
          ),
          onForgotPassword: () {},
          onSignInWithGoogle: model.useGoogleAuthentication,
          onSignInWithApple: model.useAppleAuthentication,
        )),
      ),
    );
  }
}
