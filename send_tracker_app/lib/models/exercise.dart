class Exercise {
  final int id;
  final String date;
  final String type;
  final String name;
  final int volume;

  const Exercise(
      {required this.id,
      required this.date,
      required this.type,
      required this.name,
      required this.volume});

  Exercise.fromMap(Map<String, dynamic> result)
      : id = result["id"],
        date = result["date"],
        type = result["type"],
        name = result["name"],
        volume = result["volume"];

  Map<String, Object> toMap() {
    return {
      'id': id,
      'date': date,
      'type': type,
      'name': name,
      'volume': volume
    };
  }

  @override
  String toString() {
    return "Exercise{id: $id, date: $date, type: $type, name: $name, volume: $volume}";
  }
}
