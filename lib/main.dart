import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lcn_firm/api/worker.dart';
import 'package:lcn_firm/categories_services.dart';
import 'package:lcn_firm/extras/colors.dart';
import 'package:lcn_firm/extras/extras.dart';
import 'package:lcn_firm/extras/texts.dart';
import 'package:lcn_firm/form.dart';
import 'package:lcn_firm/widgets/categories.dart';
import 'package:lcn_firm/widgets/service_card.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LCN Firm',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // initial data
  DataHolder services = DataHolder();
  DataHolder categories = DataHolder();

  // controllers

  @override
  void initState() {
    // Change Statusbar Color
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle.light.copyWith(
        statusBarColor: WidgetColors.statusBar,
      ),
    );

    // fetch data
    getServices();
    getCategories();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SafeArea(
            child: Column(
              children: [
                Container(
                  height: 100,
                  padding: const EdgeInsets.all(10),
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        WidgetColors.grad1,
                        WidgetColors.grad2,
                        WidgetColors.grad3,
                      ],
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(width: 150, child: Image.asset('assets/images/logo.png')),
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.notifications,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      const Text(
                        "Pikashi Jain",
                        style: TextStyle(color: Colors.white),
                      ),
                      Row(
                        children: const [
                          Icon(
                            Icons.location_on_outlined,
                            color: Colors.white,
                            size: 15,
                          ),
                          Text(
                            "Time Square Plaza, New York",
                            style: TextStyles.categoryName,
                          )
                        ],
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: LayoutBuilder(builder: (context, constraints) {
                    return constraints.maxWidth < 700
                        ? SingleChildScrollView(
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Layout1(categories: categories, services: services),
                                const Divider(),
                                const FormLayout(),
                              ],
                            ),
                          )
                        : Row(
                            children: [
                              Expanded(
                                  child: SingleChildScrollView(
                                child: Layout1(
                                  categories: categories,
                                  services: services,
                                ),
                              )),
                              Container(
                                height: MediaQuery.of(context).size.height,
                                width: 1,
                                margin: const EdgeInsets.all(10),
                                color: Colors.black45,
                              ),
                              const SizedBox(
                                width: 300,
                                child: SingleChildScrollView(child: FormLayout()),
                              ),
                            ],
                          );
                  }),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // api calls with functions

  void getServices() async {
    try {
      List<Map> data = await Api.temp();
      services.loaded(data);
    } catch (e) {
      services.failed(e);
    }
    setState(() {});
  }

  void getCategories() async {
    try {
      var data = await Api.getCategories();
      categories.loaded(data);
    } catch (e) {
      categories.failed(e);
    }
    setState(() {});
  }
}
