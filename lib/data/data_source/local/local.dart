import '../../model/model_cache/model_cache.dart';
import 'package:hive/hive.dart';

class Data_Local {
  String _boxName_setting = "Model_Cache_Setting";

  static final Data_Local _services_auth_instance = Data_Local._internal();

  factory Data_Local() {
    return _services_auth_instance;
  }
  Data_Local._internal();

  Future<Box> my_setting_box() async {
    var box = await Hive.openBox<Model_Cache_Setting>(_boxName_setting);
    return box;
  }

  Future<List<Model_Cache_Setting>> getall_setting_local() async {
    final box = await my_setting_box();
    List<Model_Cache_Setting> model =
        box.values.cast<Model_Cache_Setting>().toList();
    return model;
  }

  Future<void> add_setting_local(
      Model_Cache_Setting model_cache_setting) async {
    final box = await my_setting_box();
    await box.add(model_cache_setting);
  }

  Future<void> delete_all_setting_local(var tittle) async {
    final box = Hive.box<Model_Cache_Setting>(_boxName_setting);

    final Map<dynamic, Model_Cache_Setting> deliveriesMap = box.toMap();
    dynamic desiredKey;
    deliveriesMap.forEach((key, value) {
      if (value.key == tittle) desiredKey = key;
    });
    box.delete(desiredKey);
  }
}
