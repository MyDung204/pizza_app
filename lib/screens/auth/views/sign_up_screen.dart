import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_repository/user_repository.dart';

import '../../../components/my_text_field.dart';
import '../blocs/sign_up_bloc/sign_up_bloc.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final passwordController = TextEditingController();
  final emailController = TextEditingController();
  final nameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  IconData iconPassword = CupertinoIcons.eye_fill;
  bool obscurePassword = true;
  bool signUpRequired = false;

  bool containsUpperCase = false;
  bool containsLowerCase = false;
  bool containsNumber = false;
  bool containsSpecialChar = false;
  bool contains8Length = false;

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignUpBloc, SignUpState>(
      listener: (context, state) {
        if (state is SignUpSuccess) {
          setState(() {
            signUpRequired = false;
          });
        } else if (state is SignUpProcess) {
          setState(() {
            signUpRequired = true;
          });
        } else if (state is SignUpFailure) {
          setState(() {
            signUpRequired = false;
          });
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Đăng ký thất bại. Vui lòng kiểm tra lại!')),
          );
        }
      },
      child: Form(
        key: _formKey,
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 20),
              // KHUNG NHẬP EMAIL
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                child: MyTextField(
                  controller: emailController,
                  hintText: 'Email',
                  obscureText: false,
                  keyboardType: TextInputType.emailAddress,
                  prefixIcon: const Icon(CupertinoIcons.mail_solid),
                  validator: (val) {
                    if (val!.isEmpty) {
                      return 'Please fill in this field';
                    } else if (!RegExp(r'^[\w-\.]+@([\w-]+.)+[\w-]{2,4}$').hasMatch(val)) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 10),

              // KHUNG NHẬP PASSWORD
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                child: MyTextField(
                  controller: passwordController,
                  hintText: 'Password',
                  obscureText: obscurePassword,
                  keyboardType: TextInputType.visiblePassword,
                  prefixIcon: const Icon(CupertinoIcons.lock_fill),
                  onChanged: (val) {
                    if (val!.contains(RegExp(r'[A-Z]'))) {
                      setState(() => containsUpperCase = true);
                    } else {
                      setState(() => containsUpperCase = false);
                    }
                    if (val.contains(RegExp(r'[a-z]'))) {
                      setState(() => containsLowerCase = true);
                    } else {
                      setState(() => containsLowerCase = false);
                    }
                    if (val.contains(RegExp(r'[0-9]'))) {
                      setState(() => containsNumber = true);
                    } else {
                      setState(() => containsNumber = false);
                    }
                    if (val.contains(RegExp(r'^(?=.*?[!@#\$&*~`)\%\-(_+=;:,.<>/?"[{\]}\|^])'))) {
                      setState(() => containsSpecialChar = true);
                    } else {
                      setState(() => containsSpecialChar = false);
                    }
                    if (val.length >= 8) {
                      setState(() => contains8Length = true);
                    } else {
                      setState(() => contains8Length = false);
                    }
                    return null;
                  },
                  validator: (val) {
                    if (val!.isEmpty) {
                      return 'Please fill in this field';
                    } else if (!containsUpperCase || !containsLowerCase || !containsNumber || !containsSpecialChar || !contains8Length) {
                      return 'Please enter a stronger password';
                    }
                    return null;
                  },
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        obscurePassword = !obscurePassword;
                        iconPassword = obscurePassword ? CupertinoIcons.eye_fill : CupertinoIcons.eye_slash_fill;
                      });
                    },
                    icon: Icon(iconPassword),
                  ),
                ),
              ),
              const SizedBox(height: 10),

              // UI KIỂM TRA ĐỘ MẠNH PASSWORD
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("✓ Đủ 8 ký tự", style: TextStyle(color: contains8Length ? Colors.green : Theme.of(context).colorScheme.onSurface)),
                      Text("✓ 1 Chữ in hoa", style: TextStyle(color: containsUpperCase ? Colors.green : Theme.of(context).colorScheme.onSurface)),
                      Text("✓ 1 Chữ thường", style: TextStyle(color: containsLowerCase ? Colors.green : Theme.of(context).colorScheme.onSurface)),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("✓ 1 Chữ số", style: TextStyle(color: containsNumber ? Colors.green : Theme.of(context).colorScheme.onSurface)),
                      Text("✓ 1 Ký tự đặc biệt", style: TextStyle(color: containsSpecialChar ? Colors.green : Theme.of(context).colorScheme.onSurface)),
                    ],
                  )
                ],
              ),
              const SizedBox(height: 10),

              // KHUNG NHẬP TÊN (Đoạn xuất hiện trong ảnh)
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                child: MyTextField(
                  controller: nameController,
                  hintText: 'Name',
                  obscureText: false,
                  keyboardType: TextInputType.name,
                  prefixIcon: const Icon(CupertinoIcons.person_fill),
                  validator: (val) {
                    if (val!.isEmpty) {
                      return 'Please fill in this field';
                    } else if (val.length > 30) {
                      return 'Name too long';
                    }
                    return null;
                  },
                ),
              ),

              // Đoạn SizedBox khoảng cách như trong ảnh
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),

              // NÚT BẤM (Đúng hệt logic của video trong ảnh)
              !signUpRequired
                  ? SizedBox(
                width: MediaQuery.of(context).size.width * 0.5,
                child: TextButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      MyUser myUser = MyUser.empty;
                      myUser.email = emailController.text;
                      myUser.name = nameController.text;

                      // Gọi setState loading ngay lập tức
                      setState(() {
                        signUpRequired = true;
                      });

                      // Bắn event lên Bloc
                      context.read<SignUpBloc>().add(
                          SignUpRequired(
                              myUser,
                              passwordController.text
                          )
                      );
                    }
                  },
                  style: TextButton.styleFrom(
                    elevation: 3.0,
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(60),
                    ),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 25, vertical: 5),
                    child: Text(
                      'Sign Up',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              )
                  : const CircularProgressIndicator(),
            ],
          ),
        ),
      ),
    );
  }
}