import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';


class FirstTable extends StatefulWidget {
  const FirstTable({Key? key}) : super(key: key);

  @override
  State<FirstTable> createState() => _FirstTableState();
}

class _FirstTableState extends State<FirstTable> {
  bool _isSearch=false;
  String _searchKey='department';
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
    //         if (_isSearch)
    //           Expanded(
    //               child: TextField(
    //                 decoration: InputDecoration(
    //                     hintText: 'Enter search term based on ' +
    //                         _searchKey
    //                             .replaceAll(new RegExp('[\\W_]+'), ' ')
    //                             .toUpperCase(),
    //                     prefixIcon: IconButton(
    //                         icon: Icon(Icons.cancel),
    //                         onPressed: () {
    //                           setState(() {
    //                             _isSearch = false;
    //                           });
    //                           _initializeData();
    //                         }),
    //                     suffixIcon: IconButton(
    //                         icon: Icon(Icons.search), onPressed: () {})),
    //                 onSubmitted: (value) {
    //                   _filterData(value);
    //                 },
    //               )),
    //
    // _mockPullData() async {
    // _expanded = List.generate(_currentPerPage!, (index) => false);
    // setState(() => _isLoading = true);
    // Future.delayed(const Duration(seconds: 3)).then((value) {
    // _sourceOriginal.clear();
    // _sourceOriginal.addAll(_generateData(n: random.nextInt(10000)));
    // _sourceFiltered = _sourceOriginal;
    // _total = _sourceFiltered.length;
    // _source = _sourceFiltered.getRange(0, _currentPerPage!).toList();
    // setState(() => _isLoading = false);
    // });
    // }
    //
    // _filterData(value) {
    // setState(() => _isLoading = true);
    //
    // try {
    // if (value == "" || value == null) {
    // _sourceFiltered = _sourceOriginal;
    // } else {
    // _sourceFiltered = _sourceOriginal
    //     .where((data) => data[_searchKey!]
    //     .toString()
    //     .toLowerCase()
    //     .contains(value.toString().toLowerCase()))
    //     .toList();
    // }
    //
    // _total = _sourceFiltered.length;
    // var _rangeTop = _total < _currentPerPage! ? _total : _currentPerPage!;
    // _expanded = List.generate(_rangeTop, (index) => false);
    // _source = _sourceFiltered.getRange(0, _rangeTop).toList();
    // } catch (e) {
    // print(e);
    // }
    // setState(() => _isLoading = false);
    // }
    //
    // if (!_isSearch)
    //           IconButton(
    //               icon: Icon(Icons.search),
    //               onPressed: () {
    //                 setState(() {
    //                   _isSearch = true;
    //                 });
    //               }),
            ElevatedButton(
              onPressed: () => {
              showDialog(
              context: context,
              builder: (context) => const AddTableContent(),
              ),
              },
              child: const Text('Add Row', style: TextStyle(fontSize: 20.0)),
              // style: ElevatedButton.styleFrom(primary: Colors.deepPurple),
            ),
            const ViewTable(),
          ],
        ),
      ),
    );
  }
}
class AddTableContent extends StatefulWidget {
  const AddTableContent({Key? key}) : super(key: key);

  @override
  State<AddTableContent> createState() => _AddTableContentState();
}

class _AddTableContentState extends State<AddTableContent> {
 var dept='';
 var num='';
 final _formKey = GlobalKey<FormState>();
 final deptController = TextEditingController();
 final numController = TextEditingController();

 @override
  void dispose() {
    super.dispose();
    deptController.dispose();
    numController.dispose();
  }

  clearText(){
   deptController.clear();
   numController.clear();
  }

  CollectionReference tableOne=FirebaseFirestore.instance.collection('tableOne');

 Future<void> addUser() {
   return tableOne
       .add({'department': dept, 'telecomNum': num,})
       .then((value) => print('row Added'))
       .catchError((error) => print('Failed to Add user: $error'));
 }

  @override
  Widget build(BuildContext context) {
    return  AlertDialog(
      title: const Text('Add new Row'),
      content:Form(
        key: _formKey,
        child: Container(
          width: MediaQuery.of(context).size.width / 3,
          child: SingleChildScrollView(
            child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 10.0),
                    child: TextFormField(
                      autofocus: false,
                      decoration: const InputDecoration(
                        labelText: 'Dept: ',
                        labelStyle:  TextStyle(fontSize: 20.0),
                        border: OutlineInputBorder(),
                        errorStyle:
                        TextStyle(color: Colors.redAccent, fontSize: 15),
                      ),
                      controller: deptController,
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
                      controller: numController,
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
                            if(_formKey.currentState!.validate() && deptController.text!='' &&numController.text!='') {
                            setState(() {
                              dept = deptController.text;
                              num = numController.text;
                              addUser();
                            });
                            Navigator.pop(context);
                          }
                        },
                          child: const Text(
                            'Add',
                            style: const TextStyle(fontSize: 18.0),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () => {clearText()},
                          child: const Text(
                            'Reset',
                            style: const TextStyle(fontSize: 18.0),
                          ),
                          style: ElevatedButton.styleFrom(primary: Colors.blueGrey),
                        ),
                      ],
                    ),
                  )
                ],
              ),
          ),
        ),
      ),
    );
  }
}

