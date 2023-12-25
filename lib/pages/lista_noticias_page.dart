import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:xml/xml.dart' as xml;
import 'detalhes_noticia_page.dart'; // Import the detail page

class ListaNoticiasPage extends StatefulWidget {
  @override
  _ListaNoticiasPageState createState() => _ListaNoticiasPageState();
}

class _ListaNoticiasPageState extends State<ListaNoticiasPage> {
  final String rssUrl = 'https://g1.globo.com/rss/g1/ciencia-e-saude/';
  List<Map<String, dynamic>> newsItems = [];
  bool isLoading = true;
  String errorMessage = '';

  @override
  void initState() {
    super.initState();
    fetchRss();
  }

  T? firstOrNull<T>(Iterable<T> iterable) {
    if (iterable.isEmpty) {
      return null;
    }
    return iterable.first;
  }

  Future<void> fetchRss() async {
    try {
      final response = await http.get(Uri.parse(rssUrl));

      if (response.statusCode == 200) {
        final document = xml.XmlDocument.parse(response.body);
        final items = document.findAllElements('item');

        final newsList = items.map((item) {
          final title = item.findElements('title').first.innerText;
          final imageUrlElement =
              firstOrNull(item.findElements('media:content'));
          final imageUrl = imageUrlElement?.getAttribute('url');
          final description = item.findElements('description').first.innerText;

          return {
            'title': title,
            'imageUrl': imageUrl,
            'description': description,
          };
        }).toList();

        setState(() {
          newsItems = newsList;
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
          errorMessage = 'Failed to load RSS. Please try again later.';
        });
      }
    } catch (error, stackTrace) {
      setState(() {
        isLoading = false;
        errorMessage = 'An error occurred. Please try again later.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ciência e Saúde - Notícias'),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : errorMessage.isNotEmpty
              ? Center(child: Text(errorMessage))
              : ListView.builder(
                  itemCount: newsItems.length,
                  itemBuilder: (context, index) {
                    return Card(
                      margin: const EdgeInsets.all(5),
                      elevation: 3,
                      child: ListTile(
                        leading: newsItems[index]['imageUrl'] != null
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.network(
                                  newsItems[index]['imageUrl'],
                                  width: 60,
                                  height: 60,
                                  fit: BoxFit.cover,
                                ),
                              )
                            : Container(),
                        title: Text(
                          newsItems[index]['title'],
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        onTap: () {
                          // Navigate to the detail page when a news item is tapped
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetalheNoticiaPage(
                                  newsItem: newsItems[index]),
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
    );
  }
}
