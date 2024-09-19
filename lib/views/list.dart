import 'package:flutter/material.dart';
import 'package:project_test/models/task_model.dart';
import 'package:project_test/service/task_service.dart';
import 'package:project_test/views/form.dart';

class ListViewTasks extends StatefulWidget {
  const ListViewTasks({super.key});

  @override
  State<ListViewTasks> createState() => _ListViewTasksState();
}

class _ListViewTasksState extends State<ListViewTasks> {
  TaskService taskService = TaskService();
  List<Task> tasks = [];

  getAllTasks() async {
    tasks = await taskService.getTasks();
    setState(() {});
  }

  @override
  void initState() {
    getAllTasks();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Lista de tarefas "),
          backgroundColor: Color.fromARGB(255, 71, 84, 231),
        ),
        body: ListView.builder(
            itemCount: tasks.length,
            itemBuilder: (context, index) {
              bool localIsDone = tasks[index].isDone ?? false;
              String priority = tasks[index].priority ?? 'baixa';

              Color priorityColor;
              String priorityText;

              switch (priority) {
                case 'média':
                  priorityColor = Colors.orange;
                  priorityText = 'Prioridade Média';
                  break;
                case 'alta':
                  priorityColor = Colors.red;
                  priorityText = 'Prioridade Alta';
                  break;
                case 'baixa':
                default:
                  priorityColor = Colors.green;
                  priorityText = 'Prioridade Baixa';
                  break;
              }
              return Card(
                  color: Colors.grey[200],
                  child: Padding(
                      padding: EdgeInsets.all(10),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    (tasks[index].title.toString()),
                                    style: TextStyle(
                                        fontSize: 22,
                                        color: localIsDone
                                            ? Colors.grey
                                            : Colors.blue,
                                        decoration: localIsDone
                                            ? TextDecoration.lineThrough
                                            : TextDecoration.none),
                                  ),
                                  Checkbox(
                                      value: tasks[index].isDone ?? false,
                                      onChanged: (value) {
                                        if (value != null) {
                                          taskService.editTaskByCheckBox(
                                              index, value);
                                        }

                                        setState(() {
                                          tasks[index].isDone = value;
                                        });
                                      })
                                ]),
                            Text(
                              tasks[index].description.toString(),
                              style: TextStyle(
                                  fontSize: 22,
                                  color:
                                      localIsDone ? Colors.grey : Colors.blue,
                                  decoration: localIsDone
                                      ? TextDecoration.lineThrough
                                      : TextDecoration.none),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                IconButton(
                                    onPressed: () async {
                                      if (localIsDone == false) {
                                        Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        FormViewTasks(
                                                            task: tasks[index],
                                                            index: index)))
                                            .then((value) => getAllTasks());
                                      }
                                    },
                                    icon: Icon(
                                      localIsDone ? null : Icons.edit,
                                      color: Colors.blue,
                                    )),
                                IconButton(
                                    onPressed: () async {
                                      await taskService.deleteTasks(index);
                                      getAllTasks();
                                    },
                                    icon: Icon(
                                      Icons.delete,
                                      color: localIsDone
                                          ? Colors.grey
                                          : Colors.red,
                                    )),
                              ],
                            ),
                            Text(
                              priorityText,
                              style: TextStyle(
                                  decoration: localIsDone
                                      ? TextDecoration.lineThrough
                                      : TextDecoration.none,
                                  color:
                                      localIsDone ? Colors.grey : priorityColor,
                                  fontWeight: FontWeight.bold),
                            )
                          ])));
            }));
  }
}
