import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hayaah_karimuh/empolyer/providers/filter_provider.dart';
import 'package:hayaah_karimuh/empolyer/providers/projects_provider.dart';
import 'package:provider/provider.dart';

import '../enums/filter_enum.dart';
import '../providers/beneficiaries_provider.dart';
import '../providers/inspections_provider.dart';
import '../utils/app_colors.dart';

class FilterDialog extends StatefulWidget {
  final Filter filterType;
  final Map<String, dynamic>? queries;

  const FilterDialog({required this.filterType, this.queries, Key? key}) : super(key: key);

  @override
  State<FilterDialog> createState() => _FilterDialogState();
}

class _FilterDialogState extends State<FilterDialog> {
  int? govId;
  int? cityId;
  int? villageId;
  int? independentId;
  late ProjectsProvider _projectsProvider;
  late FilterProvider _filterProvider;
  int govsPage = 1;
  int citiesPage = 1;
  int villagesPage = 1;
  int independentsPage = 1;
  int benfitesPage = 1;
  int projectsPage = 1;
  final ScrollController _projectsScrollController = ScrollController();
  final ScrollController _govsScrollController = ScrollController();
  final ScrollController _benfetsScrollController = ScrollController();
  final ScrollController _citiesScrollController = ScrollController();
  final ScrollController _villagesScrollController = ScrollController();
  final ScrollController _independentsScrollController = ScrollController();

  late String title;

  bool init = false;

  @override
  void dispose() {
    _filterProvider.governorates.clear();
    _filterProvider.cities.clear();
    _filterProvider.villages.clear();
    _filterProvider.independents.clear();
    _filterProvider.benifetsList.clear();
    _filterProvider.projectsList.clear();

    super.dispose();
  }

  void _setTitle() {
    switch (widget.filterType) {
      case Filter.governorates:
        title = 'المحافظة';
        break;
      case Filter.cities:
        title = 'المدينة';
        break;
      case Filter.villages:
        title = 'القرية';
        break;
      case Filter.independents:
        title = 'التابع';
        break;

      case Filter.benifetsType:
        title = "نوع التبرع";
        break;
      case Filter.projectsList:
        title = "اسم المشروع";
        break;
    }
    log('Title -> $title');
  }

