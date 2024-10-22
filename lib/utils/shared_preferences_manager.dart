import 'dart:convert';

import 'package:checklist_app/model/check_list_item.dart';
import 'package:checklist_app/model/tab_data_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesManager {
  SharedPreferencesManager._internal();
  static final SharedPreferencesManager _instance =
      SharedPreferencesManager._internal();

  factory SharedPreferencesManager() {
    return _instance;
  }
  late SharedPreferences _preferences;

  Future<void> init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  // Save a list of TabData
  Future<void> saveTabs(List<TabDataModel> tabs) async {
    List<String> tabDataJsonList =
        tabs.map((tab) => jsonEncode(tab.toJson())).toList();
    await _preferences.setStringList('saved_tabs', tabDataJsonList);
  }

  // Get a list of TabData
  List<TabDataModel> getTabs() {
    List<String>? tabDataJsonList = _preferences.getStringList('saved_tabs');
    if (tabDataJsonList != null) {
      return tabDataJsonList
          .map((jsonStr) => TabDataModel.fromJson(jsonDecode(jsonStr)))
          .toList();
    }
    return [];
  }

  // Save a list of topics
  Future<void> saveTopics(List<String> topics) async {
    print('Saving topics: $topics');
    await _preferences.setStringList('topics', topics);
  }

  // Get a list of topics
  Future<List<String>> getTopics() async {
    print('Getting topics ${_preferences.getStringList('topics')}');
    return _preferences.getStringList('topics') ?? [];
  }

  // // Remove a topic by index
  // Future<void> removeTopicAtIndex(int index, List<String> topics) async {
  //   topics.removeAt(index);
  //   await saveTopics(topics);
  // }
  //
  // // Clear all SharedPreferences data (for testing or reset)
  // Future<void> clearAll() async {
  //   await _preferences.clear();
  // }

  // Save checklist items for a specific topic
  void saveCheckList(String topic, List<CheckListItem> checkList) {
    List<String> checkListJson =
        checkList.map((item) => jsonEncode(item.toJson())).toList();
    _preferences.setStringList(topic, checkListJson);
  }

  List<CheckListItem> getCheckList(String topic) {
    List<String>? checkListJson = _preferences.getStringList(topic);
    if (checkListJson != null) {
      return checkListJson
          .map((item) => CheckListItem.fromJson(jsonDecode(item)))
          .toList();
    }
    return [];
  }
}
