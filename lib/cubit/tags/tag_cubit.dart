import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tasks/cubit/tags/tag_state.dart';

import 'package:tasks/data/models/tags.dart';
import 'package:tasks/data/service/tag_service.dart';

import '../../data/service/tag_service.dart';

// part 'tags_state.dart';

class TagsCubit extends Cubit<TagsState> {
  final TagsService _tagsService;

  TagsCubit(this._tagsService) : super(TagsInitial()) {
    allTags();
  }

  Future<void> allTags() async {
    try {
      //   emit(state.copyWith(isLoading: true, errorMessage: '', tasks: []));
      final tags = await _tagsService.allTags();
      emit(TagsSuccess(tags));
      //   emit(state.copyWith(tasks: tasks, isLoading: false, errorMessage: ''));
    } catch (e) {
      emit(TagsFail());
      //   emit(state.copyWith(
      //       isLoading: false, errorMessage: 'Failed to fetch tasks.', tasks: []));
    }
  }

  Future<void> createTags(Tags task) async {
    try {
      final createdTask = await _tagsService.createTags(task);
      print(createdTask);
      final tags = await _tagsService.allTags();
      emit(TagsSuccess(tags));
    } catch (e) {
      print(e);
      emit(TagsFail());
    }
  }

  Future<void> updateTags(Tags updatedTask, int id) async {
    try {
      await _tagsService.updateTags(updatedTask, id);
      final tags = await _tagsService.allTags();
      emit(TagsSuccess(tags));
    } catch (e) {
      emit(TagsFail());
    }
  }
}
