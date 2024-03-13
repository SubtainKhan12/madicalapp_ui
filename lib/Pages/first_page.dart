import 'package:flutter/material.dart';
import 'package:madicalapp_ui/Pages/home_page.dart';

class FirstPage extends StatefulWidget {
  const FirstPage({super.key});

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            SizedBox(
              height: 100,
            ),
            Container(
              color: Colors.blueGrey,
              height: 500,
              child: Image.asset(
                "lib/Doctors/doctor4.png",
                fit: BoxFit.fill,
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              margin: EdgeInsets.only(right: 80),
              child: Text(
                "All Spacialist in one App",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              margin: EdgeInsets.only(left: 10),
              child: Text(
                "Find your doctor and make an appointment on one tap",
                style: TextStyle(fontSize: 18),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => HomePage()));
              },
              child: Text("Start"),
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  fixedSize: Size(360, 50)),
            ),
          ],
        ));
  }
}
