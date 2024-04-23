class Verse {
  Verse({
    required this.id,
    required this.suraId,
    required this.verseId,
    required this.ayahText,
    required this.indoText,
    required this.readText,
  });

  factory Verse.fromMap(Map<String, dynamic> map) => Verse(
        id: map['id'] as int,
        suraId: map['suraId'] as int,
        verseId: map['verseId'] as int,
        ayahText: map['ayahText'] as String,
        indoText: map['indoText'] as String,
        readText: map['readText'] as String,
      );

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'suraId': suraId,
      'verseId': verseId,
      'ayahText': ayahText,
      'indoText': indoText,
      'readText': readText,
    };
  }

  final int id;
  final int suraId;
  final int verseId;
  final String ayahText;
  final String indoText;
  final String readText;
}
