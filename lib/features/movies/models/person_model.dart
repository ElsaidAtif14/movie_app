class Person {
  final int id;
  final String name;
  final String biography;
  final String birthday;
  final String? deathday;
  final int gender;
  final String placeOfBirth;
  final String knownForDepartment;
  final String profilePath;
  final List<String> alsoKnownAs;

  Person({
    required this.id,
    required this.name,
    required this.biography,
    required this.birthday,
    required this.deathday,
    required this.gender,
    required this.placeOfBirth,
    required this.knownForDepartment,
    required this.profilePath,
    required this.alsoKnownAs,
  });

  factory Person.fromJson(Map<String, dynamic> json) {
    return Person(
      id: json['id'] as int? ?? 0,
      name: json['name'] as String? ?? 'Unknown',
      biography: json['biography'] as String? ?? 'No biography available.',
      birthday: json['birthday'] as String? ?? 'Unknown',
      deathday: json['deathday'] as String?,
      gender: json['gender'] as int? ?? 0,
      placeOfBirth: json['place_of_birth'] as String? ?? 'Unknown',
      knownForDepartment: json['known_for_department'] as String? ?? 'Acting',
      profilePath: json['profile_path'] as String? ?? '',
      alsoKnownAs: (json['also_known_as'] as List<dynamic>?)
              ?.cast<String>()
              .where((name) => name.isNotEmpty)
              .toList() ??
          [],
    );
  }

  String get genderText {
    if (gender == 1) return 'Female';
    if (gender == 2) return 'Male';
    return 'Other';
  }
}
