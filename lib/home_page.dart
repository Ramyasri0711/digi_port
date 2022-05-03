import 'package:digiport/table_view.dart';
import 'package:flutter/material.dart';
import 'table_view.dart';
class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('DigiPort')),
      body: const Center(
        child: Text('My Page!'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text('Digital Portal'),
            ),
            ListTile(
              title: const Text('INC'),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>const TableView()));
                // Update the state of the app
                // ...
                // Then close the drawer
               // Navigator.pop(context);
              },
            // ),
            // ListTile(
            //   title: const Text('Item 2'),
            //   onTap: () {
            //     // Update the state of the app
            //     // ...
            //     // Then close the drawer
            //     Navigator.pop(context);
            //   },
             ),
          ],
        ),
      ),
    );
  }
}
