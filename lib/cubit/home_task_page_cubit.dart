import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part '../screens/home_task_page_state.dart';

class HomeTaskPageCubit extends Cubit<HomeTaskPageState> {
  HomeTaskPageCubit() : super(HomeTaskPageInitial());
}
