import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomCupertinoTimePicker extends StatefulWidget {
  final double itemExtent;
  final Widget selectionOverlay;
  final double diameterRatio;
  final Color? backgroundColor;
  final double offAxisFraction;
  final bool useMaginifier;
  final double magnification;
  final double squeeze;
  final void Function(DateTime) onSelectedItemChanged;
  // Text style of selected item
  final TextStyle? selectedStyle;
  // Text style of unselected item
  final TextStyle? unselectedStyle;
  // Text style of disabled item
  final TextStyle? disabledStyle;
  // Minimum selectable date
  final DateTime? minDate;
  // Maximum selectable date
  final DateTime? maxDate;
  // Initially selected date
  final DateTime? selectedDate;
  const CustomCupertinoTimePicker({
    Key? key,
    required this.itemExtent,
    required this.onSelectedItemChanged,
    this.minDate,
    this.maxDate,
    this.selectedDate,
    this.selectedStyle,
    this.unselectedStyle,
    this.disabledStyle,
    this.backgroundColor,
    this.squeeze = 1.45,
    this.diameterRatio = 1.1,
    this.magnification = 1.0,
    this.offAxisFraction = 0.0,
    this.useMaginifier = false,
    this.selectionOverlay = const CupertinoPickerDefaultSelectionOverlay(),
  }) : super(key: key);
  @override
  State<CustomCupertinoTimePicker> createState() =>
      _CustomCupertinoTimePickerState();
}

enum _SelectorType { minute, hour, day, month, year }

class _CustomCupertinoTimePickerState extends State<CustomCupertinoTimePicker> {
  late DateTime _minDate;
  late DateTime _maxDate;
  late DateTime _selectedDate;
  late int _selectedMinuteIndex;
  late int _selectedHourIndex;
  // late int _selectedMeridiemIndex;
  late int _selectedDayIndex;
  late int _selectedMonthIndex;
  late int _selectedYearIndex;
  late final FixedExtentScrollController _minuteScrollController;
  late final FixedExtentScrollController _hourScrollController;
  // late final FixedExtentScrollController _meridiemScrollController;
  late final FixedExtentScrollController _dayScrollController;
  late final FixedExtentScrollController _monthScrollController;
  late final FixedExtentScrollController _yearScrollController;

  final _minute = List.generate(60, (index) => index);
  final _hour = List.generate(12, (index) => index);

  final _days = ['오전', '오후'];
  // final _days = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];
  final _months = List.generate(12, (index) => index + 1);
  @override
  void initState() {
    super.initState();
    _validateDates();
    _minuteScrollController = FixedExtentScrollController();
    _hourScrollController = FixedExtentScrollController();
    // _meridiemScrollController = FixedExtentScrollController();
    _dayScrollController = FixedExtentScrollController();
    _monthScrollController = FixedExtentScrollController();
    _yearScrollController = FixedExtentScrollController();
    _initDates();
  }

  void _validateDates() {
    if (widget.minDate != null && widget.maxDate != null) {
      assert(!widget.minDate!.isAfter(widget.maxDate!));
    }
    if (widget.minDate != null && widget.selectedDate != null) {
      assert(!widget.minDate!.isAfter(widget.selectedDate!));
    }
    if (widget.maxDate != null && widget.selectedDate != null) {
      assert(!widget.selectedDate!.isAfter(widget.maxDate!));
    }
  }

  void _initDates() {
    final currentDate = DateTime.now();
    _minDate = widget.minDate ?? DateTime(currentDate.year - 100);
    _maxDate = widget.maxDate ?? DateTime(currentDate.year + 100);
    if (widget.selectedDate != null) {
      _selectedDate = widget.selectedDate!;
    } else if (!currentDate.isBefore(_minDate) &&
        !currentDate.isAfter(_maxDate)) {
      _selectedDate = currentDate;
    } else {
      _selectedDate = _minDate;
    }
    _selectedMinuteIndex = _selectedDate.minute;
    _selectedHourIndex = _selectedDate.hour;
    // _selectedMeridiemIndex = 0;
    _selectedDayIndex = _selectedDate.day - 1;
    _selectedMonthIndex = _selectedDate.month - 1;
    _selectedYearIndex = _selectedDate.year - _minDate.year;
    WidgetsBinding.instance.addPostFrameCallback((_) => {
          _scrollList(_minuteScrollController, _selectedMinuteIndex),
          _scrollList(_hourScrollController, _selectedHourIndex),
          // _scrollList(_meridiemScrollController, _selectedMeridiemIndex),
          _scrollList(_dayScrollController, _selectedDayIndex),
          _scrollList(_monthScrollController, _selectedMonthIndex),
          _scrollList(_yearScrollController, _selectedYearIndex),
        });
  }

