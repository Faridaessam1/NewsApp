class SourcesModel {
  String status;
  List<Source> sources;

  SourcesModel({
    required this.status,
    required this.sources,
  });

  factory SourcesModel.fromJson(Map<String, dynamic> json) {
    return SourcesModel(
      status: json["status"],
      sources: (json["sources"] as List)
          .map((element) => Source.fromJson(element))
          .toList(),
    );
  }
}

class Source {
  String id;
  String name;

  Source({
    required this.id,
    required this.name,
  });

  factory Source.fromJson(Map<String, dynamic> json) {
    return Source(id: json["id"], name: json["name"]);
  }
}
