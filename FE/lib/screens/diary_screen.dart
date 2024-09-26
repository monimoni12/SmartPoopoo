import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DiaryScreen extends StatefulWidget {
  const DiaryScreen({super.key});

  @override
  _DiaryScreenState createState() => _DiaryScreenState();
}

class _DiaryScreenState extends State<DiaryScreen> {
  final TextEditingController _textController = TextEditingController();
  List<String> _diaryEntries = [];

  // 다이어리 저장 API 호출
  Future<void> _saveDiaryEntry(String text) async {
    final url = Uri.parse('http://127.0.0.1:5000/diary');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'text': text}),
    );

    if (response.statusCode == 201) {
      setState(() {
        _diaryEntries.add(text);
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('다이어리 저장 성공')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('다이어리 저장 실패')),
      );
    }
  }

  // 다이어리 가져오기 API 호출
  Future<void> _fetchDiaryEntries() async {
    final url = Uri.parse('http://127.0.0.1:5000/diary');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        _diaryEntries = List<String>.from(data['entries']);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchDiaryEntries(); // 앱 시작 시 다이어리 항목 불러오기
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('다이어리'),
      ),
      body: Column(
        children: [
          TextField(
            controller: _textController,
            decoration: InputDecoration(
              hintText: '다이어리 내용을 입력하세요.',
            ),
          ),
          ElevatedButton(
            onPressed: () {
              _saveDiaryEntry(_textController.text);
            },
            child: Text('저장하기'),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _diaryEntries.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_diaryEntries[index]),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
