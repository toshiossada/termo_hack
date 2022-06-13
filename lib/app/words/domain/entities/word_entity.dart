class WordEntity {
  final String firstLetter;
  final String secondLetter;
  final String thirdLetter;
  final String fourthLetter;
  final String fifthLetter;

  WordEntity({
    this.firstLetter = '',
    this.secondLetter = '',
    this.thirdLetter = '',
    this.fourthLetter = '',
    this.fifthLetter = '',
  });

  WordEntity copyWith({
    String? firstLetter,
    String? secondLetter,
    String? thirdLetter,
    String? fourthLetter,
    String? fifthLetter,
  }) {
    return WordEntity(
      firstLetter: firstLetter ?? this.firstLetter,
      secondLetter: secondLetter ?? this.secondLetter,
      thirdLetter: thirdLetter ?? this.thirdLetter,
      fourthLetter: fourthLetter ?? this.fourthLetter,
      fifthLetter: fifthLetter ?? this.fifthLetter,
    );
  }
}
