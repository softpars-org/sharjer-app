import 'package:intl/intl.dart';

class Rule {
  String rule;
  String createdOn;
  String editedOn;
  String createdTime;
  String editedTime;

  Rule(
    this.rule,
    this.createdOn,
    this.editedOn,
    this.createdTime,
    this.editedTime,
  );
  factory Rule.fromMap(Map<String, dynamic> ruleMap) {
    DateTime now = DateTime.now();
    DateTime createdTime = DateTime.fromMillisecondsSinceEpoch(
        int.parse(ruleMap["created_at"]) * 1000);
    DateTime editedTime = DateTime.fromMillisecondsSinceEpoch(
        int.parse(ruleMap["edited_at"]) * 1000);
    Duration createdTimeDifference = now.difference(createdTime);
    Duration editedTimeDifference = now.difference(editedTime);
    DateFormat formatter = DateFormat("h:m");
    String _createdTime = formatter.format(createdTime);
    String _editedTime = formatter.format(editedTime);
    return Rule(
      ruleMap["rule"],
      createdTimeDifference.inDays.toString(),
      editedTimeDifference.inDays.toString(),
      _createdTime,
      _editedTime,
    );
  }
}
