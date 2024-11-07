import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:saju/common/custom_container.dart';
import 'package:saju/common/custom_text_form_filed.dart';
import 'package:saju/constants/colors.dart';
import 'package:saju/constants/data.dart';
import 'package:saju/controller/userController.dart';
import 'package:saju/features/userInfo/Component/date_picker_solar_lunar.dart';
import 'package:saju/features/userInfo/Component/time_picker_am_pm.dart';
import 'package:saju/model/user.dart';

class UserInfoScreen extends ConsumerStatefulWidget {
  const UserInfoScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _UserInfoScreenState();
}

class _UserInfoScreenState extends ConsumerState<UserInfoScreen> {
  late final DateTime _minDate;
  late final DateTime _maxDate;
  late DateTime _selectedDate;
  late final DateTime _minTime;
  late final DateTime _maxTime;
  late DateTime _selectedTime;
  @override
  void initState() {
    super.initState();

    // WidgetsBinding.instance.addPostFrameCallback((_) => initPlugin());

    final currentDate = DateTime.now();
    _minDate = DateTime(
      1900,
      1,
      1,
      1,
    );
    _maxDate = DateTime(
      currentDate.year,
      currentDate.month,
      currentDate.day,
    );

    _minTime = DateTime(
      2000,
      1,
      1,
      0,
      0,
    );
    _maxTime = DateTime(
      2000,
      12,
      31,
      23,
      59,
    );
    _selectedDate = DateTime(1990, 01, 01);
    _selectedTime = DateTime(1990, 01, 01, 00, 00);
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userProvider);
    final userController = ref.read(userProvider.notifier);

