import 'package:carousel_slider/carousel_slider.dart';
import 'package:carrot_market/components/manor_temperature_widget.dart';
import 'package:carrot_market/repository/contents_repository.dart';
import 'package:carrot_market/utils/data_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/parser.dart';

class DetailContentsView extends StatefulWidget {
  Map<String, String> data;
  DetailContentsView({key, required this.data}) : super(key: key);

  @override
  _DetailContentsViewState createState() => _DetailContentsViewState();
}

class _DetailContentsViewState extends State<DetailContentsView> with SingleTickerProviderStateMixin{

  final scaffoldKey = GlobalKey<ScaffoldState>();
  late ContentsRepository contentsRepository;
  // device 가로 길이를 알아서 맞춰 주도록 사이즈를 처리.
  late Size size;
  late List<String> imgList;

  late int _current;
  double scrollpositionToAlpha = 0;
  ScrollController _controller = ScrollController();
  late AnimationController _animationController;
  late Animation _colorTween;
  late bool isMyFavoriteContent;

  @override
  void initState() {
    super.initState();
    isMyFavoriteContent = false;
    contentsRepository = ContentsRepository();
    _animationController = AnimationController(vsync: this);
    _colorTween = ColorTween(begin: Colors.white, end: Colors.black).animate(_animationController);
    _controller.addListener(() {
      setState(() {
        if(_controller.offset > 255) {
          scrollpositionToAlpha = 255;
        } else {
          scrollpositionToAlpha = _controller.offset;
        }
        _animationController.value = scrollpositionToAlpha / 255;
      });
    });
    _loadMyFavoriteContentState();
  }

  _loadMyFavoriteContentState() async {
    // nullsafty 처리!!
    bool? ck = await contentsRepository.isMyFavoriteContents(widget.data["cid"].toString());
    setState(() {
      isMyFavoriteContent = ck!;
    });
    print(ck);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _current = 0;
    size = MediaQuery.of(context).size;
    imgList = [
      widget.data["image"].toString(),
      widget.data["image"].toString(),
      widget.data["image"].toString(),
      widget.data["image"].toString(),
      widget.data["image"].toString(),
    ];
  }

  // 스크롤 위치에 따라 appBar Icon 컬러 변경처리 함수
  Widget _makeIcon(IconData icon) {
    return AnimatedBuilder(
        animation: _colorTween,
        builder: (context, child) =>
            Icon(icon, color: _colorTween.value));
  }

