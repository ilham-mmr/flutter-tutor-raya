class Tutoring {
  int? id;
  String? title, description, subject, category;
  DateTime? startTime;
  DateTime? endTime;
  int? duration;
  double? totalPrice;

  Tutoring(
      {this.id,
      this.title,
      this.description,
      this.subject,
      this.category,
      this.startTime,
      this.endTime,
      this.duration,
      this.totalPrice});

  factory Tutoring.fromJson(Map<String, dynamic> json) => Tutoring(
        id: json['tutoring_id'],
        title: json['title'],
        description: json['description'],
        // startTime: DateTime.parse(json['start_time']),
        // endTime: DateTime.parse(json['end_time']),
        // duration: json['duration'],
        // totalPrice: json['total_price'],
        // subject: json['subject'],
        // category: json['category'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'description': description,
        'start_time': startTime,
        'end_time': endTime,
        'duration': duration,
        'total_price': totalPrice,
        'subject': subject,
        'category': category
      };
}
