// import 'package:flutter/material.dart';

// import '../../enums/calories_related_models.dart';

// class GenderUi {
//   String name;
//   IconData icon;
//   bool isSelected;
//   Gender gender;

//   GenderUi(this.name, this.icon, this.isSelected, this.gender);
// }


// class GenderSelector extends StatefulWidget {
//   const GenderSelector({ Key? key }) : super(key: key);

//   @override
//   State<GenderSelector> createState() => _GenderSelectorState();
// }

// class _GenderSelectorState extends State<GenderSelector> {
//   GenderUi? _selectedGender;

//    var genders = [
//     GenderUi("Male", Icons.arrow_upward, false, Gender.male),
//     GenderUi("Female", Icons.arrow_downward, false, Gender.female),
//   ];

//   void onGenderPressed(int index) {
//     genders.forEach((gender) => gender.isSelected = false);
//     genders[index].isSelected = true;
//     _selectedGender = genders[index];
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Container(
//             height: 180,
//             alignment: Alignment.center,
//             child: ListView.builder(
//               scrollDirection: Axis.horizontal,
//               shrinkWrap: true,
//               itemBuilder: (context, index) => GestureDetector(
//                 onTap: () => model.onGenderPressed(index),
//                 child: Card(
//                     color: model.genders[index].isSelected
//                         ? Color(0xFF3B4257)
//                         : Colors.white,
//                     child: Container(
//                       height: 160,
//                       width: 170,
//                       alignment: Alignment.center,
//                       margin: const EdgeInsets.all(5.0),
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         children: <Widget>[
//                           Icon(
//                             model.genders[index].icon,
//                             color: model.genders[index].isSelected
//                                 ? Colors.white
//                                 : Colors.grey,
//                             size: 40,
//                           ),
//                           const SizedBox(height: 10),
//                           Text(
//                             model.genders[index].name,
//                             style: TextStyle(
//                                 color: model.genders[index].isSelected
//                                     ? Colors.white
//                                     : Colors.grey),
//                           )
//                         ],
//                       ),
//                     )),
//               ),
//               itemCount: 2,
//             ),
//           ),
//         ],
//       );
//   }
// }