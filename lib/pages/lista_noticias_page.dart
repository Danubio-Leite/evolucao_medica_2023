import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:xml/xml.dart' as xml;

class ListaNoticiasPage extends StatefulWidget {
  @override
  _ListaNoticiasPageState createState() => _ListaNoticiasPageState();
}

class _ListaNoticiasPageState extends State<ListaNoticiasPage> {
  final String rssUrl = 'https://g1.globo.com/rss/g1/ciencia-e-saude/';
  List<String> titles = [];

  @override
  void initState() {
    super.initState();
    fetchRss();
  }

  Future<void> fetchRss() async {
    final response = await http.get(Uri.parse(rssUrl));
    if (response.statusCode == 200) {
      final document = xml.XmlDocument.parse(response.body);
      final items = document.findAllElements('item');

      final newsTitles = items
          .map((item) => item.findElements('title').first.innerText)
          .toList();

      setState(() {
        titles = newsTitles;
      });
    } else {
      throw Exception('Failed to load RSS');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ciência e Saúde - Notícias'),
      ),
      body: ListView.builder(
        itemCount: titles.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(titles[index]),
          );
        },
      ),
    );
  }
}
