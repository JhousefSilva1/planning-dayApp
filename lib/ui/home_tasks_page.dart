// ignore_for_file: no_logic_in_create_state, prefer_const_constructors, no_leading_underscores_for_local_identifiers, unused_local_variable, unused_field, prefer_final_fields, depend_on_referenced_packages

import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart'
    show
        AlertDialog,
        AppBar,
        BorderRadius,
        BuildContext,
        Checkbox,
        Colors,
        Column,
        CrossAxisAlignment,
        DropdownButtonFormField,
        DropdownMenuItem,
        EdgeInsets,
        ElevatedButton,
        FloatingActionButton,
        Form,
        FormState,
        GlobalKey,
        Icon,
        IconButton,
        Icons,
        InputDecoration,
        ListTile,
        ListView,
        MainAxisSize,
        Navigator,
        OutlineInputBorder,
        Scaffold,
        State,
        StatefulWidget,
        Text,
        TextButton,
        TextEditingController,
        TextFormField,
        TextStyle,
        TimeOfDay,
        Widget,
        showDatePicker,
        showDialog,
        showTimePicker;

import 'package:intl/intl.dart';

class Task {
  String title;
  String description;
  bool isDone;
  DateTime date;

  String? tags;

  Task({
    required this.title,
    required this.description,
    this.isDone = false,
    required this.date,
    this.tags,
  });
}

class HomeTasksPage extends StatefulWidget {
  const HomeTasksPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomeTasksPageState createState() => _HomeTasksPageState();
}

class _HomeTasksPageState extends State<HomeTasksPage> {
  final _formkey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _dateController = TextEditingController();
  final _tagsController = TextEditingController();

  final List<Task> __tasks = [];

