// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get appName => 'Selida';

  @override
  String get today => 'Сегодня';

  @override
  String get library => 'Библиотека';

  @override
  String get dictionary => 'Словарь';

  @override
  String get continueReading => 'Продолжить чтение';

  @override
  String get reviewsDue => 'К повторению';

  @override
  String get noReviews => 'На сегодня повторений нет';

  @override
  String get emptyLibraryTitle => 'Следующая история начинается здесь';

  @override
  String get emptyLibraryBody =>
      'Импортируйте книгу EPUB или TXT и читайте в своём темпе.';

  @override
  String get importBook => 'Импортировать книгу';

  @override
  String get importingBook => 'Подготавливаем книгу…';

  @override
  String get retry => 'Повторить';

  @override
  String get deleteBook => 'Удалить книгу?';

  @override
  String get deleteBookBody =>
      'Файл книги будет удалён. Сохранённые слова останутся.';

  @override
  String get cancel => 'Отмена';

  @override
  String get delete => 'Удалить';

  @override
  String get unknownAuthor => 'Автор неизвестен';

  @override
  String get readerSettings => 'Настройки чтения';

  @override
  String get paragraphStyle => 'Абзацы';

  @override
  String get bookParagraphStyle => 'Книжные';

  @override
  String get modernParagraphStyle => 'Современные';

  @override
  String get fontSize => 'Размер текста';

  @override
  String get lineHeight => 'Межстрочный интервал';

  @override
  String get margins => 'Поля';

  @override
  String get readerBrightness => 'Яркость';

  @override
  String get pageAnimation => 'Анимация перелистывания';

  @override
  String get bookLanguage => 'Язык книги';

  @override
  String get englishLanguage => 'Английский';

  @override
  String get greekLanguage => 'Греческий';

  @override
  String get theme => 'Тема';

  @override
  String get lightTheme => 'Светлая';

  @override
  String get sepiaTheme => 'Сепия';

  @override
  String get darkTheme => 'Тёмная';

  @override
  String get contents => 'Оглавление';

  @override
  String get returnToPreviousLocation => 'Вернуться к предыдущему месту';

  @override
  String mappingPrototype(int offset) {
    return 'Позиция слова: $offset';
  }

  @override
  String get translationNextMilestone =>
      'Перевод будет подключён во второй вехе';

  @override
  String get translatingWord => 'Переводим…';

  @override
  String get translationOffline =>
      'Нет сети. Сохранённые переводы доступны офлайн.';

  @override
  String get translationUnavailable => 'Не удалось получить перевод.';

  @override
  String get translationInvalid => 'Сервис вернул некорректный ответ.';

  @override
  String get saveWord => 'Сохранить слово';

  @override
  String get wordSaved => 'Слово сохранено';

  @override
  String get removeFromDictionary => 'Удалить из словаря';

  @override
  String savedVocabularyStatus(String status) {
    return 'Уже в словаре · $status';
  }

  @override
  String get translateSentence => 'Перевести предложение';

  @override
  String get sentenceAction => 'Предложение';

  @override
  String get translateSelection => 'Перевести';

  @override
  String get savePhrase => 'Сохранить фразу';

  @override
  String get savedAction => 'Сохранено';

  @override
  String get phraseLabel => 'фраза';

  @override
  String get fragmentTranslationTitle => 'Перевод';

  @override
  String get explainText => 'Объяснить';

  @override
  String get explanationTitle => 'Объяснение';

  @override
  String get explanationSummaryLabel => 'Коротко';

  @override
  String get explanationMeaningLabel => 'В этом контексте';

  @override
  String get explanationBreakdownLabel => 'Как устроено';

  @override
  String get explanationLiteralLabel => 'Дословно';

  @override
  String get explanationNaturalLabel => 'Естественный перевод';

  @override
  String get explanationExamplesLabel => 'Примеры';

  @override
  String get explanationCommonMistakeLabel => 'Частая ошибка';

  @override
  String lemmaDetails(String lemma, String partOfSpeech) {
    return '$lemma · $partOfSpeech';
  }

  @override
  String get bookLoadError => 'Не удалось открыть книгу.';

  @override
  String get unsupportedBook => 'Выберите файл EPUB или TXT в кодировке UTF-8.';

  @override
  String get invalidBook =>
      'Похоже, файл книги повреждён или не поддерживается.';

  @override
  String get shareImportError => 'Не удалось импортировать переданный файл.';

  @override
  String get dictionaryComingSoon => 'Сохранённые слова появятся здесь.';

  @override
  String get searchWords => 'Поиск по словам и переводам';

  @override
  String get allBooks => 'Все книги';

  @override
  String get allStatuses => 'Все статусы';

  @override
  String get statusNew => 'Новое';

  @override
  String get statusLearning => 'Изучается';

  @override
  String get statusLearned => 'Выучено';

  @override
  String get emptyDictionaryTitle => 'Словарь пока пуст';

  @override
  String get emptyDictionaryBody =>
      'Тапните по слову в книге и сохраните его после перевода.';

  @override
  String get dictionaryLoadError => 'Не удалось загрузить словарь.';

  @override
  String get chapter => 'Глава';

  @override
  String readerPageProgress(
    int page,
    String pageCount,
    int chapter,
    int chapterCount,
  ) {
    return 'Стр. $page из $pageCount · глава $chapter из $chapterCount';
  }

  @override
  String readerCompactProgress(int page, String pageCount, int percent) {
    return '$page из $pageCount · $percent%';
  }

  @override
  String readerProgressPreview(int percent, int chapter, int chapterCount) {
    return '$percent% · глава $chapter из $chapterCount';
  }

  @override
  String get previousChapter => 'Предыдущая глава';

  @override
  String get nextChapter => 'Следующая глава';
}