  @override
  void initState() {
    _setTitle();
    _govsScrollController.addListener(pagination);
    _citiesScrollController.addListener(pagination);
    _villagesScrollController.addListener(pagination);
    _independentsScrollController.addListener(pagination);
    _benfetsScrollController.addListener(pagination);
    _projectsScrollController.addListener(pagination);

    super.initState();
  }

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    _projectsProvider = Provider.of<ProjectsProvider>(context);
    _filterProvider = Provider.of<FilterProvider>(context);
    widget.queries!.putIfAbsent('limit', () => 20);
    switch (widget.filterType) {
      case Filter.governorates:
        log('Check If Init');
        if (!init) {
          _filterProvider.getGovernorates(page: govsPage, queries: widget.queries);
          init = true;
        }
        break;
      case Filter.cities:
        if (!init) {
          await _filterProvider.getCities(page: citiesPage, queries: widget.queries);
          init = true;
        }
        break;
      case Filter.villages:
        if (!init) {
          await _filterProvider.getVillages(page: villagesPage, queries: widget.queries);
          init = true;
        }
        break;
      case Filter.independents:
        if (!init) {
          await _filterProvider.getIndependents(page: independentsPage, queries: widget.queries);
          init = true;
        }
        break;
      case Filter.benifetsType:
        if (!init) {
          await _filterProvider.getBenifetsTypes(page: benfitesPage, queries: widget.queries);
          init = true;
        }
        break;
      case Filter.projectsList:
        if (!init) {
          await _filterProvider.getProjectsList(
            page: projectsPage,
          );
          init = true;
        }
        break;
    }
  }

  void pagination() async {
    log('Pagination');
    switch (widget.filterType) {
      case Filter.governorates:
        if (_govsScrollController.position.pixels == _govsScrollController.position.maxScrollExtent) {
          log('Pagination Callback');
          setState(() {
            // isLoading = true;
            govsPage += 1;
          });
          await _filterProvider.getGovernorates(page: govsPage, queries: widget.queries);
        }
        break;
      case Filter.cities:
        if (_citiesScrollController.position.pixels == _citiesScrollController.position.maxScrollExtent) {
          log('Pagination Callback');
          setState(() {
            // isLoading = true;
            citiesPage += 1;
          });
          await _filterProvider.getCities(page: citiesPage, queries: widget.queries);
        }
        break;
      case Filter.benifetsType:
        if (_benfetsScrollController.position.pixels == _benfetsScrollController.position.maxScrollExtent) {
          log('Pagination Callback');
          setState(() {
            // isLoading = true;
            citiesPage += 1;
          });
          await _filterProvider.getBenifetsTypes(page: citiesPage, queries: widget.queries);
        }
        break;
      case Filter.villages:
        if (_villagesScrollController.position.pixels == _villagesScrollController.position.maxScrollExtent) {
          log('Pagination Callback');
          setState(() {
            // isLoading = true;
            villagesPage += 1;
          });
          await _filterProvider.getVillages(page: villagesPage, queries: widget.queries);
        }
        break;
      case Filter.independents:
        if (_independentsScrollController.position.pixels == _independentsScrollController.position.maxScrollExtent) {
          log('Pagination Callback');
          setState(() {
            // isLoading = true;
            independentsPage += 1;
          });
          await _filterProvider.getIndependents(page: villagesPage, queries: widget.queries);
        }
        break;
      case Filter.projectsList:
        if (_projectsScrollController.position.pixels == _projectsScrollController.position.maxScrollExtent) {
          log('Pagination Callback');
          setState(() {
            // isLoading = true;
            projectsPage += 1;
          });
          await _filterProvider.getProjectsList(page: projectsPage);
        }
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          title: Text(
            title,
            style: GoogleFonts.cairo(
              color: AppColors.primaryColor,
              fontSize: 16,
              fontWeight: FontWeight.w700,
              fontStyle: FontStyle.normal,
            ),
          ),
        ),
        body: Directionality(
          textDirection: TextDirection.rtl,
          child: SizedBox(
            height: double.infinity,
            width: double.infinity,
            child: _getChildWidget(),
          ),
        ),
      ),
    );
  }

  Widget _getChildWidget() {
    Widget children;
    switch (widget.filterType) {
      case Filter.governorates:
        children = ListView.builder(
          scrollDirection: Axis.vertical,
          itemCount: _filterProvider.governorates.length,
          // shrinkWrap: true,
          controller: _govsScrollController,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                _projectsProvider.setSelectedGov(_filterProvider.governorates[index]);
                Navigator.of(context).pop();
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Text(
                  _filterProvider.governorates[index].name!,
                  style: GoogleFonts.cairo(
                    color: AppColors.textColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    fontStyle: FontStyle.normal,
                  ),
                ),
              ),
            );
          },
        );
        break;
      case Filter.cities:
        children = ListView.builder(
          scrollDirection: Axis.vertical,
          itemCount: _filterProvider.cities.length,
          // shrinkWrap: true,
          controller: _citiesScrollController,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                _projectsProvider.setSelectedCity(_filterProvider.cities[index]);
                Navigator.of(context).pop();
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Text(
                  _filterProvider.cities[index].name!,
                  style: GoogleFonts.cairo(
                    color: AppColors.textColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    fontStyle: FontStyle.normal,
                  ),
                ),
              ),
            );
          },
        );
        break;
      case Filter.villages:
        children = ListView.builder(
          scrollDirection: Axis.vertical,
          itemCount: _filterProvider.villages.length,
          // shrinkWrap: true,
          controller: _villagesScrollController,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                _projectsProvider.setSelectedVillage(_filterProvider.villages[index]);
                Navigator.of(context).pop();
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Text(
                  _filterProvider.villages[index].name!,
                  style: GoogleFonts.cairo(
                    color: AppColors.textColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    fontStyle: FontStyle.normal,
                  ),
                ),
              ),
            );
          },
        );
        break;
      case Filter.independents:
        children = ListView.builder(
          scrollDirection: Axis.vertical,
          itemCount: _filterProvider.independents.length,
          // shrinkWrap: true,
          controller: _independentsScrollController,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                _projectsProvider.setSelectedIndependent(_filterProvider.independents[index]);
                Navigator.of(context).pop();
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Text(
                  _filterProvider.independents[index].name ?? '',
                  style: GoogleFonts.cairo(
                    color: AppColors.textColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    fontStyle: FontStyle.normal,
                  ),
                ),
              ),
            );
          },
        );
        break;
      case Filter.benifetsType:
        children = ListView.builder(
          scrollDirection: Axis.vertical,
          itemCount: _filterProvider.benifetsList.length,
          // shrinkWrap: true,
          controller: _benfetsScrollController,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Provider.of<BeneficiariesProvider>(context, listen: false).selectBenifetsTyp(_filterProvider.benifetsList[index]);
                Navigator.of(context).pop();
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Text(
                  _filterProvider.benifetsList[index].name ?? '',
                  style: GoogleFonts.cairo(
                    color: AppColors.textColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    fontStyle: FontStyle.normal,
                  ),
                ),
              ),
            );
          },
        );
        break;
      case Filter.projectsList:
        children = ListView.builder(
          scrollDirection: Axis.vertical,
          itemCount: _filterProvider.projectsList.length,
          // shrinkWrap: true,
          controller: _projectsScrollController,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                setState(() {
                  Provider.of<InspectionsProvider>(context, listen: false).selectProject(_filterProvider.projectsList[index]);
                });
                Navigator.of(context).pop(Provider.of<InspectionsProvider>(context, listen: false).projectsList);
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Text(
                  _filterProvider.projectsList[index].name ?? '',
                  style: GoogleFonts.cairo(
                    color: AppColors.textColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    fontStyle: FontStyle.normal,
                  ),
                ),
              ),
            );
          },
        );
        break;
    }
    return children;
  }
}
