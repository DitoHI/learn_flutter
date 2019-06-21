import "package:flutter/material.dart";
import "note_detail.dart";

class NoteList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return NoteListState();
  }
}

class NoteListState extends State<NoteList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Notes"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          this._navigateToDetail("Add Note");
        },
        tooltip: "Add Note",
        child: Icon(Icons.add),
      ),
      body: getNoteListView(),
    );
  }

  ListView getNoteListView() {
    TextStyle titleStyle = Theme.of(context).textTheme.subhead;

    return ListView.builder(itemBuilder: (BuildContext context, int position) {
      return Card(
        color: Colors.white,
        elevation: 2.0,
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.yellow,
            child: Icon(Icons.keyboard_arrow_right),
          ),
          title: Text(
            "Dummy Title",
            style: titleStyle,
          ),
          subtitle: Text("Dummy Date"),
          trailing: Icon(Icons.delete, color: Colors.grey),
          onTap: () {
            this._navigateToDetail("Edit Note");
          },
        ),
      );
    });
  }

  void _navigateToDetail(String title) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return NoteDetail(title);
    }));
  }
}