  void _scrollList(FixedExtentScrollController controller, int index) {
    controller.animateToItem(
      index,
      curve: Curves.easeIn,
      duration: const Duration(milliseconds: 300),
    );
  }

  @override
  void dispose() {
    _minuteScrollController.dispose();
    _hourScrollController.dispose();
    // _meridiemScrollController.dispose();
    _dayScrollController.dispose();
    _monthScrollController.dispose();
    _yearScrollController.dispose();
    super.dispose();
  }

  /// check if selected year is a leap year
  bool _isLeapYear() {
    final year = _minDate.year + _selectedYearIndex;
    return year % 4 == 0 &&
        (year % 100 != 0 || (year % 100 == 0 && year % 400 == 0));
  }

  /// get number of days for the selected month
  // int _numberOfDays() {
  //   if (_selectedMonthIndex == 1) {
  //     _days[1] = _isLeapYear() ? 29 : 28;
  //   }
  //   return _days[_selectedMonthIndex];
  // }

  void _onSelectedItemChanged(int index, _SelectorType type) {
    DateTime temp;
    switch (type) {
      case _SelectorType.year:
        temp = DateTime(
          _minDate.year + index,
          _selectedMonthIndex + 1,
          _selectedDayIndex + 1,
        );
        break;
      case _SelectorType.month:
        temp = DateTime(
          _minDate.year + _selectedYearIndex,
          index + 1,
          _selectedDayIndex + 1,
        );
        break;
      case _SelectorType.day:
        temp = DateTime(
          _minDate.year + _selectedYearIndex,
          _selectedMonthIndex + 1,
          index + 1,
          _selectedHourIndex,
          _selectedMinuteIndex,
        );
        break;
      case _SelectorType.hour:
        temp = DateTime(
          _minDate.year + _selectedYearIndex,
          _selectedMonthIndex + 1,
          _selectedDayIndex + 1,
          index,
          _selectedMinuteIndex,
        );
        break;
      case _SelectorType.minute:
        temp = DateTime(
          _minDate.year + _selectedYearIndex,
          _selectedMonthIndex + 1,
          _selectedDayIndex + 1,
          _selectedHourIndex,
          index,
        );
        break;

      // case _SelectorType.meridiem:
      //   temp = DateTime(
      //     _minDate.year + _selectedYearIndex,
      //     _selectedMonthIndex + 1,
      //     _selectedDayIndex + 1,
      //     _selectedHourIndex + (index * 12),
      //     _selectedMinuteIndex,
      //   );
      //   break;
    }

    // return if selected date is not the min - max date range
    // scroll selector back to the valid point
    if (temp.isBefore(_minDate) || temp.isAfter(_maxDate)) {
      switch (type) {
        case _SelectorType.month:
          _monthScrollController.jumpToItem(_selectedMonthIndex);
          break;
        case _SelectorType.year:
          _yearScrollController.jumpToItem(_selectedYearIndex);
          break;
        case _SelectorType.day:
          _dayScrollController.jumpToItem(_selectedDayIndex);
          break;
        case _SelectorType.hour:
          _hourScrollController.jumpToItem(_selectedHourIndex);
          break;
        case _SelectorType.minute:
          _minuteScrollController.jumpToItem(_selectedMinuteIndex);
          break;

        // case _SelectorType.meridiem:
        //   _meridiemScrollController.jumpToItem(_selectedMeridiemIndex);
        //   break;
      }
      return;
    }
    // update selected date
    _selectedDate = temp;
    // adjust other selectors when one selctor is changed
    switch (type) {
      case _SelectorType.day:
        _selectedDayIndex = index;
        break;
      case _SelectorType.month:
        _selectedMonthIndex = index;
        // if month is changed to february &
        // selected day is greater than 29,
        // set the selected day to february 29 for leap year
        // else to february 28
        if (_selectedMonthIndex == 1 && _selectedDayIndex > 27) {
          _selectedDayIndex = _isLeapYear() ? 28 : 27;
        }
        // if selected day is 31 but current selected month has only
        // 30 days, set selected day to 30
        if (_selectedDayIndex == 30 && _days[_selectedMonthIndex] == 30) {
          _selectedDayIndex = 29;
        }
        break;
      case _SelectorType.year:
        _selectedYearIndex = index;
        // if selected month is february & selected day is 29
        // But now year is changed to non-leap year
        // set the day to february 28
        if (!_isLeapYear() &&
            _selectedMonthIndex == 1 &&
            _selectedDayIndex == 28) {
          _selectedDayIndex = 27;
        }
        break;
      case _SelectorType.minute:
        _selectedMinuteIndex = index;
        break;
      case _SelectorType.hour:
        _selectedHourIndex = index;
        break;
      // case _SelectorType.meridiem:
      //   _selectedMeridiemIndex = index;
      //   break;
    }
    setState(() {});
    widget.onSelectedItemChanged(_selectedDate);
  }

