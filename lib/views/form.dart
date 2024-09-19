import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:project_test/models/task_model.dart';
import 'package:project_test/service/task_service.dart';

class FormViewTasks extends StatefulWidget {
  final Task? task;
  final int? index;
  const FormViewTasks({super.key, this.task, this.index});

  @override
  State<FormViewTasks> createState() => _FormViewTasksState();
}

class _FormViewTasksState extends State<FormViewTasks> {
  String priority = 'baixa';
  final _formKey = GlobalKey<FormState>();
  TextEditingController _titleController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  TaskService TasksService = TaskService();

  @override
  void initState() {
    if(widget.task != null){
      _titleController.text = widget.task!.title!;
      _descriptionController.text = widget.task!.description!;
      priority = widget.task!.priority ?? 'baixa';
    }
    super.initState();
  }
  

  @override
  Widget build(BuildContext context) {
    final bool isIndexNotNull = widget.index != null;
    return Scaffold(
      appBar: AppBar(
        title: isIndexNotNull? Text('Edição de tarefas') : Text('Criação de tarefas'),
        backgroundColor: Color.fromARGB(255, 71, 84, 231),
      ),
      body:
      Form (key: _formKey, 
          child:
      Column(
        children: [
          
          Padding(
              padding: EdgeInsets.all(12),
              child: TextFormField(
                controller: _titleController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Campo obrigatório!';
                  }
                  return null;
                },
                decoration: InputDecoration(
                    label: Text('Titulo da tarefa'),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15)))),
              )),
          Padding(
              padding: EdgeInsets.all(12),
              child: TextFormField(
                controller: _descriptionController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Campo obrigatório!';
                  }
                  return null;
                },
                keyboardType: TextInputType.multiline,
                maxLines: 4,
                minLines: null,
                decoration: InputDecoration(
                    label: Text('Descrição da tarefa'),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15)))),
              )),
          SizedBox(height: 15),
          Text('Prioridade'),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Radio(
                value: 'baixa', 
                groupValue: priority, 
                onChanged: (value) {
                  setState(() {
                    if(value != null){
                      priority = value;
                    }
                  });
                }),
                Text('Baixa'),
                Radio(
                value: 'média', 
                groupValue: priority, 
                onChanged: (value) {
                  setState(() {
                    if(value != null){
                      priority = value;
                    }
                  });
                }),
                Text('Média'),
                Radio(
                value: 'alta', 
                groupValue: priority, 
                onChanged: (value) {
                  setState(() {
                    if(value != null){
                      priority = value;
                    }
                  });
                }),
                Text('Alta')
            ],
          ),
          ElevatedButton(onPressed: () async {
            if(_formKey.currentState!.validate()){
              String titleNewTask = _titleController.text;
              String descriptionNewTask = _descriptionController.text;
              if(widget.task != null && widget.index != null){
                await TasksService.editTask(widget.index!, titleNewTask, descriptionNewTask, priority);
              }else{
                 await TasksService.saveTask(titleNewTask, descriptionNewTask, false, priority);
              }

          }}, child: isIndexNotNull? Text('Editar tarefa') : Text('Criar Tarefa'))
        ],
      ),
    )
    );
  }
}