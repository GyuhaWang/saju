import 'package:saju/model/letter.dart';

class Saju {
  final Letter yearHeavenly;
  final Letter yearEarthly;
  final Letter monthHeavenly;
  final Letter monthEarthly;
  final Letter dayHeavenly;
  final Letter dayEarthly;
  final Letter? timeHeavenly;
  final Letter? timeEarthly;

  Saju(
      {required this.yearHeavenly,
      required this.yearEarthly,
      required this.dayHeavenly,
      required this.dayEarthly,
      required this.monthHeavenly,
      required this.monthEarthly,
      this.timeEarthly,
      this.timeHeavenly});
}
