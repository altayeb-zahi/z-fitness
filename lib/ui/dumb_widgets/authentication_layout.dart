import 'package:auth_buttons/auth_buttons.dart';
import 'package:flutter/material.dart';
import 'package:universal_io/io.dart';

import '../shared/styles.dart';
import '../shared/ui_helpers.dart';

class AuthenticationLayout extends StatelessWidget {
  final String? title;
  final String? subtitle;
  final String? mainButtonTitle;
  final Widget? form;
  final bool showTermsText;
  final void Function()? onMainButtonTapped;
  final void Function()? onCreateAccountTapped;
  final void Function()? onForgotPassword;
  final void Function()? onBackPressed;
  final void Function()? onSignInWithApple;
  final void Function()? onSignInWithGoogle;
  final String? validationMessage;
  final bool busy;

  const AuthenticationLayout({
    Key? key,
    this.title,
    this.subtitle,
    this.mainButtonTitle,
    this.form,
    this.onMainButtonTapped,
    this.onCreateAccountTapped,
    this.onForgotPassword,
    this.onBackPressed,
    this.onSignInWithApple,
    this.onSignInWithGoogle,
    this.validationMessage,
    this.showTermsText = false,
    this.busy = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: ListView(
        children: [
          if (onBackPressed == null) verticalSpaceLarge,
          if (onBackPressed != null) verticalSpaceRegular,
          if (onBackPressed != null)
            IconButton(
              padding: EdgeInsets.zero,
              alignment: Alignment.centerLeft,
              icon: const Icon(
                Icons.arrow_back_ios,
                color: Colors.black,
              ),
              onPressed: onBackPressed,
            ),
          Text(
            title!,
            style: const TextStyle(fontSize: 34),
          ),
          verticalSpaceSmall,
          Align(
            alignment: Alignment.centerLeft,
            child: SizedBox(
              width: screenWidthPercentage(context, percentage: 0.7),
              child: Text(
                subtitle!,
                style: theme.textTheme.titleMedium!
                    .copyWith(color: theme.textTheme.caption!.color),
              ),
            ),
          ),
          verticalSpaceRegular,
          form!,
          verticalSpaceRegular,
          if (onForgotPassword != null)
            Align(
              alignment: Alignment.centerRight,
              child: GestureDetector(
                  onTap: onForgotPassword,
                  child: Text(
                    'Forget Password?',
                    style: theme.textTheme.bodyText2!.copyWith(
                        fontWeight: FontWeight.bold,
                        color: theme.colorScheme.tertiary),
                  )),
            ),
          verticalSpaceMedium,
          if (validationMessage != null)
            Text(
              validationMessage!,
              style: TextStyle(
                color: theme.colorScheme.error,
                fontSize: kBodyTextSize,
              ),
            ),
          if (validationMessage != null) verticalSpaceRegular,
          GestureDetector(
            onTap: onMainButtonTapped,
            child: Container(
              width: double.infinity,
              height: 50,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: theme.colorScheme.primary,
                borderRadius: BorderRadius.circular(8),
              ),
              child: busy
                  ? const CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation(Colors.white),
                    )
                  : Text(
                      mainButtonTitle!,
                      style: TextStyle(
                          color: theme.colorScheme.onPrimary,
                          fontWeight: FontWeight.bold,
                          fontSize: 14),
                    ),
            ),
          ),
          verticalSpaceRegular,
          if (onCreateAccountTapped != null)
            GestureDetector(
              onTap: onCreateAccountTapped,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Don\'t have an account?'),
                  horizontalSpaceTiny,
                  Text(
                    'Create an account',
                    style: TextStyle(color: theme.colorScheme.secondary),
                  )
                ],
              ),
            ),
          if (showTermsText)
            Text(
              'By signing up you agree to our terms, conditions and privacy policy.',
              style: theme.textTheme.caption,
              textAlign: TextAlign.center,
            ),
          verticalSpaceRegular,
          const Align(
              alignment: Alignment.center,
              child: Text(
                'Or',
                style: ktsMediumGreyBodyText,
              )),
          verticalSpaceRegular,
          if (Platform.isIOS)
            AppleAuthButton(
              onPressed: onSignInWithApple ?? () {},
              darkMode: true,
              text: 'CONTINUE WITH APPLE',
              style: const AuthButtonStyle(
                iconSize: 24,
                height: 50,
                // textStyle: TextStyle(color: Colors.black),
                buttonType: AuthButtonType.secondary,
              ),
            ),
          verticalSpaceRegular,
          GoogleAuthButton(
            onPressed: onSignInWithGoogle ?? () {},
            text: 'CONTINUE WITH GOOGLE',
            style: const AuthButtonStyle(
              iconSize: 24,
              iconBackground: Colors.white,
              buttonType: AuthButtonType.secondary,
              height: 50,
              textStyle: TextStyle(color: Colors.white),
            ),
          )
        ],
      ),
    );
  }
}
