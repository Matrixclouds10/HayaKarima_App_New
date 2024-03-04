
class Model_Counters{
 late String status;
 late String message;
 late  Items_Counters items;

  Model_Counters({required this.status, required this.message, required this.items});

  Model_Counters.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    items = (json['items'] != null ? new Items_Counters.fromJson(json['items']) : null)!;
  }

}

class Items_Counters {
 late int countries;
 late int governments;
 late  int cities;
 late  int villages;
 late  int independents;
 late  int projects;
 late int beneficiaries;
 late int projectPreviews;
 late int users;
 late int donations;
 late  int beneficiaryTypeSingle;
 late int beneficiaryTypeCondition;

  Items_Counters({
       required this.countries,
       required this.governments,
       required this.cities,
       required this.villages,
       required this.independents,
       required this.projects,
       required this.beneficiaries,
       required this.projectPreviews,
       required this.users,
       required this.donations,
       required this.beneficiaryTypeSingle,
       required this.beneficiaryTypeCondition});

  Items_Counters.fromJson(Map<String, dynamic> json) {
    countries = json['countries'] ?? 0;
    governments = json['governments'] ?? 0;
    cities = json['cities'] ?? 0;
    villages = json['villages'] ?? 0;
    independents = json['independents'] ?? 0;
    projects = json['projects'] ?? 0;
    beneficiaries = json['beneficiaries'] ?? 0;
    projectPreviews = json['project_previews'] ?? 0;
    users = json['users'] ?? 0;
    donations = json['donations'] ?? 0;
    beneficiaryTypeSingle = json['beneficiary_type_single'] ?? 0;
    beneficiaryTypeCondition = json['beneficiary_type_condition'] ?? 0;
  }

}