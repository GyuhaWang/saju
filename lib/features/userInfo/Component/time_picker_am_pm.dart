import 'package:flutter/material.dart';
import 'package:saju/constants/colors.dart';
import 'package:saju/constants/data.dart';

import 'custom_cupertino_time_picker.dart';

class TimePickerAmPm extends StatefulWidget {
  final int userYear;
  final int userMonth;
  final int userDay;
  final int userHour;
  final int userMinute;
  final InputStatus inputStatus;

  const TimePickerAmPm(
      {required this.userYear,
      required this.userMonth,
      required this.userDay,
      required this.userMinute,
      required this.userHour,
      required this.inputStatus,
      required DateTime minTime,
      required DateTime maxTime,
      required DateTime selectedTime,
      super.key});

  @override
  State<TimePickerAmPm> createState() => _TimePickerAmPmState();
}

class _TimePickerAmPmState extends State<TimePickerAmPm> {
  late final DateTime minTime;
  late final DateTime maxTime;
  late DateTime selectedTime;

  @override
  void initState() {
    super.initState();
    final currentDate = DateTime.now();

    minTime = DateTime(
      1000,
      1,
      1,
      0,
      0,
    );
    maxTime = DateTime(
      2500,
      12,
      31,
      23,
      59,
    );
    print('파라미터로 받은 userHour ${widget.userHour}');
    print('파라미터로 받은 userDay ${widget.userDay}');
    int newDate;
    int newHour;
    if (widget.userDay == 1) {
      newDate = widget.userHour >= 12 ? 2 : 1;
      newHour = widget.userHour >= 12 ? widget.userHour - 12 : widget.userHour;
    } else {
      newDate = widget.userDay;
      newHour = widget.userHour;
    }

    // if (widget.inputStatus == InputStatus.modify) {
    selectedTime = DateTime(
      widget.userYear,
      widget.userMonth,
      newDate,
      newHour,
      widget.userMinute,
    );

    print(widget.userHour);

    // }
  }

  @override
  Widget build(BuildContext context) {
    print('selectedTime: $selectedTime');

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: heightRatio(24.0),
        ),
        Container(
          height: heightRatio(26.0),
          child: Text(
            (selectedTime.day == 2)
                ? '오후 ${selectedTime.hour}시 ${selectedTime.minute}분'
                : '오전 ${selectedTime.hour}시 ${selectedTime.minute}분',
            style: TextStyle(
                color: OdoSajuColors.black01,
                fontWeight: FontWeight.w700,
                fontSize: 18.0),
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(
          height: heightRatio(24.0),
        ),
        Container(
          height: heightRatio(208.0),
          width: widthRatio(184.0),
          child: CustomCupertinoTimePicker(
              itemExtent: 50,
              minDate: minTime,
              maxDate: maxTime,
              selectedDate: selectedTime,
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
              onSelectedItemChanged: (time) {
                setState(() {
                  selectedTime.hour >= 12
                      ? selectedTime = DateTime(
                          time.year,
                          time.month,
                          time.day,
                          time == 12 ? 12 : time.hour + 12,
                          time.minute,
                        )
                      : selectedTime = time;
                });
              }),
        ),
        Container(
          width: widthRatio(184.0),
          height: heightRatio(32.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            color: OdoSajuColors.white,
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(
              vertical: heightRatio(4),
            ),
            child: InkWell(
              onTap: () {},
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    selectedTime = DateTime(1000, 1, 1, 00, 00);
                  });
                  Navigator.pop(context, selectedTime);
                },
                child: Container(
                  width: MediaQuery.of(context).size.width * (184 / 375),
                  height: MediaQuery.of(context).size.height * (32 / 812),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    color: OdoSajuColors.white,
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(),
                    child: Text(
                      "태어난 시 모름",
                      style: const TextStyle(
                        color: OdoSajuColors.black01,
                        fontWeight: FontWeight.w700,
                        fontSize: 14.0,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * (32 / 812),
        ),
        GestureDetector(
          onTap: () {
            Navigator.pop(context, selectedTime);
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
                vertical: heightRatio(13.0),
              ),
              child: Text("확인",
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 14.0),
                  textAlign: TextAlign.center),
            ),
          ),
        ),
      ],
    );
  }
}
