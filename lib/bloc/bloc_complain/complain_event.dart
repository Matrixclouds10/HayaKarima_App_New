part of 'complain_bloc.dart';

@immutable
abstract class ComplainEvent extends Equatable {

  const ComplainEvent();

  @override
  List<Object> get props => [];
}


class Start_ComplainEvent extends ComplainEvent {

}


class Submission_ComplainEvent extends ComplainEvent {
  var name;
  var nationality_id;
  var national_id_photo;
  var country;

  var phone;
  var email;
  var type;
  var description;
  var idea_area_id;

  Submission_ComplainEvent(
  {
   required   this.name,
   required   this.nationality_id,
   required   this.national_id_photo,
   required   this.country,
   required   this.phone,
   required   this.email,
   required   this.type,
   required   this.description,
   required   this.idea_area_id});
}