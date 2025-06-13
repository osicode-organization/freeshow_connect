class BibleBook {
  final String name;
  final String abbreviation;
  final Map<int, int> chapters; // Chapter number -> Verse count

  BibleBook({
    required this.name,
    required this.abbreviation,
    required this.chapters,
  });

  factory BibleBook.fromJson(String name, Map<String, dynamic> json) {
    return BibleBook(
      name: name,
      abbreviation: json["abr"],
      chapters: (json["data"] as Map<String, dynamic>).map(
        (key, value) => MapEntry(int.parse(key), value),
      ),
    );
  }
}

class Bible {
  final Map<String, BibleBook> books;

  Bible({required this.books});

  factory Bible.fromJson(Map<String, dynamic> json) {
    return Bible(
      books: json.map(
        (key, value) => MapEntry(key, BibleBook.fromJson(key, value)),
      ),
    );
  }
}
