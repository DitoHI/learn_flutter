import "package:flutter/material.dart";

class NoteDetail extends StatefulWidget {
  final String appBarTitle;

  NoteDetail(this.appBarTitle);

  @override
  State<StatefulWidget> createState() {
    return NoteDetailState(this.appBarTitle);
  }
}

class NoteDetailState extends State<NoteDetail> {
  String appBarTitle;

  NoteDetailState(String title) {
    this.appBarTitle = title;
  }

  List<String> _priorities = ["High", "Medium", "Low"];
  String _prioritySelected = "";

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    this._prioritySelected = this._priorities[0];
  }

  @override
  Widget build(BuildContext context) {
    var textStyle = Theme.of(context).textTheme.title;

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
                      items: this._priorities.map((priority) {
                        return DropdownMenuItem<String>(
                          value: priority,
                          child: Text(priority),
                        );
                      }).toList(),
                      style: textStyle,
                      value: this._prioritySelected,
                      onChanged: (String prioritySelected) {
                        this._onDropdownPrioritySelected(prioritySelected);
                      }),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                  child: TextField(
                    controller: titleController,
                    style: textStyle,
                    onChanged: (value) {
                      debugPrint("$value in Title TextField");
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
                      debugPrint("$value in Description TextField");
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
                                debugPrint("Save button clicked");
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
                                debugPrint("Delete button clicked");
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

  void _onDropdownPrioritySelected(String prioritySelected) {
    setState(() {
      this._prioritySelected = prioritySelected;
    });
  }

  void _moveToLastScreen() {
    Navigator.pop(context);
  }
}
