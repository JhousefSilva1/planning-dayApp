// ignore_for_file: unused_local_variable, avoid_unnecessary_containers, unused_import, unused_field, sort_child_properties_last, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:tasks/cubit/auth/auth_cubit.dart';
import 'package:tasks/data/models/tags.dart';
import 'package:tasks/data/models/tasks.dart';
import 'package:tasks/data/service/tag_service.dart';

import '../../cubit/tags/tag_cubit.dart';
import '../../cubit/tags/tag_state.dart';
import '../../cubit/task/task_cubit.dart';
import '../../cubit/task/task_state.dart';
import '../../data/service/task_service.dart';
import 'package:quickalert/quickalert.dart';
// Importamos el Cubit que maneja el estado de las tareas.

// ignore: must_be_immutable
class TagsPanel extends StatelessWidget {
  //controllres

  final _titleController = TextEditingController();
  // final _subtitleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _dateController = TextEditingController();
  final _tagsController = TextEditingController();
  final _statusController = TextEditingController();
  String? _selectTag;
  final _formKey = GlobalKey<FormState>();
  late Tags _tags = Tags(isDelete: false);
  late Tags _newTags = Tags(isDelete: false);

  TagsPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => TagsCubit(TagsService()),
        child: BlocBuilder<TagsCubit, TagsState>(
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
          if (state is TagsInitial) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is TagsFail) {
            return Center(
              child: Icon(Icons.close),
            );
          } else if (state is TagsSuccess) {
            var tag = [];
            final tagsList = state.tags;
            for (var i = 0; i < tagsList.length; i++) {
              if(tagsList[i].isDelete == false){
                tag.add(tagsList[i]);
              }
            }
            final tags = tag;
            // final tags = state.tags;
            return WillPopScope(
              onWillPop: () async {
                await Navigator.of(context).pushReplacementNamed('/task_panel');
                return true;
              },
              child: Scaffold(
                  appBar: AppBar(
                    backgroundColor: const Color(0xFF004070),
                    title: const Text('Tags Panel'),
                    actions: [
                      IconButton(
                          onPressed: () async{
                            Navigator.of(context).pushNamed('/login');
                          },
                          icon: const Icon(Icons.logout_outlined)),
                      IconButton(
                          onPressed: () {
                            Navigator.of(context).pushNamed('/tags_panel');
                          },
                          icon: const Icon(Icons.category_rounded)),
                    ],
                  ),
                  body: RefreshIndicator(
                    onRefresh: () => context.read<TagsCubit>().allTags(),
                    child: ListView.builder(
                      itemCount: tags.length,
                      itemBuilder: (context, index) => Card(
                        child: Slidable(
                          key: Key(tags[index].labelId.toString()),
                          // The end action pane is the one at the right or the bottom side.
                          endActionPane: ActionPane(
                            motion: ScrollMotion(),
                            children: [
                              SlidableAction(
                                onPressed: (context) {
                                  for (var i = 0; i < tagsList.length; i++) {
                                    if(tagsList[i].labelId == tags[index].labelId){
                                      _newTags = tagsList[i];
                                      // _newTask = task[index];
                                      _newTags.isDelete = true;
                                      context.read<TagsCubit>().updateTags(_newTags, _newTags.labelId!);
                                    }
                                  }
                                },
                                backgroundColor: Color(0xFFFE4A49),
                                foregroundColor: Colors.white,
                                icon: Icons.delete,
                                label: 'Delete',
                              ),
                            ],
                          ),
                          child: GestureDetector(
                            onTap: () {
                              for (var i = 0; i < tagsList.length; i++) {
                                if(tagsList[i].labelId == tags[index].labelId){
                                  _newTags = tagsList[i];
                                  QuickAlert.show(
                                    context: context,
                                    type: QuickAlertType.custom,
                                    showCancelBtn: true,
                                    onConfirmBtnTap: () {
                                      _newTags.name = _titleController.text;
                                      context.read<TagsCubit>().updateTags(_newTags, _newTags.labelId!);
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
                                          'Labels',
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
                                      ],
                                    )
                                  );
                                }
                              }
                            },
                            child: ListTile(
                              title: Row(
                                children: [
                                  Text(tags[index].labelId.toString(), style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                                  SizedBox(width: 10),
                                  Text(tags[index].name!, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                                ],
                              ),
                            ),
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
                          _tags.name = _titleController.text;
                          context.read<TagsCubit>().createTags(_tags);
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
                              'Labels',
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
                          ],
                        )
                      );
                    }
                ),
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
