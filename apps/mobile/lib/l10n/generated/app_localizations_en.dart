// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appName => 'Selida';

  @override
  String get today => 'Today';

  @override
  String get library => 'Library';

  @override
  String get dictionary => 'Dictionary';

  @override
  String get continueReading => 'Continue reading';

  @override
  String get reviewsDue => 'Due for review';

  @override
  String get noReviews => 'Your review queue is clear';

  @override
  String get emptyLibraryTitle => 'Your next story starts here';

  @override
  String get emptyLibraryBody =>
      'Import an EPUB or TXT book and read it at your own pace.';

  @override
  String get importBook => 'Import book';

  @override
  String get importingBook => 'Preparing book…';

  @override
  String get retry => 'Try again';

  @override
  String get deleteBook => 'Delete book?';

  @override
  String get deleteBookBody =>
      'The book file will be removed. Saved vocabulary will remain.';

  @override
  String get cancel => 'Cancel';

  @override
  String get delete => 'Delete';

  @override
  String get unknownAuthor => 'Unknown author';

  @override
  String get readerSettings => 'Reading settings';

  @override
  String get paragraphStyle => 'Paragraphs';

  @override
  String get bookParagraphStyle => 'Book';

  @override
  String get modernParagraphStyle => 'Modern';

  @override
  String get fontSize => 'Text size';

  @override
  String get lineHeight => 'Line spacing';

  @override
  String get margins => 'Margins';

  @override
  String get readerBrightness => 'Brightness';

  @override
  String get pageAnimation => 'Page animation';

  @override
  String get bookLanguage => 'Book language';

  @override
  String get englishLanguage => 'English';

  @override
  String get greekLanguage => 'Greek';

  @override
  String get theme => 'Theme';

  @override
  String get lightTheme => 'Light';

  @override
  String get sepiaTheme => 'Sepia';

  @override
  String get darkTheme => 'Dark';

  @override
  String get contents => 'Contents';

  @override
  String get returnToPreviousLocation => 'Return to previous location';

  @override
  String mappingPrototype(int offset) {
    return 'Word position: $offset';
  }

  @override
  String get translationNextMilestone =>
      'Translation will be connected in milestone 2';

  @override
  String get translatingWord => 'Translating…';

  @override
  String get translationOffline =>
      'You are offline. Cached translations remain available.';

  @override
  String get translationUnavailable => 'The translation could not be loaded.';

  @override
  String get translationInvalid => 'The service returned an invalid response.';

  @override
  String get saveWord => 'Save word';

  @override
  String get wordSaved => 'Word saved';

  @override
  String get removeFromDictionary => 'Remove from dictionary';

  @override
  String savedVocabularyStatus(String status) {
    return 'Already in dictionary · $status';
  }

  @override
  String get translateSentence => 'Translate sentence';

  @override
  String get sentenceAction => 'Sentence';

  @override
  String get translateSelection => 'Translate';

  @override
  String get savePhrase => 'Save phrase';

  @override
  String get savedAction => 'Saved';

  @override
  String get phraseLabel => 'phrase';

  @override
  String get fragmentTranslationTitle => 'Translation';

  @override
  String get explainText => 'Explain';

  @override
  String get explanationTitle => 'Explanation';

  @override
  String get explanationSummaryLabel => 'In short';

  @override
  String get explanationMeaningLabel => 'In this context';

  @override
  String get explanationBreakdownLabel => 'How it works';

  @override
  String get explanationLiteralLabel => 'Literally';

  @override
  String get explanationNaturalLabel => 'Natural translation';

  @override
  String get explanationExamplesLabel => 'Examples';

  @override
  String get explanationCommonMistakeLabel => 'Common mistake';

  @override
  String lemmaDetails(String lemma, String partOfSpeech) {
    return '$lemma · $partOfSpeech';
  }

  @override
  String get bookLoadError => 'The book could not be opened.';

  @override
  String get unsupportedBook => 'Choose an EPUB or UTF-8 TXT file.';

  @override
  String get invalidBook => 'This book appears to be damaged or unsupported.';

  @override
  String get shareImportError => 'The shared file could not be imported.';

  @override
  String get dictionaryComingSoon => 'Saved words will appear here.';

  @override
  String get searchWords => 'Search words and translations';

  @override
  String get allBooks => 'All books';

  @override
  String get allStatuses => 'All statuses';

  @override
  String get statusNew => 'New';

  @override
  String get statusLearning => 'Learning';

  @override
  String get statusLearned => 'Learned';

  @override
  String get emptyDictionaryTitle => 'Your dictionary is empty';

  @override
  String get emptyDictionaryBody =>
      'Tap a word in a book and save it after translation.';

  @override
  String get dictionaryLoadError => 'The dictionary could not be loaded.';

  @override
  String get chapter => 'Chapter';

  @override
  String readerPageProgress(
    int page,
    String pageCount,
    int chapter,
    int chapterCount,
  ) {
    return 'Page $page of $pageCount · chapter $chapter of $chapterCount';
  }

  @override
  String readerCompactProgress(int page, String pageCount, int percent) {
    return '$page of $pageCount · $percent%';
  }

  @override
  String readerProgressPreview(int percent, int chapter, int chapterCount) {
    return '$percent% · chapter $chapter of $chapterCount';
  }

  @override
  String get previousChapter => 'Previous chapter';

  @override
  String get nextChapter => 'Next chapter';
}
