import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:my_bmi_calc/localization/app_localization.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({Key? key}) : super(key: key);

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {

  Future<List<String>> getResultData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> saveList = prefs.getStringList('saveList') ?? [];
    return saveList;
  }

  void deleteAll() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                deleteAll();
              });
            },
            icon: const Icon(Icons.delete),
          ),
        ],
        elevation: 0.0,
        title: Text(
          context.localize('history'),
        ),
      ),
      body: FutureBuilder(
        future: getResultData(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasData &&
              snapshot.connectionState == ConnectionState.done) {
            List<String> resultList = snapshot.data ?? [];
            return Column(
              children: [
                Expanded(
                  child: resultList.isEmpty
                      ? buildEmptyView()
                      : buildListView(resultList),
                )
              ],
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  buildEmptyView() {
    return Center(
      child: Text(
        'Empty!',
        style: Theme.of(context).textTheme.caption?.copyWith(fontSize: 20.0),
      ),
    );
  }

  buildListView(List<String> resultList) {
    return ListView.separated(
      separatorBuilder: (BuildContext context, int index) => const SizedBox(
        height: 10,
      ),
      itemCount: resultList.length,
      itemBuilder: (BuildContext context, int i) {
        String result = resultList[i];
        var resultItems = jsonDecode(result);
        return Card(
          shadowColor: const Color(0xFF7776FE),
          elevation: 3,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          child: ListTile(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            tileColor: Color(
              int.parse(resultItems['statusColor'], radix: 16),
            ).withOpacity(0.3),
            title: Text(resultItems['status']),
            subtitle: Text(resultItems['formattedDate']),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            leading: Text(
              resultItems['bmi'],
              style: const TextStyle(
                  fontSize: 50,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF5E5F61)),
            ),
          ),
        );
      },
    );
  }
}
