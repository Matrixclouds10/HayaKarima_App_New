part of 'news_bloc.dart';

@immutable
abstract class NewsEvent extends Equatable{

  const NewsEvent();

  @override
  List<Object> get props => [];
}


class StartNewsEvent extends NewsEvent {

  // StartHotelEvent(this.token);
}


class News_loaded extends NewsEvent {

  int page ;
  var title;
  var date;


  News_loaded(this.page, this.title, this.date);
}

class News_Details extends NewsEvent {

  late Data_News data_news;

  News_Details(this.data_news);
}

