import 'package:flutter/material.dart';

class RCPPage extends StatefulWidget {
  const RCPPage({super.key});

  static Future<void> navigatorPush(BuildContext context) async {
    return Navigator.push<void>(
      context,
      MaterialPageRoute(
        builder: (_) => RCPPage(),
      ),
    );
  }

  @override
  State<RCPPage> createState() => _RCPPageState();
}

class _RCPPageState extends State<RCPPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cronômetro RCP'),
      ),
    );
  }
}
