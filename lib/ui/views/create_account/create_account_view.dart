import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../dumb_widgets/authentication_layout.dart';
import 'create_account_view_model.dart';

class CreateAccountView extends StatefulWidget {
  const CreateAccountView({Key? key}) : super(key: key);

  @override
  _CreateAccountViewState createState() => _CreateAccountViewState();
}

class _CreateAccountViewState extends State<CreateAccountView> {
  final model = CreateAccountViewModel();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final fullNameController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    fullNameController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (
        BuildContext context,
      ) =>
          model,
      child: Consumer<CreateAccountViewModel>(
        builder: (context, model, child) => Scaffold(
            body: AuthenticationLayout(
          busy: model.isBusy,
          onMainButtonTapped: () => model.createAccountWithEmail(
              email: emailController.text,
              passowrd: passwordController.text,
              username: fullNameController.text),
          onBackPressed: model.navigateBack,
          validationMessage: model.validationMessage,
          title: 'Create Account',
          subtitle: 'Enter your name, email and password for sign up.',
          mainButtonTitle: 'SIGN UP',
          form: Column(
            children: [
              TextField(
                decoration: const InputDecoration(labelText: 'Full Name'),
                controller: fullNameController,
              ),
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
          showTermsText: true,
        )),
      ),
    );
  }
}
