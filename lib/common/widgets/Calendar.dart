import 'package:flutter/material.dart';
import 'package:greenmate/features/models/Plant.dart';
import 'package:table_calendar/table_calendar.dart';

class Calendar extends StatefulWidget {
  @override
  _Calendar createState() => _Calendar();
}

class _Calendar extends State<Calendar> {
  List<Plant> yourPlants = List.empty();
  CalendarFormat _calendarFormat = CalendarFormat.week;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  final kFirstDay = DateTime(
      DateTime.now().year, DateTime.now().month - 3, DateTime.now().day);
  final kLastDay = DateTime(
      DateTime.now().year, DateTime.now().month + 3, DateTime.now().day);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(0),
        child: Column(
          children: [
            TableCalendar(
              focusedDay: _focusedDay,
              firstDay: kFirstDay,
              lastDay: kLastDay,
              calendarFormat: _calendarFormat,
              selectedDayPredicate: (day) {
                return isSameDay(_selectedDay, day);
              },
              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  _selectedDay = selectedDay;
                  _focusedDay = focusedDay;
                });
              },
              onPageChanged: (focusedDay) {
                _focusedDay = focusedDay;
              },
              onFormatChanged: (format) {
                setState(() {
                  _calendarFormat = format;
                });
              },
              availableCalendarFormats: const {
                CalendarFormat.week: "2 Weeks",
                CalendarFormat.twoWeeks: "Week"
              },
            ),
            // Expanded(
            //   child: ListView.builder(
            //   itemCount: yourPlants.length,
            //   itemBuilder: (context, index) {
            //   return Card(
            //     elevation: 3.0,
            //     shape: RoundedRectangleBorder(
            //         borderRadius: BorderRadius.circular(15)),
            //     child: Stack(
            //       children: [
            //         Text(yourPlants[index].name),
            //         Text(yourPlants[index].maintenance[index].type),
            //         Text(yourPlants[index].maintenance[index].description)
            //       ],
            //     ),
            //   );
            // }))
          ],
        ));
  }
}
