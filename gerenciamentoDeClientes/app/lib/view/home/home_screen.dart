import 'package:auth_migration/view/peca/peca_list.dart';
import 'package:auth_migration/widgets/sidebar_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../shared/widgets/NavBarWidget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key, int? cla}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const NavbarWidget(),
      drawer: const Sidebar(),
      body: Container(
        margin: const EdgeInsets.only(left: 50, right: 50),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Stack(
                children: [
                  Image.network(
                    'https://cdn.pixabay.com/photo/2017/03/31/17/44/avatar-2191932_1280.png',
                    fit: BoxFit.cover,
                  ),

                  // Add other widgets on top of the background image here
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
