import 'package:saju/model/letter.dart';

final TENGAN = {
  'A': Letter(kor: '갑', chiness: '甲', DBnum: 'd1'),
  'B': Letter(kor: '을', chiness: '乙', DBnum: 'd2'),
  'C': Letter(kor: '병', chiness: '丙', DBnum: 'd3'),
  'D': Letter(kor: '정', chiness: '丁', DBnum: 'd4'),
  'E': Letter(kor: '무', chiness: '戊', DBnum: 'd5'),
  'F': Letter(kor: '기', chiness: '己', DBnum: 'd6'),
  'G': Letter(kor: '경', chiness: '庚', DBnum: 'd7'),
  'H': Letter(kor: '신', chiness: '辛', DBnum: 'd8'),
  'I': Letter(kor: '임', chiness: '壬', DBnum: 'd9'),
  'J': Letter(kor: '계', chiness: '癸', DBnum: 'd10'),
  '-1': Letter(kor: '?', chiness: "?", DBnum: 'e0')
};

final TENGANBYCHINESS = {
  '甲': Letter(kor: '갑', chiness: '甲', DBnum: 'd1'),
  '乙': Letter(kor: '을', chiness: '乙', DBnum: 'd2'),
  '丙': Letter(kor: '병', chiness: '丙', DBnum: 'd3'),
  '丁': Letter(kor: '정', chiness: '丁', DBnum: 'd4'),
  '戊': Letter(kor: '무', chiness: '戊', DBnum: 'd5'),
  '己': Letter(kor: '기', chiness: '己', DBnum: 'd6'),
  '庚': Letter(kor: '경', chiness: '庚', DBnum: 'd7'),
  '辛': Letter(kor: '신', chiness: '辛', DBnum: 'd8'),
  '壬': Letter(kor: '임', chiness: '壬', DBnum: 'd9'),
  '癸': Letter(kor: '계', chiness: '癸', DBnum: 'd10'),
  '-1': Letter(kor: '?', chiness: "?", DBnum: 'e0')
};
