import 'package:flutter/material.dart';

class DoctorCard extends StatelessWidget {
  final IconImagepath;
  final String rating;
  final String doctorname;
  final String professsion;
  DoctorCard({
    required this.IconImagepath,
    required this.rating,
    required this.doctorname,
    required this.professsion,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 20.0,
        bottom: 25,
      ),
      child:SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.deepPurple.shade100,
          ),
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: Image.asset(
                  IconImagepath,
                  height: 100,
                ),
              ),
              Row(
                children: [
                  Icon(
                    Icons.star,
                    color: Colors.yellow[500],
                  ),
                  Text(
                    rating,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                doctorname,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Text(professsion),
            ],
          ),
        ),
      ),
    );
  }
}
