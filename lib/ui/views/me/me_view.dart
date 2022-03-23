import 'package:flutter/material.dart';

class MeView extends StatefulWidget {
  const MeView({ Key? key }) : super(key: key);

  @override
  State<MeView> createState() => _MeViewState();
}

class _MeViewState extends State<MeView> {
  @override
  Widget build(BuildContext context) {
   return const Scaffold(
      body: Center(child: Text('Me view')),
    );
  }
}