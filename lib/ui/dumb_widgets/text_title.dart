import 'package:flutter/material.dart';

class TextTitle extends StatelessWidget {
  final String title;
  const TextTitle(
     this.title,
    
    {

    Key? key,    
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Text(
      title,
      style: theme.textTheme.headline3,
    );
  }
}
