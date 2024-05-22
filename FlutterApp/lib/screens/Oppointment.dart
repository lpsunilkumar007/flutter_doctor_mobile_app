import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hospital/res/app_api.dart';
import 'package:hospital/res/user_model.dart';
import 'package:hospital/widgets/text_widget.dart';
import 'package:http/http.dart' as http;

import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class Oppointment extends StatefulWidget {
  int index = 0;
  String dateValue = "";
  Oppointment(
    this.index, {
    super.key,
    required this.dateValue,
  });
  @override
  State<Oppointment> createState() => _OppointmentState();
}

class _OppointmentState extends State<Oppointment> {
  var images = [
    const AssetImage('assets/images/doctor2.png'),
    const AssetImage('assets/images/doctor3.png'),
    const AssetImage('assets/images/doctor4.png'),
    const AssetImage('assets/images/doctor5.png'),
    const AssetImage('assets/images/doctor6.png'),
    const AssetImage('assets/images/doctor7.png'),
    const AssetImage('assets/images/doctor5.png'),
  ];

  var timeshedule = [
    "09:00",
    "09:30",
    "10:00",
    "10:30",
    "11:00",
    "11:30",
    "12:00",
    "12:30",
    "01:00",
    "01:30",
    "2:00",
    "02:30",
  ];

  late Size size;
  var animate = false;
  var opacity = 0.0;
  int statuscode = 100;

  var time = [
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
  ];
  final DateRangePickerController _controller = DateRangePickerController();
  String _date = "";
  int doctorId = 0;
  String timeValues = "";
  String bookedValue = "";
  int indexVlaue = 0;
  var book = [
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
  ];

  DateTime date = DateTime.now();

  @override
  void initState() {
    // TODO: implement initState

    if (widget.index == 0) {
      doctorId = 1;
    } else if (widget.index == 1) {
      doctorId = 2;
    } else if (widget.index == 2) {
      doctorId = 3;
    } else if (widget.index == 3) {
      doctorId = 4;
    } else if (widget.index == 4) {
      doctorId = 5;
    } else if (widget.index == 5) {
      doctorId = 6;
    } else if (widget.index == 6) {
      doctorId = 7;
    }

    super.initState();
    _date = widget.dateValue;
    statuscode = 100;
    _controller.selectedDate = DateTime.parse(_date);
    date = DateTime.parse(_date);
    fetchData();
    Future.delayed(Duration.zero, () {
      animator();
    });
  }

  animator() {
    if (opacity == 0.0) {
      opacity = 1.0;
      animate = true;
    } else {
      opacity = 0.0;
      animate = false;
    }
    setState(() {});
  }

