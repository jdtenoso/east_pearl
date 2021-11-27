// import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:east_pearl/screens/stats_screen.dart';
import 'package:east_pearl/components/expanded_row.dart';

class WelcomeScreen extends StatefulWidget {
  static const String id = 'welcome_screen';
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  String name = 'default';
  double radius = 100.0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'east pearl',
      theme: ThemeData.dark(),
      home: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: const Text(
              'EAST PEARL',
              style: TextStyle(
                color: Colors.white70,
                fontSize: 20.0,
              ),
            ),
          ),
          body: Column(
            children: [
              const ExpandedRow(
                candidate1: 'bongbong',
                candidate2: 'bonggo',
              ),
              const ExpandedRow(
                candidate1: 'isko',
                candidate2: 'leni',
              ),
              const ExpandedRow(
                candidate1: 'pacman',
                candidate2: 'ping',
              ),
              Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: AnimatedContainer(
                      color: Colors.blueGrey,
                      width: double.maxFinite,
                      duration: const Duration(seconds: 1),
                      child: TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, StatsScreen.id);
                        },
                        child: const Text(
                          'Check Votes',
                          style: TextStyle(
                            color: Colors.white70,
                          ),
                        ),
                      ),
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
