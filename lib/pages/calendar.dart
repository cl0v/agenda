import 'package:agenda/models/calendar_data.dart';
import 'package:agenda/repositories/calendar_data.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({
    Key? key,
    required this.uid,
  }) : super(key: key);
  final String uid;

  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<CalendarDataModel>>(
        stream: CalendarDataRepository().readAll(widget.uid),
        builder: (context, snapshot) {
          if (!snapshot.hasData && snapshot.data == null) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          List<CalendarDataModel> l = snapshot.data!;

          return SfCalendar(
            view: CalendarView.day,
            dataSource: MeetingDataSource(_getDataSource(l)),
            monthViewSettings: const MonthViewSettings(
              appointmentDisplayMode: MonthAppointmentDisplayMode.appointment,
            ),
          );
        });
  }

  List<Meeting> _getDataSource(List<CalendarDataModel> list) {
    final List<Meeting> meetings = <Meeting>[];
    list.forEach((element) {
      meetings.add(
        Meeting(
          '${element.name}\n >${element.servico}',
          element.start,
          element.end,
          const Color(0xFF0F8644), // A cor
          false,
        ),
      );
    });
    return meetings;
  }
}

// Livia Amanda Viana
// DateTime da hora que será a reunião
// Datetime da hora que irá finalizar

/// An object to set the appointment collection data source to calendar, which
/// used to map the custom appointment data to the calendar appointment, and
/// allows to add, remove or reset the appointment collection.
class MeetingDataSource extends CalendarDataSource {
  /// Creates a meeting data source, which used to set the appointment
  /// collection to the calendar
  MeetingDataSource(List<Meeting> source) {
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) {
    return _getMeetingData(index).from;
  }

  @override
  DateTime getEndTime(int index) {
    return _getMeetingData(index).to;
  }

  @override
  String getSubject(int index) {
    return _getMeetingData(index).eventName;
  }

  @override
  Color getColor(int index) {
    return _getMeetingData(index).background;
  }

  @override
  bool isAllDay(int index) {
    return _getMeetingData(index).isAllDay;
  }

  Meeting _getMeetingData(int index) {
    final dynamic meeting = appointments![index];
    late final Meeting meetingData;
    if (meeting is Meeting) {
      meetingData = meeting;
    }

    return meetingData;
  }
}

/// Custom business object class which contains properties to hold the detailed
/// information about the event data which will be rendered in calendar.
class Meeting {
  /// Creates a meeting class with required details.
  Meeting(this.eventName, this.from, this.to, this.background, this.isAllDay);

  /// Event name which is equivalent to subject property of [Appointment].
  String eventName;

  /// From which is equivalent to start time property of [Appointment].
  DateTime from;

  /// To which is equivalent to end time property of [Appointment].
  DateTime to;

  /// Background which is equivalent to color property of [Appointment].
  Color background;

  /// IsAllDay which is equivalent to isAllDay property of [Appointment].
  bool isAllDay;
}
