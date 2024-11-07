import 'package:saju/model/letter.dart';

final Map<int, Letter> TWELVEJI = {
  11: Letter(kor: '자', chiness: '子', DBnum: 'e3'),
  12: Letter(kor: '축', chiness: '丑', DBnum: 'e4'),
  1: Letter(kor: '인', chiness: '寅', DBnum: 'e5'),
  2: Letter(kor: '묘', chiness: '卯', DBnum: 'e6'),
  3: Letter(kor: '진', chiness: '辰', DBnum: 'e7'),
  4: Letter(kor: '사', chiness: '巳', DBnum: 'e8'),
  5: Letter(kor: '오', chiness: '午', DBnum: 'e9'),
  6: Letter(kor: '미', chiness: '未', DBnum: 'e10'),
  7: Letter(kor: '신', chiness: '申', DBnum: 'e11'),
  8: Letter(kor: '유', chiness: '酉', DBnum: 'e12'),
  9: Letter(kor: '술', chiness: '戌', DBnum: 'e1'),
  10: Letter(kor: '해', chiness: '亥', DBnum: 'e2'),
  -1: Letter(kor: '?', chiness: "?", DBnum: 'e0')
};

final Map<String, Letter> TWELVEJIBYCHINESS = {
  "子": Letter(kor: '자', chiness: '子', DBnum: 'e3'),
  "丑": Letter(kor: '축', chiness: '丑', DBnum: 'e4'),
  "寅": Letter(kor: '인', chiness: '寅', DBnum: 'e5'),
  "卯": Letter(kor: '묘', chiness: '卯', DBnum: 'e6'),
  "辰": Letter(kor: '진', chiness: '辰', DBnum: 'e7'),
  "巳": Letter(kor: '사', chiness: '巳', DBnum: 'e8'),
  "午": Letter(kor: '오', chiness: '午', DBnum: 'e9'),
  "未": Letter(kor: '미', chiness: '未', DBnum: 'e10'),
  "申": Letter(kor: '신', chiness: '申', DBnum: 'e11'),
  "酉": Letter(kor: '유', chiness: '酉', DBnum: 'e12'),
  "戌": Letter(kor: '술', chiness: '戌', DBnum: 'e1'),
  "亥": Letter(kor: '해', chiness: '亥', DBnum: 'e2'),
  "-1": Letter(kor: '?', chiness: "?", DBnum: 'e0')
};
