class TaskModel {
  String id;
  String titel;
  String discrapion;
  bool isDone;
  int date;

  TaskModel({
    this.id="",
    required this.titel,
    required this.discrapion,
     this.isDone = false,
    required this.date,
  });

  TaskModel.fromJson(Map<String, dynamic> data)
      : this(
          id: data['id'],
          isDone: data['isDone'],
          date: data['date'],
          discrapion: data['discrapion'],
          titel: data['titel'],
        );

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "isDone": isDone,
      "discrapion": discrapion,
      "titel": titel,
      "date": date,
    };
  }
}
