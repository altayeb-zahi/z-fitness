import 'package:flutter/material.dart';

class MainButton extends StatelessWidget {
  final void Function() onTap;
  final String title;
  final bool busy;

  const MainButton(
      {Key? key, required this.onTap, required this.title, this.busy = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SizedBox(
      height: 45,
      width: double.infinity,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              primary: theme.colorScheme.primary,
              onPrimary: theme.colorScheme.onPrimary,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0))),
          onPressed: onTap,
          child: busy
              ? CircularProgressIndicator(
                  color: theme.colorScheme.onPrimary,
                )
              : Text(
                  title,
                  style: theme.textTheme.titleSmall!.copyWith(
                      color: theme.colorScheme.onPrimary,
                      fontWeight: FontWeight.bold),
                )),
    );
  }
}
