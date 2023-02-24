// ignore_for_file: no_logic_in_create_state, prefer_const_constructors, no_leading_underscores_for_local_identifiers, unused_local_variable, unused_field, prefer_final_fields

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
class Task{
  String title;
  String description;
  bool isDone;
  DateTime date;

  List<String> tags;

  Task({
    required this.title,
    required this.description,
    this.isDone = false,
    required this.date,
    required this.tags,
  });
}

class HomeTasksPage extends StatefulWidget {
  const HomeTasksPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomeTasksPageState createState() => _HomeTasksPageState();
}

class _HomeTasksPageState extends State<HomeTasksPage>{
  final _formkey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _dateController = TextEditingController();
  final _tagsController = TextEditingController();


  List<Task> __tasks= [];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Home Tasks Page',
          style: TextStyle(fontSize: 20),
        ),
      ),

      body: ListView.builder(
        itemCount: __tasks.length,

        itemBuilder: (context, index) {

          final task = __tasks[index];
          return ListTile(
            title: Text(__tasks[index].title),
            subtitle: Text(__tasks[index].description),
            
            leading: Checkbox(
              value: __tasks[index].isDone,
              onChanged: (value) {
                setState(() {
                  __tasks[index].isDone = value!;
                });
              },
            ),
            
            trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                setState(() {
                  __tasks.removeAt(index);
                });
              },
            ),
          
          );
        },
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () async {
            String? taskTitle = await showDialog<String>(
              context: context,
              builder: (BuildContext context ){
                TextEditingController _titleController = TextEditingController();
                TextEditingController _descriptionController = TextEditingController();
                TextEditingController _dateController = TextEditingController();
                TextEditingController _tagsController = TextEditingController();

    

/*
                return AlertDialog(
                  
                  title: Text('Add Task'),
                  content: TextField(
                    controller: _titleController,
                    decoration: InputDecoration(
                      hintText: 'Task Title',
                      
                      
                    ),
                  

                  ),

                  actions: <Widget>[
                    TextButton(
                      child: Text('Cancel'),
                      onPressed: () =>
                        Navigator.of(context).pop(),
                      
                    ),
                    TextButton(
                      child: Text('Add'),
                      onPressed: () =>
                        Navigator.of(context).pop(_titleController.text),
                      
                    ),
                  ],
                                    
                );
              });*/


              return AlertDialog(
                //cajas de texto con 2 controllers
                title: Text('Add Task'),
                content: Form(
                  key: _formkey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextFormField(
                        controller: _titleController,
                        decoration: InputDecoration(
                          hintText: 'Task Title',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a title';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: _descriptionController,
                        decoration: InputDecoration(
                          hintText: 'Task Description',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a description';
                          }
                          return null;
                        },
                      ),

                    
                      //Cmapo de texto para ingresar fecha y hora con datetime y validador
                       TextFormField(
                          controller: _dateController,
                          decoration: InputDecoration(
                            labelText: 'Fecha y hora',
                            hintText: 'Ingrese la fecha y hora',
                          ),
                          onTap: () async {
                            // Abre el selector de fecha y hora
                            DateTime? picked = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(1900),
                              lastDate: DateTime(2100),
                            );
                            TimeOfDay? timePicked = await showTimePicker(
                              context: context,
                              initialTime: TimeOfDay.now(),
                            );

                            // Formatea la fecha y la hora seleccionadas
                            if (picked != null && timePicked != null) {
                              String formattedDate = DateFormat('dd/MM/yyyy HH:mm').format(DateTime(picked.year, picked.month, picked.day, timePicked.hour, timePicked.minute));
                              _dateController.text = formattedDate;
                            }
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a date';
                            }
                            return null;
                          },  
                        ),

                      

                      
                      TextFormField(
                        controller: _tagsController,
                        decoration: InputDecoration(
                          hintText: 'Task Tags',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a tag';
                          }
                        
                        }
                      ),
                    ],
                  ),
                ),
                actions: <Widget>[
                  TextButton(
                    child: Text('Cancel'),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                  TextButton(
                    child: Text('Add'),
                    onPressed: () {
                      if (_formkey.currentState!.validate()) {
                        Navigator.of(context).pop(_titleController.text);
                      }
                    },
                  ),
                ],
              );
            },
          );
          if (taskTitle != null) {
            setState(() {
              __tasks.add(Task(
                title: taskTitle,
                description: _descriptionController.text,
                date: DateTime.now(),
                tags: _tagsController.text.split(','),
              ));
            });
          }
        },
      ),
    );
  }
}


                
              
            