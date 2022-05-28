import 'package:intl/intl.dart';

class Lesson {
  int? id;
  String? title,
      status,
      subject,
      category,
      phoneNumber,
      tutor,
      picture,
      meetingLink;
  DateTime? startTime;
  DateTime? endTime;
  num? totalPrice;

  Lesson(
      {this.id,
      this.title,
      this.subject,
      this.category,
      this.startTime,
      this.endTime,
      this.meetingLink,
      this.phoneNumber,
      this.status,
      this.totalPrice,
      this.tutor,
      this.picture});

  factory Lesson.fromJson(Map<String, dynamic> json) => Lesson(
        id: json['id'],
        meetingLink: json['meeting_link'],
        phoneNumber: json['phone_number'],
        status: json['status'],
        tutor: json['tutor'],
        title: json['title'],
        picture: json['picture'],
        startTime: DateTime.parse(json['start_time']),
        endTime: DateTime.parse(json['end_time']),
        totalPrice: json['total_price'],
        subject: json['subject'],
        category: json['category'],
      );
  getFormattedTime() {
    var startTimeFormatted = DateFormat.Hm().format(startTime!);
    var endTimeFormatted = DateFormat.Hm().format(endTime!);
    return "$startTimeFormatted - $endTimeFormatted";
  }

  getFormmatedDate() {
    var startDate = DateFormat("EEEE, d MMMM y").format(startTime!);

    return startDate;
  }
}
