import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:hospital/res/doctor_model.dart';
import 'package:hospital/screens/Home.dart';
import 'package:hospital/widgets/text_widget.dart';

class DoctorAppointments extends StatefulWidget {
  const DoctorAppointments({super.key});

  @override
  State<DoctorAppointments> createState() => _SeeAllState();
}

class _SeeAllState extends State<DoctorAppointments> {
  var animate = false;
  var opacity = 0.0;
  late Size size;
  final doctorAppointment = DoctorAppointment();
  @override
  void initState() {
    fetchData();
    super.initState();
    Future.delayed(Duration.zero, () {
      animator();
    });
  }

  Future<void> fetchData() async {
    await doctorAppointment.getData();
    setState(() {});
  }

  animator() {
    if (opacity == 0.0) {
      opacity = 1;
      animate = true;
    } else {
      opacity = 0.0;
      animate = false;
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
              top: animate ? 1 : 50,
              left: 20,
              right: 20,
              child: upperRow(),
            ),
            AnimatedPositioned(
                top: animate ? 60 : 120,
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
                          "Your Appointments",
                          22,
                          Colors.black,
                          FontWeight.bold,
                          letterSpace: 0,
                        ),
                      ],
                    ),
                  ),
                )),
            AnimatedPositioned(
                top: animate ? 90 : 390,
                left: 20,
                right: 20,
                duration: const Duration(milliseconds: 500),
                child: AnimatedOpacity(
                    duration: const Duration(milliseconds: 500),
                    opacity: opacity,
                    child: SizedBox(
                      height: 630,
                      width: 50,
                      child: ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        itemCount:  doctorAppointment.doctorProfile?.length  ??7,
                        itemBuilder: (context, index) => InkWell(
                          onTap: () async {},
                          child: Card(
                            margin: const EdgeInsets.only(bottom: 10),
                            elevation: 2,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: InkWell(
                              onTap: () {
                                log(doctorAppointment.doctorProfile![index].time
                                    .toString());
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 10),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        TextWidget(
                                          "Date :",
                                          16,
                                          Colors.black,
                                          FontWeight.bold,
                                          letterSpace: 0,
                                        ),
                                        TextWidget(
                                          doctorAppointment
                                                  .doctorProfile?[index].date ??
                                              "",
                                          16,
                                          Colors.black,
                                          FontWeight.normal,
                                          letterSpace: 0,
                                        ),
                                        const Icon(
                                          Icons.calendar_month,
                                          color: Colors.green,
                                          size: 30.0,
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        TextWidget(
                                          "Time :",
                                          16,
                                          Colors.black,
                                          FontWeight.bold,
                                          letterSpace: 0,
                                        ),
                                        TextWidget(
                                          doctorAppointment
                                                  .doctorProfile?[index].time ??
                                              "",
                                          16,
                                          Colors.black,
                                          FontWeight.normal,
                                          letterSpace: 0,
                                        ),
                                        const Icon(
                                          Icons.timer_sharp,
                                          color: Colors.green,
                                          size: 30.0,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
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
          TextWidget("Dr. Frasier Crane", 25, Colors.black, FontWeight.bold),
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
