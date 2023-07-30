import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tanbits_task/Models/food_model.dart';

class HomeProvider extends ChangeNotifier {
  List<FoodModel> list_food_model = [];
  List<FoodModel> filteredList = [];
  TextEditingController controller = TextEditingController();
  String? selected_cat;
  String? selected_recipe;
  String? selected_chef;
  bool showFilteredList = false;

  final Stream<QuerySnapshot> categoryType =
      FirebaseFirestore.instance.collection('Categories').snapshots();
  final Stream<QuerySnapshot> recipeType =
      FirebaseFirestore.instance.collection('RecipeType').snapshots();
  final Stream<QuerySnapshot> sheffType =
      FirebaseFirestore.instance.collection('Shef').snapshots();

  Future filterApply() async {
    QuerySnapshot querySnapshot1 = await FirebaseFirestore.instance
        .collection('FoodList')
        .where('chef', isEqualTo: selected_chef ?? '')
        .get();
    querySnapshot1.docs.forEach(
      (doc) {
        DocumentSnapshot document = doc;
        Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
        FoodModel model = FoodModel.fromJson(data);
        if (!list_food_model.contains(model)) {
          list_food_model.add(FoodModel.fromJson(data));
        }
      },
    );
    QuerySnapshot querySnapshot2 = await FirebaseFirestore.instance
        .collection('FoodList')
        .where('cuisineId', isEqualTo: selected_recipe ?? '')
        .get();
    querySnapshot2.docs.forEach(
      (doc) {
        DocumentSnapshot document = doc;
        Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
        FoodModel model = FoodModel.fromJson(data);
        if (!list_food_model.contains(model)) {
          list_food_model.add(FoodModel.fromJson(data));
        }
      },
    );
    QuerySnapshot querySnapshot3 = await FirebaseFirestore.instance
        .collection('FoodList')
        .where('categoryId', isEqualTo: selected_cat ?? '')
        .get();
    querySnapshot3.docs.forEach(
      (doc) {
        DocumentSnapshot document = doc;
        Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
        FoodModel model = FoodModel.fromJson(data);
        if (!list_food_model.contains(model)) {
          list_food_model.add(FoodModel.fromJson(data));
        }
      },
    );
    showFilteredList = false;
    notifyListeners();
  }
  //................Clear Filter................//

  Future clearFilter(BuildContext context) async {
    FirebaseFirestore.instance.collection('FoodList').get().then(
      (QuerySnapshot querySnapshot) {
        querySnapshot.docs.forEach(
          (doc) {
            DocumentSnapshot document = doc;
            Map<String, dynamic> data =
                document.data()! as Map<String, dynamic>;
            list_food_model.add(FoodModel.fromJson(data));
          },
        );
        log('list_food_model = ${list_food_model}');
        Navigator.of(context).pop();
      },
    );
  }
}