  List userModel = [];
  _save() async {
    var url = Uri.https(AppApi.baseUrl, AppApi.save);
    var response = await http.post(url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, Object>{
          "patientId": 1,
          "doctorId": doctorId,
          "appointmentDate": date.toIso8601String(),
          "appointmentTime": timeValues,
          "status": "Check up"
        }));
    var parsedData = json.decode(response.body);
    if (response.statusCode == 200) {
      bookedValue = timeValues;
      book[indexVlaue] = true;
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(parsedData["error"])));
    }
  }

  List dates = [];
  Future<void> fetchData() async {
    String getRecords = "Appointment/doctor/$doctorId/$date";
    var url = Uri.https(AppApi.baseUrl, getRecords);
    final response = await http.get(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
      },
    );
    var parsedData = json.decode(response.body);
    if (response.statusCode == 200) {
      try {
        userModel = parsedData.map((e) => UserModel.fromJson(e)).toList();
        setState(() {});

        var i = 0;
        for (var ii in timeshedule) {
          var contain =
              userModel.where((element) => element.slotsTime == '$ii:30');
          if (contain.isNotEmpty) {
            book[i] = true;
          }else{
             book[i] = false;
          }
          i++;
        }
      } catch (e) {
        print(e);
      }
    } else if (response.statusCode == 403 || response.statusCode == 401) {}
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        height: size.height,
        width: size.width,
        color: Colors.white,
        child: Stack(
          children: [
            AnimatedPositioned(
                duration: const Duration(milliseconds: 400),
                top: animate ? 1 : 80,
                left: 1,
                bottom: 1,
                right: 1,
                child: AnimatedOpacity(
                  duration: const Duration(milliseconds: 400),
                  opacity: opacity,
                  child: Container(
                    padding: const EdgeInsets.only(top: 30),
                    height: double.infinity,
                    width: double.infinity,
                    child: Stack(
                      children: [
                        Positioned(
                            top: 5,
                            right: 20,
                            left: 20,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                InkWell(
                                    onTap: () {
                                      animator();
                                      Timer(const Duration(milliseconds: 500),
                                          () {
                                        Navigator.pop(context);
                                      });
                                    },
                                    child: const Icon(
                                      Icons.arrow_back_ios_new_outlined,
                                      color: Colors.black,
                                    )),
                                TextWidget(
                                  "Appointment",
                                  25,
                                  Colors.black,
                                  FontWeight.bold,
                                  letterSpace: 0,
                                ),
                                Container(
                                  height: 10,
                                ),
                              ],
                            )),
                        Positioned(
                            top: 60,
                            left: 20,
                            right: 20,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: SfDateRangePicker(
                                controller: _controller,
                                selectionMode:
                                    DateRangePickerSelectionMode.single,
                                backgroundColor: Colors.grey.withOpacity(.1),
                                allowViewNavigation: true,
                                enablePastDates: false,
                                headerHeight: 50,
                                selectionColor: Colors.green,
                                toggleDaySelection: true,
                                showNavigationArrow: true,
                                // onSelectionChanged: selectionChanged,
                                selectionShape:
                                    DateRangePickerSelectionShape.circle,
                                onSelectionChanged:
                                    (DateRangePickerSelectionChangedArgs args) {
                                  if (date != args.value && args.value!=null) {
                                    date = args.value;
                                    fetchData();
                                  }
                                  setState(() {});
                                },
                                selectionTextStyle: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                                headerStyle: const DateRangePickerHeaderStyle(
                                  textStyle: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                      fontSize: 20),
                                ),
                                // maxDate: DateTime.now(),
                                initialDisplayDate: DateTime.parse(_date),
                              ),
                            )),
                        Positioned(
                            top: 390,
                            left: 30,
                            child: TextWidget(
                              "Time",
                              25,
                              Colors.black,
                              FontWeight.bold,
                              letterSpace: 0,
                            )),
                        gridViewList(),
                        Positioned(
                          bottom: 10,
                          left: 30,
                          right: 30,
                          child: InkWell(
                            onTap: () async {
                              var contain = time.where((item) => item == true);
                              if (contain.isEmpty) {
                                return;
                              } else {
                                if (bookedValue ==
                                    '${timeshedule[indexVlaue]}:30') return;
                                await _save();
                                showModalBottomSheet(
                                  barrierColor: Colors.black.withOpacity(.8),
                                  backgroundColor: Colors.transparent,
                                  isDismissible: true,
                                  context: context,
                                  builder: (context) {
                                    return SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height /
                                                1.7,
                                        width: double.infinity,
                                        child: Stack(
                                          children: [
                                            Align(
                                              alignment: Alignment.bottomCenter,
                                              child: Container(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height /
                                                    1.9,
                                                width: double.infinity,
                                                decoration: const BoxDecoration(
                                                    boxShadow: [
                                                      BoxShadow(
                                                          color: Colors.white,
                                                          blurRadius: 40),
                                                    ],
                                                    gradient: LinearGradient(
                                                        begin:
                                                            Alignment.topLeft,
                                                        end: Alignment.topRight,
                                                        colors: [
                                                          Colors.green,
                                                          Colors.green,
                                                          Colors.green,
                                                          Colors.green,
                                                        ]),
                                                    borderRadius:
                                                        BorderRadius.only(
                                                            topLeft:
                                                                Radius.circular(
                                                              40,
                                                            ),
                                                            topRight:
                                                                Radius.circular(
                                                                    40))),
                                              ),
                                            ),
                                            Align(
                                              alignment: Alignment.bottomCenter,
                                              child: Container(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 100,
                                                          left: 20,
                                                          right: 20),
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height /
                                                      1.93,
                                                  width: double.infinity,
                                                  decoration:
                                                      const BoxDecoration(
                                                          color: Colors.white,
                                                          borderRadius:
                                                              BorderRadius.only(
                                                                  topLeft: Radius
                                                                      .circular(
                                                                    40,
                                                                  ),
                                                                  topRight: Radius
                                                                      .circular(
                                                                          40))),
                                                  child: Center(
                                                    child: Column(
                                                      children: [
                                                        CircleAvatar(
                                                          backgroundColor:
                                                              Colors.black
                                                                  .withOpacity(
                                                                      .1),
                                                          radius: 60,
                                                          child: const Center(
                                                            child: Icon(
                                                              Icons.check,
                                                              color:
                                                                  Colors.green,
                                                              size: 30,
                                                            ),
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                          height: 20,
                                                        ),
                                                        const Text(
                                                          "Appointment Booked",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.green,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 20),
                                                        ),
                                                      ],
                                                    ),
                                                  )),
                                            ),
                                            Align(
                                                alignment: Alignment.topCenter,
                                                child: Container(
                                                  height: 90,
                                                  width: 90,
                                                  decoration: BoxDecoration(
                                                      boxShadow: const [
                                                        BoxShadow(
                                                            color: Colors.white,
                                                            blurRadius: 10,
                                                            offset:
                                                                Offset(0, 10)),
                                                        BoxShadow(
                                                            color: Colors
                                                                .transparent,
                                                            offset:
                                                                Offset(10, 0)),
                                                        BoxShadow(
                                                            color: Colors
                                                                .transparent,
                                                            offset:
                                                                Offset(-10, 0))
                                                      ],
                                                      shape: BoxShape.circle,
                                                      image: DecorationImage(
                                                          image: images[
                                                              widget.index])),
                                                )),
                                          ],
                                        ));
                                  },
                                );
                              }
                            },
                            child: Container(
                              height: 65,
                              width: size.width,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Colors.green.shade900,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  TextWidget(
                                    "Book an appointment",
                                    18,
                                    Colors.white,
                                    FontWeight.w500,
                                    letterSpace: 1,
                                  ),
                                  const SizedBox(
                                    width: 4,
                                  ),
                                  const Icon(
                                    Icons.arrow_forward_ios_outlined,
                                    color: Colors.white,
                                    size: 18,
                                  ),
                                  Icon(
                                    Icons.arrow_forward_ios_outlined,
                                    color: Colors.white.withOpacity(.5),
                                    size: 18,
                                  ),
                                  Icon(
                                    Icons.arrow_forward_ios_outlined,
                                    color: Colors.white.withOpacity(.2),
                                    size: 18,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ))
          ],
        ),
      ),
    );
  }

  Widget gridViewList() {
    return Stack(
      children: [
        Positioned(
          top: 410, // Adjust the position as needed
          left: 20,
          right: 20, // Adjust the position as needed
          child: SizedBox(
              width: 350,
              height: 400,
              child: GridView.count(
                crossAxisCount: 4,
                childAspectRatio: 1.5,
                children: List.generate(12, (index) {
                  return Center(
                    child: InkWell(
                      onTap: () {
                        var contain = userModel.where((element) =>
                            element.slotsTime == '${timeshedule[index]}:30');
                        if (contain.isNotEmpty) {
                          book[index] = true;
                          setState(() {});
                          return;
                        } else {
                          changer(index, timeshedule[index]);
                        }
                      },
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        elevation: 1,
                        color: book[index]
                            ? Colors.white
                            : time[index]
                                ? Colors.green
                                : Colors.white,
                        child: Center(
                          child: SizedBox(
                              height: 50,
                              width: 80,
                              child: Center(
                                  child: TextWidget(
                                timeshedule[index],
                                14,
                                book[index] ? Colors.grey : Colors.black,
                                FontWeight.bold,
                                letterSpace: 1,
                              ))),
                        ),
                      ),
                    ),
                  );
                }),
              )),
        ),
      ],
    );
  }

  void changer(int ind, String timeValue) {
    for (int i = 0; i < 12; i++) {
      if (i == ind) {
        if (book[i] != true) {
          time[i] = true;
          indexVlaue = i;
          timeValues = "$timeValue:30";
        }
      } else {
        time[i] = false;
      }
    }
    setState(() {});
  }
}
