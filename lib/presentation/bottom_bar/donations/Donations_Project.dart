import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../../bloc/cities/cities_bloc.dart';
import '../../../bloc/governments/governments_bloc.dart';
import '../../../bloc/project/project_bloc.dart';
import '../../../constants/my_colors.dart';
import '../../../data/model/model_project.dart';
import '../../widgets/List_loading.dart';
import '../../widgets/Widget_DropdownMenu_governments.dart';
import '../../widgets/widget_dropdownmenu_cities.dart';
import '../../widgets/widgetdonation_project.dart';

class Project_Page extends StatefulWidget {
  @override
  _Project_Page createState() => _Project_Page();
}

class _Project_Page extends State<Project_Page> {
  TextEditingController textEditingController_search = TextEditingController();
  final PagingController<int, Data_Project> pagingController =
      PagingController(firstPageKey: 1);
  int PageKey = 0;
  bool show = false;
  int? city_id;
  int? governmentId;
  @override
  void initState() {
    context.read<GovernmentsBloc>().add(const Submission_GovernmentsEvent());
    textEditingController_search.clear();
    pagingController.addPageRequestListener((pageKey) {
      // _fetchPage(pageKey);

      BlocProvider.of<ProjectBloc>(context).add(Project_loaded(
          pageKey, textEditingController_search.text,
          goveId: governmentId ?? "", cityId: city_id ?? ""));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
        backgroundColor: HexColor(MyColors.gray_light2),
        body: Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: ListView(
            children: <Widget>[
              Container(
                width: width,
                padding: EdgeInsets.only(
                    left: 25.w, right: 25.w, top: 5.h, bottom: 5.w),
                child: TextFormField(
                  keyboardType: TextInputType.text,
                  controller: textEditingController_search,
                  onSaved: (input) {},
                  onChanged: (input) {
                    pagingController.addPageRequestListener((pageKey) {
                      // _fetchPage(pageKey);
                      BlocProvider.of<ProjectBloc>(context).add(Project_loaded(
                        pageKey,
                        textEditingController_search.text,
                      ));
                    });
                    Future.sync(() {
                      context.read<ProjectBloc>().add(StartProjectEvent());
                      BlocProvider.of<ProjectBloc>(context).add(Project_loaded(
                          1, textEditingController_search.text,
                          goveId: governmentId ?? "", cityId: city_id ?? ""));
                      pagingController.refresh();
                    });
                  },

                  style: TextStyle(
                    fontSize: 15.0.sp,
                    color: HexColor(MyColors.black),
                  ),
                  textInputAction: TextInputAction.done,

                  decoration: InputDecoration(
                    hintText: "بحث",
                    filled: true,
                    fillColor: HexColor(MyColors.white),
                    prefixIcon: InkWell(
                      onTap: () {
                        pagingController.addPageRequestListener((pageKey) {
                          // _fetchPage(pageKey);
                          BlocProvider.of<ProjectBloc>(context).add(
                              Project_loaded(
                                  pageKey, textEditingController_search.text,
                                  goveId: governmentId ?? "",
                                  cityId: city_id ?? ""));
                        });
                        Future.sync(() {
                          context.read<ProjectBloc>().add(StartProjectEvent());
                          BlocProvider.of<ProjectBloc>(context).add(
                              Project_loaded(
                                  1, textEditingController_search.text,
                                  goveId: governmentId ?? "",
                                  cityId: city_id ?? ""));
                          pagingController.refresh();
                        });
                      },
                      child: Icon(
                        Icons.search,
                        color: HexColor(MyColors.gray),
                      ),
                    ),
                    suffixIcon: InkWell(
                      onTap: () {
                        setState(() {
                          show = !show;
                        });
                        if (show == false) {
                          setState(() {
                            governmentId = null;
                            city_id = null;
                          });
                        }
                      },
                      child: SizedBox(
                          width: 55.w,
                          child: Icon(
                            show == true ? Icons.close : Icons.filter_alt_sharp,
                            color: HexColor(MyColors.gray),
                          )),
                    ),

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
              show == true
                  ? Container(
                      margin: EdgeInsets.only(
                        left: 20.w,
                        right: 20.w,
                      ),
                      width: double.infinity,
                      child: Widget_governments(
                        icon: Icon(
                          Icons.location_on,
                          color: HexColor(MyColors.green),
                        ),
                        onChanged: (val) {
                          context.read<CitiesBloc>().add(Start_CitiesEvent());
                          context
                              .read<CitiesBloc>()
                              .add(Submission_CitiesEvent(val.id));
                          governmentId = val.id;
                        },
                        onSaved: (val) {},
                      ),
                    )
                  : const SizedBox(),
              show == true
                  ? Container(
                      margin:
                          EdgeInsets.only(left: 20.w, right: 20.w, top: 2.h),
                      width: double.infinity,
                      child: Widget_DropdownMenu_Cities(
                        icon: Icon(
                          Icons.apartment_outlined,
                          color: HexColor(MyColors.green),
                        ),
                        onChanged: (val) {
                          setState(() {
                            city_id = val.id;
                          });
                        },
                        onSaved: (val) {},
                      ),
                    )
                  : const SizedBox(),
              BlocBuilder<ProjectBloc, ProjectState>(builder: (context, state) {
                if (state is Project_LoadingState) {
                  BlocProvider.of<ProjectBloc>(context).add(Project_loaded(
                      1, textEditingController_search.text,
                      goveId: governmentId ?? "", cityId: city_id ?? ""));

                  return Container(
                      color: HexColor(MyColors.white),
                      width: width,
                      height: height,
                      margin: EdgeInsets.only(
                        top: 10.h,
                      ),
                      child: ListView(
                        children: <Widget>[
                          List_loading(),
                          List_loading(),
                          List_loading(),
                        ],
                      ));
                } else if (state is Project_Loaded_State) {
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
                      child: RefreshIndicator(
                          onRefresh: () => Future.sync(() {
                                context
                                    .read<ProjectBloc>()
                                    .add(StartProjectEvent());
                                BlocProvider.of<ProjectBloc>(context)
                                    .add(Project_loaded(
                                  1,
                                  textEditingController_search.text,
                                ));
                                pagingController.refresh();
                              }),
                          child: PagedListView<int, Data_Project>(
                            pagingController: pagingController,
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            builderDelegate:
                                PagedChildBuilderDelegate<Data_Project>(
                              itemBuilder: (context, item, index) =>
                                  WidgetDonation_Project(item),
                            ),
                          )));
                } else if (state is Project_ErrorState) {
                  return Container();
                } else {
                  return Container();
                }
              }),
            ],
          ),
        ));
  }
}
