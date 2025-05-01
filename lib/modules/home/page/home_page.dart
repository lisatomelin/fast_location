import 'dart:html';
import 'dart:ui';

import 'package:fast_location/shared/colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:fast_location/modules/home/page/result.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var heightMedia = size.height;
    var widthMedia = size.width;

    return Scaffold(
        backgroundColor: AppColors.appPageBackground,
        body: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Icon(size: 30, color: Colors.green, Icons.multiple_stop),
                Text("Fast Location",
                    style: TextStyle(
                        color: Colors.green,
                        fontSize: 30,
                        fontWeight: FontWeight.bold)),
              ]),
              Container(
                  width: widthMedia * 0.8,
                  height: heightMedia * 0.2,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(color: AppColors.appBarContainer, blurRadius: 7)
                    ],
                    borderRadius: BorderRadius.circular(15),
                    color: AppColors.appBarContainer,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(size: 60, color: Colors.green, Icons.directions),
                      Text("Faça uma busca",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 25,
                              fontWeight: FontWeight.bold))
                    ],
                  )),
              ElevatedButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return WidgetAlert(context, "Digite o CEP");
                        });
                  },
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.green),
                      minimumSize:
                          MaterialStateProperty.all(Size(widthMedia * 0.8, 15)),
                      padding: MaterialStateProperty.all<EdgeInsets>(
                          EdgeInsets.all(heightMedia * 0.02))),
                  child: Text("Localizar endereço",
                      style: TextStyle(
                          color: Colors.white, fontSize: heightMedia * 0.03))),
              Row(
                children: [
                  Icon(size: 20, color: Colors.green, Icons.place),
                  Text("Últimas localizações",
                      style: TextStyle(
                          color: Colors.green,
                          fontSize: 20,
                          fontWeight: FontWeight.bold))
                ],
                mainAxisAlignment: MainAxisAlignment.center,
              ),
              ElevatedButton(
                  onPressed: null,
                  style: ButtonStyle(
                      minimumSize:
                          MaterialStateProperty.all(Size(widthMedia * 0.8, 15)),
                      backgroundColor: MaterialStateProperty.all(Colors.green),
                      padding: MaterialStateProperty.all<EdgeInsets>(
                          EdgeInsets.all(heightMedia * 0.02))),
                  child: Text("Histórico de endereços",
                      style: TextStyle(
                          color: Colors.white, fontSize: heightMedia * 0.03)))
            ])),
        bottomNavigationBar: Container(
            decoration: BoxDecoration(color: Colors.green),
            child: IconButton(
                onPressed: null,
                icon: Icon(
                    size: 50,
                    color: Colors.white,
                    Icons.assistant_direction))));
  }
}