class UpdateTableContent extends StatefulWidget {
  //const UpdateTableContent({Key? key}) : super(key: key);
  final String id;
  const UpdateTableContent({Key? key, required this.id}) : super(key: key);
  @override
  State<UpdateTableContent> createState() => _UpdateTableContentState();
}

class _UpdateTableContentState extends State<UpdateTableContent> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController teleController=TextEditingController();
  TextEditingController deptController=TextEditingController();

  // Updaing Student
  CollectionReference tableOne =
  FirebaseFirestore.instance.collection('tableOne');

  Future<void> updateUser(id, dpt, nm) {
    return tableOne
        .doc(id)
        .update({'department': dpt, 'telecomNum': nm,})
        .then((value) => print("changes Updated"))
        .catchError((error) => print("Failed to update user: $error"));
  }
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Form(
        key: _formKey,
        child: Container(
            width: MediaQuery.of(context).size.width / 3,
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  child: TextFormField(
                    decoration: const InputDecoration(
                        hintText: 'Department', border: OutlineInputBorder()),
                    controller: deptController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Department cannot be empty";
                      }
                      return null;
                    },
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  child: TextFormField(
                    decoration: const InputDecoration(
                        hintText: 'TelecomNUm', border: OutlineInputBorder()),
                    controller: teleController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "TelecomNum cannot be empty";
                      }
                      return null;
                    },
                  ),
                ),


                ElevatedButton(onPressed: () {

                  if (_formKey.currentState!.validate() && teleController!=null && deptController!=null) {
                    updateUser(widget.id,deptController.text,teleController.text);
                    // v.reference.update({'telecomNum':telecontroller,'department':deptController});
                  }
                  setState(() {
                  });
                  Navigator.pop(context);
                }, child: const Text('Update')),

              ],
            )

        ),

      ),
    );
  }
}


class ViewTable extends StatefulWidget {
  const ViewTable({Key? key}) : super(key: key);

  @override
  State<ViewTable> createState() => _ViewTableState();
}

class _ViewTableState extends State<ViewTable> {

  final Stream<QuerySnapshot> tableOneStream =
  FirebaseFirestore.instance.collection('tableOne').snapshots();

  // For Deleting User
  CollectionReference students =
  FirebaseFirestore.instance.collection('tableOne');
  Future<void> deleteUser(id) {
    // print("User Deleted $id");
    return students
        .doc(id)
        .delete()
        .then((value) => print('User Deleted'))
        .catchError((error) => print('Failed to Delete user: $error'));
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: tableOneStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            print('Something went Wrong');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          final List storedocs = [];
          snapshot.data!.docs.map((DocumentSnapshot document) {
            Map a = document.data() as Map<String, dynamic>;
            storedocs.add(a);
            a['id'] = document.id;
          }).toList();

          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Table(
                border: TableBorder.all(),
                columnWidths: const <int, TableColumnWidth>{
                  1: FixedColumnWidth(140),
                },
                defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                children: [
                  const TableRow(
                    children: [
                      TableCell(
                        child:  Center(
                          child: Text(
                            'Sl.No',
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      TableCell(
                        child:  Center(
                          child: Text(
                            'Department',
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      TableCell(
                        child: Center(
                          child: Text(
                            'TelecomeNum',
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                       TableCell(
                        child: Center(
                          child: Text(
                            'Action',
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  for (var i = 0; i < (storedocs.length); i++) ...[
                    TableRow(
                      children: [
                        TableCell(
                          child: Center(
                              child: Text((i+1).toString(),
                                  style: const TextStyle(fontSize: 18.0))),
                        ),
                        TableCell(
                          child: Center(
                              child: Text(storedocs[i]['department'],
                                  style: const TextStyle(fontSize: 18.0))),
                        ),
                        TableCell(
                          child: Center(
                              child: Text(storedocs[i]['telecomNum'],
                                  style: const TextStyle(fontSize: 18.0))),
                        ),
                        TableCell(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                onPressed: () => {
                                  showDialog(
                                    context: context,
                                    builder: (context) => UpdateTableContent(id: storedocs[i]['id']),
                                  ),
                                // Navigator.push(
                                // context,
                                // MaterialPageRoute(builder: (context) => UpdateTableContent(id: storedocs[i]['id']))),
                                 // AlertDialog(title: Text('Update'),content: Container(child:  UpdateTableContent(id: storedocs[i]['id']),),)
                                },
                                icon: const Icon(
                                  Icons.edit,
                                  color: Colors.orange,
                                ),
                              ),
                              IconButton(
                                onPressed: (){},
                               // {deleteUser(storedocs[i]['id'])},
                                icon: const Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
          );
        });
  }
}

