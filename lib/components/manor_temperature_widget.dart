import 'package:flutter/material.dart';

class ManorTemperature extends StatelessWidget {
  double manorTemp;
  late int level;

   ManorTemperature({Key? key, required this.manorTemp}){
     _calcTempLevel();
   }

   void _calcTempLevel() {
     if(manorTemp <= 20){
       level = 0;
     } else if(manorTemp > 20 && manorTemp <= 32){
       level = 1;
     } else if(manorTemp > 32 && manorTemp <= 36.5){
       level = 2;
     } else if(manorTemp > 36.5 && manorTemp <= 40){
       level = 3;
     } else if(manorTemp > 40 && manorTemp <= 50){
       level = 4;
     } else if(manorTemp > 50){
       level = 5;
     }
   }

  final List<Color> temperColors = [
    Color(0xff072038),
    Color(0xff0d3a65),
    Color(0xff186ec0),
    Color(0xff37b24d),
    Color(0xffffad13),
    Color(0xfff76707),
  ];

   Widget _makeTempLabelAndBar() {
     return Container(
       width: 65,
       child: Column(
         children: [
           Text(
             "${manorTemp}℃",
              style: TextStyle(
                color: temperColors[level],
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
           ),
           ClipRRect( // 매너온도 게이지바 모서리 둥글게
             borderRadius: BorderRadius.circular(10),
             child: Container(
               height: 6,
               color: Colors.black.withOpacity(0.2),
               child: Row(
                 children: [
                   Container(
                     height:  6,
                     width: 65 / 99 * manorTemp,  // 가로가 총 65이므로 65를 기준으로 퍼센테이지 계산해서 게이지 채워줌.
                     color: temperColors[level]
                   )
                 ],
               ),
             ),
           )
         ],
       ),
     );
   }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column (
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              _makeTempLabelAndBar(),
              Container(
                margin: const EdgeInsets.only(left: 7),
                width: 30,
                height: 30,
                child: Image.asset("assets/images/level-${level}.jpg"),
              )
            ],
          ),
          Text("매너온도",
            style: TextStyle(
                decoration: TextDecoration.underline,
                fontSize: 12,
                color: Colors.grey),
          )
        ],
      ),
    );
  }
}
