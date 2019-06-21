import "package:flutter/material.dart";
import "note_detail.dart";

import "dart:async";
import "package:learnv2/models/note.dart";
import "package:learnv2/utils/database_helper.dart";
import "package:sqflite/sqflite.dart";

class NoteList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return NoteListState();
  }
}

class NoteListState extends State<NoteList> {
  DatabaseHelper dbHelper = DatabaseHelper();
  List<Note> notes;
  int count = 0;

  @override
  Widget build(BuildContext context) {
    if (notes == null) {
      notes = List<Note>();
      this._updateListView();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Notes"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          this._navigateToDetail(Note("", "", 2), "Add Note");
        },
        tooltip: "Add Note",
        child: Icon(Icons.add),
      ),
      body: getNoteListView(),
    );
  }

  ListView getNoteListView() {
    TextStyle titleStyle = Theme.of(context).textTheme.subhead;

    return ListView.builder(
        itemCount: this.count,
        itemBuilder: (BuildContext context, int position) {
          return Card(
            color: Colors.white,
            elevation: 2.0,
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor:
                    this._getPriorityColor(this.notes[position].priority),
                child: this._getPriorityIcon(this.notes[position].priority),
              ),
              title: Text(
                this.notes[position].title,
                style: titleStyle,
              ),
              subtitle: Text(this.notes[position].date),
              trailing: GestureDetector(
                child: Icon(Icons.delete, color: Colors.grey),
                onTap: () {
                  this._delete(context, this.notes[position]);
                },
              ),
              onTap: () {
                this._navigateToDetail(this.notes[position], "Edit Note");
              },
            ),
          );
        });
  }

  // helper for priority
  // --color
  Color _getPriorityColor(int priority) {
    switch (priority) {
      case 1:
        return Colors.red;
      case 2:
        return Colors.yellow;
      default:
        return Colors.yellow;
    }
  }

  // --icon
  Icon _getPriorityIcon(int priority) {
    switch (priority) {
      case 1:
        return Icon(Icons.play_arrow);
      case 2:
        return Icon(Icons.keyboard_arrow_right);
      default:
        return Icon(Icons.keyboard_arrow_right);
    }
  }

  void _delete(BuildContext context, Note note) async {
    int result = await this.dbHelper.deleteNote(note.id);
    if (result != 0) {
      _showSnackbar(context, "Note Deleted Successfully");
    }
    this._updateListView();
  }

  void _navigateToDetail(Note note, String title) async {
    bool result =
        await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return NoteDetail(note, title);
    }));

    if (result == true) {
      this._updateListView();
    }
  }

  void _showSnackbar(BuildContext context, String message) {
    final snackbar = SnackBar(content: Text(message));
    Scaffold.of(context).showSnackBar(snackbar);
  }

  void _updateListView() {
    final Future<Database> dbFuture = this.dbHelper.initializeDatabase();
    dbFuture.then((database) {
      Future<List<Note>> noteListFuture = this.dbHelper.getNoteList();
      noteListFuture.then((noteList) {
        setState(() {
          this.notes = noteList;
          this.count = noteList.length;
        });
      });
    });
  }
}
