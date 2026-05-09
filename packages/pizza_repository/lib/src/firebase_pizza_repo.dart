import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../pizza_repository.dart';

class FirebasePizzaRepo implements PizzaRepo {
  final pizzaCollection = FirebaseFirestore.instance.collection('pizzas');

  Future<List<Pizza>> getPizza() async {
    try {
      return await pizzaCollection
          .get()
          .then((value) => value.docs.map((e) =>
            Pizza.fromEntity(PizzaEntity.fromDocument(e.data()))
          ).toList());
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }
}