import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../data/model/model_news.dart';
import '../../data/repository/repository.dart';

part 'news_event.dart';
part 'news_state.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {

  late Repository repository;

  NewsBloc(this.repository) : super(News_LoadingState()) {
    add(StartNewsEvent());
  }


  @override
  Stream<NewsState> mapEventToState(NewsEvent event) async* {
    // TODO: implement event handler

    if (event is StartNewsEvent) {
      yield News_LoadingState();
    } else if (event is News_loaded) {
      try {
        var model = await repository.get_news(event.page,event.title,event.date);
        yield News_Loaded_State(model);
      } catch (e) {
        print("----->${e.toString()}");
        yield News_ErrorState(message: '$e');
      }
    }else if(event is News_Details){

      yield News_Details_Loaded(event.data_news);
    }
  }
}