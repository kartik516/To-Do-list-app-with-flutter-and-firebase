import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../../../authentication/presentation/screens/accounts_screen.dart';
import 'all_task_screen.dart';
import 'add_task_screen.dart';
import 'Incompelete_task_screen.dart';
import 'completed_tasks_screen.dart';
class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int currentIndex = 0;

  @override
  void initState() {
    _tabController = TabController(length: 5, vsync: this);

    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _tabController.index = currentIndex;
    return Scaffold(
      appBar: AppBar(title: Text('VISHWANATH')),

      body: TabBarView(controller: _tabController,
      children: const [

        AllTasksScreen(), 
       IncompleteTasksScreen(),
        AddTaskScreen(),
        CompletedTasksScreen (),
        AccountsScreen(),
      ]
      
      ),

      bottomNavigationBar: BottomNavigationBar(currentIndex: currentIndex,
      onTap: (value) {
        setState(() {
          currentIndex=value;
        });
      },
iconSize:  20.0,
elevation: 5.0,
type: BottomNavigationBarType.fixed,
items:  const [
  BottomNavigationBarItem(icon:Icon(Icons.home_outlined),
  label: 'Home',
  
  
  activeIcon: Icon(Icons.home),
  ),
  

BottomNavigationBarItem(icon:Icon(Icons.dangerous_outlined),
  label: 'Incompleted',
  
  
  activeIcon: Icon(Icons.dangerous),
  ),

  BottomNavigationBarItem(icon:Icon(Icons.add),
  label: 'Add',
  
  
  activeIcon: Icon(Icons.add),
  ),

  BottomNavigationBarItem(icon:Icon(Icons.check_box_outlined),
  label: 'Complete',
  activeIcon: Icon(Icons.check_box),
  ),

BottomNavigationBarItem(icon:Icon(Icons.person_outline),
  label: 'Account',
  
  activeIcon: Icon(Icons.person),
  ),

],

      ),

    );
  }
}

class AllTaskScreen {
}

class AccountScreen {
}
