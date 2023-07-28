import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tanbits_task/Utills/app_colors.dart';
import 'package:tanbits_task/Widgets/custom_text.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
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
                      showModelBottomSheet();
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
                itemCount: 10,
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
                                      color: Colors.blue,
                                      borderRadius:
                                          BorderRadius.circular(14.sp)),
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      CustomText(
                                        text: "Easy homemade",
                                        size: 15.sp,
                                        color: AppColors.blackColor,
                                        fontWeight: FontWeight.w600,
                                      )
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      CustomText(
                                        text: "beef burger",
                                        size: 15.sp,
                                        color: AppColors.blackColor,
                                        fontWeight: FontWeight.w600,
                                      ),
                                      SizedBox(
                                        width: 80.w,
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
                                  Row(
                                    children: [
                                      CircleAvatar(
                                        backgroundColor: AppColors.blackColor,
                                        radius: 12.sp,
                                      ),
                                      SizedBox(
                                        width: 4.w,
                                      ),
                                      CustomText(
                                        text: "James Spader",
                                        size: 14.sp,
                                        color: Colors.black38,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ],
                                  )
                                ],
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  //................Show Model Bottom Sheet....................//
  final Stream<QuerySnapshot> _usersStream =
      FirebaseFirestore.instance.collection('Categories').snapshots();

  Future showModelBottomSheet() {
    return showModalBottomSheet(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.sp),
                topRight: Radius.circular(20.sp))),
        context: context,
        builder: (context) {
          var textList = ['Break fast', 'Dinner', 'Lunch'];
          return StatefulBuilder(
            builder: (context, setState) {
              return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Column(
                    // mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    // crossAxisAlignment: CrossAxisAlignment.center,
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
                          Container(
                            height: 45.0.h,
                            child: StreamBuilder<QuerySnapshot>(
                              stream: _usersStream,
                              builder: (BuildContext context,
                                  AsyncSnapshot<QuerySnapshot> snapshot) {
                                if (snapshot.hasError) {
                                  return Text('Something went wrong');
                                }

                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return Text("Loading");
                                }

                                return ListView.builder(
                                  itemCount: snapshot.data!.docs.length,
                                  padding: EdgeInsets.zero,
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index) {
                                    DocumentSnapshot document =
                                        snapshot.data!.docs[index];
                                    Map<String, dynamic> data = document.data()!
                                        as Map<String, dynamic>;
                                    return Container(
                                      margin: EdgeInsets.symmetric(
                                          horizontal: 4.0.w),
                                      height: 50.0.h,
                                      decoration: BoxDecoration(
                                          color: AppColors.primaryColor,
                                          borderRadius:
                                              BorderRadius.circular(30.sp)),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 26),
                                        child: Builder(builder: (context) {
                                          return Center(
                                            child: CustomText(
                                              text: data['name'],
                                              color: Colors.white,
                                              size: 15.sp,
                                            ),
                                          );
                                        }),
                                      ),
                                    );
                                  },
                                );
                                // ListView(
                                //   children: snapshot.data!.docs
                                //       .map((DocumentSnapshot document) {
                                //     Map<String, dynamic> data =
                                //         document.data()! as Map<String, dynamic>;
                                //     log('${data}');
                                //     return ListTile(
                                //       title: Text(data['name']),
                                //     );
                                //   }).toList(),
                                // );
                              },
                            ),
                          ),

                          // Container(
                          //   height: 45.0.h,
                          //   width: MediaQuery.of(context).size.width,
                          //   child: ListView.builder(
                          //     itemCount: textList.length,
                          //     padding: EdgeInsets.zero,
                          //     scrollDirection: Axis.horizontal,
                          //     itemBuilder: (context, index) {
                          //       return Container(
                          //         margin:
                          //             EdgeInsets.symmetric(horizontal: 4.0.w),
                          //         height: 50.0.h,
                          //         decoration: BoxDecoration(
                          //             color: AppColors.primaryColor,
                          //             borderRadius:
                          //                 BorderRadius.circular(30.sp)),
                          //         child: Padding(
                          //           padding: const EdgeInsets.symmetric(
                          //               horizontal: 26),
                          //           child: Center(
                          //             child: CustomText(
                          //               text: textList[index],
                          //               color: Colors.white,
                          //               size: 15.sp,
                          //             ),
                          //           ),
                          //         ),
                          //       );
                          //     },
                          //   ),
                          // ),
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
                      GridView.builder(
                        shrinkWrap: true,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                crossAxisSpacing: 8.0,
                                mainAxisSpacing: 8.0,
                                childAspectRatio: 30 / 11),
                        itemCount: 6,
                        itemBuilder: (context, index) {
                          return Container(
                            decoration: BoxDecoration(
                                color: AppColors.primaryColor,
                                borderRadius: BorderRadius.circular(26.sp)),
                            child: Center(
                              child: CustomText(
                                text: "Vagitables",
                                size: 15.sp,
                                color: AppColors.whiteColor,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          );
                        },
                      ),
                      SizedBox(
                        height: 40.h,
                      ),
                      Container(
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
                      SizedBox(
                        height: 20.h,
                      ),
                      CustomText(
                        text: "Clear Filter",
                        color: AppColors.primaryColor,
                        size: 14.sp,
                        fontWeight: FontWeight.w400,
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                    ],
                  ));
            },
          );
        });
  }
}
