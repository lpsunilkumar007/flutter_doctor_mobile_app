import 'dart:async';
import 'package:flutter/material.dart';
import 'package:hospital/res/doctor_model.dart';
import 'package:hospital/screens/DoctorAppointment.dart';
import 'package:hospital/screens/SeeAll.dart';
import 'package:hospital/res/lists.dart';
import 'package:hospital/widgets/text_widget.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var opacity = 0.0;
  bool position = false;
  final userService = UserService();
  final doctorAppointment = DoctorAppointment();
  int todayAppointment = 0;
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      animator();
      fetchData();
      setState(() {});
    });
  }

  DateTime currentdatecount = DateTime.now();
  Future<void> fetchData() async {
    await userService.getData();
    await doctorAppointment.getData();
    setState(() {});
  }

  animator() {
    if (opacity == 1) {
      opacity = 0;
      position = false;
    } else {
      opacity = 1;
      position = true;
    }
    setState(() {});
  }

  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    Home(),
    DoctorAppointments(),
    Text(
      'Index 2: ',
      style: optionStyle,
    ),
    Text(
      'Index 3: ',
      style: optionStyle,
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: Colors.white,
          padding: const EdgeInsets.only(top: 30, left: 0, right: 0),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Stack(
            children: [
              AnimatedPositioned(
                duration: const Duration(milliseconds: 400),
                top: position ? 1 : 100,
                right: 20,
                left: 20,
                child: AnimatedOpacity(
                  duration: const Duration(milliseconds: 400),
                  opacity: opacity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextWidget("Hello", 17, Colors.black.withOpacity(.7),
                              FontWeight.bold),
                          TextWidget(
                              "${userService.userProfile?[2].firstName ?? ""} ${userService.userProfile?[2].lastName ?? ""}",
                              25,
                              Colors.black,
                              FontWeight.bold),
                        ],
                      ),
                      // const Icon(Icons.phonelink_ring)
                    ],
                  ),
                ),
              ),
              // AnimatedPositioned(
              //   top: position ? 80 : 140,
              //   left: 20,
              //   right: 20,
              //   duration: const Duration(milliseconds: 400),
              //   child: AnimatedOpacity(
              //     duration: const Duration(milliseconds: 400),
              //     opacity: opacity,
              //     child: Container(
              //       height: 50,
              //       width: double.infinity,
              //       decoration: BoxDecoration(
              //         color: Colors.white,
              //         borderRadius: BorderRadius.circular(15),
              //       ),
              //       child: TextFormField(
              //         decoration: InputDecoration(
              //             border: InputBorder.none,
              //             prefixIcon: Icon(
              //               Icons.search_sharp,
              //               size: 30,
              //               color: Colors.black.withOpacity(.5),
              //             ),
              //             hintText: "   Search"),
              //       ),
              //     ),
              //   ),
              // ),
              AnimatedPositioned(
                  top: position ? 80 : 140,
                  right: 20,
                  left: 20,
                  duration: const Duration(milliseconds: 400),
                  child: AnimatedOpacity(
                    duration: const Duration(milliseconds: 400),
                    opacity: opacity,
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      child: Container(
                        height: 130,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Colors.green.shade700,
                                  Colors.green.shade500,
                                  Colors.green.shade300,
                                ])),
                        child: Stack(
                          children: [
                            Positioned(
                                top: 25,
                                left: 20,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        position = false;
                                        opacity = 0;
                                        setState(() {});
                                        Timer(
                                          const Duration(milliseconds: 400),
                                          () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      const DoctorAppointments(),
                                                ));
                                          },
                                        );
                                      },
                                      child: const CircleAvatar(
                                        backgroundColor: Colors.white,
                                        radius: 30,
                                        child: Center(
                                          child: Image(
                                            fit: BoxFit.fill,
                                            image: AssetImage(
                                                'assets/images/doctor3.png'),
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    InkWell(
                                        onTap: () {
                                          position = false;
                                          opacity = 0;
                                          setState(() {});
                                          Timer(
                                            const Duration(milliseconds: 400),
                                            () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        const DoctorAppointments(),
                                                  ));
                                            },
                                          );
                                        },
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                TextWidget(
                                                  "${userService.userProfile?[2].firstName ?? ""} ${userService.userProfile?[2].lastName ?? ""}",
                                                  18,
                                                  Colors.white,
                                                  FontWeight.bold,
                                                  letterSpace: 0,
                                                ),
                                              ],
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                TextWidget(
                                                  "Today's Appointment :",
                                                  16,
                                                  Colors.white,
                                                  FontWeight.bold,
                                                  letterSpace: 0,
                                                ),
                                                TextWidget(
                                                  "5",
                                                  16,
                                                  Colors.white,
                                                  FontWeight.normal,
                                                  letterSpace: 0,
                                                ),
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                TextWidget(
                                                  "Upcoming Appointment :",
                                                  16,
                                                  Colors.white,
                                                  FontWeight.bold,
                                                  letterSpace: 0,
                                                ),
                                                TextWidget(
                                                  "3",
                                                  16,
                                                  Colors.white,
                                                  FontWeight.normal,
                                                  letterSpace: 0,
                                                ),
                                              ],
                                            ),
                                          ],
                                        ))
                                  ],
                                )),
                            // Positioned(
                            //     top: 100,
                            //     left: 20,
                            //     child: Container(
                            //       height: 1,
                            //       width: 300,
                            //       color: Colors.white.withOpacity(.5),
                            //     )),
                            // Positioned(
                            //     top: 115,
                            //     left: 20,
                            //     right: 1,
                            //     child: Container(
                            //       width: double.infinity,
                            //       child: Row(
                            //         children: [
                            //           TextWidget(
                            //               "120K people join live Stream!",
                            //               15,
                            //               Colors.white,
                            //               FontWeight.bold,
                            //               letterSpace: 1),
                            //           const SizedBox(
                            //             width: 10,
                            //           ),
                            //           const Expanded(
                            //             child: Stack(
                            //               children: [
                            //                 Positioned(
                            //                   child: CircleAvatar(
                            //                     radius: 15,
                            //                     backgroundColor: Colors.blue,
                            //                   ),
                            //                 ),
                            //                 Positioned(
                            //                   left: 20,
                            //                   child: CircleAvatar(
                            //                     radius: 15,
                            //                     backgroundColor: Colors.red,
                            //                   ),
                            //                 ),
                            //                 Positioned(
                            //                   left: 40,
                            //                   child: CircleAvatar(
                            //                     radius: 15,
                            //                     backgroundColor: Colors.white,
                            //                   ),
                            //                 )
                            //               ],
                            //             ),
                            //           )
                            //         ],
                            //       ),
                            //     )),
                            // const Positioned(
                            //     top: 10,
                            //     right: 10,
                            //     child: Icon(
                            //       Icons.close_outlined,
                            //       color: Colors.white,
                            //       size: 15,
                            //     ))
                          ],
                        ),
                      ),
                    ),
                  )),
              categoryRow(),
              AnimatedPositioned(
                  top: position ? 400 : 500,
                  left: 20,
                  right: 20,
                  duration: const Duration(milliseconds: 400),
                  child: AnimatedOpacity(
                    duration: const Duration(milliseconds: 300),
                    opacity: opacity,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextWidget(
                          "Our Doctors",
                          25,
                          Colors.black.withOpacity(.8),
                          FontWeight.bold,
                          letterSpace: 0,
                        ),
                        InkWell(
                            onTap: () async {
                              animator();
                              setState(() {});
                              // Timer(Duration(seconds: 1),() {
                              //   Navigator.push(context, MaterialPageRoute(builder: (context) => SeeAll(),));
                              //   animator();
                              // },);
                              await Future.delayed(
                                  const Duration(milliseconds: 500));
                              await Navigator.push(context, MaterialPageRoute(
                                builder: (context) {
                                  return const SeeAll();
                                },
                              ));

                              setState(() {
                                animator();
                              });
                            },
                            child: TextWidget(
                              "See all",
                              15,
                              Colors.green.shade600.withOpacity(.8),
                              FontWeight.bold,
                              letterSpace: 0,
                            )),
                      ],
                    ),
                  )),
              doctorList(),
              Align(
                  alignment: Alignment.bottomCenter,
                  child: AnimatedOpacity(
                    duration: const Duration(milliseconds: 400),
                    opacity: opacity,
                    child: CurvedNavigationBar(
                      backgroundColor: Colors.white,
                      items: [
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const Home(),
                                ));
                          },
                          child: const Icon(
                            Icons.home_filled,
                            color: Colors.green,
                            size: 30,
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const DoctorAppointments(),
                                   ));
                          },
                          child: const Icon(
                            Icons.calendar_month_rounded,
                            color: Colors.black,
                            size: 30,
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const DoctorAppointments(),
                                   ));
                          },
                          child:const Icon(
                            Icons.whatshot_outlined,
                            color: Colors.black,
                            size: 30,
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const DoctorAppointments(),
                                   ));
                          },
                          child: const Icon(
                            Icons.account_circle_outlined,
                            color: Colors.black,
                            size: 30,
                          ),
                        ),
                      ],
                      index: _selectedIndex,
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }

  Widget doctorList() {
    return AnimatedPositioned(
        top: position ? 460 : 550,
        left: 20,
        right: 20,
        duration: const Duration(milliseconds: 400),
        child: AnimatedOpacity(
          duration: const Duration(milliseconds: 400),
          opacity: opacity,
          child: AnimatedOpacity(
            opacity: opacity,
            duration: const Duration(milliseconds: 300),
            child: SizedBox(
              height: 270,
              width: MediaQuery.of(context).size.width,
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    doctorCard(
                        "${userService.userProfile?[0].firstName ?? ""} ${userService.userProfile?[0].lastName ?? ""}",
                        userService.userProfile?[0].specialization ?? "",
                        images[0]),
                    doctorCard(
                        "${userService.userProfile?[1].firstName ?? ""} ${userService.userProfile?[1].lastName ?? ""}",
                        userService.userProfile?[1].specialization ?? "",
                        images[1]),
                    doctorCard(
                        "${userService.userProfile?[2].firstName ?? ""} ${userService.userProfile?[2].lastName ?? ""}",
                        userService.userProfile?[2].specialization ?? "",
                        images[2]),
                  ],
                ),
              ),
            ),
          ),
        ));
  }

  Widget doctorCard(String name, String specialist, AssetImage image) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: SizedBox(
        height: 120,
        width: double.infinity,
        child: Row(
          children: [
            const SizedBox(
              width: 10,
            ),
            CircleAvatar(
              radius: 30,
              backgroundImage: image,
              backgroundColor: Colors.green,
            ),
            const SizedBox(
              width: 10,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextWidget(
                  name,
                  20,
                  Colors.black,
                  FontWeight.bold,
                  letterSpace: 0,
                ),
                const SizedBox(
                  height: 5,
                ),
                TextWidget(
                  specialist,
                  17,
                  Colors.black,
                  FontWeight.bold,
                  letterSpace: 0,
                ),
                const SizedBox(
                  height: 5,
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.star,
                      color: Colors.orangeAccent,
                    ),
                    Icon(
                      Icons.star,
                      color: Colors.orangeAccent,
                    ),
                    Icon(
                      Icons.star,
                      color: Colors.orangeAccent,
                    ),
                    Icon(
                      Icons.star,
                      color: Colors.orangeAccent,
                    ),
                    Icon(
                      Icons.star,
                      color: Colors.orangeAccent,
                    ),
                  ],
                ),
              ],
            ),
            const Spacer(),
            const Icon(
              Icons.navigation_sharp,
              color: Colors.blue,
            ),
            const SizedBox(
              width: 20,
            ),
          ],
        ),
      ),
    );
  }

  Widget categoryRow() {
    return AnimatedPositioned(
        top: position ? 270 : 420,
        left: 25,
        right: 25,
        duration: const Duration(milliseconds: 400),
        child: AnimatedOpacity(
          duration: const Duration(milliseconds: 400),
          opacity: opacity,
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                category("assets/images/capsule.png", "Drug", 5),
                category("assets/images/virus.png", "Virus", 10),
                category("assets/images/heart.png", "Physo", 10),
                category("assets/images/app.png", "Other", 12),
              ],
            ),
          ),
        ));
  }

  Widget category(String asset, String txt, double padding) {
    return Column(
      children: [
        InkWell(
          child: Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: Container(
              padding: EdgeInsets.all(padding),
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Image(
                  image: AssetImage(asset),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        TextWidget(
          txt,
          16,
          Colors.black,
          FontWeight.bold,
          letterSpace: 1,
        ),
      ],
    );
  }

  Widget BoottomNavigationbar(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
            backgroundColor: Colors.green,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month_rounded),
            label: 'Calender',
            backgroundColor: Colors.green,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.whatshot_outlined),
            label: 'School',
            backgroundColor: Colors.green,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle_outlined),
            label: '',
            backgroundColor: Colors.green,
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}
