class Event {
  int? id;
  String title;
  DateTime eventDate;
  bool isArchived;
  int notificationDaysBefore;
  String? colorHex; // e.g. "#FF5733"
  String? emoji;
  String? backgroundImagePath;

  Event({
    this.id,
    required this.title,
    required this.eventDate,
    this.isArchived = false,
    this.notificationDaysBefore = 1,
    this.colorHex,
    this.emoji,
    this.backgroundImagePath,
  });

  factory Event.fromMap(Map<String, dynamic> json) => Event(
        id: json['id'],
        title: json['title'],
        eventDate: DateTime.parse(json['eventDate']),
        isArchived: json['isArchived'] == 1,
        notificationDaysBefore: json['notificationDaysBefore'],
        colorHex: json['colorHex'],
        emoji: json['emoji'],
        backgroundImagePath: json['backgroundImagePath'],
      );

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'eventDate': eventDate.toIso8601String(),
      'isArchived': isArchived ? 1 : 0,
      'notificationDaysBefore': notificationDaysBefore,
      'colorHex': colorHex,
      'emoji': emoji,
      'backgroundImagePath': backgroundImagePath,
    };
  }
}
