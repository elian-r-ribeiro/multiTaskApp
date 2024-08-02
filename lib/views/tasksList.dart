import 'package:flutter/material.dart';

class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 22, 22, 22),
      appBar: AppBar(
        title: Text('Tasks list'),
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Card(
            child: Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Title",
                            style: TextStyle(
                                fontSize: 21,
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.underline),
                          ),
                          Radio(
                              value: "", groupValue: "", onChanged: (value) {})
                        ]),
                    Text(
                      "Description",
                      style: TextStyle(fontSize: 16),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                          onPressed: () {
                            print("Edit icon");
                          },
                          icon: Icon(Icons.edit),
                          color: Colors.green,
                        ),
                        IconButton(
                          onPressed: () {
                            print("Delete icon");
                          },
                          icon: Icon(Icons.delete),
                          color: Colors.red,
                        )
                      ],
                    )
                  ],
                )),
          )
        ],
      ),
    );
  }
}
