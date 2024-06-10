import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:madicalapp_ui/Services/databaseService.dart';
import 'package:madicalapp_ui/Services/model.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // final DataBaseServices _dataBaseServices = DataBaseServices.instance;
  // String? _task;
  DBHelper? dbHelper;
  late Future<List<NotesModel>> notesList;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dbHelper = DBHelper();
    loadData();
  }

  loadData() async {
    notesList = dbHelper!.getNotesList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'SQF Lite',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
                future: notesList,
                builder: (context, AsyncSnapshot<List<NotesModel>> snapshot) {
                  return snapshot.data!.isEmpty
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : ListView.builder(
                          itemCount: snapshot.data?.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10.0, vertical: 2),
                              child: InkWell(
                                onTap: () {
                                  dbHelper!.updateQuantity(NotesModel(
                                    id: snapshot.data![index].id!,
                                      title: 'Updated second note',
                                      age: 23,
                                      description:
                                          'Hello how are u doing',
                                      email: 'subtainkhan5656@gmail.com'));
                                  setState(() {
                                    notesList = dbHelper!.getNotesList();
                                  });
                                },
                                child: Dismissible(
                                  direction: DismissDirection.endToStart,
                                  background: Container(
                                    color: Colors.red,
                                    child: Icon(Icons.delete),
                                  ),
                                  onDismissed: (DismissDirection direction) {
                                    setState(() {
                                      dbHelper!.deleteProduct(
                                          snapshot.data![index].id!);
                                      notesList = dbHelper!.getNotesList();
                                      snapshot.data!
                                          .remove(snapshot.data![index]);
                                    });
                                  },
                                  key: ValueKey<int>(snapshot.data![index].id!),
                                  child: Card(
                                    child: ListTile(
                                      title: Text(snapshot.data![index].title
                                          .toString()),
                                      subtitle: Text(snapshot
                                          .data![index].description
                                          .toString()),
                                      trailing: Text(
                                          snapshot.data![index].age.toString()),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          });
                }),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        onPressed: () {
          dbHelper!
              .insert(NotesModel(
            title: 'Second Note',
            age: 23,
            description: 'Hello how are u doing',
            email: 'subtainkhan5656@gmail.com',
          ))
              .then((value) {
            if (kDebugMode) {
              print('data added');
              setState(() {
                notesList = dbHelper!.getNotesList();
              });
            }
          }).onError((error, stackTrace) {
            if (kDebugMode) {
              print(error.toString());
            }
          });
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
