import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_firebase_yt/common_widgets/async_value_ui.dart';
import 'package:todo_firebase_yt/feature/authentication/presentation/controllers/auth_controller.dart';
import 'package:todo_firebase_yt/feature/authentication/presentation/widgets/common_text_field.dart';
import 'package:todo_firebase_yt/routes/routes.dart';
import 'package:todo_firebase_yt/utilis/appstyles.dart';
import 'package:todo_firebase_yt/utilis/size_config.dart';

class SignInScreen extends ConsumerStatefulWidget {
  const SignInScreen({super.key});

  @override
  ConsumerState createState() => _SignInScreenState();
}

class _SignInScreenState extends ConsumerState<SignInScreen> {
  final _emailEditingController = TextEditingController();
  final _passwordController = TextEditingController();
  bool isChecked = false;

  void _validatedetails() {
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
      ref
          .read(authControllerProvider.notifier)
          .signInWithEmailAndPassword(email: email, password: password);
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
            if (state is AsyncData<void> && !state.isLoading) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (mounted) {
            context.goNamed(AppRoutes.main.name);
          }
        });
      }
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
                Text(
                  'Sign In To Account 😄✨👋',
                  style: AppStyles.titleTextStyle,
                ),

                SizedBox(height: SizeConfig.getProportionateHeight(30)),
                CommonTextField(
                  hintText: "Enter Yours Email...",
                  textInputType: TextInputType.emailAddress,
                  controller: _emailEditingController,
                ),

                SizedBox(height: SizeConfig.getProportionateHeight(25)),
                CommonTextField(
                  hintText: "Enter Yours Password...",
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
                  onTap: _validatedetails,
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
                            'Sign In',
                            style: AppStyles.normalTextStyle.copyWith(
                              color: Colors.white,
                            ),
                          ),
                  ),
                ),

                SizedBox(height: SizeConfig.getProportionateHeight(10)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: SizeConfig.getProportionateHeight(1),
                      width: SizeConfig.screenWidth * 0.4,
                      decoration: const BoxDecoration(color: Colors.green),
                    ),
                    SizedBox(width: SizeConfig.getProportionateWidth(5)),
                    Text('or', style: AppStyles.normalTextStyle),
                    SizedBox(width: SizeConfig.getProportionateWidth(5)),
                    Container(
                      height: SizeConfig.getProportionateHeight(1),
                      width: SizeConfig.screenWidth * 0.4,
                      decoration: const BoxDecoration(color: Colors.green),
                    ),
                  ],
                ),
                SizedBox(height: SizeConfig.getProportionateHeight(10)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      height: SizeConfig.getProportionateHeight(40),
                      width: SizeConfig.screenWidth * 0.25,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: Colors.black,
                          style: BorderStyle.solid,
                          width: 2,
                        ),
                      ),
                      child: const FaIcon(
                        FontAwesomeIcons.google,
                        color: Colors.red,
                      ),
                    ),
                    Container(
                      height: SizeConfig.getProportionateHeight(40),
                      width: SizeConfig.screenWidth * 0.25,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: Colors.black,
                          style: BorderStyle.solid,
                          width: 2,
                        ),
                      ),
                      child: const FaIcon(
                        FontAwesomeIcons.apple,
                        color: Colors.black,
                      ),
                    ),
                    Container(
                      height: SizeConfig.getProportionateHeight(40),
                      width: SizeConfig.screenWidth * 0.25,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: Colors.black,
                          style: BorderStyle.solid,
                          width: 2,
                        ),
                      ),
                      child: const FaIcon(
                        FontAwesomeIcons.facebook,
                        color: Colors.blue,
                      ),
                    ),
                  ],
                ),

                SizedBox(height: SizeConfig.getProportionateHeight(40)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Don\'t have an account? ',
                      style: AppStyles.normalTextStyle,
                    ),
                    GestureDetector(
                      onTap: () {
                        context.goNamed(AppRoutes.register.name);
                      },
                      child: Text(
                        'Register',
                        style: AppStyles.normalTextStyle.copyWith(
                          color: Colors.amber,
                        ),
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