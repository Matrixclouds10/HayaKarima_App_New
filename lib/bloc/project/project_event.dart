part of 'project_bloc.dart';

@immutable
class ProjectEvent extends Equatable {
  const ProjectEvent();

  @override
  List<Object> get props => [];
}

class StartProjectEvent extends ProjectEvent {
  // StartHotelEvent(this.token);
}

class Project_loaded extends ProjectEvent {
  int page;
  String SearchKey;
  dynamic goveId;
  dynamic cityId;

  Project_loaded(this.page, this.SearchKey, {this.goveId, this.cityId});
}
