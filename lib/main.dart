import 'package:flutter/material.dart';
import 'package:project_test/views/form.dart';
import 'package:project_test/views/list.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: false,
      ),
      home: MyWidget(),
      routes: {
        //  '/': (context) => MyWidget(),
        'listaDeTarefas': (context) => ListViewTasks(),
        'formDeTarefas': (context) => FormViewTasks()
      },
    );
  }
}

class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Lista de tarefas')),
      drawer: Drawer(
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              accountName: Text(
                'Paulin Bacana',
                style: TextStyle(fontSize: 24),
              ),
              accountEmail: Text('paulinbacana@gmail.com'),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(Icons.person),
              ),
            ),
            ListTile(
              title: Text(
                'Lista de Tarefas',
                style: TextStyle(fontSize: 17),
              ),
              onTap: () {
                Navigator.pushNamed(context, 'listaDeTarefas');
              },
              leading: Icon(
                Icons.list,
                size: 28,
              ),
            ),
            Divider(
              thickness: 2,
            )
          ],
        ),
      ),
      body: Stack(
        children: [
          Padding(
              padding: EdgeInsets.only(bottom: 20, right: 10),
              child: Align(
                alignment: Alignment.bottomRight,
                child: FloatingActionButton(
                  onPressed: () {
                    Navigator.pushNamed(context, 'formDeTarefas');
                  },
                  child: Icon(Icons.add),
                ),
              ))
        ],
      ),
    );
  }
}
