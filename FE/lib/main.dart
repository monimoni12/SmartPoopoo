import 'package:flutter/material.dart';
import 'package:SmartPoopoo/common_widgets.dart';
import 'package:SmartPoopoo/screens/image_picker_screen.dart';
import 'package:SmartPoopoo/screens/image_detection_screen.dart';
import 'package:SmartPoopoo/screens/diary_screen.dart'; // 다이어리 화면 import

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const HomePage(),
      theme: ThemeData(
        primaryColor: const Color(0xFF445DF6),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  String? selectedImageUrl;
  String defaultImageUrl =
      'https://www.nct.org.uk/sites/default/files/3to4.jpg';



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(120),
        child: AppBar(
          title: Semantics(
            label: '당신의 스마트푸푸입니다. 아래에서 원하는 서비스를 선택하세요.', // 이 라벨만 읽히고
            child: const ExcludeSemantics(
              child: Text(
                '스마트푸푸',
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 0,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                children: [
                  buildMenuButton(context, "사진촬영", () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            const ImageDetectionScreen(), // ImageDetectionScreen으로 이동
                      ),
                    );
                  }, "사진촬영 버튼"),
                  buildMenuButton(context, "앨범에서 가져오기", () async {
                    final result = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ImagePickerScreen(),
                      ),
                    );

                    if (result != null && result is String) {
                      setState(() {
                        selectedImageUrl = result;
                      });
                    }
                  }, "앨범에서 가져오기 버튼"),
                  buildMenuButton(context, "다이어리 보기", () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const DiaryScreen(),
                      ),
                    );
                  }, "다이어리 보기 버튼"), // 다이어리 화면 버튼 추가
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
