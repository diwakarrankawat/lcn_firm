import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lcn_firm/extras/extras.dart';
import 'package:lcn_firm/extras/texts.dart';
import 'package:lcn_firm/widgets/categories.dart';
import 'package:lcn_firm/widgets/service_card.dart';

class Layout1 extends StatelessWidget {
  final DataHolder services;
  final DataHolder categories;
  const Layout1({
    Key? key,
    required this.categories,
    required this.services,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Highest Rated
        const SizedBox(height: 20),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Highest Rated", style: TextStyles.sectionName),
              TextButton(
                onPressed: () {},
                child: const Text("View all"),
              )
            ],
          ),
        ),
        // Services
        SizedBox(
          height: 190,
          width: MediaQuery.of(context).size.width,
          child: ListView(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            children: [
              const SizedBox(width: 8),
              ...List.generate(
                  services.data?.length ?? 1,
                  (index) => services.data != null
                      ? ServiceCard(
                          name: services.data[index]["name"],
                          thumbnail: services.data[index]["thumbnail"],
                          location: services.data[index]["location"],
                          distance: services.data[index]["distance"],
                          rating: services.data[index]["rating"],
                        )
                      : Container(
                          width: MediaQuery.of(context).size.width - 16,
                          alignment: Alignment.center,
                          child: services.state == dataState.loading
                              ? Container(child: (Platform.isIOS ? const CupertinoActivityIndicator() : const CircularProgressIndicator()))
                              : Text(services.error?.toString() ?? "Unable to fetch data"),
                        ))
            ],
          ),
        ),

        // Categories
        const SizedBox(height: 15),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Categories", style: TextStyles.sectionName),
              TextButton(
                onPressed: () {},
                child: const Text("View all"),
              )
            ],
          ),
        ),
        // Data
        SizedBox(
          height: 112,
          width: MediaQuery.of(context).size.width,
          child: ListView(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            children: [
              const SizedBox(width: 10),
              ...List.generate(
                  categories.data?["data"]?.length ?? 1,
                  (index) => categories.data != null
                      ? CategoryCard(
                          name: categories.data["data"][index]['name']["EN"],
                          color: Color(int.parse(categories.data["data"][index]["bgcolor"])),
                          icon: categories.data["data"][index]["icon"],
                        )
                      : Container(
                          width: MediaQuery.of(context).size.width - 16,
                          alignment: Alignment.center,
                          child: categories.state == dataState.loading
                              ? Container(child: (Platform.isIOS ? const CupertinoActivityIndicator() : const CircularProgressIndicator()))
                              : Text(categories.error?.toString() ?? "Unable to fetch data"),
                        ))
            ],
          ),
        ),
      ],
    );
  }
}
