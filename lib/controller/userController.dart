import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:saju/model/user.dart';

class UserController extends StateNotifier<User> {
  UserController() : super(User());

  void updateName(String name) {
    state = state.copyWith(name: name);
  }

  void updateBirthDate(DateTime birthDate) {
    state = state.copyWith(birthday: birthDate);
  }

  void updateBirthTime(TimeOfDay? birthTime) {
    state = state.copyWith(birthTime: birthTime);
  }

  void updateCalendarType(CalendarType calendarType) {
    state = state.copyWith(solar: calendarType);
  }

  void updateGenderType(GenderType genderType) {
    state = state.copyWith(sex: genderType);
  }

  Future<void> setSaju() async {
    await state.getSaju().then((value) => state = state.copyWith(saju: value));
  }
}

final userProvider = StateNotifierProvider<UserController, User>((ref) {
  return UserController();
});
