
import 'package:digiport/table1.dart';
import 'package:flutter/material.dart';

class TableView extends StatefulWidget {
  const TableView({Key? key}) : super(key: key);

  @override
  State<TableView> createState() => _TableViewState();
}

class _TableViewState extends State<TableView> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 1,
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Digital Portal'),
          bottom: const TabBar(
            tabs: <Widget>[
              Tab(
                child: Text('Table1'),
              ),
              Tab(
                child: Text('Table2'),
              ),
              Tab(
                child: Text('Table3'),
              ),
            ],
          ),
        ),
        body: const TabBarView(
          children: <Widget>[
            Center(
              child: FirstTable(),
            ),
            Center(
              child: Text("Table2"),
            ),
            Center(
              child: Text("Table3"),
            ),
          ],
        ),
      ),
    );
  }
}

