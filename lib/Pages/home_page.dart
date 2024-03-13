import 'package:curved_labeled_navigation_bar/curved_navigation_bar.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar_item.dart';
import 'package:flutter/material.dart';
import 'package:madicalapp_ui/Pages/Doctorcard.dart';
import 'package:madicalapp_ui/Pages/catagorycard.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentindex = 0;
  void gotoPage(index) {
    setState(() {
      currentindex = index;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
          backgroundColor: Colors.deepPurple.shade100,
          onTap: (index)=>gotoPage(index),
          items: [
            CurvedNavigationBarItem(
              child: Icon(Icons.home),
            ),
            CurvedNavigationBarItem(
              child: Icon(Icons.chat),
            ),
            CurvedNavigationBarItem(
              child: Icon(Icons.notifications),
            ),
            CurvedNavigationBarItem(
              child: Icon(Icons.person),
            )
          ]),
      body: SafeArea(
        child: Column(
          children: [
            //app bar
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "hello,",
                        style: TextStyle(fontSize: 18),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Subtain Khan",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                        color: Colors.deepPurple[100],
                        borderRadius: BorderRadius.circular(12)),
                    child: InkWell(
                      onTap: () {
                        // Handle icon tap here
                        print('Icon tapped!');
                      },
                      child: Icon(
                        Icons.person_2_rounded,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.deepPurple.shade100,
                    borderRadius: BorderRadius.circular(12)),
                height: 150,
                child: Row(
                  children: [
                    // picture
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 100,
                        width: 100,
                        child: Image.asset(
                          "lib/Doctors/doctor.png",
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),

                    //text+ button

                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 15,
                          ),
                          Text(
                            "   How do you feel?",
                            style: TextStyle(fontSize: 20),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Text(
                            "   Fill out your medical card!",
                            style: TextStyle(fontSize: 15),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 10),
                            child: ElevatedButton(
                              onPressed: () {},
                              child: Text("Get Started"),
                              style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  fixedSize: Size(180, 50)),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),

            //searchbar
            Padding(
              padding: const EdgeInsets.only(top: 10, left: 25, right: 25),
              child: TextField(
                decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.search,
                      color: Colors.black38,
                    ),
                    hintText: "How can we help you ?",
                    hintStyle: TextStyle(color: Colors.black38),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12))),
              ),
            ),
            SizedBox(
              height: 20,
            ),

            //horizontal listview => doctor surgen etc
            Padding(
              padding: const EdgeInsets.only(left: 15.0),
              child: Container(
                  height: 80,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      CatagoryCard(
                        catagoryName: 'Dentist',
                        iconimagePath: 'lib/Doctors/tooth.png',
                      ),
                      CatagoryCard(
                        catagoryName: 'Pharmacist',
                        iconimagePath: 'lib/Doctors/drugs.png',
                      ),
                      CatagoryCard(
                        catagoryName: 'surgeon',
                        iconimagePath: 'lib/Doctors/doctor.png',
                      ),
                    ],
                  )),
            ),
            SizedBox(height: 5),

            //doctor list
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Doctor list",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  TextButton(
                      onPressed: () {},
                      child: Text(
                        'See all',
                        style: TextStyle(fontSize: 16, color: Colors.black54),
                      )),
                ],
              ),
            ),
            SizedBox(height: 5),
            Expanded(
                child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                DoctorCard(
                  IconImagepath: "lib/Doctors/doctor1.png",
                  rating: "4.5",
                  doctorname: 'Dr James Vince',
                  professsion: "sergeon, 13 y.e.",
                ),
                DoctorCard(
                  IconImagepath: "lib/Doctors/doctor2.png",
                  rating: "4.5",
                  doctorname: 'Mark Taylor',
                  professsion: "Physiotheripist, 12 y.e.",
                ),
                DoctorCard(
                  IconImagepath: "lib/Doctors/doctor3.png",
                  rating: "4.5",
                  doctorname: 'Dr Micheal Anderson',
                  professsion: "Pharmacist, 9 y.e.",
                ),
              ],
            ))
          ],
        ),
      ),
    );
  }
}
