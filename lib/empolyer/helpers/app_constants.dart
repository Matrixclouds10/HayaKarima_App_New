class AppConstants {
  static const String baseUrl = 'https://hayhkarima.com/api/';
  static const String mapLink = 'https://hayhkarima.com/api/map';
  static const String loginPath = 'login';
  static const String registerPath = 'register';
  static const String logoutPath = 'logout';
  static const String userPath = 'users';
  static const String updateProfilePath = 'users/edit';
  static const String governsPath = 'governs';
  static const String notificationsPath = 'notifications';
  static const String notificationCountPath = 'notifications/count';
  static const String saveNotificationPath = 'notifications/store';
  static const String readNotificationPath = 'notifications/read';
  static const String projectsPath = 'projects';
  static const String deleteImagePath = 'images/delete';
  static const String deleteDocumentPath = 'documentations/delete';
  static const String beneficiariesPath = 'beneficiaries';
  static const String countriesPath = 'countries-list';
  static const String governoratesPath = 'governments-list';
  static const String citiesPath = 'cities-list';
  static const String projectsListPath = 'projects-list';
  static const String benefetsPath = 'beneficiary-types-list';
  static const String villagesPath = 'villages-list';
  static const String independentsPath = 'independents-list';
  static const String inspectionsPath = 'project-previews';
  static const String addInspectionsPath = 'project-previews/store';
  static const String firebaseServerKey = 'AAAAJ3rgQxA:APA91bEUPu4sG5Yvc7M-tAWrhC4j9ctW_V9klgCmlC-ROA7RtWo3ngJ0jjrMP7x2jM7UQNhsfBHydATpz1jP8e9dbjsldcWUvfk-MwfOk8uLm19GEdKj1lg5ZTn0ztLw8B9rRcv_8ooj';
  static const String firebaseLegacyApi = 'https://fcm.googleapis.com/fcm/send';
}

class MessageType {
  static const int text = 1;
  static const int image = 2;
  static const int video = 3;
  static const int file = 4;
  static const int audio = 5;
}
