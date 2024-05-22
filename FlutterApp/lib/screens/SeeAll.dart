import 'dart:async';
import 'package:flutter/material.dart';
import 'package:hospital/res/doctor_model.dart';
import 'package:hospital/screens/Home.dart';
import 'package:hospital/screens/Profile.dart';
import 'package:hospital/widgets/text_widget.dart';
import 'package:hospital/res/lists.dart';

class SeeAll extends StatefulWidget {
  const SeeAll({super.key});

  @override
  State<SeeAll> createState() => _SeeAllState();
}

class _SeeAllState extends State<SeeAll> {
  var opacity = 0.0;
  bool position = false;

  final userService = UserService();
  @override
  void initState() {
    fetchData();
    super.initState();
    Future.delayed(Duration.zero, () {
      animator();
    });
  }

  Future<void> fetchData() async {
    await userService.getData();
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

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        color: Colors.white,
        padding: const EdgeInsets.only(top: 40),
        height: size.height,
        width: size.width,
        child: Stack(
          children: [
            AnimatedPositioned(
              duration: const Duration(milliseconds: 400),
              top: position ? 1 : 50,
              left: 20,
              right: 20,
              child: upperRow(),
            ),
            AnimatedPositioned(
                top: position ? 60 : 120,
                right: 20,
                left: 20,
                duration: const Duration(milliseconds: 400),
                child: AnimatedOpacity(
                  opacity: opacity,
                  duration: const Duration(milliseconds: 400),
                  child: SizedBox(
                    width: size.width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextWidget(
                          "Nearby Doctors",
                          22,
                          Colors.black,
                          FontWeight.bold,
                          letterSpace: 0,
                        ),
                        // TextWidget(
                        //   "See all",
                        //   14,
                        //   Colors.green.shade900,
                        //   FontWeight.bold,
                        //   letterSpace: 0,
                        // ),
                      ],
                    ),
                  ),
                )),
            AnimatedPositioned(
                top: position ? 100 : 350,
                left: 20,
                right: 20,
                duration: const Duration(milliseconds: 500),
                child: AnimatedOpacity(
                    duration: const Duration(milliseconds: 500),
                    opacity: opacity,
                    child: SizedBox(
                      height: 630,
                      child: ListView.builder(
                        physics:const BouncingScrollPhysics(),
                        itemCount: userService.userProfile?.length ??0 ,
                        itemBuilder: (context, index) => InkWell(
                          onTap: () async {
                            animator();
                            await Future.delayed(
                                const Duration(milliseconds: 400));
                            await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Profile(
                                      image: images[index],
                                      name:
                                          "${userService.userProfile?[index].firstName ?? ""} ${userService.userProfile?[index].lastName ?? ""}",
                                      speciality: userService.userProfile?[index].specialization??"",
                                      doctorId: index),
                                ));
                            animator();
                          },
                          child: Card(
                            elevation: 5,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: SizedBox(
                              height: 120,
                              width: double.infinity,
                              child: Row(
                                children: [
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  CircleAvatar(
                                    radius: 30,
                                    backgroundImage: images[index],
                                    backgroundColor: Colors.green,
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      TextWidget(
                                        "${userService.userProfile?[index].firstName ?? ""} ${userService.userProfile?[index].lastName ?? ""}",
                                        20,
                                        Colors.black,
                                        FontWeight.bold,
                                        letterSpace: 0,
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      TextWidget(
                                        userService.userProfile?[index]
                                                .specialization ??
                                            "",
                                        15,
                                        Colors.black,
                                        FontWeight.bold,
                                        letterSpace: 0,
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      const Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
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
                                    color: Colors.green,
                                  ),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ))),
          ],
        ),
      ),
    );
  }

  Widget upperRow() {
    return AnimatedOpacity(
      opacity: opacity,
      duration: const Duration(milliseconds: 400),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: () {
              Timer(const Duration(milliseconds: 600), () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Home(),
                    ));
              });
            },
            child: const Icon(
              Icons.arrow_back_ios_rounded,
              color: Colors.black,
              size: 25,
            ),
          ),
          TextWidget("Our Doctors", 25, Colors.black, FontWeight.bold),
          const Icon(
            Icons.search,
            color: Colors.black,
            size: 25,
          )
        ],
      ),
    );
  }

}
