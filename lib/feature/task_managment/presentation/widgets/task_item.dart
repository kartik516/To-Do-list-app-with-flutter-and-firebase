import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_firebase_yt/feature/authentication/data/auth_repository.dart';
import 'package:todo_firebase_yt/feature/task_managment/data/firestore_repository.dart';
import 'package:todo_firebase_yt/feature/task_managment/presentation/widgets/firestore_controller.dart';
import 'package:todo_firebase_yt/utilis/appstyles.dart';
import 'package:todo_firebase_yt/utilis/size_config.dart';
import '../../domain/task.dart';
import 'package:intl/intl.dart';

String formattedDate(String date) {
  DateTime dateTime = DateTime.parse(date);
  String formatted = DateFormat('dd-MM-yyyy').format(dateTime);
  return formatted;
}

class TaskItem extends ConsumerStatefulWidget {
  const TaskItem(this.task, {super.key});

  final Task task;

  @override
  ConsumerState createState() => _TaskItemState();
}

class _TaskItemState extends ConsumerState<TaskItem> {
  void _deleteTask(String taskId) {
    final userId = ref.watch(currentUserProvider)!.uid;
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text("Are you sure", style: AppStyles.titleTextStyle),
        icon: const Icon(Icons.delete, size: 60, color: Colors.red),
        alignment: Alignment.center,
        content: const Text('Tap to delete the task!'),
        actions: [
          ElevatedButton(
            onPressed: () {
              context.pop();
            },
            child: Text('Cancel', style: AppStyles.normalTextStyle),
          ),
          ElevatedButton(
            onPressed: () async {
              await ref
                  .read(firestoreControllerProvider.notifier)
                  .deleteTask(userId: userId, taskId: taskId);
              if (mounted) {
                context.pop();
              }
            },
            child: Text('delete ', style: AppStyles.normalTextStyle),
          ),
        ],
      ),
    );
  }

  void _updateTask() {
    TextEditingController titleController =
        TextEditingController(text: widget.task.title);
    TextEditingController descriptionController =
        TextEditingController(text: widget.task.description);

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        icon: const Icon(
          Icons.edit,
          color: Colors.green,
          size: 40,
        ),
        title: Text(
          'Update Task',
          style: AppStyles.normalTextStyle,
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(
                labelText: 'Title',
              ),
            ),
            TextField(
              controller: descriptionController, 
              decoration: const InputDecoration(
                labelText: 'Description ',
              ),
            ),
          ],
        ),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  context.pop();
                },
                child: Text(
                  'cancel ',
                  style: AppStyles.normalTextStyle,
                ),
              ),







SizedBox(width: SizeConfig.getProportionateWidth(20)),

ElevatedButton(
  onPressed: () {
    String newTitle = titleController.text;
    String newDesc = descriptionController.text;

    final userId = ref.read(currentUserProvider)!.uid;

    final newTask=Task(title: newTitle,
     description: newDesc,
     priority: widget.task.priority,
     id: widget.task.id,
     isComplete: widget.task.isComplete,
      date: DateTime.now().toString(),
      );


ref.read(firestoreControllerProvider.notifier).updateTask(task: newTask,
 userId: userId, 
 taskId: widget.task.id); 
context.pop();


  },
  child: Text(
    'Update',
    style: AppStyles.normalTextStyle,
  ),
),









               
            ],
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);

    return Container(
      margin: const EdgeInsets.all(18),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.black,
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.task.title,
                  style: AppStyles.headingTextStyle.copyWith(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: SizeConfig.getProportionateHeight(10)),
                Text(
                  widget.task.description,
                  style: AppStyles.normalTextStyle.copyWith(
                    color: Colors.white,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: SizeConfig.getProportionateHeight(20)),
                Row(
                  children: [
                    Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.all(5),
                      height: SizeConfig.getProportionateHeight(40),
                      decoration: BoxDecoration(
                        color: Colors.deepOrange,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        widget.task.priority.toUpperCase(),
                        style: AppStyles.normalTextStyle.copyWith(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(width: SizeConfig.getProportionateWidth(10)),
                    Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.all(5),
                      height: SizeConfig.getProportionateHeight(40),
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.calendar_month,
                            color: Colors.black,
                            size: 20,
                          ),
                          Text(
                            formattedDate(widget.task.date),
                            style: AppStyles.normalTextStyle.copyWith(
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Transform.scale(
                  scale: 1.9,
                  child: Checkbox(
                    value: widget.task.isComplete,
                    onChanged: (bool? value) {
                      if (value == null) {
                        return;
                      } else {
                        final userId = ref.watch(currentUserProvider)!.uid;
                        ref
                            .read(firestoreRepositoryProvider)
                            .updateTaskCompletion(
                              userId: userId,
                              taskId: widget.task.id,
                              isComplete: value,
                            );
                      }
                    },
                  ),
                ),
                GestureDetector(
                  onTap: _updateTask,
                  child: Container(
                    height: SizeConfig.getProportionateHeight(40),
                    padding: const EdgeInsets.all(5),
                    decoration: const BoxDecoration(
                      color: Colors.pink,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.edit,
                      color: Colors.white,
                      size: 30.0,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    _deleteTask(widget.task.id);
                  },
                  child: Container(
                    height: SizeConfig.getProportionateHeight(40),
                    padding: const EdgeInsets.all(5),
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.delete,
                      color: Colors.white,
                      size: 30.0,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


