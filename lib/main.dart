import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(
    ProviderScope(
        child: MyApp()
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.yellow,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Expanded(child: HeaderPage()),
            Expanded(child: BottomPage()),
          ],
        ),
      ),
    );
  }
}

final countProvider = StateNotifierProvider<HomePageState, int>((ref) {
  return HomePageState(0);
});

class HomePageState extends StateNotifier<int> {
  HomePageState(int num) : super(num);

  // 상태 관리 함수
  void add(){
    state++;
  }
}

class HeaderPage extends StatelessWidget {
  const HeaderPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("나 그려짐?===================");

    return Container(
      color: Colors.red,
      child: Align(
        child: Consumer(
           builder: (BuildContext context, WidgetRef ref, Widget? child) {
              final int num = ref.watch(countProvider);
             return Text(
               "$num",
               style: TextStyle(
                 color: Colors.white,
                 fontWeight: FontWeight.bold,
                 fontSize: 100,
                 decoration: TextDecoration.none
             ),);
           },
        ),
      ),
    );
  }
}

class BottomPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      color: Colors.blue,
      child: Align(
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red
          ),
          onPressed: (){
            ref.read(countProvider.notifier).add();
          },
          child: Text("증가", style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 100,
          ),),
        ),
      ),
    );
  }
}