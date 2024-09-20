import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project_test/views/form.dart';
import 'package:project_test/views/list.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
        // '/': (context) => MyWidget(),
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
  File? _image;
  ImagePicker _picker = ImagePicker();

  pickImage() async {
    XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (pickedFile != null) {
      prefs.setString('image_path', pickedFile.path);
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  loadImage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? imagePath = prefs.getString('image_path');
    if (imagePath != null) {
      setState(() {
        _image = File(imagePath);
      });
    }
  }

  @override
  void initState() {
    loadImage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de tarefas'),
        backgroundColor: Colors.black,
      ),
      drawer: Drawer(
        child: Column(
          children: [
            UserAccountsDrawerHeader(
                decoration: BoxDecoration(color: Colors.black),
                accountName: Text(
                  'Elian',
                  style: TextStyle(fontSize: 24),
                ),
                accountEmail: Text('elianrodriguesribeiro@gmail.com'),
                currentAccountPicture: ClipOval(
                  child: Container(
                    height: 100,
                    width: 100,
                    child: FittedBox(
                      fit: BoxFit.fill,
                      child: Image.asset('assets/Profile Picture.png'),
                    ),
                  ),
                )),
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
          SingleChildScrollView(
              child: Column(
            children: [
              Image.network('https://i.ytimg.com/vi/1E-UftIFYoA/hqdefault.jpg'),
              _image != null
                  ? Image.file(
                      _image!,
                      fit: BoxFit.cover,
                      width: 300,
                      height: 300,
                    )
                  : Container(),
              ElevatedButton(
                  onPressed: () {
                    pickImage();
                  },
                  child: Text("Selecionar imagem da galeria"))
            ],
          )),
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
