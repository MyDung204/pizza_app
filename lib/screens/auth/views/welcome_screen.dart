import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pizza_app/screens/auth/views/sign_in_screen.dart';
import 'package:pizza_app/screens/auth/views/sign_up_screen.dart';
import '../../../blocs/authentication_bloc/authentication_bloc.dart';
import '../blocs/sign_in_bloc/sign_in_bloc.dart';
import '../blocs/sign_up_bloc/sign_up_bloc.dart';
class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

// Thêm 'with TickerProviderStateMixin' là bắt buộc để dùng TabController
class _WelcomeScreenState extends State<WelcomeScreen> with TickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    // Khởi tạo TabController với 2 tab
    tabController = TabController(
      initialIndex: 0,
      length: 2,
      vsync: this,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface, // Đã đổi thành surface
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              // 1. Hình tròn trang trí Tertiary
              Align(
                alignment: const AlignmentDirectional(20, -1.2),
                child: Container(
                  height: MediaQuery.of(context).size.width,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Theme.of(context).colorScheme.tertiary,
                  ),
                ),
              ),
              // 2. Hình tròn trang trí Primary
              Align(
                alignment: const AlignmentDirectional(2.7, -1.2),
                child: Container(
                  height: MediaQuery.of(context).size.width / 1.3,
                  width: MediaQuery.of(context).size.width / 1.3,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
              // 3. Hiệu ứng kính mờ (Glassmorphism)
              BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 100.0, sigmaY: 100.0),
                child: Container(),
              ),
              // 4. Nội dung chính: TabBar và TabBarView
              Align(
                alignment: Alignment.bottomCenter,
                child: SizedBox(
                  height: MediaQuery.of(context).size.height / 1.8,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 50.0),
                        child: TabBar(
                          controller: tabController,
                          // Đã đổi onBackground thành onSurface
                          unselectedLabelColor: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.5),
                          labelColor: Theme.of(context).colorScheme.onSurface,
                          tabs: const [
                            Padding(
                              padding: EdgeInsets.all(12.0),
                              child: Text(
                                'Sign In',
                                style: TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(12.0),
                              child: Text(
                                'Sign Up',
                                style: TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: TabBarView(
                          controller: tabController,
                          children: [
                            // Tab 1: Màn hình Sign In bọc trong BlocProvider
                            BlocProvider<SignInBloc>(
                              create: (context) => SignInBloc(
                                  context.read<AuthenticationBloc>().userRepository
                              ),
                              child: const SignInScreen(),
                            ),
                            // Tab 2: Màn hình Sign Up bọc trong BlocProvider
                            BlocProvider<SignUpBloc>(
                              create: (context) => SignUpBloc(
                                  context.read<AuthenticationBloc>().userRepository
                              ),
                              child: const SignUpScreen(),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}