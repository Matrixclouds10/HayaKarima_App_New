part of 'idea_area_bloc.dart';

@immutable
 class IdeaAreaState  extends Equatable{

 const IdeaAreaState();

 @override
 // TODO: implement props
 List<Object?> get props => [];
}

class IdeaAreaInitial extends IdeaAreaState {
 const IdeaAreaInitial();

}

class IdeaList_LoadingState extends IdeaAreaInitial {
}

class IdeaList_Loaded_State extends IdeaAreaInitial {
 Model_Idea_Area model;
 IdeaList_Loaded_State(this.model);
}

class  IdeaList_ErrorState extends IdeaAreaInitial {
 late String message;
 IdeaList_ErrorState({required this.message});
}