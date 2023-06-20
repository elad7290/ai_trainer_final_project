class Exercise {
  final String name;
  final String tools;
  final int repetitions;
  final String videoURL;


  Exercise({required this.name, required this.tools, required this.repetitions, required this.videoURL});

  Map<String, dynamic> toJson() =>
      {
        'name': name,
        'tools': tools,
        'repetitions': repetitions,
        'videoURL': videoURL,
      };

  static Exercise fromJson(Map<String, dynamic> json) =>
      Exercise(
        name: json['name'],
        tools: json['tools'],
        repetitions: json['repetitions'],
        videoURL: json['videoURL'],
      );
}

