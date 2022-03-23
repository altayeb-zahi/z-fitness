import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:z_fitness/ui/base/base_view_model.dart';
import '../../../app/locator.dart';
import '../../../services/user_service.dart';

class BirthdaySelectorViewModel extends BaseViewModel {
  // final _currentUser = locator<UserService>().currentUser;

  String? _dateOfBirth = locator<UserService>().currentUser!.dateOfBirth;
  String? get dateOfBirth => _dateOfBirth;

  
  Future pickDate(BuildContext context) async {
    final initialDate = DateTime.now();
    final newDate = await showDatePicker(
        context: context,
        initialDate: initialDate,
        firstDate: DateTime(DateTime.now().year - 120),
        lastDate: DateTime.now());

    if (newDate == null) return;

    String formattedDate = DateFormat('dd-MM-yyyy').format(newDate);
    _dateOfBirth = formattedDate;
    notifyListeners();
  }
}
