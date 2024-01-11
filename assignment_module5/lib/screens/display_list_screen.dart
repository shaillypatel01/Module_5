import 'package:assignment_module5/screens/task_screen.dart';
import 'package:flutter/material.dart';

import '../dbhelper/db_helper.dart';
import '../model/task.dart';



class DisplayListScreen extends StatefulWidget {
  const DisplayListScreen({super.key});

  @override
  State<DisplayListScreen> createState() => _DisplayListScreenState();
}

class _DisplayListScreenState extends State<DisplayListScreen> {
  List<Task> taskList = [];
  var dbHelper = DbHelper();

  void initState() {
    fetchTaskList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    Color getPriorityColor(String priority) {
      switch (priority) {
        case 'High':
          return Color(0xffA12568);
        case 'Medium':
          return Color(0xff03506F);
        case 'Low':
          return Color(0xffA4B494);
        default:
          return Colors.green;
      }
    }
    return Scaffold(
        appBar: AppBar(
          title: Text('Task List Screen',
            style: TextStyle(
                color: Colors.black
            ),),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async{
            Task? person = await Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => TaskScreen(null),
                )
            );
            if(person != null){
              taskList.insert(0, person);
              refreshList(taskList);
            }
          },
          child: Icon(Icons.add),
        ),
        body: Padding(
          padding: EdgeInsets.all(5),
          child: ListView.builder(
            itemCount: taskList.length,
            itemBuilder: (context, index){
              return Card(
                color: getPriorityColor(taskList[index].priority!),
                elevation: 5,
                shape:  RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    ListTile(
                      title: Text(
                        'Name : ${taskList[index].name}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text(
                        'Description : ${taskList[index].description}',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    ListTile(
                      title: Text('Date : ${taskList[index].date}'),
                      subtitle: Text('Time : ${taskList[index].time}'),
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        'Priority : ${taskList[index].priority}',
                        style: TextStyle(
                          color: Colors.black,
                          //color: getPriorityColor(taskList[index].priority!),
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    ButtonBar(
                      children: <Widget>[
                        TextButton(
                          onPressed: () async {
                            Task? person = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => TaskScreen(taskList[index]),
                              ),);
                            if (person != null) {
                              var index = taskList.indexWhere((element) => element.id == person.id);
                              taskList[index] = person;
                              refreshList(taskList);
                            }
                          },
                          child: Text('Edit'),
                        ),
                        TextButton(
                          onPressed: () {
                            var task = taskList[index];
                            deleteRecord(task);
                          },
                          child: Text('Delete'),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        )
    );
  }
  Future<void> fetchTaskList() async {
    var task = await dbHelper.getTask();
    refreshList(task);
  }

  void refreshList(List<Task> tasks) {
    setState(() {
      taskList = tasks;
    });
  }

  Future<void> deleteRecord(Task task) async {
    var id = await dbHelper.deleteTask(task.id!);
    if (id == 1) {
      taskList.removeWhere((element) => element.id == task.id);
      refreshList(taskList);
    }
  }
}
