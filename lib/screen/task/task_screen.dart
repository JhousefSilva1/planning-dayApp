// // ignore_for_file: unused_local_variable, avoid_unnecessary_containers, unused_import, unused_field

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:intl/intl.dart';
// import 'package:tasks/data/data/task_list.dart';

// import '../../cubit/task/task_cubit.dart';
// import '../../data/service/task_service.dart';
// import 'package:quickalert/quickalert.dart';
// // Importamos el Cubit que maneja el estado de las tareas.

// // ignore: must_be_immutable
// class TaskPanel extends StatelessWidget {
//   late Task task;

//   //controllres

//   final _titleController = TextEditingController();
//   final _subtitleController = TextEditingController();
//   final _descriptionController = TextEditingController();
//   final _dateController = TextEditingController();
//   final _tagsController = TextEditingController();
//   final _statusController = TextEditingController();
//   String? _selectTag;
//   final _formKey = GlobalKey<FormState>();

//   TaskPanel({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//         create: (_) => TaskCubit(TaskService()),
//         child: BlocBuilder<TaskCubit, TaskState>(
//           builder: (context, state) {
//             return Scaffold(
//               appBar: AppBar(
//                 //boton de logout
//                 actions: [
//                   IconButton(
//                     onPressed: () {
//                       // ignore: avoid_print
//                       print('Logout');
//                     },
//                     icon: const Icon(Icons.logout),
//                   ),
//                 ],
//                 automaticallyImplyLeading: false,
//                 backgroundColor: const Color(0xFF004070),
//                 title: const Text(
//                   'Task Managment',
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontSize: 20,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ),
//               body: Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: ListView(),
//               ),
//               floatingActionButton: FloatingActionButton(
//                 onPressed: (
//                     //dos opciones, Guardar y cancelar

