// class Activity {
//   String? activity;
// }

// I/flutter ( 7001): [{"id":56,"actor":"z@a.com","target":null,"action_object":null,"verb":"joined","target_content_type_name":"space","actor_object_id":"11","description":null,"target_object_id":"3","action_object_object_id":null,"timestamp":"2023-12-18T10:16:55.579128Z","public":true,"actor_content_type":6,"target_content_type":16,"action_object_content_type":null},{"id":55,"actor":"z@a.com","target":null,"action_object":null,"verb":"joined","target_content_type_name":"space","actor_object_id":"11","description":null,"target_object_id":"1","action_object_object_id":null,"timestamp":"2023-12-15T19:17:26.304989Z","public":true,"actor_content_type":6,"target_content_type":16,"action_object_content_type":null}]

class Activity {
  final int? id;
  final String? actor;
  final String? target;
  final String? actionObject;
  final String? verb;
  final String? targetContentTypeName;
  final String? actorObjectId;
  final String? description;
  final String? targetObjectId;
  final String? actionObjectObjectId;
  final DateTime? timestamp;
  final bool? public;
  final int? actorContentType;
  final int? targetContentType;
  final int? actionObjectContentType;

  Activity({
    this.id,
    this.actor,
    this.target,
    this.actionObject,
    this.verb,
    this.targetContentTypeName,
    this.actorObjectId,
    this.description,
    this.targetObjectId,
    this.actionObjectObjectId,
    this.timestamp,
    this.public,
    this.actorContentType,
    this.targetContentType,
    this.actionObjectContentType,
  });

  factory Activity.fromJson(Map<String, dynamic> json) {
    return Activity(
      id: json['id'],
      actor: json['actor'],
      target: json['target'],
      actionObject: json['action_object'],
      verb: json['verb'],
      targetContentTypeName: json['target_content_type_name'],
      actorObjectId: json['actor_object_id'],
      description: json['description'],
      targetObjectId: json['target_object_id'],
      actionObjectObjectId: json['action_object_object_id'],
      timestamp:
          json['timestamp'] != null ? DateTime.parse(json['timestamp']) : null,
      public: json['public'],
      actorContentType: json['actor_content_type'],
      targetContentType: json['target_content_type'],
      actionObjectContentType: json['action_object_content_type'],
    );
  }

  //to json
  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "actor": actor,
      "target": target,
      "action_object": actionObject,
      "verb": verb,
      "target_content_type_name": targetContentTypeName,
      "actor_object_id": actorObjectId,
      "description": description,
      "target_object_id": targetObjectId,
      "action_object_object_id": actionObjectObjectId,
      "timestamp": timestamp,
      "public": public,
      "actor_content_type": actorContentType,
      "target_content_type": targetContentType,
      "action_object_content_type": actionObjectContentType,
    };
  }

}