    return Scaffold(
        // appBar: AppBar(title: const Text('사주를 입력하세요')),
        body: SafeArea(
            child: Padding(
      padding: EdgeInsets.all(12),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              '운세풀이를 위해 정보를 \n정확히 입력해 주세요.',
              style: TextStyle(
                  color: OdoSajuColors.black01,
                  fontWeight: FontWeight.w700,
                  fontSize: 20.0),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * (40 / 812),
            ),
            CustomTextFormField(
              initialValue: user.name ?? '',
              inputFormatters: [
                LengthLimitingTextInputFormatter(10),
              ],
              contentPadding: EdgeInsets.only(left: widthRatio(20)),

              // counter: AlignTextCounter(),
              maxLength: 10,
              maxLines: 1,
              textInputAction: TextInputAction.done,
              keyboardType: TextInputType.name,
              autofocus: false,
              hintText: '이름',
              onChanged: (value) {
                userController.updateName(value);
              },
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * (20 / 812),
            ),
            Row(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * (168 / 375),
                  height: MediaQuery.of(context).size.height * (56 / 812),
                  child: TextButton(
                    onPressed: () {
                      userController.updateGenderType(GenderType.M);
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.resolveWith(
                          (states) => user.sex == GenderType.M
                              ? OdoSajuColors.lightBlueGreyDarker
                              : OdoSajuColors.white),
                      shape: MaterialStateProperty.resolveWith(
                        (states) => user.sex == GenderType.M
                            ? RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16.0),
                                side: BorderSide(
                                  color: OdoSajuColors.greyBlue,
                                ),
                              )
                            : RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16.0),
                                side: BorderSide(
                                  color: OdoSajuColors.lightBlueGrey,
                                ),
                              ),
                      ),
                    ),
                    child: const Text(
                      '남자',
                      style: TextStyle(color: OdoSajuColors.black01),
                    ),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * (7 / 375),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * (168 / 375),
                  height: MediaQuery.of(context).size.height * (56 / 812),
                  child: TextButton(
                    onPressed: () {
                      userController.updateGenderType(GenderType.e);
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.resolveWith(
                          (states) => user.sex == GenderType.e
                              ? OdoSajuColors.lightBlueGreyDarker
                              : OdoSajuColors.white),
                      shape: MaterialStateProperty.resolveWith(
                        (states) => user.sex == GenderType.e
                            ? RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16.0),
                                side: BorderSide(
                                  color: OdoSajuColors.greyBlue,
                                ),
                              )
                            : RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16.0),
                                side: BorderSide(
                                  color: OdoSajuColors.lightBlueGrey,
                                ),
                              ),
                      ),
                    ),
                    child: Text(
                      '여자',
                      style: TextStyle(color: OdoSajuColors.black01),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * (48 / 812),
            ),
            TextButton(
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
              ),
              onPressed: () {
                _showDateDialog(user, userController);
              },
              child: user.Birthday == DateTime(1990, 1, 1)
                  ? CustomContainer(
                      child: Text('생년월일',
                          style: const TextStyle(
                              color: OdoSajuColors.brownGrey02,
                              fontWeight: FontWeight.w400,
                              fontSize: 16.0)))
                  : CustomContainer(
                      child: Text(
                          '${DateFormat('yyyy-MM-dd').format(user.Birthday)} ${user.Solar == CalendarType.solar ? "양력" : "음력"}',
                          style: const TextStyle(
                              color: OdoSajuColors.black01,
                              fontWeight: FontWeight.w400,
                              fontSize: 16.0))),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * (48 / 812),
            ),
            TextButton(
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
              ),
              onPressed: () {
                _showTimeDialog(user, userController);
              },
              child: user.BirthTime == ''
                  ? CustomContainer(
                      child: Text('태어난 시간',
                          style: const TextStyle(
                              color: OdoSajuColors.brownGrey02,
                              fontWeight: FontWeight.w400,
                              fontSize: 16.0)))
                  : CustomContainer(
                      child: Text(
                          user.BirthTime != null
                              ? "${user.BirthTime?.hour}시 ${user.BirthTime?.minute}분"
                              : '태어난 시간 모름',
                          style: const TextStyle(
                              color: OdoSajuColors.black01,
                              fontWeight: FontWeight.w400,
                              fontSize: 16.0))),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * (80 / 812),
            ),
            TextButton(
                onPressed: () => {userController.setSaju()},
                child: Text('사주뽑아보기')),
            Column(
              children: [
                SizedBox(
                    height: MediaQuery.of(context).size.height * (50 / 812)),
                Container(
                  height: MediaQuery.of(context).size.height * (20 / 812),
                  width: MediaQuery.of(context).size.width * (336 / 375),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * (72 / 375),
                        height: MediaQuery.of(context).size.height * (20 / 812),
                        child: Text("시주", textAlign: TextAlign.center),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * (72 / 375),
                        height: MediaQuery.of(context).size.height * (20 / 812),
                        child: Text("일주", textAlign: TextAlign.center),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * (72 / 375),
                        height: MediaQuery.of(context).size.height * (20 / 812),
                        child: Text("월주", textAlign: TextAlign.center),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * (72 / 375),
                        height: MediaQuery.of(context).size.height * (20 / 812),
                        child: Text("연주", textAlign: TextAlign.center),
                      ),
                    ],
                  ),
                ),
                // Container(
                //   width:
                //       MediaQuery.of(context).size.width * (336 / 375),
                //   height:
                //       MediaQuery.of(context).size.height * (40 / 812),
                //   decoration: BoxDecoration(
                //       borderRadius:
                //           BorderRadius.all(Radius.circular(8)),
                //       color: OdoSajuColors.greyishBrown),
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //     children: [
                //       Container(
                //         alignment: Alignment.center,
                //         width: MediaQuery.of(context).size.width *
                //             (72 / 375),
                //         height: MediaQuery.of(context).size.height *
                //             (20 / 812),
                //         child: Text(user.hourHeavenlyTenStar,
                //             style: tenstarTextStyle,
                //             textAlign: TextAlign.center),
                //       ),
                //       Container(
                //         alignment: Alignment.center,
                //         width: MediaQuery.of(context).size.width *
                //             (72 / 375),
                //         height: MediaQuery.of(context).size.height *
                //             (20 / 812),
                //         child: Text(user.dayHeavenlyTenStar,
                //             style: tenstarTextStyle,
                //             textAlign: TextAlign.center),
                //       ),
                //       Container(
                //         alignment: Alignment.center,
                //         width: MediaQuery.of(context).size.width *
                //             (72 / 375),
                //         height: MediaQuery.of(context).size.height *
                //             (20 / 812),
                //         child: Text(user.monthHeavenlyTenStar,
                //             style: tenstarTextStyle,
                //             textAlign: TextAlign.center),
                //       ),
                //       Container(
                //         alignment: Alignment.center,
                //         width: MediaQuery.of(context).size.width *
                //             (72 / 375),
                //         height: MediaQuery.of(context).size.height *
                //             (20 / 812),
                //         child: Text(user.yearHeavenlyTenStar,
                //             style: tenstarTextStyle,
                //             textAlign: TextAlign.center),
                //       ),
                //     ],
                //   ),
                // ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * (16 / 812),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * (336 / 375),
                  height: MediaQuery.of(context).size.height * (72 / 812),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      userGapjaContainer(
                          gapja: user.saju?.timeHeavenly?.chiness ?? '?'),
                      userGapjaContainer(
                          gapja: user.saju?.dayHeavenly?.chiness ?? '?'),
                      userGapjaContainer(
                          gapja: user.saju?.monthHeavenly?.chiness ?? '?'),
                      userGapjaContainer(
                          gapja: user.saju?.yearHeavenly?.chiness ?? '?'),
                    ],
                  ),
                ),
                SizedBox(height: 16.0),
                Container(
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width * (336 / 375),
                  height: MediaQuery.of(context).size.height * (72 / 812),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      userGapjaContainer(
                          gapja: user.saju?.timeEarthly?.chiness ?? '?'),
                      userGapjaContainer(
                          gapja: user.saju?.dayEarthly?.chiness ?? '?'),
                      userGapjaContainer(
                          gapja: user.saju?.monthEarthly?.chiness ?? '?'),
                      userGapjaContainer(
                          gapja: user.saju?.yearEarthly?.chiness ?? '?'),
                    ],
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * (16 / 812),
                ),
                // Container(
                //   alignment: Alignment.center,
                //   width:
                //       MediaQuery.of(context).size.width * (336 / 375),
                //   height:
                //       MediaQuery.of(context).size.height * (40 / 812),
                //   decoration: BoxDecoration(
                //       borderRadius:
                //           BorderRadius.all(Radius.circular(8)),
                //       color: OdoSajuColors.greyishBrown),
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //     children: [
                //       Container(
                //         alignment: Alignment.center,
                //         width: MediaQuery.of(context).size.width *
                //             (72 / 375),
                //         height: MediaQuery.of(context).size.height *
                //             (22 / 812),
                //         child: Text(user.hourEarthlyTenStar,
                //             style: tenstarTextStyle,
                //             textAlign: TextAlign.center),
                //       ),
                //       Container(
                //         alignment: Alignment.center,
                //         width: MediaQuery.of(context).size.width *
                //             (72 / 375),
                //         height: MediaQuery.of(context).size.height *
                //             (22 / 812),
                //         child: Text(user.dayEarthlyTenStar,
                //             style: tenstarTextStyle,
                //             textAlign: TextAlign.center),
                //       ),
                //       Container(
                //         alignment: Alignment.center,
                //         width: MediaQuery.of(context).size.width *
                //             (72 / 375),
                //         height: MediaQuery.of(context).size.height *
                //             (22 / 812),
                //         child: Text(user.monthEarthlyTenStar,
                //             style: tenstarTextStyle,
                //             textAlign: TextAlign.center),
                //       ),
                //       Container(
                //         alignment: Alignment.center,
                //         width: MediaQuery.of(context).size.width *
                //             (72 / 375),
                //         height: MediaQuery.of(context).size.height *
                //             (22 / 812),
                //         child: Text(user.yearEarthlyTenStar,
                //             style: tenstarTextStyle,
                //             textAlign: TextAlign.center),
                //       ),
                //     ],
                //   ),
                // ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * (64 / 812),
                ),
                // SingleChildScrollView(child: LegitimacyCard(id: id)),
              ],
            )
          ],
        ),
      ),
    )));
  }

  Future _showDateDialog(User user, UserController userController) async {
    final result = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return Theme(
          data: ThemeData(
            dialogBackgroundColor: Colors.transparent,
          ),
          child: Dialog(
            child: Container(
                height: heightRatio(378.0),
                width: widthRatio(296.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24.0),
                  color: OdoSajuColors.white,
                ),
                child: DatePickerSolarLunar(
                    userYear: user.Birthday.year,
                    userMonth: user.Birthday.month,
                    userDay: user.Birthday.day,
                    userSolarLunar:
                        user.Solar == CalendarType.solar ? "양력" : "음력",
                    initialSolarLunar:
                        user.Solar == CalendarType.solar ? "양력" : "음력",
                    userHour: user.BirthTime?.hour ?? 10,
                    userMinute: user.BirthTime?.minute ?? 00,
                    minDate: _minDate,
                    maxDate: _maxDate,
                    selectedDate: _selectedDate,
                    inputStatus: InputStatus.first)),
          ),
        );
      },
    );
    setState(() {
      print('result1 = $result');
      if (result != null) {
        _selectedDate = result;
        _selectedDate.hour == 00
            ? userController.updateCalendarType(CalendarType.solar)
            : userController.updateCalendarType(CalendarType.lunar);
        userController.updateBirthDate(_selectedDate);
        // userController.updateCalendarType(calendarType)
      }
    });
  }

  Future<void> _showTimeDialog(User user, UserController userController) async {
    final result = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return Theme(
          data: ThemeData(
            dialogBackgroundColor: Colors.transparent,
          ),
          child: Dialog(
            child: Container(
              height: heightRatio(418.0),
              width: widthRatio(296.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24.0),
                color: OdoSajuColors.white,
              ),
              child: TimePickerAmPm(
                minTime: _minTime,
                maxTime: _maxTime,
                selectedTime: _selectedTime,
                inputStatus: InputStatus.first,
                userDay: user.Birthday.day,
                userHour: user.BirthTime == null ? 10 : user.BirthTime!.hour,
                userMinute: user.BirthTime == null ? 0 : user.BirthTime!.minute,
                userMonth: user.Birthday.month,
                userYear: user.Birthday.year,
              ),
            ),
          ),
        );
      },
    );
    setState(() {
      if (result != null) {
        _selectedTime = result;
        print('타임픽커에서 넘어온 값 $_selectedTime');

        final TimeOfDay time = TimeOfDay(
            hour: result.day == 1 ? result.hour : 12 + result.hour,
            minute: result.minute);
        print(result.year == 1000);
        userController.updateBirthTime(result.year == 1000 ? null : time);
      }
    });
  }

  Container userGapjaContainer({
    required String gapja,
  }) {
    Color color = OdoSajuColors.white;
    if (gapja == '甲' || gapja == '乙' || gapja == '寅' || gapja == '卯')
      color = OdoSajuColors.seafoamGreen;
    if (gapja == '丙' || gapja == '丁' || gapja == '巳' || gapja == '午')
      color = OdoSajuColors.peachyPink;

    if (gapja == '戊' ||
        gapja == '己' ||
        gapja == '辰' ||
        gapja == '未' ||
        gapja == '戌' ||
        gapja == '丑') color = OdoSajuColors.paleSalmon;

    if (gapja == '庚' || gapja == '辛' || gapja == '申' || gapja == '酉')
      color = OdoSajuColors.white;

    if (gapja == '壬' || gapja == '癸' || gapja == '子' || gapja == '亥')
      color = OdoSajuColors.brownGrey02;

    return Container(
        alignment: Alignment.center,
        child: Text(gapja, textAlign: TextAlign.center),
        width: MediaQuery.of(context).size.width * (72 / 375),
        height: MediaQuery.of(context).size.height * (72 / 812),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            boxShadow: [
              BoxShadow(
                  color: const Color(0x0d333333),
                  offset: Offset(0, 6),
                  blurRadius: 8,
                  spreadRadius: 0)
            ],
            color: color));
  }
}

