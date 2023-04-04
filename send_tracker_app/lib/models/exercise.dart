class Exercise {
  final int id;
  final String type;
  final String name;
  final int volume;

  const Exercise(
      {required this.id,
      required this.type,
      required this.name,
      required this.volume});

  Exercise.fromMap(Map<String, dynamic> result)
      : id = result["id"],
        type = result["type"],
        name = result["name"],
        volume = result["volume"];

  Map<String, Object> toMap() {
    return {'id': id, 'type': type, 'name': name, 'volume': volume};
  }
}