  List<String> options = [
    'Select an option',
    'Personal',
    'Work',
    'School',
    'New Tag'
  ];
  String dropdownValue = '';
  TextEditingController textFieldController = TextEditingController();
  String optionTag = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Home Tasks Page',
          style: TextStyle(fontSize: 20),
        ),
      ),

      body: Container(
        padding: EdgeInsets.all(20),
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: ListView.builder(
            itemCount: __tasks.length,
            itemBuilder: (context, index) {
              final task = __tasks[index];
      
              return ListTile(
                // listar title description date tags
                title: Text(
                  "Task : ${task.title}",
                  style:
                      TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                  strutStyle: StrutStyle(height: 2.5),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Descrption :${task.description}",
                        style: TextStyle(color: Colors.grey)),
                    Text("Tag:  ${task.tags!}",
                        style: TextStyle(color: Colors.grey)),
                    Text(
                        "Date: ${task.date.toString().characters.take(19).toString().replaceAll('-', '/')}",
                        style: TextStyle(color: Colors.grey)),
                    Text(
                      "Status: ${task.isDone ? 'Completed' : 'Incomplete'}",
      
                      //textStyle con dos colores
      
                      //maring top
      
                      style: TextStyle(
                          color: task.isDone ? Colors.green : Colors.red),
      
                      //background dos colores
                    ),
                  ],
                ),
                leading: Checkbox(
                  value: task.isDone,
                  onChanged: (value) {
                    setState(() {
                      task.isDone = value!;
                      //show text complete
                      if (task.isDone == true) {
                        /*
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Task completed'),
                            duration: Duration(seconds: 1),
                          ),
      
                          
                        );*/
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text('Congratulations!!'),
                                content: Text('Now your task are completed'),
                                actions: [
                                  TextButton(
                                    child: Text('Ok'),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  )
                                ],
                              );
                            });
                      } else {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text('Pending!!'),
                                content: Text(
                                    'Now yor Task are incompleted, please complete it'),
                                actions: [
                                  TextButton(
                                    child: Text('Ok'),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  )
                                ],
                              );
                            });
                      }
                    });
                  },
                ),
                trailing: IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    setState(() {
                      // __tasks.removeAt(index);
      
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Delete Task'),
                              content:
                                  Text('Are you sure you want to delete it?'),
                              actions: [
                                TextButton(
                                  child: Text('Yes'),
                                  onPressed: () {
                                    setState(() {
                                      __tasks.removeAt(index);
                                    });
                                    //__tasks.removeAt(index);
                                    Navigator.of(context).pop();
      
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: Text('Delete Task'),
                                            content: Text('Task deleted'),
                                            actions: [
                                              TextButton(
                                                child: Text('Ok'),
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                              )
                                            ],
                                          );
                                        });
                                  },
                                ),
                                TextButton(
                                  child: Text('No'),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                )
                              ],
                            );
                          });
                    });
                  },
                ),
      
                //espacio
              );
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Add Task',
        onPressed: () async {
          String? taskTitle = await showDialog<String>(
            context: context,
            builder: (BuildContext context) {
              // TextEditingController _titleController = TextEditingController();
              //TextEditingController _descriptionController = TextEditingController();
              //TextEditingController _dateController = TextEditingController();
              //TextEditingController _tagsController = TextEditingController();
              return AlertDialog(
                title: Text('Add Task'),
                content: Form(
                  key: _formkey,
                  child: Column(
                    
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextFormField(
                        //limpiar cajas

                        controller: _titleController,
                        decoration: InputDecoration(
                          labelText: 'Task Title',
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
                          labelText: 'Description',
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
                            initialTime: TimeOfDay.now(), //Hora actual
                          );

                          // Formatea la fecha y la hora seleccionadas
                          if (picked != null && timePicked != null) {
                            String formattedDate =
                                DateFormat('dd/MM/yyyy HH:mm:ss').format(
                                    DateTime(
                                        picked.year,
                                        picked.month,
                                        picked.day,
                                        timePicked.hour,
                                        timePicked.minute));
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
                      //espacio

                      SizedBox(
                        height: 20,
                      ),
                      DropdownButtonFormField<String>(
                        value: dropdownValue = 'Select an option',
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          //labelText: 'Select an option',
                          hintText: 'Select an option',
                          //espacio
                          contentPadding: EdgeInsets.only(
                            left: 20.0,
                            top: 20.0,
                            bottom: 10.0,
                          ),
                          //padding high
                        ),
                        onChanged: (String? newValue) {
                          setState(() {
                            dropdownValue = newValue!;
                            _tagsController.text = dropdownValue;
                            //espacio

                            if(newValue == 'Select an option'){
                                
                                showDialog(
                                  context: context,
                                  builder: ((context) => AlertDialog(
                                        title: Text('Select an option'),
                                        content: Text('Please select an option'),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: Text('Ok'),
                                          )
                                        ],
                                      )));
                            }

                            

                            if (newValue == 'New Tag') {
                              showDialog(
                                  context: context,
                                  builder: ((context) => AlertDialog(
                                        title: Text('Add Tag'),
                                        content: TextFormField(
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return 'Please enter a tag';
                                            }
                                            return null;
                                          },
                                          onSaved: (value) {
                                            setState(() {
                                              optionTag = value!;
                                            });
                                          },
                                          
                                          
                                        ),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: Text('Cancel'),
                                          ),
                                          ElevatedButton(
                                            onPressed: () {
                                              if (_formkey.currentState!
                                                  .validate()) {
                                                setState(() {
                                                  options.add(optionTag);
                                                  dropdownValue = optionTag;
                                                  _tagsController.text =
                                                      dropdownValue;
                                                  textFieldController.clear();
                                                });
                                                Navigator.of(context).pop();
                                              }
                                            },
                                            child: Text('Add'),
                                          ),
                                        ],
                                      )));
                            } else {
                              setState(() {
                                dropdownValue = newValue;
                                _tagsController.text = dropdownValue;
                              });
                            }
                          });
                        },
                        items: options
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
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

                      if(dropdownValue=='Select an option'){

                        showDialog(
                                  context: context,
                                  builder: ((context) => AlertDialog(
                                        title: Text('Select an option'),
                                        content: Text('Please select an option'),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: Text('Ok'),
                                          )
                                        ],
                                      )));
                                       
                                       
                      }
                      else{
                      if (_formkey.currentState!.validate()) {
                        setState(() {
                          options.add(optionTag);
                          // dropdownValue = value;
                          textFieldController.clear();
                        });
                        Navigator.of(context).pop(_titleController.text);
                      }

                      //limpiar rodas las entradas
                      _titleController.clear();
                      _descriptionController.clear();
                      _dateController.clear();
                  

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
                tags: _tagsController.text,
              ));
            });
          }
        },
        child: Icon(Icons.add),
      ),

      //create a floating button
    );
  }
}
