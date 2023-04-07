import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'account.dart';

class NextPage extends StatelessWidget {
  const NextPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('履歴を表示'),
        elevation: 2,
      ),
    );
  }
}

class History extends StatefulWidget {
  const History({Key? key}) : super(key: key);

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  Account myAccount = Account(
    id: '1',
    name: 'calc',
    userId: 'saito',
    createdTime: DateTime.now(),
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('履歴を表示'),
        elevation: 2,
      ),
      body: ListView.builder(
        // itemCount: postList.length,
        itemBuilder: (context, index) {
          return Row(
            children: [],
          );
        },
      ),
    );
  }
}
