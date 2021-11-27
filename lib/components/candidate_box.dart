import 'package:flutter/material.dart';

class CandidateBox extends StatelessWidget {
  const CandidateBox({
    Key? key,
    required this.candidateName,
  }) : super(key: key);
  final String candidateName;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: AnimatedContainer(
        decoration: const BoxDecoration(
          color: Colors.brown,
          borderRadius: BorderRadius.all(
            Radius.circular(15.0),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(3.0),
          child: Hero(
            tag: candidateName,
            child: ClipOval(
              child: Image.asset('images/$candidateName.jpg'),
            ),
          ),
        ),
        curve: Curves.bounceInOut,
        duration: const Duration(
          seconds: 1,
        ),
      ),
    );
  }
}
