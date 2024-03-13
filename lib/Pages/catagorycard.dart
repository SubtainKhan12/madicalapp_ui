import 'package:flutter/material.dart';

class CatagoryCard extends StatelessWidget {
  final iconimagePath;
  final String catagoryName;

  CatagoryCard({
    required this.iconimagePath,
    required this.catagoryName,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.deepPurple.shade100,
        ),
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Row(children: [
            Image.asset(
              iconimagePath,
              height: 45,
            ),
            SizedBox(
              width: 10,
            ),
            Text(catagoryName),
          ]),
        ),
      ),
    );
  }
}
