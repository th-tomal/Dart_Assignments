import 'package:flutter/material.dart';
import '../models/task.dart';
import '../services/firestore_services.dart';
import '../screens/add_edit_task_page.dart';

class TaskTile extends StatelessWidget {
  final TaskModel task;
  final String uid;
  const TaskTile({super.key, required this.task, required this.uid});

  @override
  Widget build(BuildContext context) {
    final fs = FirestoreService();

    return Card(
      child: ListTile(
        leading: Checkbox(
          value: task.completed,
          onChanged: (val) {
            final updated = TaskModel(
              id: task.id,
              title: task.title,
              description: task.description,
              completed: val ?? false,
              createdAt: task.createdAt,
            );
            fs.updateTask(uid, updated);
          },
        ),
        title: Text(
          task.title,
          style: TextStyle(
            decoration: task.completed
                ? TextDecoration.lineThrough
                : TextDecoration.none,
          ),
        ),
        subtitle: Text(task.description),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => AddEditTaskPage(task: task),
                  ),
                );
              },
            ),
            IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: () async {
                final confirm = await showDialog<bool>(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    title: const Text('Delete Task?'),
                    content: const Text('Are you sure you want to delete this task?'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(ctx, false),
                        child: const Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () => Navigator.pop(ctx, true),
                        child: const Text('Delete'),
                      ),
                    ],
                  ),
                );
                if (confirm == true) {
                  await fs.deleteTask(uid, task.id);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
