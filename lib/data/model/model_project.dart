class Model_Project {
  late String status;
  late String message;
  late Items_Project items;

  Model_Project({required this.status, required this.message, required this.items});

  Model_Project.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    items = (json['items'] != null ? new Items_Project.fromJson(json['items']) : null)!;
  }


}

class Items_Project {
  late List<Data_Project> data;

  Items_Project({required this.data});

  Items_Project.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data_Project>[];
      json['data'].forEach((v) {
        data.add(Data_Project.fromJson(v));
      });
    }
  }
}

class Data_Project {
  late int id;
  late String name;
  late String villageId;
  late String cityId;
  late String govern;
  late String countryId;
  late String independentId;
  late String sourceId;
  late String donationBudget;
  late String donationNeeded;
  late String donationPercentage;
  late String donationStatus;
  late String startDate;
  late String endDate;
  late dynamic budget;
  late dynamic residentNo;
  late String adminId;
  late String managerId;
  late String supervisorId;
  late String donatorId;
  late String landPositionId;
  late String departmentId;
  late String subDepartmentId;
  late dynamic finishPercentageBeforeExecution;
  late dynamic finishPercentageAfterExecution;
  late String latitude;
  late String longitude;
  late String description;
  late String documentation;
  late String note;
  late dynamic donation;

  Data_Project({required this.id, required this.name, required this.villageId, required this.cityId, required this.govern, required this.countryId, required this.independentId, required this.sourceId, required this.donationBudget, required this.donationNeeded, required this.donationPercentage, required this.donationStatus, required this.startDate, required this.endDate, required this.budget, required this.residentNo, required this.adminId, required this.managerId, required this.supervisorId, required this.donatorId, required this.landPositionId, required this.departmentId, required this.subDepartmentId, required this.finishPercentageBeforeExecution, required this.finishPercentageAfterExecution, required this.latitude, required this.longitude, required this.description, required this.documentation, required this.note, required this.donation});

  Data_Project.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = "${json['name']}";
    villageId = "${json['village_id']}";
    cityId = "${json['city_id']}";
    govern = "${json['govern']}";
    countryId = "${json['country_id']}";
    independentId = "${json['independent_id']}";
    sourceId = "${json['source_id']}";
    donationBudget = "${json['donation_budget']}";
    donationNeeded = "${json['donation_needed']}";
    donationPercentage = "${json['donation_percentage']}";
    donationStatus = "${json['donation_status']}";
    startDate = "${json['start_date']}";
    endDate = "${json['end_date']}";
    budget = "${json['budget']}";
    residentNo = "${json['resident_no']}";
    adminId = "${json['admin_id']}";
    managerId = "${json['manager_id']}";
    supervisorId = "${json['supervisor_id']}";
    donatorId = "${json['donator_id']}";
    landPositionId = "${json['land_position_id']}";
    departmentId = "${json['department_id']}";
    subDepartmentId = "${json['sub_department_id']}";
    finishPercentageBeforeExecution = "${json['finish_percentage_before_execution']}";
    finishPercentageAfterExecution = "${json['finish_percentage_after_execution']}";
    latitude = "${json['latitude']}";
    longitude = "${json['longitude']}";
    description = "${json['description']}";
    documentation = "${json['documentation']}";
    note = "${json['note']}";
    donation = "${json['donation']}";
  }
}
