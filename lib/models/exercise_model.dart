class Exercise {
  final String name;
  final String tools;
  final String videoURL;


  Exercise({required this.name, required this.tools, required this.videoURL});

  Map<String, dynamic> toJson() =>
      {
        'name': name,
        'tools': tools,
        'videoURL': videoURL,
      };

  static Exercise fromJson(Map<String, dynamic> json) =>
      Exercise(
        name: json['name'],
        tools: json['tools'],
        videoURL: json['videoURL'],
      );
}

