import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
class UpdateTableContent extends StatefulWidget {
 // const UpdateTableContent({Key? key}) : super(key: key);
final String id;
 const UpdateTableContent({Key? key, required this.id}) : super(key: key);
  @override
  State<UpdateTableContent> createState() => _UpdateTableContentState();
}

class _UpdateTableContentState extends State<UpdateTableContent> {
  final _formKey = GlobalKey<FormState>();

  // Updaing Student
  CollectionReference tableOne =
  FirebaseFirestore.instance.collection('tableOne');

  Future<void> updateUser(id, dpt, nm) {
    return tableOne
        .doc(id)
        . set({'department': dpt, 'telecomNum': nm,})
        .then((value) => print("changes Updated"))
        .catchError((error) => print("Failed to update user: $error"));
  }
  @override
  Widget build(BuildContext context) {
    return Center(
      child: AlertDialog(
        title: const Text('Update Row'),
        content:Form(
          key: _formKey,
          child: Container(
            width: MediaQuery.of(context).size.width / 3,
            child: FutureBuilder<DocumentSnapshot<Map<String,dynamic>>>(
              future: FirebaseFirestore.instance
                  .collection('tableOne')
                  .doc(widget.id)
                  .get(),
               builder: (_,snapshot) {
                 if (snapshot.hasError) {
                   print('Something went wrong');
                 }
                 if (snapshot.connectionState == ConnectionState.waiting) {
                   return const Center(child: CircularProgressIndicator());
                 }
                 var data=snapshot.data!.data();
                 var dept=data!['department'];
                 var num=data['telecomNum'];
                 return Column(
                   children: [
                     Container(
                       margin: const EdgeInsets.symmetric(vertical: 10.0),
                       child: TextFormField(
                         autofocus: false,
                         decoration: const InputDecoration(
                           labelText: 'Dept: ',
                           labelStyle: TextStyle(fontSize: 20.0),
                           border: OutlineInputBorder(),
                           errorStyle:
                           TextStyle(color: Colors.redAccent, fontSize: 15),
                         ),
                         //controller: deptController,
                         validator: (value) {
                           if (value == null || value.isEmpty) {
                             return 'Please Enter Dept';
                           }
                           return null;
                         },
                       ),
                     ),
                     Container(
                       margin: const EdgeInsets.symmetric(vertical: 10.0),
                       child: TextFormField(
                         autofocus: false,
                         decoration: const InputDecoration(
                           labelText: 'TelecomNum: ',
                           labelStyle: TextStyle(fontSize: 20.0),
                           border: OutlineInputBorder(),
                           errorStyle:
                           TextStyle(color: Colors.redAccent, fontSize: 15),
                         ),
                         //controller: numController,
                         validator: (value) {
                           if (value == null || value.isEmpty) {
                             return 'Please Enter Num';
                           }
                           return null;
                         },
                       ),
                     ),

                     Container(
                       child: Row(
                         mainAxisAlignment: MainAxisAlignment.spaceAround,
                         children: [
                           ElevatedButton(
                             onPressed: () {
                               if (_formKey.currentState!.validate()) {

                                   updateUser(widget.id,dept,num);

                                 Navigator.pop(context);
                               }
                             },
                             child: const Text(
                               'update',
                               style: TextStyle(fontSize: 18.0),
                             ),
                           ),
                           ElevatedButton(
                             onPressed: () => {},
                             child: const Text(
                               'Reset',
                               style: TextStyle(fontSize: 18.0),
                             ),
                             style: ElevatedButton.styleFrom(
                                 primary: Colors.blueGrey),
                           ),
                         ],
                       ),
                     )
                   ],
                 );
               }
            )
          ),
        ),
      ),
    );
  }
}
