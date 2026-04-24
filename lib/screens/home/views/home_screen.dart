import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pizza_app/screens/auth/blocs/sign_in_bloc/sign_in_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen ({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surface,
        title: Row(
            children: [
              Image.asset(
                'assets/8.png',
                scale: 14,
              ),
              const SizedBox(width: 8,),
              const Text(
                'PIZZA',
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 30,
                ),
              )
            ]
        ),
        actions: [
          IconButton(
              onPressed:  () {

              },
              icon: const Icon(CupertinoIcons.cart) // Thêm const
          ),
          IconButton(
              onPressed:  () {
                context.read<SignInBloc>().add(SignOutRequired());
              },
              icon: const Icon(CupertinoIcons.arrow_right_to_line) // Thêm const
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount( // Thêm const
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 9/16,
            ),
            itemCount: 8,
            itemBuilder: (context, int i){
              return Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade300,
                      blurRadius: 5,
                      offset: Offset(3, 3),
                    )
                  ]
                ),
                child: Column(
                  children: [
                    Image.asset(
                      'assets/1.png'
                    ),
                    Row(
                      children: [
                        Container(
                          color: Colors.red,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Text(
                            'NON-VEG',
                            style:TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 10,
                            ) ,
                          ),
                        )
                      ],
                    )

                  ],
                ),
              );
            }
        ),
      ),
    );
  }
}