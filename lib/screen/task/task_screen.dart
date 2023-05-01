// ignore_for_file: unused_local_variable, avoid_unnecessary_containers, unused_import, unused_field, sort_child_properties_last, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:tasks/cubit/auth/auth_cubit.dart';
import 'package:tasks/data/models/tasks.dart';
import 'package:tasks/data/service/tag_service.dart';

import '../../cubit/task/task_cubit.dart';
import '../../cubit/task/task_state.dart';
import '../../data/service/task_service.dart';
import 'package:quickalert/quickalert.dart';
// Importamos el Cubit que maneja el estado de las tareas.

// ignore: must_be_immutable
class TaskPanel extends StatelessWidget {
  //controllres

  // final _titleController = TextEditingController();
  // final _subtitleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _dateController = TextEditingController();
  final _tagsController = TextEditingController();
  final _statusController = TextEditingController();
  String? _selectTag;
  final _formKey = GlobalKey<FormState>();
  late Task _task = Task(labelIds: [], isDone: false);

  TaskPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => TaskCubit(TaskService(), TagsService()),
        child: BlocBuilder<TaskCubit, TaskState>(
        //   listener: (context, state) {
        //   if (state is TaskInitial) {
        //     // ignore: avoid_print
        //     print('TaskInitial');
        //   } else if (state is TaskInternetFailure) {
        //     QuickAlert.show(
        //         context: context,
        //         type: QuickAlertType.error,
        //         text: 'No hay internet');
        //   } else if (state is TaskServerFailure) {
        //     QuickAlert.show(
        //         context: context,
        //         type: QuickAlertType.error,
        //         text: 'No hay servidor');
        //   } else if (state is TaskSuccess) {
        //     final movies = state.task;
      
        //     return ListView.builder(
        //       itemCount: movies.length,
        //       itemBuilder: (context, index) => Card(
        //         child: ListTile(
        //           title: Text(movies[index].title),
        //           leading: CircleAvatar(
        //             backgroundImage: NetworkImage(movies[index].urlImage),
        //           ),
        //         ),
        //       ),
        //     );
        //     // QuickAlert.show(
        //     //     context: context,
        //     //     type: QuickAlertType.success,
        //     //     text: 'Tarea creada');
        //   } else {
        //     QuickAlert.show(
        //         context: context,
        //         type: QuickAlertType.error,
        //         text: 'Error desconocido');
        //   }
        // }, 
        builder: (context, state) {
          if (state is TaskInitial) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is TaskFail) {
            return Center(
              child: Icon(Icons.close),
            );
          } else if (state is TaskSuccess) {
            final task = state.task;
            final tags = state.tags;
            return Scaffold(
                appBar: AppBar(
                  backgroundColor: const Color(0xFF004070),
                  title: const Text('Task Panel'),
                  actions: [
                    IconButton(
                        onPressed: () async{
                          Navigator.of(context).pushNamed('/login');
                        },
                        icon: const Icon(Icons.logout_outlined)),
                    IconButton(
                        onPressed: () {
                          Navigator.of(context).pushNamed('');
                        },
                        icon: const Icon(Icons.category_rounded)),
                  ],
                ),
                body: RefreshIndicator(
                  onRefresh: () => context.read<TaskCubit>().allTasks(),
                  child: ListView.builder(
                    itemCount: task.length,
                    itemBuilder: (context, index) => Card(
                      child: ListTile(
                        title: Column(
                          children: [
                            Text(task[index].description!, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                            Text(DateFormat("dd-MM-yyyy HH:mm:ss").format(task[index].date!), style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
                            ListView.builder(
                              shrinkWrap: true,
                              itemCount: task[index].labelIds.length,
                              itemBuilder: (context, indexs) {
                                var name;
                                for (var i = 0; i < tags.length; i++) {
                                  if(tags[i].labelId == task[index].labelIds[indexs]){
                                    name = tags[i].name;
                                  }
                                } 
                                return Chip(label: Text(name));
                              }
                            ),
                            task[index].isDone? Text('Completado', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)):Container(),
                          ],
                        ),
                        leading: Checkbox(
                          value: task[index].isDone,
                          onChanged: (value) {
                            print(task[index].isDone);
                          
                            // task[index].isDone = value!;
                            // print(task[index].isDone);
                          },

                        ),
                      ),
                    ),
                  ),
                ),
                floatingActionButton: FloatingActionButton(
                  onPressed: () {
                    QuickAlert.show(
                      context: context,
                      type: QuickAlertType.custom,
                      showCancelBtn: true,
                      onConfirmBtnTap: () {
                        _task.date = DateTime.now();
                        _task.description = _descriptionController.text;
                        // _task!.labelIds = 
                        context.read<TaskCubit>().createTask(_task);
                        Navigator.of(context).pop();
                      },
                      confirmBtnText: 'Save',
                      onCancelBtnTap: () {
                        Navigator.of(context).pop();
                      },
                      cancelBtnText: 'Cancel',
                      widget: Column(
                        // ignore: prefer_const_literals_to_create_immutables
                        children: [
                          const SizedBox(height: 20),
                          const Text(
                            'Are you sure to save this Task',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
            
                          // ignore: unnecessary_const
                          // const SizedBox(height: 20),
            
                          // TextFormField(
                          //   //controller title
            
                          //   controller: _titleController,
                          //   keyboardType: TextInputType.multiline,
                          //   maxLines: null,
                          //   textInputAction: TextInputAction.newline,
                          //   decoration: const InputDecoration(
                          //     label: Text('Task Title'),
                          //     hintText: 'Ener a Task Title',
                          //     border: OutlineInputBorder(
                          //       borderRadius: BorderRadius.all(
                          //         Radius.circular(20),
                          //       ),
                          //     ),
                          //   ),
                          //   validator: (value) {
                          //     if (value!.isEmpty) {
                          //       return 'Please enter a Task Title';
                          //     }
                          //     return null;
                          //   },
                          // ),
            
                          // const SizedBox(height: 20),
            
                          // TextFormField(
                          //   //controller subtitle
            
                          //   controller: _subtitleController,
                          //   keyboardType: TextInputType.multiline,
                          //   maxLines: null,
                          //   textInputAction: TextInputAction.newline,
                          //   decoration: const InputDecoration(
                          //     label: Text('Task Subtitle'),
                          //     hintText: 'Ener a Task Subtitle',
                          //     border: OutlineInputBorder(
                          //       borderRadius: BorderRadius.all(
                          //         Radius.circular(20),
                          //       ),
                          //     ),
                          //   ),
                          //   validator: (value) {
                          //     if (value!.isEmpty) {
                          //       return 'Please enter a Task Subtitle';
                          //     }
                          //     return null;
                          //   },
                          // ),
            
                          const SizedBox(height: 20),
            
                          TextFormField(
                            //controller description
            
                            controller: _descriptionController,
                            keyboardType: TextInputType.multiline,
                            maxLines: null,
                            textInputAction: TextInputAction.newline,
                            decoration: const InputDecoration(
                              label: Text('Task Description'),
                              hintText: 'Ener a Task Description',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(20),
                                ),
                              ),
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter a Task Description';
                              }
                              return null;
                            },
                          ),
            
                          const SizedBox(height: 20),
            
                          TextFormField(
                              controller: _dateController,
                              keyboardType: TextInputType.datetime,
                              decoration: const InputDecoration(
                                labelText: 'Date',
                                hintText: 'Enter a Date',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(20),
                                  ),
                                ),
                                prefixIcon: Icon(Icons.calendar_today),
                              ),
                              onTap: () async {
                                DateTime? picked = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime.now(),
                                  lastDate: DateTime(2101),
                                );
            
                                TimeOfDay? timePicked = await showTimePicker(
                                  context: context,
                                  initialTime: TimeOfDay.now(),
                                  builder:
                                      (BuildContext context, Widget? child) {
                                    return MediaQuery(
                                      data: MediaQuery.of(context).copyWith(
                                          alwaysUse24HourFormat: true),
                                      child: child!,
                                    );
                                  },
                                );
            
                                if (picked != null && timePicked != null) {
                                  DateTime pickedDate = DateTime(
                                    picked.year,
                                    picked.month,
                                    picked.day,
                                    timePicked.hour,
                                    timePicked.minute,
                                  );
            
                                  if (pickedDate.isBefore(DateTime.now())) {
                                    // La fecha y hora seleccionadas son anteriores a la actual
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: Text('Error'),
                                          content: Text(
                                              'La fecha y hora seleccionadas son anteriores a la actual.'),
                                          actions: [
                                            TextButton(
                                              onPressed: () =>
                                                  Navigator.of(context).pop(),
                                              child: Text('OK'),
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  } else {
                                    String formattedDate =
                                        DateFormat('dd/MM/yyyy HH:mm:ss')
                                            .format(pickedDate);
                                    _dateController.text = formattedDate;
                                  }
                                }
                              },
                              // onTap: () async {
                              //   DateTime? picked = await showDatePicker(
                              //       context: context,
                              //       initialDate: DateTime.now(),
                              //       firstDate: DateTime.now(),
                              //       lastDate: DateTime(2101));
            
                              //   TimeOfDay? timePicked = await showTimePicker(
                              //     context: context,
                              //     initialTime: TimeOfDay.now(),
                              //     //impedir que se selecciones fechas y horas pasadas
                              //     builder:
                              //         (BuildContext context, Widget? child) {
                              //       return MediaQuery(
                              //         data: MediaQuery.of(context).copyWith(
                              //             alwaysUse24HourFormat: true),
                              //         child: child!,
                              //       );
                              //     },
                              //   );
            
                              //   if (picked != null && timePicked != null) {
                              //     String formatteDate =
                              //         DateFormat('dd/MM/yyyy HH:mm:ss')
                              //             .format(DateTime(
                              //       picked.year,
                              //       picked.month,
                              //       picked.day,
                              //       timePicked.hour,
                              //       timePicked.minute,
                              //     ));
                              //     _dateController.text = formatteDate;
                              //   }
                              // },
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter a Date';
                                }
                                return null;
                              }),
            
                          const SizedBox(height: 20),
            
                          DropdownButtonFormField(
                            items: tags.map((option) {
                              return DropdownMenuItem(
                                value: option.labelId,
                                child: Text(option.name!),
                              );
                            }).toList(),
                            onChanged: (int? selectedOption) {
                              print('Opción seleccionada: $selectedOption');
                              _task.labelIds = [selectedOption!];
                            },
                            decoration: const InputDecoration(
                              labelText: 'Select a Tag',
                              hintText: 'Select a Tag',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(20),
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    );
                  }
              ),
            );
          } else {
            return Container();
          }
        }
      )
    );
  }
}
