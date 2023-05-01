abstract class TagsState{}

class TagsInitial extends TagsState{}

class TagsInternetFailure extends TagsState{}

class TagsServerFailure extends TagsState{}

class TagsSuccess extends TagsState{}

abstract class TagsEvent{}

class TagsStarted extends TagsEvent{}

class TagsCreateSuccess extends TagsState{}

class TagsFailCreate extends TagsState{}


class TagsLoaded extends TagsState {
  final List<String> tags;

  TagsLoaded(this.tags);

  @override
  List<Object> get props => [tags];
}

