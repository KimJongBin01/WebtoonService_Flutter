import 'package:flutter/material.dart';
import 'package:toonflix/services/api_service.dart';
import 'package:toonflix/widget/webtoon_widget.dart';

import '../models/webtoon_model.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  Future<List<WebtoonModel>> webtoons = ApiService.getTodaysToons();

  /* --StatefulWidget일 때--
  List<WebtoonModel> webtoons = [];
  bool isLoading = true;

  void waitForWebToons() async {
    webtoons = await ApiService.getTodaysToons();
    isLoading = false;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    waitForWebToons();
  }
  */
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Today's toons",
          style: TextStyle(
            fontSize: 23,
          ),
        ),
        foregroundColor: Colors.green, // 글자색
        backgroundColor: Colors.white, // 배경색
        elevation: 2, // AppBar 밑에 음영
      ),

      // Future를 기다리는 위젯
      body: FutureBuilder(
        future: webtoons, // FutureBuilder가 자동으로 await을 써줌
        // context -> BuildContext, snapshot -> Future의 상태를 알 수 있음
        builder: (context, snapshot) {
          // API로부터 받은 데이터가 존재할 때
          if (snapshot.hasData) {
            // 사용자가 보고있는 아이템만 build
            // 사용자가 보고있지 않다면, 해당 아이템을 메모리에서 삭제
            return Column(
              children: [
                const SizedBox(
                  height: 50,
                ),
                // Expanded는 화면의 남는 공간을 차지하는 위젯,
                // Row나 Column의 child를 학장해서 그 child가 남는 공간을 채우게 함
                // ListView가 무한정의 높이를 가짐

                Expanded(child: makeList(snapshot)),
              ],
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  ListView makeList(AsyncSnapshot<List<WebtoonModel>> snapshot) {
    return ListView.separated(
      // ListView는 한번에 모든걸 다 로딩
      // ListView.builder는 itemBuilder 있음, 한번에 다 X, 그때 마다 로딩(최적화)
      // ListView.separated는 추가로 separatorBuilder가 있음(구분자 추가)
      scrollDirection: Axis.horizontal,
      // list의 아이템 개수를 설정 -> 몇 개의 아이템을 build할 것인지 알게 됨
      itemCount: snapshot.data!.length,
      padding: const EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 20,
      ),
      // index: 0 ~ itemCount 사이
      itemBuilder: (context, index) {
        var webtoon = snapshot.data![index];
        return Webtoon(
          title: webtoon.title,
          thumb: webtoon.thumb,
          id: webtoon.id,
        );
      },
      separatorBuilder: (context, index) => const SizedBox(
        width: 40,
      ),
    );
  }
}
