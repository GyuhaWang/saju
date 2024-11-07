import 'package:flutter/material.dart';
import 'package:saju/constants/colors.dart';
import 'package:saju/constants/data.dart';
import 'package:saju/features/userInfo/Component/custom_cupertino_date_picker.dart';

class DatePickerSolarLunar extends StatefulWidget {
  final int userYear;
  final int userMonth;
  final int userDay;
  final int userHour;
  final int userMinute;
  final InputStatus inputStatus;
  String userSolarLunar;
  String initialSolarLunar;
  DatePickerSolarLunar({
    required this.userYear,
    required this.userMonth,
    required this.userDay,
    required this.userSolarLunar,
    required this.initialSolarLunar,
    required this.userMinute,
    required this.userHour,
    required this.inputStatus,
    required DateTime minDate,
    required DateTime maxDate,
    required DateTime selectedDate,
    super.key,
  });

  @override
  State<DatePickerSolarLunar> createState() => _DatePickerSolarLunarState();
}

class _DatePickerSolarLunarState extends State<DatePickerSolarLunar> {
  late final DateTime minDate;
  late final DateTime maxDate;
  late DateTime selectedDate;

  @override
  void initState() {
    super.initState();
    final currentDate = DateTime.now();
    minDate = DateTime(
      1900,
      1,
      1,
    );

    maxDate = DateTime(
      currentDate.year,
      currentDate.month,
      currentDate.day,
    );

    print(widget.userYear);
    print(widget.userMonth);
    print(widget.userDay);

    // if (widget.inputStatus == InputStatus.modify) {
    selectedDate = DateTime(
      widget.userYear,
      widget.userMonth,
      widget.userDay,
      widget.initialSolarLunar == '양력' ? 00 : 01,
      widget.userMinute,
    );
    // }

    print('이니시 $selectedDate');
  }

  @override
  Widget build(BuildContext context) {
    // if (widget.initialSolarLunar != widget.userSolarLunar) {
    //   widget.userSolarLunar == '양력'
    //       ? selectedDate.hour == 01
    //       : selectedDate.hour == 00;
    // }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: heightRatio(24.0),
        ),
        Container(
          height: heightRatio(26.0),
          child: Text(
            '${selectedDate.year}년 ${selectedDate.month}월 ${selectedDate.day}일',
            style: const TextStyle(
                color: OdoSajuColors.black01,
                fontWeight: FontWeight.w700,
                fontSize: 18.0),
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(
          height: heightRatio(24.0),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: heightRatio(208.0),
              width: widthRatio(248.0),
              child: CustomCupertinoDatePicker(
                itemExtent: 50,
                minDate: minDate,
                maxDate: maxDate,
                selectedDate: selectedDate,
                selectionOverlay: Container(
                  width: widthRatio(248.0),
                  height: heightRatio(32.0),
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(243, 245, 246, 0.3),
                    border: Border.symmetric(
                      horizontal: BorderSide(
                        width: 1,
                        color: OdoSajuColors.iceBlue,
                      ),
                    ),
                  ),
                ),
                selectedStyle: const TextStyle(
                  color: OdoSajuColors.black01,
                  fontWeight: FontWeight.w700,
                  fontSize: 16.0,
                ),
                unselectedStyle: TextStyle(
                  color: OdoSajuColors.brownGrey02,
                  fontSize: 16.0,
                ),
                disabledStyle: TextStyle(
                  color: OdoSajuColors.brownGrey02,
                  fontSize: 16.0,
                ),
                onSelectedItemChanged: (date) {
                  setState(() {
                    date.hour == 0
                        ? widget.userSolarLunar = "양력"
                        : widget.userSolarLunar = "음력";
                    selectedDate = date;
                  });
                },
              ),
            ),
          ],
        ),
        SizedBox(
          height: heightRatio(32.0),
        ),
        GestureDetector(
          onTap: () {
            print('selectedDate = $selectedDate');
            Navigator.pop(context, selectedDate);
          },
          child: Container(
            width: widthRatio(264.0),
            height: heightRatio(48.0),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(16.0),
                ),
                color: OdoSajuColors.greyBlue),
            child: Padding(
              padding: EdgeInsets.symmetric(
                vertical: widthRatio(13.0),
              ),
              child: Text(
                "확인",
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 14.0,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
