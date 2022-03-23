import 'package:flutter/material.dart';

class RecipesView extends StatefulWidget {
  const RecipesView({ Key? key }) : super(key: key);

  @override
  State<RecipesView> createState() => _RecipesViewState();
}

class _RecipesViewState extends State<RecipesView> {
  @override
  Widget build(BuildContext context) {
   return const Scaffold(
      body: Center(child: Text('Recipes view')),
    );
  }
}