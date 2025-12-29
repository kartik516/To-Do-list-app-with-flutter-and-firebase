import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_firebase_yt/common_widgets/asyn_value_widget.dart';
import 'package:todo_firebase_yt/common_widgets/async_value_ui.dart';
import 'package:todo_firebase_yt/feature/authentication/data/auth_repository.dart';
import 'package:todo_firebase_yt/feature/task_managment/data/firestore_repository.dart';
import 'package:todo_firebase_yt/feature/task_managment/domain/task.dart';
import 'package:todo_firebase_yt/feature/task_managment/presentation/widgets/task_item.dart';
import 'package:todo_firebase_yt/utilis/appstyles.dart';

class IncompleteTasksScreen extends ConsumerWidget {
  const IncompleteTasksScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
  
    final currentUser = ref.watch(currentUserProvider);
    if (currentUser == null) {
      return const Scaffold(
        body: Center(child: Text('Please sign in first')),
      );
    }
    final userId = currentUser.uid;

    final incompletedTasksAsyncValue = ref.watch(
      loadInCompleteTasksProvider(userId),
    );

    ref.listen<AsyncValue>(loadInCompleteTasksProvider(userId), (_, state) {
      state.showAlertDialogOnError(context);
    });

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Incomplete Tasks',
          style: AppStyles.titleTextStyle.copyWith(color: Colors.white),
        ),
      ),
      body: AsyncValueWidget<List<Task>>(
        value: incompletedTasksAsyncValue,
        data: (tasks) {
          return tasks.isEmpty
              ? const Center(child: Text('No incomplete tasks yet...'))
              : ListView.separated(
                  itemBuilder: (ctx, index) {
                    final task = tasks[index];
                    return TaskItem(task);
                  },
                  separatorBuilder: (ctx, index) =>
                      const Divider(height: 2, color: Colors.blue),
                  itemCount: tasks.length,
                );
        },
      ),
    );
  }
}