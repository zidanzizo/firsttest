import 'dart:convert';
import 'package:firsttest/app/data/model/UserModel.dart';
import 'package:firsttest/app/routes/app_pages.dart';
import 'package:firsttest/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  final formKey = GlobalKey<FormState>();
  Widget header() {
    return Container(
      margin: EdgeInsets.only(
        top: defaultMargin,
        left: defaultMargin,
      ),
      child: Text(
        'My Contact',
        style: primaryTextStyle.copyWith(
          fontSize: 24,
          fontWeight: bold,
        ),
      ),
    );
  }

  Widget searchBar() {
    return Container(
      margin: EdgeInsets.all(defaultMargin),
      height: 50,
      padding: EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: thirdTextColor,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Center(
        child: Row(
          children: [
            Icon(
              CupertinoIcons.search,
              color: primaryTextColor,
            ),
            SizedBox(width: 16),
            Expanded(
              child: Form(
                key: formKey,
                child: TextFormField(
                  textInputAction: TextInputAction.search,
                  controller: controller.textEditingController,
                  style: primaryTextStyle,
                  textCapitalization: TextCapitalization.sentences,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                  decoration: InputDecoration.collapsed(
                    hintText: 'Search',
                    hintStyle: primaryTextStyle,
                  ),
                  onFieldSubmitted: (value) {},
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget recentComponent() {
    return Container(
      margin: EdgeInsets.only(left: defaultMargin),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Recent',
            style: primaryTextStyle.copyWith(
              fontSize: 18,
              fontWeight: bold,
            ),
          ),
          SizedBox(
            height: 12,
          ),
          Container(
            height: 130,
            ////// todo list
          )
        ],
      ),
    );
  }

  Widget bodyHeader(String total) {
    return Container(
      margin: EdgeInsets.only(left: defaultMargin, right: defaultMargin, top: defaultMargin),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Friends ($total)',
                style: primaryTextStyle.copyWith(
                  fontSize: 18,
                  fontWeight: bold,
                ),
              ),
              TextButton(
                onPressed: () {},
                child: Text(
                  'Show All',
                  style: primaryTextStyle.copyWith(
                    decoration: TextDecoration.underline,
                    fontSize: 18,
                    fontWeight: bold,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget body() {
    return FutureBuilder<List<Results>?>(
        future: controller.getFriends(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (!snapshot.hasData) {
            return Center(
              child: Text(
                'No Data Found',
                style: primaryTextStyle,
              ),
            );
          } else {
            List<Results>? data = snapshot.data;
            return Column(
              children: [
                bodyHeader(snapshot.data!.length.toString()),
                ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: 20,
                  padding: EdgeInsets.symmetric(horizontal: defaultMargin),
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    Results results = data![index];
                    return InkWell(
                      onTap: () {},
                      child: Container(
                        margin: EdgeInsets.symmetric(vertical: 10),
                        child: Row(
                          children: [
                            Container(
                              height: 70,
                              width: 70,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  image: NetworkImage(results.picture!.medium!),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              flex: 4,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    results.name!.first!,
                                    style: primaryTextStyle.copyWith(
                                      fontSize: 16,
                                      fontWeight: medium,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    results.email!,
                                    style: secondaryTextStyle.copyWith(
                                      fontSize: 14,
                                      fontWeight: medium,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ],
            );
          }
        });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: bgColor1,
      child: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              header(),
              searchBar(),
              recentComponent(),
              body(),
            ],
          ),
        ),
      ),
    );
  }
}
