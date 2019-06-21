import "package:flutter/material.dart";
import "package:learnv2/models/note.dart";

import "package:learnv2/utils/database_helper.dart";
import 'package:intl/intl.dart';

class NoteDetail extends StatefulWidget {
  final String appBarTitle;
  final Note note;

  NoteDetail(this.note, this.appBarTitle);

  @override
  State<StatefulWidget> createState() {
    return NoteDetailState(this.note, this.appBarTitle);
  }
}

class NoteDetailState extends State<NoteDetail> {
  DatabaseHelper dbHelper = DatabaseHelper();
  String appBarTitle;
  Note note;

  NoteDetailState(this.note, this.appBarTitle);

  static var _priorities = ["High", "Low"];

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var textStyle = Theme.of(context).textTheme.title;

    titleController.text = note.title;
    descriptionController.text = note.description;

    return WillPopScope(
        onWillPop: () {
          this._moveToLastScreen();
        },
        child: Scaffold(
          appBar: AppBar(
            title: Text(this.appBarTitle),
            leading: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  this._moveToLastScreen();
                }),
          ),
          body: Padding(
            padding: EdgeInsets.only(top: 15.0, left: 10.0, right: 10.0),
            child: ListView(
              children: <Widget>[
                ListTile(
                  title: DropdownButton(
                      items: _priorities.map((priority) {
                        return DropdownMenuItem<String>(
                          value: priority,
                          child: Text(priority),
                        );
                      }).toList(),
                      style: textStyle,
                      value: this.getPriorityAsString(note.priority),
                      onChanged: (String prioritySelected) {
                        setState(() {
                          this.updatePriorityAsInt(prioritySelected);
                        });
                      }),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                  child: TextField(
                    controller: titleController,
                    style: textStyle,
                    onChanged: (value) {
                      this.updateTitle();
                    },
                    decoration: InputDecoration(
                        labelText: "Title",
                        labelStyle: textStyle,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0))),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                  child: TextField(
                    controller: descriptionController,
                    style: textStyle,
                    onChanged: (value) {
                      this.updateDescription();
                    },
                    decoration: InputDecoration(
                        labelText: "Description",
                        labelStyle: textStyle,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0))),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: RaisedButton(
                            color: Theme.of(context).primaryColorDark,
                            textColor: Theme.of(context).primaryColorLight,
                            child: Text(
                              "Save",
                              textScaleFactor: 1.5,
                            ),
                            onPressed: () {
                              setState(() {
                                this._save();
                              });
                            }),
                      ),
                      Container(
                        width: 5.0,
                      ),
                      Expanded(
                        child: RaisedButton(
                            color: Theme.of(context).primaryColorDark,
                            textColor: Theme.of(context).primaryColorLight,
                            child: Text(
                              "Delete",
                              textScaleFactor: 1.5,
                            ),
                            onPressed: () {
                              setState(() {
                                this._delete();
                              });
                            }),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }

  void _moveToLastScreen() {
    Navigator.pop(context, true);
  }

  void updatePriorityAsInt(String value) {
    switch (value) {
      case 'High':
        this.note.priority = 1;
        break;
      case 'Low':
        this.note.priority = 2;
        break;
      default:
        break;
    }
  }

  String getPriorityAsString(int value) {
    String priority;
    switch (value) {
      case 1:
        priority = _priorities[0];
        break;
      case 2:
        priority = _priorities[1];
        break;
      default:
        break;
    }
    return priority;
  }

  void updateTitle() {
    note.title = titleController.text;
  }

  void updateDescription() {
    note.description = descriptionController.text;
  }

  void _save() async {
    note.date = DateFormat.yMMMd().format(DateTime.now());

    this._moveToLastScreen();

    int result;
    if (note.id != null) {
      result = await dbHelper.updateNote(note);
    } else {
      result = await dbHelper.insertNote(note);
    }

    if (result != 0) {
      this._showAlertDialog("Note Saved Successfully");
    } else {
      this._showAlertDialog("Problem Saving Note");
    }
  }

  void _delete() async {
    this._moveToLastScreen();

    if (note.id == null) {
      this._showAlertDialog("No Note was deleted");
      return;
    }

    int result = await this.dbHelper.deleteNote(note.id);
    if (result != 0) {
      this._showAlertDialog("Note Deleted Successfully");
    } else {
      this._showAlertDialog("Problem Deleting Note");
    }
  }

  void _showAlertDialog(String message) {
    AlertDialog alertDialog = AlertDialog(
      title: Text("Status"),
      content: Text(message),
    );
    showDialog(context: context, builder: (_) => alertDialog);
  }
}
