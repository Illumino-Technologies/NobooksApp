import 'package:flutter/material.dart';
import 'package:nobook/src/core/themes/color.dart';

import 'package:nobook/src/features/notification/notification.dart';
import 'package:nobook/src/model/subjects.dart';
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
    final querywidth = MediaQuery.of(context).size.width / 6;
    // final queryheight = MediaQuery.of(context).size.height/3;
    return  Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          SizedBox(
            width: querywidth + 120,
            // height: queryheight,
            child: Column(
              // mainAxisSize:MainAxisSize.min ,
                children: [  
                 const  Text('Your Subjects'),              
                  Expanded(
                      child: ListView.builder(
                    itemCount: timeTable.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: Image.asset(timeTable[index].subjectLogo),
                        title: Text(timeTable[index].subject),
                        trailing: const Icon(Icons.keyboard_arrow_down),
                      );
                    },
                  ))
                ]),
          ),
        ],
    );
  }
}
