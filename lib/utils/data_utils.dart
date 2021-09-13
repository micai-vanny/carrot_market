import 'package:intl/intl.dart';

class DataUtils {
  // 금액 표기 정규식
  // NumberFormat을 사용하려면 intl 라이브러리가 필요함 => pub.dev에서 installing 갖고 와 pubspec에 붙여주기
  static final oCcy = new NumberFormat("#,###","ko_KR");
  static String calStringToWon(String priceString){
    if(priceString == "무료나눔") return priceString;
    return "${oCcy.format(int.parse(priceString))}원";
  }
}