//                     ) {
//                   //ejemplo con quickAlert
//                   QuickAlert.show(
//                     context: context,
//                     type: QuickAlertType.custom,
//                     showCancelBtn: true,
//                     onConfirmBtnTap: () {
//                       // ignore: avoid_print
//                       print('Confirm button tapped');
//                       //salir del dialog
//                       Navigator.of(context).pop();
//                     },
//                     confirmBtnText: 'Save',
//                     onCancelBtnTap: () {
//                       // ignore: avoid_print
//                       print('Cancel button tapped');
//                       //salir del dialog
//                       Navigator.of(context).pop();
//                     },
//                     cancelBtnText: 'Cancel',
//                     widget: Column(
//                       children: [
//                         const SizedBox(height: 20),
//                         const Text(
//                           'Are you agree to save the Task?',
//                           style: TextStyle(
//                             fontSize: 20,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                         const SizedBox(height: 20),
//                         TextFormField(
//                           controller: _titleController,
//                           keyboardType: TextInputType.multiline,
//                           maxLines: null,
//                           textInputAction: TextInputAction.newline,
//                           decoration: const InputDecoration(
//                             label: Text('Task Title'),
//                             hintText: 'Enter a Task Title',
//                             border: OutlineInputBorder(
//                               borderRadius: BorderRadius.all(
//                                 Radius.circular(20),
//                               ),
//                             ),
//                           ),
//                           validator: (value) {
//                             if (value == null || value.isEmpty) {
//                               return 'Plase, you have to enter a task title';
//                             }
//                             return null;
//                           },
//                         ),
//                         const SizedBox(height: 20),
//                         TextFormField(
//                           controller: _subtitleController,
//                           keyboardType: TextInputType.multiline,
//                           maxLines: null,
//                           decoration: const InputDecoration(
//                             label: Text('Task Subtitle`'),
//                             hintText: 'Enter a Task Subtitle',
//                             border: OutlineInputBorder(
//                               borderRadius: BorderRadius.all(
//                                 Radius.circular(20),
//                               ),
//                             ),
//                           ),
//                           validator: (value) {
//                             if (value == null || value.isEmpty) {
//                               return 'Please, you have to enter a Subtitle Task';
//                             }
//                             return null;
//                           },
//                         ),
//                         const SizedBox(height: 20),
//                         //tenxt descrpcion
//                         TextFormField(
//                           controller: _descriptionController,
//                           keyboardType: TextInputType.multiline,
//                           maxLines: null,
//                           textInputAction: TextInputAction.newline,
//                           decoration: const InputDecoration(
//                             label: Text('Description of task'),
//                             hintText: 'Enter a Description of task',
//                             border: OutlineInputBorder(
//                               borderRadius: BorderRadius.all(
//                                 Radius.circular(20),
//                               ),
//                             ),
//                           ),
//                           validator: (value) {
//                             if (value == null || value.isEmpty) {
//                               return 'Please, you have to enter a Description!';
//                             }
//                             return null;
//                           },
//                         ),
//                         const SizedBox(height: 20),
//                         //fecha y hora
//                         TextFormField(
//                             controller: _dateController,
//                             keyboardType: TextInputType.multiline,
//                             maxLines: null,
//                             textInputAction: TextInputAction.newline,
//                             decoration: const InputDecoration(
//                               labelText: 'Date',
//                               hintText: 'Select a Due Date',
//                               border: OutlineInputBorder(
//                                 borderRadius: BorderRadius.all(
//                                   Radius.circular(20),
//                                 ),
//                               ),
//                               prefixIcon: Icon(Icons.calendar_today),
//                             ),
//                             onTap: () async {
//                               DateTime? picked = await showDatePicker(
//                                   context: context,
//                                   initialDate: DateTime.now(),
//                                   firstDate: DateTime(1900),
//                                   lastDate: DateTime(2101));
//                               // ignore: use_build_context_synchronously
//                               TimeOfDay? timePicked = await showTimePicker(
//                                 context: context,
//                                 initialTime: TimeOfDay.now(),
//                               );
//                               if (picked != null && timePicked != null) {
//                                 String formatteDate =
//                                     DateFormat('dd/MM/yyyy HH:mm:ss')
//                                         .format(DateTime(
//                                   picked.year,
//                                   picked.month,
//                                   picked.day,
//                                   timePicked.hour,
//                                   timePicked.minute,
//                                 ));
//                                 _dateController.text = formatteDate;
//                               }
//                             },
//                             validator: (value) {
//                               if (value == null || value.isEmpty) {
//                                 return 'Please, Enter a Due date for tha task';
//                               }
//                               return null;
//                             }),
//                         const SizedBox(height: 20),

//                         //Un DropWown Con opciones para seleccionar
//                         DropdownButtonFormField(
//                           value: _selectTag,
//                           decoration: const InputDecoration(
//                             labelText: 'Select a Tag',
//                             hintText: 'Introduce a tag',
//                             border: OutlineInputBorder(
//                               borderRadius: BorderRadius.all(
//                                 Radius.circular(20),
//                               ),
//                             ),
//                           ),
//                           items: const [
//                             DropdownMenuItem(
//                               value: 'Work',
//                               child: Text('Work'),
//                             ),
//                             DropdownMenuItem(
//                               value: 'Home',
//                               child: Text('Home'),
//                             ),
//                             DropdownMenuItem(
//                               value: 'School',
//                               child: Text('School'),
//                             ),
//                             DropdownMenuItem(
//                               value: 'Personal',
//                               child: Text('Personal'),
//                             ),
//                             //option to create a new
//                             DropdownMenuItem(
//                               value: 'Create a new',
//                               child: Text('Create a new'),
//                             ),
//                           ],
//                           onChanged: (value) {},
//                           validator: (value) {
//                             return null;
//                           },
//                         ),
//                       ],
//                     ),
//                   );
//                 },
//                 backgroundColor: const Color(0xFF004070),
//                 child: const Icon(Icons.add),
//               ),
//             );
//           },
//         ));
//   }
// }
// ignore_for_file: unused_local_variable, avoid_unnecessary_containers, unused_import, unused_field, sort_child_properties_last, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:tasks/data/data/task_list.dart';

