// // ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// import '../../cubit/tags/tag_cubit.dart';
// import '../../cubit/tags/tag_state.dart';
// import '../../data/service/tag_service.dart';

// class TagsPanel extends StatelessWidget {
//   List<String> _tagList = [];
//   final _tagController = TextEditingController();

//   final _formkey = GlobalKey<FormState>();

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (_) => TagCubit(TagService()),
//       child: BlocConsumer<TagCubit, TagsState>(
//         listener: (context, state) {
//           if (state is TagsInitial) {
//             BlocProvider.of<TagCubit>(context)
//                 .getTags(); // llamada a la función getTags()
//           }
//         },
//         builder: (context, state) {
//           if (state is TagsLoaded) {
//             _tagList = state.tags;
//           }

//           return Scaffold(
//             appBar: AppBar(
//               backgroundColor: const Color(0xFF004070),
//               title: const Text('Tags Managment'),
//               actions: [
//                 IconButton(
//                     onPressed: () {
//                       Navigator.of(context).pushNamed('/task_panel');
//                     },
//                     icon: const Icon(Icons.arrow_left_outlined)),
//               ],
//             ),
//             body: ListView(
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.all(16.0),
//                   child: ListView(
//                     shrinkWrap: true,
//                     children: [
//                       Form(
//                         key: _formkey,
//                         child: Column(
//                           children: [
//                             TextFormField(
//                               controller: _tagController,
//                               decoration: const InputDecoration(
//                                 labelText: 'Tag',
//                                 border: OutlineInputBorder(),
//                               ),
//                               validator: (value) {
//                                 if (value == null || value.isEmpty) {
//                                   return 'Please enter some text';
//                                 }
//                                 return null;
//                               },
//                             ),
//                             const SizedBox(
//                               height: 20,
//                             ),
//                             ElevatedButton(
//                               onPressed: () {
//                                 if (_formkey.currentState!.validate()) {
//                                   BlocProvider.of<TagCubit>(context)
//                                       .createTag(_tagController.text);
//                                   _tagList.add(_tagController.text);
//                                   _tagController.clear();
//                                   BlocProvider.of<TagCubit>(context)
//                                       .getTags(); // llamada a la función getTags()
//                                 }
//                               },
//                               child: const Text('Create'),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 ListView.builder(
//                     shrinkWrap: true,
//                     itemCount: _tagList.length,
//                     itemBuilder: (context, index) {
//                       return ListTile(
//                         title: Text(_tagList[index]),
//                       );
//                     })
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
