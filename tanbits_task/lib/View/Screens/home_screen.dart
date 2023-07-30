import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:tanbits_task/Models/food_model.dart';
import 'package:tanbits_task/Provider/home_provider.dart';
import 'package:tanbits_task/Utills/app_colors.dart';
import 'package:tanbits_task/Widgets/custom_text.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  void initState() {
    final homeProvider = Provider.of<HomeProvider>(context, listen: false);
    FirebaseFirestore.instance
        .collection('FoodList')
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        DocumentSnapshot document = doc;
        Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
        homeProvider.list_food_model.add(FoodModel.fromJson(data));
      });
      log('list_food_model = ${homeProvider.list_food_model}');
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final homeProvider = Provider.of<HomeProvider>(context);
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        backgroundColor: AppColors.whiteColor,
        elevation: 0.0,
        centerTitle: true,
        iconTheme: const IconThemeData(color: AppColors.blackColor),
        title: CustomText(
          text: "Search",
          color: AppColors.blackColor,
          fontWeight: FontWeight.bold,
          size: 20.sp,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            children: [
              SizedBox(
                height: 20.h,
              ),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 50.h,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.black26),
                          borderRadius: BorderRadius.circular(12.sp)),
                      child: TextFormField(
                        controller: homeProvider.controller,
                        onChanged: (value) {
                          if (value.isNotEmpty) {
                            setState(() {
                              homeProvider.showFilteredList = true;
                              homeProvider.filteredList.clear();
                            });
                            for (var i = 0;
                                i < homeProvider.list_food_model.length;
                                i++) {
                              if (homeProvider.list_food_model[i].name!
                                  .toLowerCase()
                                  .contains(homeProvider.controller.text
                                      .toLowerCase())) {
                                setState(() {
                                  homeProvider.filteredList
                                      .add(homeProvider.list_food_model[i]);
                                });
                              }
                            }
                          } else {
                            setState(() {
                              homeProvider.showFilteredList = false;
                            });
                          }
                        },
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.only(
                                left: 10.w, bottom: 0, top: 12.h),
                            prefixIcon: Icon(
                              Icons.search_outlined,
                              color: AppColors.labelColor,
                              size: 28.sp,
                            ),
                            hintText: 'Search Product',
                            hintStyle: TextStyle(
                                fontSize: 15.sp,
                                color: Colors.black38,
                                fontWeight: FontWeight.w400)),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 8.w,
                  ),
                  GestureDetector(
                    onTap: () {
                      showModelBottomSheet(homeProvider);
                    },
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                          color: AppColors.primaryColor,
                          borderRadius: BorderRadius.circular(16.sp)),
                      width: 50,
                      child: const Center(
                        child: Icon(
                          Icons.format_list_bulleted_rounded,
                          color: AppColors.whiteColor,
                        ),
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 10.h,
              ),
              ListView.builder(
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                physics: const NeverScrollableScrollPhysics(),
                scrollDirection: Axis.vertical,
                itemCount: homeProvider.showFilteredList
                    ? homeProvider.filteredList.length
                    : homeProvider.list_food_model.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: 10.h),
                    child: Container(
                      height: 120.h,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          color: AppColors.whiteColor,
                          boxShadow: [
                            BoxShadow(
                                blurRadius: 2,
                                spreadRadius: 3,
                                color:
                                    AppColors.primaryColor.withOpacity(0.090))
                          ],
                          borderRadius: BorderRadius.circular(12.sp)),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10.w, vertical: 10.h),
                                child: Container(
                                  height: 100.h,
                                  width: 110.w,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(14.sp),
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10.sp),
                                    child: Image.network(
                                      homeProvider.showFilteredList
                                          ? homeProvider
                                              .filteredList[index].imagePath!
                                          : homeProvider.list_food_model[index]
                                              .imagePath!,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width: 160,
                                        child: CustomText(
                                          text: homeProvider.showFilteredList
                                              ? homeProvider
                                                  .filteredList[index].name
                                              : homeProvider
                                                  .list_food_model[index].name,
                                          maxline: 2,
                                          overflow: TextOverflow.ellipsis,
                                          size: 15.sp,
                                          color: AppColors.blackColor,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      Container(
                                        height: 30.h,
                                        width: 30.w,
                                        decoration: BoxDecoration(
                                            color: AppColors.blackColor,
                                            borderRadius:
                                                BorderRadius.circular(8.sp)),
                                        child: Center(
                                          child: Icon(
                                            Icons.arrow_forward,
                                            size: 20.sp,
                                            color: Colors.white,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                  CustomText(
                                    text: homeProvider.showFilteredList
                                        ? homeProvider.filteredList[index].chef
                                        : homeProvider
                                            .list_food_model[index].chef,
                                    size: 14.sp,
                                    color: Colors.black38,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ],
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  //................Show Model Bottom Sheet....................//

  Future showModelBottomSheet(HomeProvider homeProvider) {
    return showModalBottomSheet(
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.sp),
                topRight: Radius.circular(20.sp))),
        context: context,
        builder: (context) {
          return StatefulBuilder(
            builder: (context, setState) {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    SizedBox(
                      height: 30.h,
                    ),
                    CustomText(
                      text: "Filter",
                      size: 16.sp,
                      color: AppColors.blackColor,
                      fontWeight: FontWeight.w600,
                    ),
                    SizedBox(
                      height: 30.h,
                    ),
                    Column(
                      children: [
                        Row(
                          children: [
                            CustomText(
                              text: "Category",
                              size: 15.sp,
                              color: AppColors.blackColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        SizedBox(
                          height: 45.0.h,
                          child: StreamBuilder<QuerySnapshot>(
                            stream: homeProvider.categoryType,
                            builder: (BuildContext context,
                                AsyncSnapshot<QuerySnapshot> snapshot) {
                              if (snapshot.hasError) {
                                return const Text('Something went wrong');
                              }
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const Text("Loading..");
                              }

                              return ListView.builder(
                                itemCount: snapshot.data!.docs.length,
                                padding: EdgeInsets.zero,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  DocumentSnapshot document =
                                      snapshot.data!.docs[index];
                                  Map<String, dynamic> data =
                                      document.data()! as Map<String, dynamic>;
                                  return InkWell(
                                    onTap: () {
                                      homeProvider.selected_cat = data['id'];
                                      setState(() {});
                                    },
                                    child: Container(
                                      margin: EdgeInsets.symmetric(
                                          horizontal: 4.0.w),
                                      height: 50.0.h,
                                      decoration: BoxDecoration(
                                          color: homeProvider.selected_cat ==
                                                  data['id']
                                              ? Colors.black
                                              : AppColors.primaryColor,
                                          borderRadius:
                                              BorderRadius.circular(30.sp)),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 26),
                                        child: Builder(
                                          builder: (context) {
                                            return Center(
                                              child: CustomText(
                                                text: data['name'],
                                                color: Colors.white,
                                                size: 15.sp,
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Row(
                      children: [
                        CustomText(
                          text: "Recipe Type",
                          size: 15.sp,
                          color: AppColors.blackColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    StreamBuilder<QuerySnapshot>(
                      stream: homeProvider.recipeType,
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.hasError) {
                          return const Text('Something went wrong');
                        }

                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Text("Loading..");
                        }

                        return GridView.builder(
                          shrinkWrap: true,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  crossAxisSpacing: 8.0,
                                  mainAxisSpacing: 8.0,
                                  childAspectRatio: 30 / 11),
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            DocumentSnapshot document =
                                snapshot.data!.docs[index];
                            Map<String, dynamic> data =
                                document.data()! as Map<String, dynamic>;
                            return InkWell(
                              onTap: () {
                                homeProvider.selected_recipe = data['id'];
                                setState(() {});
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    color: homeProvider.selected_recipe ==
                                            data['id']
                                        ? Colors.black
                                        : AppColors.primaryColor,
                                    borderRadius: BorderRadius.circular(26.sp)),
                                child: Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 16.w),
                                  child: Center(
                                    child: CustomText(
                                      textAlign: TextAlign.center,
                                      text: data['name'],
                                      size: 12.sp,
                                      color: AppColors.whiteColor,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Row(
                      children: [
                        CustomText(
                          text: "Chef",
                          size: 15.sp,
                          color: AppColors.blackColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    SizedBox(
                      height: 45.0.h,
                      child: StreamBuilder<QuerySnapshot>(
                        stream: homeProvider.sheffType,
                        builder: (BuildContext context,
                            AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (snapshot.hasError) {
                            return const Text('Something went wrong');
                          }
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Text("Loading..");
                          }

                          return ListView.builder(
                            itemCount: snapshot.data!.docs.length,
                            padding: EdgeInsets.zero,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              DocumentSnapshot document =
                                  snapshot.data!.docs[index];
                              Map<String, dynamic> data =
                                  document.data()! as Map<String, dynamic>;
                              return InkWell(
                                onTap: () {
                                  homeProvider.selected_chef = data['name'];
                                  setState(() {});
                                },
                                child: Container(
                                  margin:
                                      EdgeInsets.symmetric(horizontal: 4.0.w),
                                  height: 50.0.h,
                                  decoration: BoxDecoration(
                                      color: homeProvider.selected_chef ==
                                              data['name']
                                          ? Colors.black
                                          : AppColors.primaryColor,
                                      borderRadius:
                                          BorderRadius.circular(30.sp)),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 26),
                                    child: Builder(
                                      builder: (context) {
                                        return Center(
                                          child: CustomText(
                                            text: data['name'],
                                            color: Colors.white,
                                            size: 15.sp,
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ),
                    SizedBox(
                      height: 40.h,
                    ),
                    InkWell(
                      onTap: () async {
                        homeProvider.list_food_model = [];
                        homeProvider.filterApply();
                        Navigator.of(context).pop();
                      },
                      child: Container(
                        height: 55.h,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            color: AppColors.primaryColor,
                            borderRadius: BorderRadius.circular(15.sp)),
                        child: Center(
                          child: CustomText(
                            text: "Apply Filter",
                            size: 14.sp,
                            color: Colors.white,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    InkWell(
                      onTap: () {
                        homeProvider.list_food_model = [];
                        homeProvider.clearFilter(context);
                      },
                      child: CustomText(
                        text: "Clear Filter",
                        color: AppColors.primaryColor,
                        size: 14.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                  ],
                ),
              );
            },
          );
        }).then((value) {
      setState(() {});
    });
  }
}
