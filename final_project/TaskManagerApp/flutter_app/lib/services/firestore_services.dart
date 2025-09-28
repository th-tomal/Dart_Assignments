import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/task.dart';

class FirestoreService {
	final FirebaseFirestore _db = FirebaseFirestore.instance;

	CollectionReference tasksRef(String uid) =>
			_db.collection('users').doc(uid).collection('tasks');

	Stream<List<TaskModel>> streamTasks(String uid) {
		return tasksRef(uid)
				.orderBy('createdAt', descending: true)
				.snapshots()
				.map((snapshot) => snapshot.docs
						.map((d) => TaskModel.fromMap(d.id, d.data() as Map<String, dynamic>))
						.toList());
	}

	Future<void> addTask(String uid, TaskModel task) async {
		await tasksRef(uid).add(task.toMap());
	}

	Future<void> updateTask(String uid, TaskModel task) async {
		await tasksRef(uid).doc(task.id).set(task.toMap());
	}

	Future<void> deleteTask(String uid, String taskId) async {
		await tasksRef(uid).doc(taskId).delete();
	}

	Future<void> toggleComplete(String uid, String taskId, bool completed) async {
		await tasksRef(uid).doc(taskId).update({'completed': completed});
	}
}