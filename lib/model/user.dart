import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:saju/database/siji.dart';
import 'package:saju/database/tenGan.dart';
import 'package:saju/database/twelveJi.dart';
import 'package:saju/model/letter.dart';
import 'package:saju/model/sajuEightLetter.dart';

enum CalendarType { solar, lunar }

enum GenderType { M, e }

class User {
  final String id;
  final String name;
  final GenderType sex;
  final DateTime Birthday;
  final TimeOfDay? BirthTime;
  final CalendarType Solar;
  final bool Lunar;
  final bool interdalation;
  final bool Unknown;
  Saju? saju;

  User(
      {this.name = '',
      this.sex = GenderType.M,
      DateTime? birthday,
      this.Solar = CalendarType.solar,
      this.Lunar = false,
      this.interdalation = false,
      this.BirthTime,
      this.Unknown = true,
      this.saju})
      : id = _generateId(),
        age = _calculateAge(birthday ?? DateTime(1900, 1, 1)),
        Birthday = birthday ?? DateTime(1900, 1, 1);

  final int age;

  static String _generateId() {
    return DateTime.now().millisecondsSinceEpoch.toString();
  }

  static int _calculateAge(DateTime birthday) {
    // 한국나이
    DateTime today = DateTime.now();
    int age = today.year - birthday.year;
    if (today.month < birthday.month ||
        (today.month == birthday.month && today.day < birthday.day)) {
      age--;
    }
    return age;
  }

