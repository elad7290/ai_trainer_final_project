class Exercise {
  final String id;
  final String name;
  final String tools;
  final int repetitions;
  final String videoURL;


  Exercise({required this.id ,required this.name, required this.tools, required this.repetitions, required this.videoURL});

  Map<String, dynamic> toJson() =>
      {
        'id': id,
        'name': name,
        'tools': tools,
        'repetitions': repetitions,
        'videoURL': videoURL,
      };

  static Exercise fromJson(Map<String, dynamic> json) =>
      Exercise(
        id: json['id'],
        name: json['name'],
        tools: json['tools'],
        repetitions: json['repetitions'],
        videoURL: json['videoURL'],
      );
}

