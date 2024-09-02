class EventData {
  final String eventName;
  final String eventDate;
  final String eventOrganizer;
  final String eventDuration;
  final String volunteerStatus;
  final List<String> eventImages;

  EventData({
    required this.eventName,
    required this.eventDate,
    required this.eventOrganizer,
    required this.eventDuration,
    required this.volunteerStatus,
    required this.eventImages,
  });

  // Convert EventData to a map to upload to Firestore
  Map<String, dynamic> toMap() {
    return {
      'eventName': eventName,
      'eventDate': eventDate,
      'eventOrganizer': eventOrganizer,
      'eventDuration': eventDuration,
      'volunteerStatus': volunteerStatus,
      'eventImages': eventImages,
    };
  }

  // Create EventData from a Firestore document snapshot
  factory EventData.fromMap(Map<String, dynamic> map) {
    return EventData(
      eventName: map['eventName'] ?? '',
      eventDate: map['eventDate'] ?? '',
      eventOrganizer: map['eventOrganizer'] ?? '',
      eventDuration: map['eventDuration'] ?? '',
      volunteerStatus: map['volunteerStatus'] ?? '',
      eventImages: List<String>.from(map['eventImages'] ?? []),
    );
  }
}
