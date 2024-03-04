// ignore_for_file: non_constant_identifier_names, camel_case_types

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hayaah_karimuh/bloc/benifetsType/benifets_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../../bloc/beneficiaries/beneficiaries_bloc.dart';
import '../../../bloc/governments/governments_bloc.dart';
import '../../../constants/my_colors.dart';
import '../../../data/model/model_beneficiaries.dart';
import '../../widgets/List_loading.dart';
import '../../widgets/widget_dropdownmenu_benefietsType.dart';
import '../../widgets/widgetdonation_.dart';

class Donations_Page extends StatefulWidget {
  @override
  _Donations_Page createState() => _Donations_Page();
}

class _Donations_Page extends State<Donations_Page> {
  TextEditingController textEditingController_search = TextEditingController();
  final PagingController<int, Data_Beneficiaries> pagingController =
      PagingController(firstPageKey: 1);
  int PageKey = 0;
  int? beneficiary_type_id;
  bool show = false;
  int? BenfetsId;
  @override
  void initState() {
    textEditingController_search.clear();
    context.read<GovernmentsBloc>().add(const Submission_GovernmentsEvent());
    context.read<BenfetsBloc>().add(const Submission_BenfietsEvent());

    pagingController.addPageRequestListener((pageKey) {
      // _fetchPage(pageKey);
      BlocProvider.of<BeneficiariesBloc>(context).add(Beneficiaries_loaded(
          pageKey,
          textEditingController_search.text,
          beneficiary_type_id ?? ''));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                  textInputAction: TextInputAction.done,
                  onSaved: (input) {},
                  onChanged: (input) {
                    pagingController.addPageRequestListener((pageKey) {
                      // _fetchPage(pageKey);
                      BlocProvider.of<BeneficiariesBloc>(context).add(
                          Beneficiaries_loaded(
                              pageKey,
                              textEditingController_search.text,
                              beneficiary_type_id));
                    });
                    Future.sync(() {
                      context
                          .read<BeneficiariesBloc>()
                          .add(StartBeneficiariesEvent());
                      BlocProvider.of<BeneficiariesBloc>(context).add(
                          Beneficiaries_loaded(
                              1,
                              textEditingController_search.text,
                              beneficiary_type_id ?? ''));
                      pagingController.refresh();
                    });
                  },

                  style: TextStyle(
                    fontSize: 15.0.sp,
                    color: HexColor(MyColors.black),
                  ),

                  decoration: InputDecoration(
                    hintText: "بحث",
                    filled: true,
                    fillColor: HexColor(MyColors.white),
                    prefixIcon: InkWell(
                      onTap: () {
                        pagingController.addPageRequestListener((pageKey) {
                          // _fetchPage(pageKey);
                          BlocProvider.of<BeneficiariesBloc>(context).add(
                              Beneficiaries_loaded(
                                  pageKey,
                                  textEditingController_search.text,
                                  beneficiary_type_id ?? ''));
                        });
                        Future.sync(() {
                          context
                              .read<BeneficiariesBloc>()
                              .add(StartBeneficiariesEvent());
                          BlocProvider.of<BeneficiariesBloc>(context).add(
                              Beneficiaries_loaded(
                                  1,
                                  textEditingController_search.text,
                                  beneficiary_type_id ?? ''));
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

                          print('----->clicked');
                        });
                        if (show == false) {
                          setState(() {
                            beneficiary_type_id = null;
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
                      margin: EdgeInsets.only(left: 20.w, right: 20.w),
                      width: double.infinity,
                      child: Widget_DropdownMenu_BenifetsType(
                        icon: Icon(
                          Icons.architecture,
                          color: HexColor(MyColors.green),
                        ),
                        onChanged: (val) {
                          // context.read<BenfetsBloc>().add(Start_BenfietsEvent());
                          // context.read<BenfetsBloc>().add(Submission_BenfietsEvent());
                          beneficiary_type_id = val.id;
                        },
                        onSaved: (val) {},
                      ),
                    )
                  : const SizedBox(),
              BlocBuilder<BeneficiariesBloc, BeneficiariesState>(
                  builder: (context, state) {
                if (state is Beneficiaries_LoadingState) {
                  BlocProvider.of<BeneficiariesBloc>(context).add(
                      Beneficiaries_loaded(1, textEditingController_search.text,
                          beneficiary_type_id ?? ''));

                  return Container(
                      color: HexColor(MyColors.white),
                      width: width,
                      height: height,
                      margin: EdgeInsets.only(top: 10.h),
                      child: ListView(
                        children: <Widget>[
                          List_loading(),
                          List_loading(),
                          List_loading(),
                        ],
                      ));
                } else if (state is Beneficiaries_Loaded_State) {
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
                                    .read<BeneficiariesBloc>()
                                    .add(StartBeneficiariesEvent());
                                BlocProvider.of<BeneficiariesBloc>(context).add(
                                    Beneficiaries_loaded(
                                        1,
                                        textEditingController_search.text,
                                        beneficiary_type_id ?? ''));
                                pagingController.refresh();
                              }),
                          child: PagedListView<int, Data_Beneficiaries>(
                            pagingController: pagingController,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            builderDelegate:
                                PagedChildBuilderDelegate<Data_Beneficiaries>(
                              itemBuilder: (context, item, index) =>
                                  WidgetDonation(item),
                            ),
                          )));
                } else if (state is Beneficiaries_ErrorState) {
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
