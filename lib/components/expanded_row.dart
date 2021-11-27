import 'package:flutter/material.dart';
import 'candidate_box.dart';

class ExpandedRow extends StatelessWidget {
  const ExpandedRow({
    Key? key,
    required this.candidate1,
    required this.candidate2,
  }) : super(key: key);
  final String candidate1;
  final String candidate2;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 3,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          CandidateBox(
            candidateName: candidate1,
          ),
          CandidateBox(
            candidateName: candidate2,
          ),
        ],
      ),
    );
  }
}
