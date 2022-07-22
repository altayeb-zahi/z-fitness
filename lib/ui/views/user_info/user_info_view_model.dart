import 'package:stacked_services/stacked_services.dart';

import '../../../app/locator.dart';
import '../../../app/router.dart';
import '../../../models/user.dart';
import '../../../services/calories_service.dart';
import '../../../services/user_service.dart';
import '../../base/base_view_model.dart';

class UserInfoViewModel extends BaseViewModel {
  final _userService = locator<UserService>();
  final _navigationService = locator<NavigationService>();
  final _caloriesService = locator<CaloriesService>();

  User? get currentUser => locator<UserService>().currentUser;
  String? get selectedGender => _selectedGender;
  String? get dateOfBirth => _dateOfBirth;

  String? _selectedGender;
  String? _dateOfBirth;

  late int _height;
  late int _currentWeight;
  late int _desiredWeight;
  late String _activityLevel;

  void setHeight(int height) => _height = height;

  void setCurrentWeightValue(int value) => _currentWeight = value;

  void setDesiredWeightValue(int value) => _desiredWeight = value;

  void setActitvityLevel(String activityLevel) =>
      _activityLevel = activityLevel;

  void setGender(String gender) {
    _selectedGender = gender;
    notifyListeners();
  }

  void setDateOfBirth(String? dateOfBirth) {
    _dateOfBirth = dateOfBirth;
    notifyListeners();
  }

  void onSaveButtonTaped() {
    bool _canSave = dateOfBirth != null && selectedGender != null;

    if (_canSave) {
      saveUserInfo();
    }
  }

  Future<void> saveUserInfo() async {
    final _isEditing = currentUser!.hasWeightInfo;

    setBusy(true);

    User _user = await _getUserUpdatedDetails();
    await _userService.updateUserInfo(user: _user);

    setBusy(false);

    if (_isEditing) {
      // user updating his info from me view
      _navigationService.back();
    } else {
      // user adding his info first time while creating account
      _navigationService.clearStackAndShow(Routes.homeView);
    }
  }

  Future<User> _getUserUpdatedDetails() async {
    var _caloriesDetails = _caloriesService.caloriesDetails;

    var _user = User(
      id: currentUser!.id,
      name: currentUser!.name,
      email: currentUser!.email,
      gender: _selectedGender,
      activityLevel: _activityLevel.toString(),
      height: _height,
      currentWeight: _currentWeight,
      desiredWeight: _desiredWeight,
      dateOfBirth: _dateOfBirth,
    );

    await _caloriesService.syncCaloriesGoal(_user);

    _caloriesDetails.dailyCaloriesGoal =
        _caloriesService.dailyCaloriesGoal.toInt();
    _user.dailyCaloriesGoal = _caloriesService.dailyCaloriesGoal;
    _user.bmr = _caloriesService.bmr;
    _user.age = _caloriesService.age;

    _user.caloriesDetails = _caloriesDetails;

    return _user;
  }

  void onModelReady() {
    final _currentUSer = _userService.currentUser;

    _selectedGender = _currentUSer!.gender;
    _dateOfBirth = _currentUSer.dateOfBirth;
    _height = _currentUSer.height ?? 160;
    _currentWeight = _currentUSer.currentWeight ?? 70;
    _desiredWeight = _currentUSer.desiredWeight ?? 70;
    _activityLevel = _currentUSer.activityLevel ?? 'not active';
  }
}