  /// check if the given day, month or year index is disabled
  bool _isDisabled(int index, _SelectorType type) {
    DateTime temp;
    switch (type) {
      case _SelectorType.month:
        temp = DateTime(
          _minDate.year + _selectedYearIndex,
          index + 1,
          _selectedDayIndex + 1,
        );
        break;
      case _SelectorType.year:
        temp = DateTime(
          _minDate.year + index,
          _selectedMonthIndex + 1,
          _selectedDayIndex + 1,
        );
        break;
      case _SelectorType.day:
        temp = DateTime(
          _minDate.year + _selectedYearIndex,
          _selectedMonthIndex + 1,
          index + 1,
          _selectedHourIndex,
          _selectedMinuteIndex,
        );
        break;
      case _SelectorType.minute:
        temp = DateTime(
          _minDate.year + _selectedYearIndex,
          _selectedMonthIndex + 1,
          _selectedDayIndex + 1,
          _selectedHourIndex,
          index,
        );
        break;
      case _SelectorType.hour:
        temp = DateTime(
          _minDate.year + _selectedYearIndex,
          _selectedMonthIndex + 1,
          _selectedDayIndex + 1,
          index,
          _selectedMinuteIndex,
        );
        break;
      // case _SelectorType.meridiem:
      //   temp = DateTime(
      //     _minDate.year + _selectedYearIndex,
      //     _selectedMonthIndex + 1,
      //     _selectedDayIndex + 1,
      //     _selectedHourIndex + (index * 12),
      //     _selectedMinuteIndex,
      //   );
      //   break;
    }
    return temp.isAfter(_maxDate) || temp.isBefore(_minDate);
  }

  Widget _selector({
    required List<dynamic> values,
    required int selectedValueIndex,
    required bool Function(int) isDisabled,
    required void Function(int) onSelectedItemChanged,
    required FixedExtentScrollController scrollController,
  }) {
    return CupertinoPicker.builder(
      childCount: values.length,
      squeeze: widget.squeeze,
      itemExtent: widget.itemExtent,
      scrollController: scrollController,
      useMagnifier: widget.useMaginifier,
      diameterRatio: widget.diameterRatio,
      magnification: widget.magnification,
      backgroundColor: widget.backgroundColor,
      offAxisFraction: widget.offAxisFraction,
      selectionOverlay: widget.selectionOverlay,
      onSelectedItemChanged: onSelectedItemChanged,
      itemBuilder: (context, index) => Container(
        height: widget.itemExtent,
        alignment: Alignment.center,
        child: Text(
          '${values[index]}',
          style: index == selectedValueIndex
              ? widget.selectedStyle
              : isDisabled(index)
                  ? widget.disabledStyle
                  : widget.unselectedStyle,
        ),
      ),
    );
  }

  Widget _minuteSelector() {
    return _selector(
      values: _minute,
      selectedValueIndex: _selectedMinuteIndex,
      scrollController: _minuteScrollController,
      isDisabled: (index) => _isDisabled(index, _SelectorType.minute),
      onSelectedItemChanged: (v) => _onSelectedItemChanged(
        v,
        _SelectorType.minute,
      ),
    );
  }

  Widget _daySelector() {
    return _selector(
      values: _days,
      selectedValueIndex: _selectedDayIndex,
      scrollController: _dayScrollController,
      isDisabled: (index) => _isDisabled(index, _SelectorType.day),
      onSelectedItemChanged: (v) => _onSelectedItemChanged(
        v,
        _SelectorType.day,
      ),
    );
  }

  Widget _hourSelector() {
    return _selector(
      values: _hour,
      selectedValueIndex: _selectedHourIndex,
      scrollController: _hourScrollController,
      isDisabled: (index) => _isDisabled(index, _SelectorType.hour),
      onSelectedItemChanged: (v) => _onSelectedItemChanged(
        v,
        _SelectorType.hour,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: _daySelector()),
        Expanded(child: _hourSelector()),
        Expanded(child: _minuteSelector()),
      ],
    );
  }
}
