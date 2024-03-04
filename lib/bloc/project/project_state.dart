part of 'project_bloc.dart';

@immutable
 class ProjectState   extends Equatable {

  const ProjectState();
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class ProjectInitial extends ProjectState {
  const ProjectInitial();

}



class Project_LoadingState extends ProjectInitial {

}


class Project_Loaded_State extends ProjectInitial {

  late Model_Project list;
  Project_Loaded_State(this.list);
}
class Project_ErrorState extends ProjectInitial {
  late String message;
  Project_ErrorState({required this.message});
}