import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_firebase_yt/common_widgets/async_value_ui.dart';
import 'package:todo_firebase_yt/feature/authentication/data/auth_repository.dart';
import 'package:todo_firebase_yt/feature/task_managment/domain/task.dart';
import 'package:todo_firebase_yt/feature/task_managment/presentation/widgets/firestore_controller.dart';
import 'package:todo_firebase_yt/feature/task_managment/presentation/widgets/title_description.dart';
import 'package:todo_firebase_yt/utilis/appstyles.dart';
import 'package:todo_firebase_yt/utilis/size_config.dart';

class AddTaskScreen extends ConsumerStatefulWidget {
  const AddTaskScreen({super.key});

  @override
  ConsumerState createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends ConsumerState<AddTaskScreen> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();

  final List<String> _priorities = ['low', 'medium', 'high'];

  int _selectedPriority = 0;
  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);

   // final userId = ref.watch(currentUserProvider)!.uid;
    final currentUser = ref.watch(currentUserProvider);
if (currentUser == null) return const Scaffold(body: Center(child: Text('Please sign in')));
final userId = currentUser.uid;
    
    
    
    final state = ref.watch(firestoreControllerProvider);

    ref.listen<AsyncValue>(firestoreControllerProvider, (_, state) {
      state.showAlertDialogOnError(context);
    });

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Create Task',
          style: AppStyles.titleTextStyle.copyWith(color: Colors.yellow),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.fromLTRB(10, 20, 10, 10),
        child: Column(
          children: [
            TitleDescription(
              title: 'Task Title',
              prefixIcon: Icons.notes,
              hintText: 'Enter the task title',
              maxLines: 1,
              controller: _titleController,
            ),

            SizedBox(height: SizeConfig.getProportionateHeight(10)),

            TitleDescription(
              title: "Task Description ",
              prefixIcon: Icons.notes,
              hintText: 'Enter task Description ',
              controller: _descriptionController,
              maxLines: 3,
            ),

            SizedBox(height: SizeConfig.getProportionateHeight(20)),
            Row(
              children: [
                Text(
                  "Priority",
                  style: AppStyles.headingTextStyle.copyWith(
                    fontSize: SizeConfig.getProportionateHeight(18),
                  ),
                ),

                Expanded(
                  child: SizedBox(
                    height: SizeConfig.getProportionateHeight(40),
                    child: ListView.builder(
                      itemCount: _priorities.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (ctx, index) {
                        final priority = _priorities[index];
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedPriority = index;
                            });
                          },
                          child: Container(
                            margin: EdgeInsets.only(
                              left: SizeConfig.getProportionateHeight(10),
                            ),
                            padding: EdgeInsets.all(
                              SizeConfig.getProportionateHeight(10),
                            ),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: _selectedPriority == index
                                  ? Colors.green
                                  : Colors.green,
                            ),
                            child: Text(
                              priority,
                              style: AppStyles.normalTextStyle.copyWith(
                                color: _selectedPriority == index
                                    ? Colors.white
                                    : Colors.black,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: SizeConfig.getProportionateHeight(20)),
            InkWell(
              onTap: () {
                final title = _titleController.text.trim();
                final description = _descriptionController.text.trim();
                String priority = _priorities[_selectedPriority];
                String date = DateTime.now().toString();

                final myTask = Task(
                  title: title,
                  description: description,
                  priority: priority,
                  date: date,
                );

                ref
                    .read(firestoreControllerProvider.notifier)
                    .addTask(task: myTask, userId: userId);
              },
              child: Container(
                alignment: Alignment.center,
                height: SizeConfig.getProportionateHeight(50),
                width: SizeConfig.screenWidth,

                decoration: BoxDecoration(
                  color: Colors.deepOrange,
                  borderRadius: BorderRadius.circular(20),
                ),

                child:  state.isLoading? const CircularProgressIndicator(): Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.add,
                      color: Colors.white,
                      size: 30,
                    ), // Icon
                    Text(
                      'Add Task',
                      style: AppStyles.normalTextStyle.copyWith(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
