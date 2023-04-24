// ignore_for_file: unused_local_variable, avoid_unnecessary_containers, unused_import

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:tasks/data/data/task_list.dart';

import '../../cubit/task/task_cubit.dart';
import '../../data/service/task_service.dart';
import 'package:quickalert/quickalert.dart';
// Importamos el Cubit que maneja el estado de las tareas.

class TaskPanel extends StatelessWidget {
  late Task task;

  //controllres
  final _dateController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  TaskPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => TaskCubit(TaskService()),
        child: BlocBuilder<TaskCubit, TaskState>(
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(
                backgroundColor: const Color(0xFF004070),
                title: const Text(
                  'Tareas',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              body: Padding(
                padding: const EdgeInsets.all(16.0),
                child: ListView(
                  children: const [
                    //Floating button a pir de pantalla
                  ],
                ),
              ),
              floatingActionButton: FloatingActionButton(
                onPressed: (
                    //dos opciones, Guardar y cancelar

                    ) {
                  //ejemplo con quickAlert
                  QuickAlert.show(
                    context: context,
                    type: QuickAlertType.custom,
                    showCancelBtn: true,
                    onConfirmBtnTap: () {
                      // ignore: avoid_print
                      print('Confirm button tapped');
                      //salir del dialog
                      Navigator.of(context).pop();
                    },
                    confirmBtnText: 'Guardar',
                    onCancelBtnTap: () {
                      // ignore: avoid_print
                      print('Cancel button tapped');
                      //salir del dialog
                      Navigator.of(context).pop();
                    },
                    cancelBtnText: 'Cancelar',
                    widget: Column(
                      children: [
                        TextFormField(
                          decoration: const InputDecoration(
                            label: Text('Tittulo de la Tarea'),
                            hintText: 'Ingrese el titulo de la tarea',
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Por favor ingrese el titulo de la tarea';
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                          decoration: const InputDecoration(
                            label: Text('Ingrese el subtitulo de la tarea'),
                            hintText: 'Ingrese el titulo de la tarea',
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Por favor ingrese el titulo de la tarea';
                            }
                            return null;
                          },
                        ),
                        //tenxt descrpcion
                        TextFormField(
                          decoration: const InputDecoration(
                            label: Text('Ingrese la descripcion de la tarea'),
                            hintText: 'Ingrese el titulo de la tarea',
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Por favor ingrese el titulo de la tarea';
                            }
                            return null;
                          },
                        ),
                        //fecha y hora
                        TextFormField(
                            controller: _dateController,
                            decoration: const InputDecoration(
                              labelText: 'Fecha',
                              hintText: 'Ingrese la fecha de la tarea',
                              prefixIcon: Icon(Icons.calendar_today),
                            ),
                            onTap: () async {
                              DateTime? picked = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(1900),
                                  lastDate: DateTime(2101));
                              // ignore: use_build_context_synchronously
                              TimeOfDay? timePicked = await showTimePicker(
                                context: context,
                                initialTime: TimeOfDay.now(),
                              );
                              if (picked != null && timePicked != null) {
                                String formatteDate =
                                    DateFormat('dd/MM/yyyy HH:mm:ss')
                                        .format(DateTime(
                                  picked.year,
                                  picked.month,
                                  picked.day,
                                  timePicked.hour,
                                  timePicked.minute,
                                ));
                                _dateController.text = formatteDate;
                              }
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Por favor ingrese la fecha de la tarea';
                              }
                              return null;
                            }),
                      ],
                    ),
                  );
                },
                backgroundColor: const Color(0xFF004070),
                child: const Icon(Icons.add),
              ),
            );
          },
        ));
  }
}
