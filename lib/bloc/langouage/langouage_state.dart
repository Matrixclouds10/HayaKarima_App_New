part of 'langouage_cubit.dart';

@immutable
abstract class LangouageState {}

class LangouageInitial extends LangouageState {}

class LangouageCode_State extends LangouageState {

 late Locale code_langouage;
  LangouageCode_State(this.code_langouage);

}