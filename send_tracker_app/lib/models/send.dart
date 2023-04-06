class Send {
  final int id;
  final String date;
  final String location;
  final String color;
  final int grade;
  final String styles;

  const Send(
      {required this.id,
      required this.date,
      required this.location,
      required this.color,
      required this.grade,
      required this.styles});

  Send.fromMap(Map<String, dynamic> result)
      : id = result["id"],
        date = result["date"],
        location = result["location"],
        color = result["color"],
        grade = result["grade"],
        styles = result["styles"];

  Map<String, Object> toMap() {
    return {
      'id': id,
      'date': date,
      'location': location,
      'color': color,
      'grade': grade,
      'styles': styles
    };
  }

  @override
  String toString() {
    return "Send{id: $id, date: $date, location: $location, color: $color, grade: $grade, styles: $styles}";
  }
}
