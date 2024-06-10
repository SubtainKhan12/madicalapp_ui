class Complaint {
  final String id;
  final String fullname;
  final String package;
  final String description;
  final String email;
  final String status;
  final String date;
  final String time;

  Complaint({
    required this.id,
    required this.fullname,
    required this.package,
    required this.description,
    required this.email,
    required this.status,
    required this.date,
    required this.time,
  });

  factory Complaint.fromJson(Map<String, dynamic> json) {
    return Complaint(
      id: json['id'],
      fullname: json['fullname'],
      package: json['pakage'],
      description: json['discription'],
      email: json['email'],
      status: json['status'],
      date: json['date'],
      time: json['time'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'fullname': fullname,
      'package': package,
      'description': description,
      'email': email,
      'status': status,
      'date': date,
      'time': time,
    };
  }
}
