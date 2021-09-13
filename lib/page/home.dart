import 'package:carrot_market/page/detail.dart';
import 'package:carrot_market/repository/contents_repository.dart';
import 'package:carrot_market/utils/data_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late String currentlocation;
  late ContentsRepository contentsRepository;
  final Map<String, String> locationTypeToString = {
    "shincheon" : "신천동",
    "hyomok" : "효목동",
    "shinam" : "신암동"
  };

  @override
  void initState() {
    super.initState();
    currentlocation = "shincheon";
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    contentsRepository = ContentsRepository();
  }

  // appBar 프로퍼티에는 PreferredSizedWidget 형태가 와야 하기 때문에 해당 위젯의 형태로 생성.
  PreferredSizeWidget _appbarWidget() {
    return AppBar(
      title: GestureDetector(
        onTap: (){
          print("click");
        },
        // onLongPress: (){
        //   print("long pressed!");
        // },
        child: PopupMenuButton<String>(
          offset: Offset(-10,35),
          shape: ShapeBorder.lerp(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
              1),
          onSelected: (String where){
            setState(() {
              currentlocation = where;
            });
          },
          itemBuilder: (BuildContext context) {
            return [
              PopupMenuItem(value: "shincheon",child: Text("신천동"),),
              PopupMenuItem(value: "hyomok",child: Text("효목동"),),
              PopupMenuItem(value: "shinam",child: Text("신암동"),),
            ];
          },
          child: Row(
            children: [
              Text(locationTypeToString[currentlocation].toString()),
              Icon(Icons.arrow_drop_down),
            ],
          ),
        ),
      ),
      elevation: 1,
      actions: [
        IconButton(
            onPressed: (){},
            icon: Icon(Icons.search)),
        IconButton(
            onPressed: (){},
            icon: Icon(Icons.tune)),
        IconButton(
            onPressed: (){},
            icon: SvgPicture.asset("assets/svg/bell.svg", width: 22, color: Colors.white,)),
      ],
    );
  }

  _loadContents() {
    return contentsRepository.loadContentsFromLocation(currentlocation);
  }

  _makeDataList(List<Map<String, String>> datas) {
    return ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        itemBuilder: (BuildContext _context, int index){
          return GestureDetector(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (BuildContext context){
                return DetailContentsView(data: datas[index]);
              }));
              print(datas[index]["title"].toString());
            },
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    child: Hero(  // 화면 전환 위젯 애니메이션 효과 : 넘겨주는 쪽과 받는 쪽 모두 사용.
                      tag: datas[index]["cid"].toString(),  // Hero를 사용하기 위해 꼭 사용해주어야 함.
                                                            // Hero 위젯을 식별하기 위한 객체로써 주는 쪽 받는 쪽 모두 동일한 값을 가져야 함.
                      child: Image.asset(
                          datas[index]["image"].toString(),
                          width: 100,
                          height: 100),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      height: 100,
                      padding: const EdgeInsets.only(left: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start, // 좌측 정렬
                        children: [
                          Text(
                            datas[index]["title"].toString(),
                            overflow: TextOverflow.ellipsis,  // 문자열이 너무 길 경우 ... 처리해주는 속성
                            style: TextStyle(fontSize: 15),),
                          SizedBox(height: 5,),
                          Text(
                            datas[index]["location"].toString(),
                            style: TextStyle(fontSize: 12, color: Colors.black.withOpacity(0.3)),
                          ),
                          SizedBox(height: 5,),
                          Text(
                            DataUtils.calStringToWon(datas[index]["price"].toString()),
                            style: TextStyle (fontWeight: FontWeight.w500),),
                          // Expanded의 경우 부모의 사이즈에 따라 사이즈를 확장시키기 때문에 부모인 Column의 사이즈가 존재해야 한다.
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                SvgPicture.asset("assets/svg/heart_off.svg",
                                  width: 13,
                                  height: 13,
                                ),
                                SizedBox(width: 5),
                                Text(datas[index]["likes"].toString()),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        },
        separatorBuilder: (BuildContext _context, int index){
          return Container(height: 1,color: Colors.black.withOpacity(0.4));
        },
        itemCount: datas.length
    );
  }

  // body에는 Widget으로 사용한다! (PreferredSizedWidget 불가!)
  Widget _bodyWidget(){
    return FutureBuilder(
      future: _loadContents(),
      builder: (BuildContext context, dynamic snapshot) {
        if(snapshot.connectionState != ConnectionState.done){
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        if(snapshot.hasError) {
          return Center(
            child: Text("데이터 오류"),
          );
        }

        if(snapshot.hasData) {
          return _makeDataList(snapshot.data);
        }

        return Center(
          child: Text("해당 지역에 데이터가 없습니다."),
        );
      });
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appbarWidget(),
      body: _bodyWidget(),
    );
  }
}