import '../../cubit/task/task_cubit.dart';
import '../../cubit/task/task_state.dart';
import '../../data/service/task_service.dart';
import 'package:quickalert/quickalert.dart';
// Importamos el Cubit que maneja el estado de las tareas.

// ignore: must_be_immutable
class TaskPanel extends StatelessWidget {
  late Task task;

  //controllres

  final _titleController = TextEditingController();
  final _subtitleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _dateController = TextEditingController();
  final _tagsController = TextEditingController();
  final _statusController = TextEditingController();
  String? _selectTag;
  final _formKey = GlobalKey<FormState>();

  TaskPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => TaskCubit(TaskService()),
        child: BlocConsumer<TaskCubit, TaskState>(listener: (context, state) {
          if (state is TaskInitial) {
            // ignore: avoid_print
            print('TaskInitial');
          } else if (state is TaskInternetFailure) {
            QuickAlert.show(
                context: context,
                type: QuickAlertType.error,
                text: 'No hay internet');
          } else if (state is TaskServerFailure) {
            QuickAlert.show(
                context: context,
                type: QuickAlertType.error,
                text: 'No hay servidor');
          } else if (state is TaskSuccess) {
            QuickAlert.show(
                context: context,
                type: QuickAlertType.success,
                text: 'Tarea creada');
          } else {
            QuickAlert.show(
                context: context,
                type: QuickAlertType.error,
                text: 'Error desconocido');
          }
        }, builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: const Color(0xFF004070),
              title: const Text('Task Panel'),
              actions: [
                IconButton(
                    onPressed: () {
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
            body: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: FloatingActionButton(onPressed: () {
                    QuickAlert.show(
                        context: context,
                        type: QuickAlertType.custom,
                        showCancelBtn: true,
                        onConfirmBtnTap: () {
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
                            const SizedBox(height: 20),

                            TextFormField(
                              //controller title

                              controller: _titleController,
                              keyboardType: TextInputType.multiline,
                              maxLines: null,
                              textInputAction: TextInputAction.newline,
                              decoration: const InputDecoration(
                                label: Text('Task Title'),
                                hintText: 'Ener a Task Title',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(20),
                                  ),
                                ),
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter a Task Title';
                                }
                                return null;
                              },
                            ),

                            const SizedBox(height: 20),

                            TextFormField(
                              //controller subtitle

                              controller: _subtitleController,
                              keyboardType: TextInputType.multiline,
                              maxLines: null,
                              textInputAction: TextInputAction.newline,
                              decoration: const InputDecoration(
                                label: Text('Task Subtitle'),
                                hintText: 'Ener a Task Subtitle',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(20),
                                  ),
                                ),
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter a Task Subtitle';
                                }
                                return null;
                              },
                            ),

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
                              value: _selectTag,
                              decoration: const InputDecoration(
                                labelText: 'Select a Tag',
                                hintText: 'Select a Tag',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(20),
                                  ),
                                ),
                              ),
                              items: const [
                                DropdownMenuItem(
                                  child: Text('Work'),
                                  value: 'Work',
                                ),
                                DropdownMenuItem(
                                  child: Text('Personal'),
                                  value: 'Personal',
                                ),
                                DropdownMenuItem(
                                  child: Text('Family'),
                                  value: 'Family',
                                ),
                                DropdownMenuItem(
                                  child: Text('Friends'),
                                  value: 'Friends',
                                ),
                              ],
                              onChanged: (value) {},
                              validator: (value) {
                                if (value == null) {
                                  return 'Please select a Tag';
                                }
                                return null;
                              },
                            ),
                          ],
                        ));
                  }),
                )
              ],
            ),
          );
        }));
  }
}