  Future<Saju> getSaju() async {
    String _formattedDate = DateFormat('yyyy-MM-dd').format(Birthday);
    String _GapjaString = '';

    if (Solar == CalendarType.solar) {
      final String response =
          await rootBundle.loadString('assets/data/solar_mansae.json');
      dynamic jsonResponse = json.decode(response);
      _GapjaString = jsonResponse[_formattedDate];
    } else {
      final String response =
          await rootBundle.loadString('assets/data/luna_mansae.json');
      dynamic jsonResponse = json.decode(response);
      _GapjaString = jsonResponse[_formattedDate];
    }
    final _a1Str = _GapjaString.substring(0, 1);
    final _a2Str = _GapjaString.substring(1, 2);
    final _a3Str = _GapjaString.substring(4, 5);
    final _a4Str = _GapjaString.substring(5, 6);
    final _a5Str = _GapjaString.substring(8, 9);
    final _a6Str = _GapjaString.substring(9, 10);
    Letter getGanByChineseLetter(String chineseLetter) {
      return TENGANBYCHINESS[chineseLetter] ?? TENGAN['-1']!;
    }

    Letter getJiByChineseLetter(String chineseLetter) {
      return TWELVEJIBYCHINESS[chineseLetter] ?? TWELVEJI[-1]!;
    }

    final Letter _a1 = getGanByChineseLetter(_a1Str);
    final Letter _a2 = getJiByChineseLetter(_a2Str);
    final Letter _a3 = getGanByChineseLetter(_a3Str);
    final Letter _a4 = getJiByChineseLetter(_a4Str);
    final Letter _a5 = getGanByChineseLetter(_a5Str);
    final Letter _a6 = getJiByChineseLetter(_a6Str);

    Letter _getSiJi(TimeOfDay? time) {
      final hour = time?.hour ?? -1;
      final minute = time?.minute ?? -1;
      var timeRange = '모름';
      if (hour == -1 && minute == -1) {
        timeRange = '모름';
      }

      if ((hour >= 23 && minute >= 30) ||
          hour == 0 ||
          hour == 1 && minute < 30) {
        timeRange = '2330~0130';
      } else if (hour == 1 && minute >= 30 ||
          hour == 2 ||
          hour == 3 && minute < 30) {
        timeRange = '0130~0330';
      } else if (hour == 3 && minute >= 30 ||
          hour == 4 ||
          hour == 5 && minute < 30) {
        timeRange = '0330~0530';
      } else if (hour == 5 && minute >= 30 ||
          hour == 6 ||
          hour == 7 && minute < 30) {
        timeRange = '0530~0730';
      } else if (hour == 7 && minute >= 30 ||
          hour == 8 ||
          hour == 9 && minute < 30) {
        timeRange = '0730~0930';
      } else if (hour == 9 && minute >= 30 ||
          hour == 10 ||
          hour == 11 && minute < 30) {
        timeRange = '0930~1130';
      } else if (hour == 11 && minute >= 30 ||
          hour == 12 ||
          hour == 13 && minute < 30) {
        timeRange = '1130~1330';
      } else if (hour == 13 && minute >= 30 ||
          hour == 14 ||
          hour == 15 && minute < 30) {
        timeRange = '1330~1530';
      } else if (hour == 15 && minute >= 30 ||
          hour == 16 ||
          hour == 17 && minute < 30) {
        timeRange = '1530~1730';
      } else if (hour == 17 && minute >= 30 ||
          hour == 18 ||
          hour == 19 && minute < 30) {
        timeRange = '1730~1930';
      } else if (hour == 19 && minute >= 30 ||
          hour == 20 ||
          hour == 21 && minute < 30) {
        timeRange = '1930~2130';
      } else if (hour == 21 && minute >= 30 ||
          hour == 22 ||
          hour == 23 && minute < 30) {
        timeRange = '2130~2330';
      } else {
        timeRange = '모름';
      }
      return SIJI[timeRange] ?? TWELVEJI[-1]!;
    }

    final Letter _a8 = _getSiJi(BirthTime);
    Letter _getSiGan(Letter a8, Letter a5) {
      if (a8.DBnum == 'e0' || a5.DBnum == 'e0') {
        return a8;
      } else {
        // a5 의 (DBNum *10 + (a8의 DBNum -3 의 절댓값 % 12 ) ) % 10  의 값을 A,B,C ... 순으로 하면서  정하면 된다.

        // 1-10 사이의 숫자
        final _a5Index = int.parse(a5.DBnum.substring(1, a5.DBnum.length));

        // 1-12 사이의 숫자
        final _a8Index = int.parse(a8.DBnum.substring(1, a8.DBnum.length));

        // 12지의 순서 보정을 위해 2개씩 순서를 앞당긴다.
        final _a8Tmp = (_a8Index - 2) % 12 == 0 ? 12 : (_a8Index - 2) % 12;
        final _siGanIndex = (((_a5Index - 1) * 12) + _a8Tmp) % 10 == 0
            ? 10
            : (((_a5Index - 1) * 12) + _a8Tmp) % 10;

        // _siGanIndex 를 A,B,C... 에 매칭하기
        final _ganKey = String.fromCharCode(65 + (_siGanIndex - 1));

        return TENGAN[_ganKey] ?? TENGAN['-1']!;
      }
    }

    final Letter _a7 = _getSiGan(_a8, _a5);
    print(
        '${_a1.chiness}, ${_a2.chiness}, ${_a3.chiness}, ${_a4.chiness}, ${_a5.chiness}, ${_a6.chiness}, ${_a7.chiness}, ${_a8.chiness}');

    Saju userSaju = Saju(
        yearHeavenly: _a1,
        yearEarthly: _a2,
        dayHeavenly: _a5,
        dayEarthly: _a6,
        monthHeavenly: _a3,
        monthEarthly: _a4,
        timeHeavenly: _a7,
        timeEarthly: _a8);

    return userSaju;
    // // setSaju함수를 호출하면 사주팔자가 나옴
    // // 윤달이 아닌경우
    // final _birthYear = Birthday.year;
    // final _birthMonth = Birthday.month;
    // final _birthDay = Birthday.day;
    // if (!interdalation) {
    //   if (Birthday != null) {
    //     // 생년월일을 바탕으로 klc 패키지에서 만세력 글자 가져오기.
    //     // 절입 조정이 필요합니다. -> 월주를 산정하는 기준
    //     // manseTable의 no(양력기준) 보다 크면 다음 월주, 아니면 해당 월주를 사용한다.
    //     // algo -> 1. 해당 연, 월을 찾는다. 2. 해당 연 월의 no(양력), um(음력) 을 나의 날짜와 비교한다. 3. 나의 날짜가 이르면 해당 문자 사용, 아니면 다음 절기 문자 사용

    //     //양력
    //     if (Solar == CalendarType.solar) {
    //       setSolarDate(_birthYear, _birthMonth, _birthDay);

    //       final lunarChineseGapja = getChineseGapJaString();
    //       print('package result $lunarChineseGapja');
    //       final _yearHeavenly = lunarChineseGapja.substring(0, 1);
    //       final _yearEarthly = lunarChineseGapja.substring(1, 2);
    //       var _monthHeavenly = lunarChineseGapja.substring(4, 5);
    //       var _monthEarthly = lunarChineseGapja.substring(5, 6);
    //       final _dayHeavenly = lunarChineseGapja.substring(8, 9);
    //       final _dayEarthly = lunarChineseGapja.substring(9, 10);
    //       // manseTable 에서 해당 절기를 찾기
    //       bool _isBeforeJeolgi() {
    //         for (var i = 0; i < manseTable.length; i++) {
    //           int manseNo = manseTable[i]['no'];
    //           int year = manseNo ~/ 10000;
    //           int month = (manseNo % 10000) ~/ 100;
    //           int day = manseNo % 100;
    //           // 1. 연도, 월을 찾는다.
    //           if (year == _birthYear && month == _birthMonth) {
    //             // 2, 해당 일이 나보다 같거나 이르면 true, 아니면 false를 return 한다.
    //             if (day >= _birthDay) {
    //               return true;
    //             } else {
    //               return false;
    //             }
    //           }
    //         }
    //         return true;
    //       }

    //       final _isMonthlyAvailable = _isBeforeJeolgi();
    //       print(_isMonthlyAvailable);
    //       // 월주 변경 필요
    //       if (!_isMonthlyAvailable) {
    //         var _currentGapja = _monthHeavenly + _monthEarthly;
    //         for (var j = 0; j < SIXTYGAPJA.length; j++) {
    //           if (SIXTYGAPJA[j] == _currentGapja) {
    //             _currentGapja = SIXTYGAPJA[(j + 1) % SIXTYGAPJA.length];
    //             break;
    //           }
    //         }

    //         _monthHeavenly = _currentGapja.substring(0, 1);
    //         _monthEarthly = _currentGapja.substring(1, 2);
    //       }
    //       print(
    //           '양력 입력 결과 $_yearHeavenly$_yearEarthly, $_monthHeavenly$_monthEarthly, $_dayHeavenly$_dayEarthly');
    //     }
    //     //음력
    //     else {
    //       setLunarDate(
    //           Birthday.year, Birthday.month, Birthday.day, interdalation);

    //       final lunarChineseGapja = getChineseGapJaString();

    //       final _yearHeavenly = lunarChineseGapja.substring(0, 1);
    //       final _yearEarthly = lunarChineseGapja.substring(1, 2);
    //       var _monthHeavenly = lunarChineseGapja.substring(4, 5);
    //       var _monthEarthly = lunarChineseGapja.substring(5, 6);
    //       final _dayHeavenly = lunarChineseGapja.substring(8, 9);
    //       final _dayEarthly = lunarChineseGapja.substring(9, 10);
    //       // manseTable 에서 해당 절기를 찾기
    //       bool _isBeforeJeolgi() {
    //         for (var i = 0; i < manseTable.length; i++) {
    //           int manseNo = manseTable[i]['umdate'];
    //           int year = manseNo ~/ 10000;
    //           int month = (manseNo % 10000) ~/ 100;
    //           int day = manseNo % 100;
    //           // 1. 연도, 월을 찾는다.
    //           if (year == _birthYear && month == _birthMonth) {
    //             // 2, 해당 일이 나보다 같거나 이르면 true, 아니면 false를 return 한다.
    //             if (day >= _birthDay) {
    //               return true;
    //             } else {
    //               return false;
    //             }
    //           }
    //         }
    //         return true;
    //       }

    //       final _isMonthlyAvailable = _isBeforeJeolgi();
    //       print(_isMonthlyAvailable);
    //       // 월주 변경 필요
    //       if (!_isMonthlyAvailable) {
    //         var _currentGapja = _monthHeavenly + _monthEarthly;
    //         for (var j = 0; j < SIXTYGAPJA.length; j++) {
    //           if (SIXTYGAPJA[j] == _currentGapja) {
    //             _currentGapja = SIXTYGAPJA[(j + 1) % SIXTYGAPJA.length];
    //             break;
    //           }
    //         }

    //         _monthHeavenly = _currentGapja.substring(0, 1);
    //         _monthEarthly = _currentGapja.substring(1, 2);
    //       }
    //       print(
    //           '음력 입력 결과 $_yearHeavenly$_yearEarthly, $_monthHeavenly$_monthEarthly, $_dayHeavenly$_dayEarthly');
    //     }
    //   }
    // }
  }

  User copyWith(
      {String? name,
      GenderType? sex,
      DateTime? birthday,
      TimeOfDay? birthTime,
      CalendarType? solar,
      bool? lunar,
      bool? intercalation,
      bool? unknown,
      Saju? saju}) {
    return User(
        name: name ?? this.name,
        sex: sex ?? this.sex,
        birthday: birthday ?? this.Birthday,
        Solar: solar ?? this.Solar,
        Lunar: lunar ?? this.Lunar,
        interdalation: intercalation ?? this.interdalation,
        BirthTime: birthTime,
        Unknown: unknown ?? this.Unknown,
        saju: saju ?? saju);
  }
}