// class UserInfoScreen extends ConsumerWidget {
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final user = ref.watch(userProvider);
//     final userController = ref.read(userProvider.notifier);

//     return Scaffold(
//         appBar: AppBar(title: const Text('사주를 입력하세요')),
//         body: SafeArea(
//             child: Padding(
//           padding: EdgeInsets.all(12),
//           child: SingleChildScrollView(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.start,
//               crossAxisAlignment: CrossAxisAlignment.stretch,
//               children: [
//                 Text(
//                   '운세풀이를 위해 정보를 \n정확히 입력해 주세요.',
//                   style: TextStyle(
//                       color: OdoSajuColors.black01,
//                       fontWeight: FontWeight.w700,
//                       fontSize: 20.0),
//                 ),
//                 SizedBox(
//                   height: MediaQuery.of(context).size.height * (40 / 812),
//                 ),
//                 CustomTextFormField(
//                   initialValue: user.name ?? '',
//                   inputFormatters: [
//                     LengthLimitingTextInputFormatter(10),
//                   ],
//                   contentPadding: EdgeInsets.only(left: widthRatio(20)),

//                   // counter: AlignTextCounter(),
//                   maxLength: 10,
//                   maxLines: 1,
//                   textInputAction: TextInputAction.done,
//                   keyboardType: TextInputType.name,
//                   autofocus: false,
//                   hintText: '이름',
//                   onChanged: (value) {
//                     userController.updateName(value);
//                   },
//                 ),
//                 SizedBox(
//                   height: MediaQuery.of(context).size.height * (20 / 812),
//                 ),
//                 Row(
//                   children: [
//                     SizedBox(
//                       width: MediaQuery.of(context).size.width * (168 / 375),
//                       height: MediaQuery.of(context).size.height * (56 / 812),
//                       child: TextButton(
//                         onPressed: () {
//                           userController.updateGenderType(GenderType.M);
//                         },
//                         style: ButtonStyle(
//                           backgroundColor: MaterialStateProperty.resolveWith(
//                               (states) => user.sex == GenderType.M
//                                   ? OdoSajuColors.lightBlueGreyDarker
//                                   : OdoSajuColors.white),
//                           shape: MaterialStateProperty.resolveWith(
//                             (states) => user.sex == GenderType.M
//                                 ? RoundedRectangleBorder(
//                                     borderRadius: BorderRadius.circular(16.0),
//                                     side: BorderSide(
//                                       color: OdoSajuColors.greyBlue,
//                                     ),
//                                   )
//                                 : RoundedRectangleBorder(
//                                     borderRadius: BorderRadius.circular(16.0),
//                                     side: BorderSide(
//                                       color: OdoSajuColors.lightBlueGrey,
//                                     ),
//                                   ),
//                           ),
//                         ),
//                         child: const Text(
//                           '남자',
//                           style: TextStyle(color: OdoSajuColors.black01),
//                         ),
//                       ),
//                     ),
//                     SizedBox(
//                       width: MediaQuery.of(context).size.width * (7 / 375),
//                     ),
//                     SizedBox(
//                       width: MediaQuery.of(context).size.width * (168 / 375),
//                       height: MediaQuery.of(context).size.height * (56 / 812),
//                       child: TextButton(
//                         onPressed: () {
//                           userController.updateGenderType(GenderType.e);
//                         },
//                         style: ButtonStyle(
//                           backgroundColor: MaterialStateProperty.resolveWith(
//                               (states) => user.sex == GenderType.e
//                                   ? OdoSajuColors.lightBlueGreyDarker
//                                   : OdoSajuColors.white),
//                           shape: MaterialStateProperty.resolveWith(
//                             (states) => user.sex == GenderType.e
//                                 ? RoundedRectangleBorder(
//                                     borderRadius: BorderRadius.circular(16.0),
//                                     side: BorderSide(
//                                       color: OdoSajuColors.greyBlue,
//                                     ),
//                                   )
//                                 : RoundedRectangleBorder(
//                                     borderRadius: BorderRadius.circular(16.0),
//                                     side: BorderSide(
//                                       color: OdoSajuColors.lightBlueGrey,
//                                     ),
//                                   ),
//                           ),
//                         ),
//                         child: Text(
//                           '여자',
//                           style: TextStyle(color: OdoSajuColors.black01),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//                 SizedBox(
//                   height: MediaQuery.of(context).size.height * (48 / 812),
//                 ),
//                 TextButton(
//                   style: TextButton.styleFrom(
//                     padding: EdgeInsets.zero,
//                   ),
//                   onPressed: () {
//                     // _showDateDialog();
//                   },
//                   child: user.Birthday == DateTime(1900, 1, 1)
//                       ? CustomContainer(
//                           child: Text('생년월일',
//                               style: const TextStyle(
//                                   color: OdoSajuColors.brownGrey02,
//                                   fontWeight: FontWeight.w400,
//                                   fontSize: 16.0)))
//                       : CustomContainer(
//                           child: Text(user.Birthday.toString(),
//                               style: const TextStyle(
//                                   color: OdoSajuColors.black01,
//                                   fontWeight: FontWeight.w400,
//                                   fontSize: 16.0))),
//                 ),
//                 SizedBox(
//                   height: MediaQuery.of(context).size.height * (48 / 812),
//                 ),
//               ],
//             ),
//           ),
//         )));
//   }
  
// }
