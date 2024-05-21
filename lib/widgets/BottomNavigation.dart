import 'package:flutter/material.dart';
import 'package:hospital/screens/DoctorAppointment.dart';
import 'package:hospital/screens/Home.dart';

// class BottomNavigation extends StatelessWidget
// {
//   const BottomNavigation({super.key});
//   @override
//   Widget build(BuildContext context) {
//     return BottomNavigationBar(
//         showUnselectedLabels: false,
//         showSelectedLabels: false,
//         items:const  [
//       BottomNavigationBarItem(
//           label: "HH",
//           icon: Icon(Icons.home_filled,color: Colors.blue,)),
//       BottomNavigationBarItem(
//           label: "HH",icon: Icon(Icons.calendar_month_rounded,color: Colors.black,)),
//       BottomNavigationBarItem(
//           label: "HH",icon: Icon(Icons.whatshot_outlined,color: Colors.black,)),
//       BottomNavigationBarItem(
//           label: "HH",icon: Icon(Icons.account_circle_outlined,color: Colors.black,)),
//     ]);
//   }

// }
class BottomNavigation extends StatefulWidget {
  const BottomNavigation({super.key});

  @override
  State<BottomNavigation> createState() => _BottomNavigationBarExampleState();
}

class _BottomNavigationBarExampleState extends State<BottomNavigation> {
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
