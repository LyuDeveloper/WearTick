class ProjectModel {
  late String id;
  late String name;
  late String color;
  late bool closed;
  late String groupId;
  late String viewMode;
  late String permission;
  late String kind;

  ProjectModel(
      {required this.id,
      required this.name,
      required this.color,
      required this.closed,
      required this.groupId,
      required this.viewMode,
      required this.permission,
      required this.kind});

  ProjectModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    color = json['color'];
    closed = json['closed'];
    groupId = json['groupId'];
    viewMode = json['viewMode'];
    permission = json['permission'];
    kind = json['kind'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['color'] = this.color;
    data['closed'] = this.closed;
    data['groupId'] = this.groupId;
    data['viewMode'] = this.viewMode;
    data['permission'] = this.permission;
    data['kind'] = this.kind;
    return data;
  }
}


class TaskModel {
  late String id;
  late bool isAllDay;
  late String projectId;
  late String title;
  late String content;
  late String desc;
  late String timeZone;
  late String repeatFlag;
  late String startDate;
  late String dueDate;
  late List<String> reminders;
  late int priority;
  late int status;
  late String completedTime;
  late int sortOrder;
  late List<Items> items;

  TaskModel(
      {required this.id,
      required this.isAllDay,
      required this.projectId,
      required this.title,
      required this.content,
      required this.desc,
      required this.timeZone,
      required this.repeatFlag,
      required this.startDate,
      required this.dueDate,
      required this.reminders,
      required this.priority,
      required this.status,
      required this.completedTime,
      required this.sortOrder,
      required this.items});

  TaskModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    isAllDay = json['isAllDay'];
    projectId = json['projectId'];
    title = json['title'];
    content = json['content'];
    desc = json['desc'];
    timeZone = json['timeZone'];
    repeatFlag = json['repeatFlag'];
    startDate = json['startDate'];
    dueDate = json['dueDate'];
    reminders = json['reminders'].cast<String>();
    priority = json['priority'];
    status = json['status'];
    completedTime = json['completedTime'];
    sortOrder = json['sortOrder'];
    if (json['items'] != null) {
      items = List<Items>.empty(growable: true);
      json['items'].forEach((v) {
        items.add(new Items.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['isAllDay'] = this.isAllDay;
    data['projectId'] = this.projectId;
    data['title'] = this.title;
    data['content'] = this.content;
    data['desc'] = this.desc;
    data['timeZone'] = this.timeZone;
    data['repeatFlag'] = this.repeatFlag;
    data['startDate'] = this.startDate;
    data['dueDate'] = this.dueDate;
    data['reminders'] = this.reminders;
    data['priority'] = this.priority;
    data['status'] = this.status;
    data['completedTime'] = this.completedTime;
    data['sortOrder'] = this.sortOrder;
    data['items'] = this.items.map((v) => v.toJson()).toList();
      return data;
  }
}

class Items {
  late String id;
  late int status;
  late String title;
  late int sortOrder;
  late String startDate;
  late bool isAllDay;
  late String timeZone;
  late String completedTime;

  Items(
      {required this.id,
      required this.status,
      required this.title,
      required this.sortOrder,
      required this.startDate,
      required this.isAllDay,
      required this.timeZone,
      required this.completedTime});

  Items.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    status = json['status'];
    title = json['title'];
    sortOrder = json['sortOrder'];
    startDate = json['startDate'];
    isAllDay = json['isAllDay'];
    timeZone = json['timeZone'];
    completedTime = json['completedTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['status'] = this.status;
    data['title'] = this.title;
    data['sortOrder'] = this.sortOrder;
    data['startDate'] = this.startDate;
    data['isAllDay'] = this.isAllDay;
    data['timeZone'] = this.timeZone;
    data['completedTime'] = this.completedTime;
    return data;
  }
}
