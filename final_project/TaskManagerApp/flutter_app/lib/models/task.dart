import 'package:cloud_firestore/cloud_firestore.dart';
class TaskModel {
final String id;
final String title;
final String description;
final bool completed;
final DateTime createdAt;


TaskModel({
required this.id,
required this.title,
required this.description,
required this.completed,
required this.createdAt,
});


Map<String, dynamic> toMap() => {
'title': title,
'description': description,
'completed': completed,
'createdAt': createdAt.toUtc(),
};


factory TaskModel.fromMap(String id, Map<String, dynamic> map) {
return TaskModel(
id: id,
title: map['title'] ?? '',
description: map['description'] ?? '',
completed: map['completed'] ?? false,
createdAt: (map['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
);
}
}