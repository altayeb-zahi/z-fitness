import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:z_fitness/ui/views/me/me_view_model.dart';
class MeView extends StatelessWidget {
  const MeView({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = MeViewModel();

    return SafeArea(
      child:  StreamBuilder<DocumentSnapshot>(
            stream: model.getCurrentUSerStream(),
            builder:
                (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
              if (snapshot.hasError) {
                return const Text('Something went wrong');
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return Container();
              }

              return Container();
            }),
    );
  }
}