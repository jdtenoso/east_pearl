import 'package:east_pearl/components/candidate_box.dart';
import 'package:east_pearl/components/candidate_votes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:east_pearl/components/candidates.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:local_auth/local_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StatsScreen extends StatefulWidget {
  static const String id = 'stats_screen';

  const StatsScreen({Key? key}) : super(key: key);
  @override
  _StatsScreenState createState() => _StatsScreenState();
}

class _StatsScreenState extends State<StatsScreen> {
  final Future<SharedPreferences> _preferences =
      SharedPreferences.getInstance();

  late Future<String> _votedName;
  String votedName = '';

  Future<void> _setVotedName(String string) async {
    final SharedPreferences prefs = await _preferences;
    final String voted = string;
    setState(() {
      _votedName = prefs.setString('voteStatus3', voted).then((bool value) {
        return voted;
      });
    });
  }

  // Define an async function to initialize FlutterFire
  void initializeFlutterFire() async {
    try {
      // Wait for Firebase to initialize and set `_initialized` state to true
      await Firebase.initializeApp();
      setState(() {});
    } catch (e) {
      // Set `_error` state to true if Firebase initialization fails
      setState(() {});
    }
  }

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  List<CandidateVotes> getCandidateVotes() {
    Map<String, int> candidateVotes = {
      'bongbong': bongbongList.length,
      'bonggo': bonggoList.length,
      'isko': iskoList.length,
      'leni': leniList.length,
      'pacman': pacmanList.length,
      'ping': pingList.length,
    };
    List<CandidateVotes> candidatesTextItems = [];

    for (String candidates in candidateNames) {
      candidatesTextItems.add(CandidateVotes(
        candidateName: candidates,
        candidateVotes: candidateVotes[candidates],
      ));
    }
    return candidatesTextItems;
  }

  List<Text> getCandidateItems() {
    List<Text> currencyTextItems = [];
    for (String currency in candidateNames) {
      currencyTextItems.add(Text(
        currency,
      ));
    }
    return currencyTextItems;
  }

  @override
  void initState() {
    initializeFlutterFire();
    votesStream();
    super.initState();
    _votedName = _preferences.then((SharedPreferences prefs) {
      votedName = prefs.getString('voteStatus3') ?? 'noone';
      return prefs.getString('voteStatus3') ?? 'noone';
    });
  }

  int voteCount = 0;
  List<String> bongbongList = [];
  List<String> bonggoList = [];
  List<String> iskoList = [];
  List<String> leniList = [];
  List<String> pacmanList = [];
  List<String> pingList = [];
  void clearList() {
    bongbongList.clear();
    bonggoList.clear();
    iskoList.clear();
    leniList.clear();
    pacmanList.clear();
    pingList.clear();
  }

  void votesStream() async {
    await for (var votes in firestore.collection('votes').snapshots()) {
      clearList();
      for (var vote in votes.docs) {
        switch (vote.data().values.last) {
          case 'bongbong':
            {
              bongbongList.add(vote.data().values.last);

              break;
            }

          case 'bonggo':
            {
              bonggoList.add(vote.data().values.last);
              break;
            }
          case 'isko':
            {
              iskoList.add(vote.data().values.last);
              break;
            }
          case 'leni':
            {
              leniList.add(vote.data().values.last);
              break;
            }
          case 'pacman':
            {
              pacmanList.add(vote.data().values.last);
              break;
            }
          case 'ping':
            {
              pingList.add(vote.data().values.last);
              break;
            }

          default:
        }
        setState(() {
          voteCount++;
        });
        print('$voteCount ${vote.data().values.last}');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Stats',
      theme: ThemeData.dark(),
      home: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            actions: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Colors.blueGrey)),
                  onPressed: () async {
                    int candidateNumber = 0;

                    if (await _votedName == 'noone') {
                      final result = await Navigator.push(
                        context,
                        CupertinoModalPopupRoute(
                          builder: (context) => AlertDialog(
                            actions: [
                              TextButton(
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      Colors.redAccent),
                                ),
                                onPressed: () {
                                  Navigator.pop(context, 'Cancel');
                                },
                                child: const Text(
                                  'Cancel',
                                  style: TextStyle(
                                    color: Colors.white70,
                                  ),
                                ),
                              ),
                              TextButton(
                                autofocus: false,
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      Colors.blueGrey),
                                ),
                                onPressed: () {
                                  clearList();
                                  voteCount = 0;

                                  Navigator.pop(context, 'Yes');
                                },
                                child: const Text(
                                  'VOTE',
                                  style: TextStyle(
                                    color: Colors.white70,
                                  ),
                                ),
                              ),
                            ],
                            actionsAlignment: MainAxisAlignment.spaceEvenly,
                            content: CupertinoPicker(
                              itemExtent: 30.0,
                              onSelectedItemChanged: (int value) {
                                candidateNumber = value;
                              },
                              children: getCandidateItems(),
                            ),
                          ),
                        ),
                      );

                      if (result == 'Yes') {
                        firestore.collection('votes').add({
                          'voter': 'joker',
                          'vote': candidateNames[candidateNumber],
                        });
                        _setVotedName(candidateNames[candidateNumber]);
                      }
                    } else {
                      final result = await Navigator.push(
                        context,
                        CupertinoModalPopupRoute(
                          builder: (context) => AlertDialog(
                            title: const Text('You Voted for:'),
                            content: CandidateBox(
                              candidateName: votedName,
                            ),
                            actions: [
                              TextButton(
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      Colors.redAccent),
                                ),
                                onPressed: () {
                                  Navigator.pop(context, 'OK');
                                },
                                child: const Text(
                                  'OK',
                                  style: TextStyle(
                                    color: Colors.white70,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                      print(await _votedName);
                      votedName = await _votedName;
                    }
                  },
                  child: const Text(
                    'VOTE',
                    style: TextStyle(
                      color: Colors.white70,
                    ),
                  ),
                ),
              ),
            ],
            title: const Text(
              'EAST PEARL',
              style: TextStyle(
                color: Colors.white70,
                fontSize: 20.0,
              ),
            ),
          ),
          body: Column(
            children: getCandidateVotes(),
          ),
        ),
      ),
    );
  }
}
