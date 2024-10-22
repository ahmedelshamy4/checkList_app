import 'package:checklist_app/core/custom_widgets/app_text_field_input.dart';
import 'package:checklist_app/core/themes/app_colors.dart';
import 'package:checklist_app/core/themes/app_text_styles.dart';
import 'package:checklist_app/core/utils/dimensions.dart';
import 'package:checklist_app/home/topics_page/topics_page.dart';
import 'package:checklist_app/utils/shared_preferences_manager.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class MobileHostCheckList extends StatefulWidget {
  const MobileHostCheckList({
    super.key,
  });

  @override
  State<MobileHostCheckList> createState() => _MobileHostCheckListState();
}

class _MobileHostCheckListState extends State<MobileHostCheckList> {
  List<String> topics = [];
  final _newTopicController = TextEditingController();
  final _sharedPrefsManager = SharedPreferencesManager();

  @override
  void initState() {
    super.initState();
    _loadTopics();
  }

  Future<void> _loadTopics() async {
    topics = await _sharedPrefsManager.getTopics();
    setState(() {});
  }

  void _removeTopic(int index) async {
    topics.removeAt(index);
    await _sharedPrefsManager.saveTopics(topics);
    setState(() {});
  }

  void _navigateToCheckListPage(BuildContext context, String topic) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => TopicsPage(
          sharedPrefsManager: _sharedPrefsManager,
          topic: topic,
        ),
      ),
    );
  }

  void _addTopic() async {
    if (_newTopicController.text.isNotEmpty) {
      topics.add(_newTopicController.text);
      _newTopicController.clear();
      await _sharedPrefsManager.saveTopics(topics);
      setState(() {});
    }
  }

  @override
  void dispose() {
    _newTopicController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Check List',
          style: AppTextStyles.playfairFont32Bold(context),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: PaddingDimensions.large),
            child: Text(
              "Mobile App Development Process: A Step-by-Step Guide.",
              style: AppTextStyles.nunitoFont24Regular(context),
            ),
          ),
          const Divider(),
          Expanded(
            child: ListView.builder(
              itemCount: topics.length,
              itemBuilder: (context, index) {
                final topic = topics[index];
                return ListTile(
                  title: Text(
                    topic,
                    style: AppTextStyles.nunitoFont24Regular(context),
                  ),
                  trailing: IconButton(
                    icon:
                        const Icon(Icons.delete, color: AppColors.primaryColor),
                    onPressed: () {
                      _removeTopic(index);
                    },
                  ),
                  onTap: () {
                    _navigateToCheckListPage(context, topic);
                  },
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: PaddingDimensions.large,
            vertical: PaddingDimensions.large),
        child: Row(
          children: [
            Expanded(
                child: AppTextField(
              controller: _newTopicController,
              hintText: "Add new checklist topic",
            )),
            const Gap(PaddingDimensions.large),
            FloatingActionButton(
              onPressed: _addTopic,
              child: const Icon(Icons.add),
            ),
          ],
        ),
      ),
    );
  }
}
