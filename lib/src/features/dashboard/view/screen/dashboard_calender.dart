import 'package:flutter/material.dart';
import 'package:nobook/src/features/assignments/assignment_barrel.dart';
import 'package:table_calendar/table_calendar.dart';

class DashboardCalender extends StatefulWidget {
  const DashboardCalender({Key? key}) : super(key: key);

  @override
  State<DashboardCalender> createState() => _DashboardCalenderState();
}

class _DashboardCalenderState extends State<DashboardCalender> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime selectedDay = DateTime.now();
  DateTime focusedDay = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final double queryWidth = MediaQuery.of(context).size.width / 5;
    // final queryheight = MediaQuery.of(context).size.height/3;
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      // crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          child: SizedBox(
            width: queryWidth + 100,
            // height: MediaQuery.of(context).size.height,
            child: Column(
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
                    selectedTextStyle: const TextStyle(color: Colors.white),
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
                  },
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: FakeAssignmentData.timeTable.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: Image.asset(
                          FakeAssignmentData.timeTable[index].subjectLogo,
                        ),
                        title:
                            Text(FakeAssignmentData.timeTable[index].subject),
                        trailing: const Icon(Icons.arrow_forward_ios),
                      );
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
