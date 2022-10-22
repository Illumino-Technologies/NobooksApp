import 'package:flutter/material.dart';
import 'package:nobook/src/core/themes/color.dart';

import 'package:nobook/src/features/notification/notification.dart';
import 'package:nobook/src/model/subjects.dart';
import 'package:table_calendar/table_calendar.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime selectedDay = DateTime.now();
  DateTime focusedDay = DateTime.now();
  @override
  Widget build(BuildContext context) {
    final querywidth = MediaQuery.of(context).size.width / 5;
    // final queryheight = MediaQuery.of(context).size.height/3;
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          SizedBox(
            width: querywidth + 100,
            // height: queryheight,
            child: Stack(
              children: [
              Column(
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TableCalendar(
                        calendarFormat: _calendarFormat,
                        focusedDay: DateTime.now(),
                        firstDay: DateTime(1990),
                        lastDay: DateTime(2050),
                        onFormatChanged: (format) {
                          setState(() {
                            _calendarFormat = format;
                          });
                        },
                        daysOfWeekVisible: true,
                        startingDayOfWeek: StartingDayOfWeek.sunday,
                        calendarStyle: CalendarStyle(
                          isTodayHighlighted: true,
                          selectedDecoration: BoxDecoration(
                            color: Colors.blue,
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          selectedTextStyle: TextStyle(color: Colors.white),
                          todayDecoration: BoxDecoration(
                            color: Colors.purpleAccent,
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          defaultDecoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          weekendDecoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                        ),
                        headerStyle: const HeaderStyle(
                          formatButtonVisible: false,
                          titleCentered: true,
                          formatButtonTextStyle: TextStyle(color: Colors.white),
                        ),
                        onDaySelected: (DateTime selectDay, DateTime focusDay) {
                          setState(() {
                            selectedDay = selectDay;
                            focusedDay = focusDay;
                          });
                        },
                        selectedDayPredicate: (DateTime date) {
                          return isSameDay(selectedDay, date);
                        }),
                    Expanded(
                        child: ListView.builder(
                      itemCount: timeTable.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          leading: Image.asset(timeTable[index].subjectLogo),
                          title: Text(timeTable[index].subject),
                          subtitle: Row(
                            children: [
                              Text(timeTable[index].startTime),
                              const Text(" - "),
                              Text(timeTable[index].endTime),
                            ],
                          ),
                          trailing: const Icon(Icons.arrow_forward_ios),
                        );
                      },
                    ))
                  ]),
              // const Positioned(
              //     // top: 1,
              //     // left: 2,
              //     child: Notifications())
            ]),
          ),
        ],
      ),
    );
  }
}
