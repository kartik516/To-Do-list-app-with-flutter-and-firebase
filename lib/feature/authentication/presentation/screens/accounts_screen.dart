import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_firebase_yt/feature/authentication/data/auth_repository.dart';
import 'package:todo_firebase_yt/feature/authentication/presentation/controllers/auth_controller.dart';
import 'package:todo_firebase_yt/utilis/appstyles.dart';
import 'package:todo_firebase_yt/utilis/size_config.dart';
import 'package:todo_firebase_yt/routes/routes.dart';

class AccountsScreen extends ConsumerWidget {
  const AccountsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentUserAsync = ref.watch(authStateChangesProvider);

    return currentUserAsync.when(
      loading: () => const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      ),
      error: (error, stackTrace) => Scaffold(
        body: Center(
          child: Text('Error loading account', style: AppStyles.normalTextStyle),
        ),
      ),
      data: (currentUser) {
        if (currentUser == null) {
          return Scaffold(
            body: Center(
              child: Text('Please sign in first',
                  style: AppStyles.normalTextStyle),
            ),
          );
        }

        return Scaffold(
          appBar: AppBar(
            title: Text(
              'My Account',
              style: AppStyles.titleTextStyle.copyWith(color: Colors.white),
            ),
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Account Information',
                    style: AppStyles.titleTextStyle.copyWith(fontSize: 20)),
                const Icon(Icons.account_circle,
                    color: Colors.green, size: 60),
                Text(currentUser.email ?? 'No email'),
                Text(currentUser.uid),
                SizedBox(height: SizeConfig.getProportionateHeight(20)),
                GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (ctx) => AlertDialog(
                        title: Text('Confirm Logout',
                            style: AppStyles.normalTextStyle),
                        icon: const Icon(Icons.logout,
                            color: Colors.red, size: 60),
                        content: const Text('Are you sure you want to logout?'),
                        actions: [
                          ElevatedButton(
                            onPressed: () => Navigator.of(ctx).pop(),
                            child:
                                Text('Cancel', style: AppStyles.normalTextStyle),
                          ),
                          ElevatedButton(
                            onPressed: () async {
                              Navigator.of(ctx).pop();
                              await ref
                                  .read(authControllerProvider.notifier)
                                  .signOut(); // CONTROLLER USE KAREN
                              if (context.mounted) {
                                context.goNamed(AppRoutes.signIn.name);
                              }
                            },
                            child:
                                Text('Logout', style: AppStyles.normalTextStyle),
                          ),
                        ],
                      ),
                    );
                  },
                  child: Container(
                    alignment: Alignment.center,
                    height: SizeConfig.getProportionateHeight(50),
                    width: SizeConfig.screenWidth * 0.8,
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: const Text(
                      'Log Out',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

