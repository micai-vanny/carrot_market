import 'dart:convert';

import 'package:carrot_market/repository/local_storage_repository.dart';

class ContentsRepository extends LocalStorageRepository {
  final String My_FAVORITE_STORE_KEY = "My_FAVORITE_STORE_KEY";
  Map<String, dynamic> data = {
    "shincheon" : [
        {
          "cid": "1",
          "type": "패션잡화",
          "image": "assets/images/ara-1.jpg",
          "title": "네메시스 축구화275",
          "content": "축구화입니다\n잘 안 신어서 내놓게 됐습니다\n거의 새 상품이에요.\n직거래 희망합니다.",
          "location": "대구 동구 신천동",
          "price": "30000",
          "likes": "2"
         },
        {
          "cid": "2",
          "type": "식료품",
          "image": "assets/images/ara-2.jpg",
          "title": "LA갈비 5kg팔아요~",
          "content": "어제 새로 들어온 고기입니다.\n양이 너무 많아서 조금 판매합니다.\n신천역 쪽에서 직거래 희망합니다!!",
          "location": "대구 동구 신천동",
          "price": "100000",
          "likes": "5"
        },
        {
          "cid": "3",
          "type": "생활용품",
          "image": "assets/images/ara-3.jpg",
          "title": "치약팝니다",
          "content": "치약 필요하신 분~!~!~\n유통기한 아직 짱짱하게 남았습니다!\n자취생 분들이나 치약 필요하신분 연락주세요!\n신천역 쪽이나 송라시장 쪽 직거래입니다!",
          "location": "대구 동구 신천동",
          "price": "5000",
          "likes": "0"
        },
        {
          "cid": "4",
          "type": "가전/전자기기",
          "image": "assets/images/ara-4.jpg",
          "title": "[풀박스]맥북프로16인치 터치바 스페이스그레이",
          "content": "축구화입니다\n잘 안 신어서 내놓게 됐습니다\n거의 새 상품이에요.\n직거래 희망합니다.",
          "location": "대구 동구 신천동",
          "price": "2500000",
          "likes": "6"
        },
        {
          "cid": "5",
          "type": "공구",
          "image": "assets/images/ara-5.jpg",
          "title": "디월트존기임팩",
          "content": "축구화입니다\n잘 안 신어서 내놓게 됐습니다\n거의 새 상품이에요.\n직거래 희망합니다.",
          "location": "대구 동구 신천동",
          "price": "150000",
          "likes": "2"
        },
        {
          "cid": "6",
          "type": "가전/전자기기",
          "image": "assets/images/ara-6.jpg",
          "title": "갤럭시s10",
          "content": "멀쩡하게 잘 구동됩니다.\n게임 용 서브 폰이나 따로 막 쓰실 서브폰 필요하신 분 연락주세요.\n자급제폰으로 구매했던 폰입니다!\n 신천시장~신천역 직거래 원합니다.",
          "location": "대구 동구 신천동",
          "price": "180000",
          "likes": "2"
        },
        {
          "cid": "7",
          "type": "가구",
          "image": "assets/images/ara-7.jpg",
          "title": "선반",
          "content": "축구화입니다\n잘 안 신어서 내놓게 됐습니다\n거의 새 상품이에요.\n직거래 희망합니다.",
          "location": "대구 동구 신천동",
          "price": "15000",
          "likes": "2"
        },
        {
          "cid": "8",
          "type": "가전/전자기기",
          "image": "assets/images/ara-8.jpg",
          "title": "냉장 쇼케이스",
          "content": "축구화입니다\n잘 안 신어서 내놓게 됐습니다\n거의 새 상품이에요.\n직거래 희망합니다.",
          "location": "대구 동구 신천동",
          "price": "80000",
          "likes": "3"
        },
        {
          "cid": "9",
          "type": "가전/전자기기",
          "image": "assets/images/ara-9.jpg",
          "title": "대우 미니냉장고",
          "content": "축구화입니다\n잘 안 신어서 내놓게 됐습니다\n거의 새 상품이에요.\n직거래 희망합니다.",
          "location": "대구 동구 신천동",
          "price": "30000",
          "likes": "3"
        },
        {
          "cid": "10",
          "type": "기타/취미",
          "image": "assets/images/ara-10.jpg",
          "title": "멜킨스 풀업 턱걸이 판매합니다.",
          "content": "축구화입니다\n잘 안 신어서 내놓게 됐습니다\n거의 새 상품이에요.\n직거래 희망합니다.",
          "location": "대구 동구 신천동",
          "price": "50000",
          "likes": "7"
        }
      ],
    "hyomok" : [
        {
          "cid": "11",
          "type": "가전/전자기기",
          "image": "assets/images/ora-1.jpg",
          "title": "LG 통돌이세탁기 15kg(내부",
          "content": "새것같은 세탁기 내놓습니다.\n드럼세탁기가 생겨서 통돌이를 정리하려고 해요\n구매한지 얼마 안 된 거의 새것입니다.\n필요하신 분 연락주세요.",
          "location": "대구 동구 효목동",
          "price": "150000",
          "likes": "13"
        },
        {
          "cid": "12",
          "type": "가구",
          "image": "assets/images/ora-2.jpg",
          "title": "3단책장 전면책장 가져가실분",
          "content": "책장 빠르게 처분해야 해서 무료 나눔 드립니다.\n멀쩡하기도 하고 빨리 처분해야 해서\n가지고 가실 분 계시면 드리려고 합니다\n파토 절대 안됩니다.\n연락주세요!",
          "location": "대구 동구 효목동",
          "price": "무료나눔",
          "likes": "6"
        },
        {
          "cid": "13",
          "type": "가전/전자기기",
          "image": "assets/images/ora-3.jpg",
          "title": "브리츠 컴퓨터용 스피커",
          "content": "대충 쓸 스피커 필요하신 분\n연락 주세요 진짜 거저 드립니다.\n음질은 구려도 기능은 멀쩡합니다.\n잠수, 파토내실 분은 안돼요.",
          "location": "대구 동구 효목동",
          "price": "1000",
          "likes": "4"
        },
        {
          "cid": "14",
          "type": "가구",
          "image": "assets/images/ora-4.jpg",
          "title": "안락 의자",
          "content": "진짜 안락한 안락 의자입니다.\n 집을 이사가게 되었는데 같이 들고 갈 수가 없어서\n눈물을 머금고 내놓습니다.",
          "location": "대구 동구 효목동",
          "price": "10000",
          "likes": "1"
        },
        {
          "cid": "15",
          "type": "도서",
          "image": "assets/images/ora-5.jpg",
          "title": "어린이책 무료드림",
          "content": "애기들 책 필요하신 맘 계시면 연락주세요~~\n선착순입니다~~\n무료나눔이지만 매너 아시죠~\n파토내실 분, 찔러보기 안됩니다~!",
          "location": "대구 동구 효목동",
          "price": "무료나눔",
          "likes": "1"
        },
        {
          "cid": "16",
          "type": "도서",
          "image": "assets/images/ora-6.jpg",
          "title": "어린이책 무료드림",
          "content": "애기들 책 필요하신 맘 계시면 연락주세요~~\n선착순입니다~~\n무료나눔이지만 매너 아시죠~\n파토내실 분, 찔러보기 안됩니다~!",
          "location": "대구 동구 효목동",
          "price": "무료나눔",
          "likes": "0"
        },
        {
          "cid": "17",
          "type": "주방용품",
          "image": "assets/images/ora-7.jpg",
          "title": "칼세트 새제품 팝니다",
          "content": "새 상품입니다.\n칼 세트 필요하신 분 연락주세요.\n네고은 받지 않습니다.",
          "location": "대구 동구 효목동",
          "price": "20000",
          "likes": "5"
        },
        {
          "cid": "18",
          "type": "가구",
          "image": "assets/images/ora-8.jpg",
          "title": "아이팜 장난감 정리함 팔아요",
          "content": "아이가 많이 자라서\n장난감을 정리하게 되었네요.\n저렴하게 드려요~",
          "location": "대구 동구 효목동",
          "price": "30000",
          "likes": "29"
        },
        {
          "cid": "19",
          "type": "가구",
          "image": "assets/images/ora-9.jpg",
          "title": "한샘 책상 책장 수납장세트 팝니다.",
          "content": "가구를 교체하게 되면서 내놓습니다.\n너무 멀쩡하구요,\n깨끗하게 사용한 제품입니다.\n네고 가능합니다.",
          "location": "대구 동구 효목동",
          "price": "1500000",
          "likes": "1"
        },
        {
          "cid": "20",
          "type": "자동차용품",
          "image": "assets/images/ora-10.jpg",
          "title": "순정 데일리 오가닉 카시트",
          "content": "직거래 희망\n 완전 새 것입니다.\n 네고불가.",
          "location": "대구 동구 효목동",
          "price": "60000",
          "likes": "8"
        },
      ],
  };

