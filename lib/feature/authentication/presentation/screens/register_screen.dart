import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_firebase_yt/common_widgets/async_value_ui.dart';
import 'package:todo_firebase_yt/routes/routes.dart';
import 'package:todo_firebase_yt/utilis/appstyles.dart';
import 'package:todo_firebase_yt/utilis/size_config.dart';
import '../controllers/auth_controller.dart';
import '../widgets/common_text_field.dart';

class RegisterScreen extends ConsumerStatefulWidget {
  const RegisterScreen({super.key});
  @override
  ConsumerState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen> {
  final _emailEditingController = TextEditingController();
  final _passwordController = TextEditingController();
  bool isChecked = false;

  void _validateDetails() async {
    String email = _emailEditingController.text.trim();
    String password = _passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Please fill all details",
            style: AppStyles.normalTextStyle.copyWith(color: Colors.red),
          ),
          duration: const Duration(seconds: 2),
        ),
      );
    } else {
      await ref
          .read(authControllerProvider.notifier)
          .createUserWithEmailAndPassword(email: email, password: password); 
      if (mounted) {
        context.goNamed(AppRoutes.signIn.name);
      }
    }
  }
  @override
  void dispose() {
    _emailEditingController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);

    final state = ref.watch(authControllerProvider);

    ref.listen<AsyncValue>(authControllerProvider, (_, state) {
      state.showAlertDialogOnError(context);
    });

    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.fromLTRB(
            SizeConfig.getProportionateWidth(10),
            SizeConfig.getProportionateHeight(50),
            SizeConfig.getProportionateWidth(10),
            0,
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text('Create your account 😄✨👋',
                    style: AppStyles.titleTextStyle),
                SizedBox(height: SizeConfig.getProportionateHeight(30)),
                CommonTextField(
                  hintText: "Enter Yours Email...",
                  textInputType: TextInputType.emailAddress,
                  controller: _emailEditingController,
                ),
                SizedBox(height: SizeConfig.getProportionateHeight(25)),
                CommonTextField(
                  hintText: "Enter Yours  Password...",
                  textInputType: TextInputType.text,
                  obsureText: true,
                  controller: _passwordController,
                ),
                SizedBox(height: SizeConfig.getProportionateHeight(15)),
                Row(
                  children: [
                    Checkbox(
                      value: isChecked,
                      onChanged: (bool? value) {
                        setState(() {
                          isChecked = value ?? false;
                        });
                      },
                    ),
                    Text('I agree', style: AppStyles.normalTextStyle),
                  ],
                ),
                SizedBox(height: SizeConfig.getProportionateHeight(25)),
                InkWell(
                  onTap: _validateDetails,
                  child: Container(
                    alignment: Alignment.center,
                    height: SizeConfig.getProportionateHeight(50),
                    width: SizeConfig.screenWidth,
                    decoration: BoxDecoration(
                      color: Colors.amber,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: state.isLoading
                        ? const CircularProgressIndicator()
                        : Text(
                            'Register me now',
                            style: AppStyles.normalTextStyle
                                .copyWith(color: Colors.white),
                          ),
                  ),
                ),
                SizedBox(height: SizeConfig.getProportionateHeight(40)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Already have an account? ',
                        style: AppStyles.normalTextStyle),
                    GestureDetector(
                      onTap: () {
                        context.goNamed(AppRoutes.signIn.name);
                      },
                      child: Text(
                        'Sign In',
                        style: AppStyles.normalTextStyle
                            .copyWith(color: Colors.amber),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

