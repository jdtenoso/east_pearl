import 'package:flutter/material.dart';

class CandidateVotes extends StatelessWidget {
  const CandidateVotes({
    Key? key,
    required this.candidateName,
    required this.candidateVotes,
  }) : super(key: key);
  final String candidateName;
  final int? candidateVotes;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(
          8.0,
          8.0,
          4.0,
          4.0,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            AnimatedContainer(
              duration: const Duration(seconds: 1),
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
            ),
            AnimatedContainer(
              alignment: Alignment.center,
              height: double.maxFinite,
              // width: numberOfVotes,
              duration: const Duration(seconds: 1),
              decoration: const BoxDecoration(
                color: Colors.brown,
                borderRadius: BorderRadius.all(
                  Radius.circular(15.0),
                ),
              ),
              child: Text(
                candidateVotes.toString(),
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 40.0,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
