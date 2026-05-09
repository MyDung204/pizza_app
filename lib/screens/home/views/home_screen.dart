import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// CHỈ import file bloc, KHÔNG import file event vì nó là 'part of'
import 'package:pizza_app/screens/auth/blocs/sign_in_bloc/sign_in_bloc.dart';
import 'package:pizza_app/screens/home/get_pizza_bloc/get_pizza_bloc.dart';

import 'details_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surface,
        title: Row(
          mainAxisSize: MainAxisSize.min, // Tránh lỗi tràn tiêu đề
          children: [
            Image.asset(
              'assets/8.png',
              scale: 14,
              width: 40,
              // Sửa Icons.pizza thành Icons.local_pizza
              errorBuilder: (context, error, stackTrace) => const Icon(Icons.local_pizza),
            ),
            const SizedBox(width: 8),
            const Text(
              'PIZZA',
              style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 30,
              ),
            )
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(CupertinoIcons.cart),
          ),
          IconButton(
            onPressed: () {
              // Sửa SignOutRequired thành SignOutProcess (theo code SignInBloc của bạn)
              context.read<SignInBloc>().add(const SignOutProcess());
            },
            icon: const Icon(CupertinoIcons.arrow_right_to_line),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocBuilder<GetPizzaBloc, GetPizzaState>(
          builder: (context, state) {
            if(state is GetPizzaSuccess) {
              return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 9 /
                      16, // Điều chỉnh lại tỷ lệ để không bị tràn
                ),
                itemCount: state.pizzas.length,
                itemBuilder: (context, int i) {
                  return Material(
                    elevation: 3,
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(20),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute<void>(
                              builder: (
                                  BuildContext context) => const DetailsScreen(),
                            )
                        );
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.asset(
                            'assets/1.png',

                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12.0),
                            child: Row(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.red,
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  child: const Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 4.0, horizontal: 8),
                                    child: Text(
                                      'NON-VEG',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 10,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 8),
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.green.withValues(alpha: 0.2),
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  child: const Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 4.0, horizontal: 8),
                                    child: Text(
                                      '🌶️ BALANCE',
                                      style: TextStyle(
                                        color: Colors.green,
                                        fontWeight: FontWeight.w800,
                                        fontSize: 10,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 8),
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 12.0),
                            child: Text(
                              'Cheesy Marvel',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 12.0),
                            child: Text(
                              'Crafting jay your pizza, your rules, best tastel',
                              style: TextStyle(
                                fontSize: 10,
                                color: Colors.grey.shade500,
                              ),
                            ),
                          ),
                          Padding(
                              padding: EdgeInsets.symmetric(horizontal: 12.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment
                                    .spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        '\$12.00',
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Theme
                                              .of(context)
                                              .colorScheme
                                              .primary,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                      const SizedBox(width: 5),
                                      Text(
                                        '\$15.00',
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.grey.shade500,
                                          fontWeight: FontWeight.w700,
                                          decoration: TextDecoration
                                              .lineThrough,
                                        ),
                                      ),
                                    ],
                                  ),
                                  IconButton(
                                    onPressed: () {},
                                    icon: Icon(
                                        CupertinoIcons.add_circled_solid),
                                  )
                                ],
                              )
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            } else if(state is GetPizzaLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return const Center(
                child: Text(
                    'An error has occurred...'
                ),
              );
            }
  },
),
      ),
    );
  }
}