  Future<List<Map<String, String>>> loadContentsFromLocation(String location) async {
    // API 통신 : location값을 보내주면서
    await Future.delayed(Duration(milliseconds: 1000));
    return data[location];
  }

  Future<List?> loadFavoriteContents() async {
    String? jsonString = await this.getStoredValue(My_FAVORITE_STORE_KEY);
    if(jsonString != null) {
      List<dynamic> json = jsonDecode(jsonString);
      return json;
    }else {
      return null;
    }
  }

  // 좋아요 저장 처리
  addMyFavoriteContent(Map<String, String> content) async {
    // 좋아요 목록 리스트로 저장
    List? favoiteContentsList = await loadFavoriteContents();
    if(favoiteContentsList == null || !(favoiteContentsList is List)){
      favoiteContentsList = [content];
    }else {
      favoiteContentsList.add(content);
    }
    // 저장 된 좋아요 리스트 json 타입으로 인코딩
    updateFavoriteContents(favoiteContentsList);
  }

  void updateFavoriteContents(List favoiteContentsList) async {
    await this.storeValue(My_FAVORITE_STORE_KEY, jsonEncode(favoiteContentsList));
  }

  // 좋아요 했던 것 취소
  deleteMyFavoriteContent(String cid) async {
    List? favoiteContentsList = await loadFavoriteContents();
    if(favoiteContentsList != null && favoiteContentsList is List){
      favoiteContentsList.removeWhere((data) => data["cid"] == cid);
    }
    // 저장 된 좋아요 리스트 json 타입으로 인코딩
    updateFavoriteContents(favoiteContentsList!);
  }

  isMyFavoriteContents(String cid) async {
    bool? isMyFavoriteContents = false;
    List? json = await loadFavoriteContents();
    // null 체크 해서 decoding 처리
      if(json == null || !(json is List)){
        return false;
      } else {
        for(dynamic data in json) {
          if(data["cid"] == cid) {
            isMyFavoriteContents = true;
            break;
          }
        }
      }
      return isMyFavoriteContents;
  }
}
