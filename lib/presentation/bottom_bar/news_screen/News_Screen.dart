import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:provider/src/provider.dart';

import '../../../bloc/news/news_bloc.dart';
import '../../../bloc/step_pageview/pageview_bloc.dart';
import '../../../constants/my_colors.dart';
import '../../../data/data_source/api/services.dart';
import '../../../data/data_source/local/local.dart';
import '../../../data/model/model_news.dart';
import '../../../data/repository/repository.dart';
import '../../../generated/locale_keys.g.dart';
import '../../../router/router_path.dart';
import '../../widgets/List_loading.dart';
import '../../widgets/news_widget.dart';

class News_Screen extends StatefulWidget {
  @override
  _News_Screen createState() => _News_Screen();
}

class _News_Screen extends State<News_Screen> {
  late Repository repository;
  final PagingController<int, Data_News> pagingController =
      PagingController(firstPageKey: 1);
  int PageKey = 0;
  TextEditingController textEditingController_img = TextEditingController();
  TextEditingController textEditingController_search =
      TextEditingController();
  DateTime? _dateTime;
  bool is_show = false;

  @override
  void initState() {
    repository = Repository(Services(), Data_Local());
    pagingController.addPageRequestListener((pageKey) {
      // _fetchPage(pageKey);
      BlocProvider.of<NewsBloc>(context).add(News_loaded(pageKey, "", ""));
    });
    super.initState();
  }

  @override
  void dispose() {
    pagingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    // TODO: implement build
    return Scaffold(
      backgroundColor: HexColor(MyColors.gray_light2),
      body: WillPopScope(
        onWillPop: () async {
          context.read<PageviewBloc>().add(Start_Eventstep());
          context.read<PageviewBloc>().add(NextStep_one(0, 0));

          return false;
        },
        child: ListView(
          shrinkWrap: true,
          children: <Widget>[
            Container(
              width: width,
              padding: EdgeInsets.only(
                  left: 25.w, right: 25.w, top: 15.h, bottom: 5.w),
              child: TextFormField(
                keyboardType: TextInputType.text,
                controller: textEditingController_search,
                onSaved: (input) {},
                onChanged: (input) {
                  if (input.toString().length > 4) {
                    setState(() {
                      is_show = true;
                    });

                    context.read<NewsBloc>().add(StartNewsEvent());
                    context.read<NewsBloc>().add(News_loaded(
                        1,
                        "&title=${textEditingController_search.text}",
                        _dateTime != null
                            ? "&month=${_dateTime?.month}&year=${_dateTime?.year}&day=${_dateTime?.day}"
                            : ""));
                    pagingController.refresh();
                  }
                },
                onEditingComplete: () {
                  //this is called only when done or ok is button is tapped in keyboard
                  print('----->test');
                },
                style: TextStyle(
                  fontSize: 18.0.sp,
                  color: HexColor(MyColors.black),
                ),

                decoration: InputDecoration(
                  hintText: "بحث",
                  filled: true,
                  fillColor: HexColor(MyColors.white),
                  prefixIcon: Icon(
                    Icons.search,
                    color: HexColor(MyColors.gray),
                  ),
                  suffixIcon: SizedBox(
                      width: is_show ? 95.w : 55.w,
                      child: Row(
                        children: <Widget>[
                          IconButton(
                            onPressed: () async {
                              _dateTime = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime.now().add(const Duration(days: -356)),
                                lastDate:DateTime.now().add(const Duration(days: 356)),
                              );

                              context.read<NewsBloc>().add(StartNewsEvent());
                              context.read<NewsBloc>().add(News_loaded(
                                  1,
                                  textEditingController_search.text.isNotEmpty
                                      ? "&title=${textEditingController_search.text}"
                                      : "",
                                  _dateTime != null
                                      ? "&month=${_dateTime?.month}&year=${_dateTime?.year}&day=${_dateTime?.day}"
                                      : ""));
                              pagingController.refresh();
                            },
                            icon: Icon(
                              Icons.date_range_outlined,
                              color: HexColor(MyColors.gray),
                            ),
                          ),
                          is_show
                              ? IconButton(
                                  onPressed: () {
                                    textEditingController_search.clear();
                                    context
                                        .read<NewsBloc>()
                                        .add(StartNewsEvent());
                                    context.read<NewsBloc>().add(News_loaded(
                                        1,
                                        textEditingController_search
                                                .text.isNotEmpty
                                            ? "&title=${textEditingController_search.text}"
                                            : "",
                                        _dateTime != null
                                            ? "&month=${_dateTime?.month}&year=${_dateTime?.year}&day=${_dateTime?.day}"
                                            : ""));
                                    pagingController.refresh();
                                    setState(() {
                                      is_show = false;
                                    });
                                  },
                                  icon: Icon(
                                    Icons.close_rounded,
                                    color: HexColor(MyColors.gray),
                                  ),
                                )
                              : Container()
                        ],
                      )),

                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.w),
                    borderSide: BorderSide(
                      color: HexColor(MyColors.white),
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.w),
                    borderSide: BorderSide(
                      color: HexColor(MyColors.white),
                    ),
                  ),
                  // labelText: '${LocaleKeys.search.tr()}',
                ),
                // ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                  top: 10.h, bottom: 10.h, left: 25.w, right: 25.w),
              child: Text(
                LocaleKeys.news.tr(),
                style: TextStyle(
                    fontSize: 22.sp,
                    color: HexColor(MyColors.green),
                    fontWeight: FontWeight.w600),
              ),
            ),
            BlocBuilder<NewsBloc, NewsState>(builder: (context, state) {
              if (state is News_LoadingState) {
                context
                    .read<NewsBloc>()
                    .add(News_loaded(1, textEditingController_search.text, ""));
                // EasyLoading.show(
                //   status: 'loading...',
                //   maskType: EasyLoadingMaskType.black,
                // );
                return Container(
                    margin: EdgeInsets.only(bottom: 20.h),
                    color: HexColor(MyColors.white),
                    width: width,
                    height: height,
                    child: ListView(
                      children: <Widget>[
                        List_loading(),
                        List_loading(),
                        List_loading(),
                      ],
                    ));
              } else if (state is News_Loaded_State) {
                final list = (state).list.items.data;
                if (list.length < 20) {
                  print("----->appendLastPage");
                  pagingController.appendLastPage(list);
                } else {
                  PageKey++;
                  final nextPageKey = PageKey + 1;
                  pagingController.appendPage(list, nextPageKey);
                }
                return Container(
                    height: height * .59,
                    padding: EdgeInsets.only(bottom: 40.w),
                    child: RefreshIndicator(
                        onRefresh: () => Future.sync(() {
                              context.read<NewsBloc>().add(StartNewsEvent());
                              BlocProvider.of<NewsBloc>(context)
                                  .add(News_loaded(1, "", ""));
                              pagingController.refresh();
                            }),
                        child: PagedListView<int, Data_News>(
                            pagingController: pagingController,
                            physics: const BouncingScrollPhysics(),
                            builderDelegate:
                                PagedChildBuilderDelegate<Data_News>(
                              itemBuilder: (context, item, index) =>
                                  News_Widget(item, () {
                                Navigator.pushNamed(context, NewsDetails,
                                    arguments: item);
                              }),
                            ))));
              } else {
                return Container();
              }
            })
          ],
        ),
      ),
    );
  }
}
