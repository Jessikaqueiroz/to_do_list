import 'package:flutter/material.dart';

void main() {
  runApp(ToDoApp());
}

class ToDoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'To Do List',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ToDoListPage(),
    );
  }
}

class ToDoListPage extends StatefulWidget {
  @override
  _ToDoListPageState createState() => _ToDoListPageState();
}

class _ToDoListPageState extends State<ToDoListPage> {
  List<Map<String, dynamic>> tasks = [];
  TextEditingController taskController = TextEditingController();

  void _addTask() {
    String taskText = taskController.text;
    if (taskText.isNotEmpty) {
      setState(() {
        tasks.add({'task': taskText, 'completed': false});
      });
      taskController.clear();
    }
  }

  void _toggleCompletion(int index) {
    setState(() {
      tasks[index]['completed'] = !tasks[index]['completed'];
      if (tasks[index]['completed']) {

        var completedTask = tasks.removeAt(index);
        tasks.add(completedTask);
      } else {

        var incompleteTask = tasks.removeAt(index);
        tasks.insert(0, incompleteTask);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Tarefas'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: taskController,
                    decoration: InputDecoration(
                      labelText: 'Digite uma tarefa',
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: _addTask,
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                return CheckboxListTile(
                  title: Text(
                    tasks[index]['task'],
                    style: TextStyle(
                      decoration: tasks[index]['completed']
                          ? TextDecoration.lineThrough
                          : TextDecoration.none,
                    ),
                  ),
                  value: tasks[index]['completed'],
                  onChanged: (bool? value) {
                    _toggleCompletion(index);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
