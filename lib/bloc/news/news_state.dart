part of 'news_bloc.dart';

@immutable
 class NewsState  extends Equatable{
  const NewsState();
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class NewsInitial extends NewsState {

  const NewsInitial();

}



class News_LoadingState extends NewsInitial {

}


class News_Loaded_State extends NewsInitial {

  late Model_News list;
  News_Loaded_State(this.list);
}

class News_Details_Loaded extends NewsInitial{
  late Data_News data_news;

  News_Details_Loaded(this.data_news);
}


class News_ErrorState extends NewsInitial {
  late String message;
  News_ErrorState({required this.message});
}