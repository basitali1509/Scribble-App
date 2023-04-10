import 'package:flutter/material.dart';
import 'package:notes_app/Model/db_helper.dart';
import 'package:notes_app/Model/db_model.dart';
import 'package:notes_app/Utils/snackbar.dart';
import 'package:notes_app/View/notes_display.dart';

class AddNotes extends StatefulWidget {
  Future<List<Notes>> noteslist;
  AddNotes({required this.noteslist, Key? key}) : super(key: key);

  @override
  State<AddNotes> createState() => _AddNotesState();
}

class _AddNotesState extends State<AddNotes> {
  TextEditingController titleController = TextEditingController();
  TextEditingController subtitleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  int priority = 1;

  DatabaseHelper databaseHelper = DatabaseHelper();

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    databaseHelper = DatabaseHelper();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Container(
              height: 50,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(.65),
                  borderRadius: BorderRadius.circular(8)),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 0),
                child: TextFormField(
                  textInputAction: TextInputAction.newline,
                  style: const TextStyle(fontSize: 19),
                  controller: titleController,
                  cursorColor: Colors.grey,
                  decoration: const InputDecoration(
                    hintText: 'Title',
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: Container(
              height: 50,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(.65),
                  borderRadius: BorderRadius.circular(8)),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: TextFormField(
                  maxLines: 2,
                  style: const TextStyle(fontSize: 16),
                  controller: subtitleController,
                  cursorColor: Colors.grey,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Subtitle',
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 25),
            child: Row(
              children: [
                InkWell(
                    onTap: () {
                      setState(() {
                        priority = 1;
                      });
                    },
                    child: Stack(
                      children: [
                        CircleAvatar(
                          radius: 10,
                          backgroundColor:
                              priority == 1 ? Colors.white : Colors.red,
                          child: priority == 1
                              ? Stack(
                                  children: const [
                                    CircleAvatar(
                                      radius: 7.7,
                                      backgroundColor: Colors.red,
                                    ),
                                  ],
                                )
                              : Container(),
                        ),
                      ],
                    )),
                const SizedBox(width: 10),
                InkWell(
                    onTap: () {
                      setState(() {
                        priority = 2;
                      });
                    },
                    child: Stack(
                      children: [
                        CircleAvatar(
                          radius: 10,
                          backgroundColor:
                              priority == 2 ? Colors.white : Colors.yellow,
                          child: priority == 2
                              ? Stack(
                                  children: const [
                                    CircleAvatar(
                                      radius: 7.5,
                                      backgroundColor: Colors.yellow,
                                    ),
                                  ],
                                )
                              : Container(),
                        ),
                      ],
                    )),
                const SizedBox(width: 10),
                InkWell(
                  onTap: () {
                    setState(() {
                      priority = 3;
                    });
                  },
                  child: Stack(
                    children: [
                      CircleAvatar(
                        radius: 10,
                        backgroundColor:
                            priority == 3 ? Colors.white : Colors.green,
                        child: priority == 3
                            ? Stack(
                                children: const [
                                  CircleAvatar(
                                    radius: 7.7,
                                    backgroundColor: Colors.green,
                                  ),
                                ],
                              )
                            : Container(),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: Container(
              height: 270,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(.65),
                  borderRadius: BorderRadius.circular(8)),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                child: TextFormField(
                  style: const TextStyle(fontSize: 15),
                  maxLines: 20,
                  textInputAction: TextInputAction.newline,
                  controller: descriptionController,
                  cursorColor: Colors.grey,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Description',
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 25),
            child: InkWell(
              onTap: () {
                databaseHelper
                    .insert(Notes(
                        title: titleController.text.toString(),
                        subtitle: subtitleController.text.toString(),
                        description: descriptionController.text.toString(),
                        priority: priority))
                    .then((value) {
                  setState(() {
                    widget.noteslist = databaseHelper.getNotes();
                  });
                  snackBar.showSnackBar(context, 'Notes Added');
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const DisplayNotes()));
                }).onError((error, stackTrace) {
                  print(error.toString());
                });
              },
              child: Container(
                height: 40,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.redAccent,
                    borderRadius: BorderRadius.circular(40)),
                child: const Center(
                    child: Text(
                  'Save',
                  style: TextStyle(fontSize: 18),
                )),
              ),
            ),
          )
        ],
      ),
    );
  }
}