  PreferredSizeWidget _appbarWidget() {
    return AppBar(
      backgroundColor: Colors.white.withAlpha(scrollpositionToAlpha.toInt()), // appbar 상단 고정
      elevation: 0.0,
      leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: _makeIcon(Icons.arrow_back),
      ),
      actions: [
        IconButton(
            onPressed: (){},
            icon: _makeIcon(Icons.share)),
        IconButton(
            onPressed: (){},
            icon: _makeIcon(Icons.more_vert)),
      ],
    );
  }

  Widget _makeSliderImage() {
    return Container(
      child: Stack( // 인디케이터를 이미지 안의 하단 가운데에 배치 해야 하므로 Column이 아닌 Stack 사용
        // 위치 조정은 아래에 있는 Positioned에서 설정
        children: [
          Hero(  // 받는 페이지이므로 추가
            tag: widget.data["cid"].toString(),
            child: CarouselSlider(
              options: CarouselOptions(
                  height: size.width,
                  initialPage: 0,
                  enableInfiniteScroll: false,  // 무한스크롤 X
                  viewportFraction: 1, // 화면을 정사이즈로 사용
                  onPageChanged: (index, reason) {
                    setState(() {
                      _current = index;
                    });
                    print(index);
                  }
              ),
              items: imgList.map((url) {
                return Image.asset(
                  url,
                  width: size.width,
                  fit: BoxFit.fill,
                );
              }).toList(),
            ),
          ),
          Positioned(
            // 이미지 하단에 인디게이터 위치 시킴
            bottom: 0.0,
            // 가로폭을 디바이스 전체로 사용하기 위해서 좌우 0으로 지정
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: imgList.asMap().entries.map((entry) {
                return GestureDetector(
                  child: Container(
                    // 인디케이터 크기 조정
                    width: 8.0,
                    height: 8.0,
                    margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 5.0),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        // 인디케이터 컬러 설정
                        color: (Theme.of(context).brightness == Brightness.dark
                            ? Colors.white
                            : Colors.white)
                            .withOpacity(_current == entry.key ? 0.9 : 0.4)
                    ),
                  ),
                );
              }).toList(),
            ),
          )
        ],
      ),
    );
  }

  Widget _sellerSimpleInfo() {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Row(
        children: [
          // ClipRRect(
          //   borderRadius: BorderRadius.circular(50),
          //   child: Container(
          //     width: 50,
          //     height: 50,
          //     child: Image.asset("assets/Images/user.png"),
          //   ),
          // )
          CircleAvatar(
              radius: 30,
              backgroundImage: Image.asset("assets/images/user.png").image
          ),
          SizedBox(
            width: 15,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("괴도 도구리",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16),
              ),
              Text("대구시 동구 신천동"),
            ],
          ),
          Expanded(child: ManorTemperature(manorTemp: 62)),
        ],
      ),
    );
  }

  Widget _line() {  // 섹션? 마다 라인 넣어주는 함수
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15),
      height: 1,
      color: Colors.grey.withOpacity(0.3),
    );
  }

  Widget _contentDetail() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch, // stretch를 사용해야 전체 영역을 활용하면서 좌측 정렬 가능
        children: [
          SizedBox(height: 20), // 사이사이 간격 주기
          Text(
            widget.data["title"].toString(),
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          SizedBox(height: 15),
          Text(
            widget.data["type"].toString(),
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey,
            ),
          ),
          SizedBox(height: 15),
          Text(
            widget.data["content"].toString(),
            style: TextStyle(
              fontSize: 15,
              height: 1.5,
            ),
          ),
          SizedBox(height: 15),
          Text(
            "채팅 3 • 관심 17 • 조회 295",  // 임의로 데이터 입력
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey,
            ),
          ),
          SizedBox(height: 15),
        ],
      ),
    );
  }

  Widget _otherCellContents() {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("판매자님의 판매 상품", style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
          ),
          Text("모두 보기", style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
          )
        ],
      ),
    );
  }

  Widget _bodyWidget() {
    return CustomScrollView(
        controller: _controller,
        slivers: [
          SliverList(delegate: SliverChildListDelegate([
            _makeSliderImage(),
            _sellerSimpleInfo(),
            _line(),
            _contentDetail(),
            _line(),
            _otherCellContents(),
          ],
          ),
          ),
          SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              sliver: SliverGrid(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10),
                delegate: SliverChildListDelegate(List.generate(20, (index) {
                  return Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Container(
                            color: Colors.grey,
                            height: 120,
                          ),
                        ),
                        Text("상품 이름",style: TextStyle(fontSize: 14),
                        ),
                        Text("금액",style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),);
                }).toList()),
              ))
        ]
    );
  }

  Widget _bottomBarWidget() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      height: 55,
      width: size.width,
      child: Row(
        children: [
          GestureDetector(
            onTap: () async {
              if(isMyFavoriteContent) {
                // 제거
                await contentsRepository.deleteMyFavoriteContent(widget.data["cid"]!);
              }else {
                await contentsRepository.addMyFavoriteContent(widget.data);
              }
              setState(() {
                isMyFavoriteContent = !isMyFavoriteContent;
              });
              scaffoldKey.currentState!.showSnackBar(
                SnackBar(
                  duration: Duration(milliseconds: 1000),
                  content: Text(
                      isMyFavoriteContent
                          ? "관심목록에 추가되었습니다."
                          : "관심목록에서 제거되었습니다."
                  ),
                ),
              );
            },
            child: SvgPicture.asset(
              isMyFavoriteContent
                  ? "assets/svg/heart_on.svg"
                  : "assets/svg/heart_off.svg",
              width: 25,
              height: 25,
              color: Color(0xfff08f4f),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 15, right: 10),
            width: 1,
            height: 40,
            color: Colors.grey.withOpacity(0.3),
          ),
          Column(
            children: [
              Text(
                DataUtils.calStringToWon(widget.data["price"].toString()),
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text("가격 제안 불가",style: TextStyle(fontSize: 14, color: Colors.grey),)
            ],
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 7),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Color(0xfff08f4f),
                  ),
                  child: Text("채팅으로 거래하기",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      extendBodyBehindAppBar: true, // appBar 상위 까지 사용
      appBar: _appbarWidget(),
      body: _bodyWidget(),
      bottomNavigationBar: _bottomBarWidget(),
    );
  }
}
