class PeopleInSpace {
  PeopleInSpace({
    required this.name,
    required this.craft,
  });

  final String name;
  final String craft;

  factory PeopleInSpace.fromJson(Map<String, dynamic> json) {
    return PeopleInSpace(
      name: json['name'],
      craft: json['craft'],
    );
  }
}
