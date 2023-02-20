import 'dart:async'; // import Timer
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:http/http.dart' as http;
// import clipboard from services
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _markdownData = "";

  @override
  void initState() {
    super.initState();
    fetchMarkdownData();

    // Schedule fetching markdown data again after 50 minutes
    Timer.periodic(const Duration(minutes: 50), (timer) {
      fetchMarkdownData();
    });
  }

  void fetchMarkdownData() async {
    try {
      final response = await http.get(Uri.parse("https://raw.githubusercontent.com/FriendlyUser/chatgpt_prompts/main/README.md"));
      setState(() {
        _markdownData = response.body;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("ChatGpt Prompt Viewer"),
        ),
        body: Markdown(
              data: _markdownData,
              selectable: true,
              // onTapLink: (text, href, title) {
              //   Clipboard.setData(ClipboardData(text: text));
              // },
        ),
      ),
    );
  }
}