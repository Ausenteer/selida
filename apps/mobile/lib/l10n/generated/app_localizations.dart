import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_ru.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'generated/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('ru'),
  ];

  /// No description provided for @appName.
  ///
  /// In en, this message translates to:
  /// **'Selida'**
  String get appName;

  /// No description provided for @today.
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get today;

  /// No description provided for @library.
  ///
  /// In en, this message translates to:
  /// **'Library'**
  String get library;

  /// No description provided for @dictionary.
  ///
  /// In en, this message translates to:
  /// **'Dictionary'**
  String get dictionary;

  /// No description provided for @continueReading.
  ///
  /// In en, this message translates to:
  /// **'Continue reading'**
  String get continueReading;

  /// No description provided for @reviewsDue.
  ///
  /// In en, this message translates to:
  /// **'Due for review'**
  String get reviewsDue;

  /// No description provided for @noReviews.
  ///
  /// In en, this message translates to:
  /// **'Your review queue is clear'**
  String get noReviews;

  /// No description provided for @emptyLibraryTitle.
  ///
  /// In en, this message translates to:
  /// **'Your next story starts here'**
  String get emptyLibraryTitle;

  /// No description provided for @emptyLibraryBody.
  ///
  /// In en, this message translates to:
  /// **'Import an EPUB or TXT book and read it at your own pace.'**
  String get emptyLibraryBody;

  /// No description provided for @importBook.
  ///
  /// In en, this message translates to:
  /// **'Import book'**
  String get importBook;

  /// No description provided for @importingBook.
  ///
  /// In en, this message translates to:
  /// **'Preparing book…'**
  String get importingBook;

  /// No description provided for @retry.
  ///
  /// In en, this message translates to:
  /// **'Try again'**
  String get retry;

  /// No description provided for @deleteBook.
  ///
  /// In en, this message translates to:
  /// **'Delete book?'**
  String get deleteBook;

  /// No description provided for @deleteBookBody.
  ///
  /// In en, this message translates to:
  /// **'The book file will be removed. Saved vocabulary will remain.'**
  String get deleteBookBody;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @unknownAuthor.
  ///
  /// In en, this message translates to:
  /// **'Unknown author'**
  String get unknownAuthor;

  /// No description provided for @readerSettings.
  ///
  /// In en, this message translates to:
  /// **'Reading settings'**
  String get readerSettings;

  /// No description provided for @paragraphStyle.
  ///
  /// In en, this message translates to:
  /// **'Paragraphs'**
  String get paragraphStyle;

  /// No description provided for @bookParagraphStyle.
  ///
  /// In en, this message translates to:
  /// **'Book'**
  String get bookParagraphStyle;

  /// No description provided for @modernParagraphStyle.
  ///
  /// In en, this message translates to:
  /// **'Modern'**
  String get modernParagraphStyle;

  /// No description provided for @textAlignment.
  ///
  /// In en, this message translates to:
  /// **'Alignment'**
  String get textAlignment;

  /// No description provided for @readerFont.
  ///
  /// In en, this message translates to:
  /// **'Font'**
  String get readerFont;

  /// No description provided for @fontLiterata.
  ///
  /// In en, this message translates to:
  /// **'Literata'**
  String get fontLiterata;

  /// No description provided for @fontInter.
  ///
  /// In en, this message translates to:
  /// **'Inter'**
  String get fontInter;

  /// No description provided for @alignLeft.
  ///
  /// In en, this message translates to:
  /// **'Left'**
  String get alignLeft;

  /// No description provided for @alignJustified.
  ///
  /// In en, this message translates to:
  /// **'Justified'**
  String get alignJustified;

  /// No description provided for @externalLinkCopied.
  ///
  /// In en, this message translates to:
  /// **'External link copied'**
  String get externalLinkCopied;

  /// No description provided for @searchInBook.
  ///
  /// In en, this message translates to:
  /// **'Search in book'**
  String get searchInBook;

  /// No description provided for @searchBookHint.
  ///
  /// In en, this message translates to:
  /// **'Word or phrase'**
  String get searchBookHint;

  /// No description provided for @searchStartTyping.
  ///
  /// In en, this message translates to:
  /// **'Enter a word or phrase to search the whole book.'**
  String get searchStartTyping;

  /// No description provided for @searchNoResults.
  ///
  /// In en, this message translates to:
  /// **'Nothing found'**
  String get searchNoResults;

  /// No description provided for @searchResultsCount.
  ///
  /// In en, this message translates to:
  /// **'{count} results'**
  String searchResultsCount(int count);

  /// No description provided for @fontSize.
  ///
  /// In en, this message translates to:
  /// **'Text size'**
  String get fontSize;

  /// No description provided for @lineHeight.
  ///
  /// In en, this message translates to:
  /// **'Line spacing'**
  String get lineHeight;

  /// No description provided for @margins.
  ///
  /// In en, this message translates to:
  /// **'Margins'**
  String get margins;

  /// No description provided for @readerBrightness.
  ///
  /// In en, this message translates to:
  /// **'Brightness'**
  String get readerBrightness;

  /// No description provided for @pageAnimation.
  ///
  /// In en, this message translates to:
  /// **'Page animation'**
  String get pageAnimation;

  /// No description provided for @bookLanguage.
  ///
  /// In en, this message translates to:
  /// **'Book language'**
  String get bookLanguage;

  /// No description provided for @englishLanguage.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get englishLanguage;

  /// No description provided for @greekLanguage.
  ///
  /// In en, this message translates to:
  /// **'Greek'**
  String get greekLanguage;

  /// No description provided for @theme.
  ///
  /// In en, this message translates to:
  /// **'Theme'**
  String get theme;

  /// No description provided for @lightTheme.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get lightTheme;

  /// No description provided for @sepiaTheme.
  ///
  /// In en, this message translates to:
  /// **'Sepia'**
  String get sepiaTheme;

  /// No description provided for @darkTheme.
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get darkTheme;

  /// No description provided for @contents.
  ///
  /// In en, this message translates to:
  /// **'Contents'**
  String get contents;

  /// No description provided for @returnToPreviousLocation.
  ///
  /// In en, this message translates to:
  /// **'Return to previous location'**
  String get returnToPreviousLocation;

  /// No description provided for @mappingPrototype.
  ///
  /// In en, this message translates to:
  /// **'Word position: {offset}'**
  String mappingPrototype(int offset);

  /// No description provided for @translationNextMilestone.
  ///
  /// In en, this message translates to:
  /// **'Translation will be connected in milestone 2'**
  String get translationNextMilestone;

  /// No description provided for @translatingWord.
  ///
  /// In en, this message translates to:
  /// **'Translating…'**
  String get translatingWord;

  /// No description provided for @translationOffline.
  ///
  /// In en, this message translates to:
  /// **'You are offline. Cached translations remain available.'**
  String get translationOffline;

  /// No description provided for @translationUnavailable.
  ///
  /// In en, this message translates to:
  /// **'The translation could not be loaded.'**
  String get translationUnavailable;

  /// No description provided for @translationInvalid.
  ///
  /// In en, this message translates to:
  /// **'The service returned an invalid response.'**
  String get translationInvalid;

  /// No description provided for @saveWord.
  ///
  /// In en, this message translates to:
  /// **'Save word'**
  String get saveWord;

  /// No description provided for @wordSaved.
  ///
  /// In en, this message translates to:
  /// **'Word saved'**
  String get wordSaved;

  /// No description provided for @removeFromDictionary.
  ///
  /// In en, this message translates to:
  /// **'Remove from dictionary'**
  String get removeFromDictionary;

  /// No description provided for @savedVocabularyStatus.
  ///
  /// In en, this message translates to:
  /// **'Already in dictionary · {status}'**
  String savedVocabularyStatus(String status);

  /// No description provided for @translateSentence.
  ///
  /// In en, this message translates to:
  /// **'Translate sentence'**
  String get translateSentence;

  /// No description provided for @sentenceAction.
  ///
  /// In en, this message translates to:
  /// **'Sentence'**
  String get sentenceAction;

  /// No description provided for @translateSelection.
  ///
  /// In en, this message translates to:
  /// **'Translate'**
  String get translateSelection;

  /// No description provided for @savePhrase.
  ///
  /// In en, this message translates to:
  /// **'Save phrase'**
  String get savePhrase;

  /// No description provided for @savedAction.
  ///
  /// In en, this message translates to:
  /// **'Saved'**
  String get savedAction;

  /// No description provided for @phraseLabel.
  ///
  /// In en, this message translates to:
  /// **'phrase'**
  String get phraseLabel;

  /// No description provided for @fragmentTranslationTitle.
  ///
  /// In en, this message translates to:
  /// **'Translation'**
  String get fragmentTranslationTitle;

  /// No description provided for @explainText.
  ///
  /// In en, this message translates to:
  /// **'Explain'**
  String get explainText;

  /// No description provided for @explanationTitle.
  ///
  /// In en, this message translates to:
  /// **'Explanation'**
  String get explanationTitle;

  /// No description provided for @explanationSummaryLabel.
  ///
  /// In en, this message translates to:
  /// **'In short'**
  String get explanationSummaryLabel;

  /// No description provided for @explanationMeaningLabel.
  ///
  /// In en, this message translates to:
  /// **'In this context'**
  String get explanationMeaningLabel;

  /// No description provided for @explanationBreakdownLabel.
  ///
  /// In en, this message translates to:
  /// **'How it works'**
  String get explanationBreakdownLabel;

  /// No description provided for @explanationLiteralLabel.
  ///
  /// In en, this message translates to:
  /// **'Literally'**
  String get explanationLiteralLabel;

  /// No description provided for @explanationNaturalLabel.
  ///
  /// In en, this message translates to:
  /// **'Natural translation'**
  String get explanationNaturalLabel;

  /// No description provided for @explanationExamplesLabel.
  ///
  /// In en, this message translates to:
  /// **'Examples'**
  String get explanationExamplesLabel;

  /// No description provided for @explanationCommonMistakeLabel.
  ///
  /// In en, this message translates to:
  /// **'Common mistake'**
  String get explanationCommonMistakeLabel;

  /// No description provided for @lemmaDetails.
  ///
  /// In en, this message translates to:
  /// **'{lemma} · {partOfSpeech}'**
  String lemmaDetails(String lemma, String partOfSpeech);

  /// No description provided for @bookLoadError.
  ///
  /// In en, this message translates to:
  /// **'The book could not be opened.'**
  String get bookLoadError;

  /// No description provided for @unsupportedBook.
  ///
  /// In en, this message translates to:
  /// **'Choose an EPUB or UTF-8 TXT file.'**
  String get unsupportedBook;

  /// No description provided for @invalidBook.
  ///
  /// In en, this message translates to:
  /// **'This book appears to be damaged or unsupported.'**
  String get invalidBook;

  /// No description provided for @shareImportError.
  ///
  /// In en, this message translates to:
  /// **'The shared file could not be imported.'**
  String get shareImportError;

  /// No description provided for @dictionaryComingSoon.
  ///
  /// In en, this message translates to:
  /// **'Saved words will appear here.'**
  String get dictionaryComingSoon;

  /// No description provided for @searchWords.
  ///
  /// In en, this message translates to:
  /// **'Search words and translations'**
  String get searchWords;

  /// No description provided for @allBooks.
  ///
  /// In en, this message translates to:
  /// **'All books'**
  String get allBooks;

  /// No description provided for @allStatuses.
  ///
  /// In en, this message translates to:
  /// **'All statuses'**
  String get allStatuses;

  /// No description provided for @statusNew.
  ///
  /// In en, this message translates to:
  /// **'New'**
  String get statusNew;

  /// No description provided for @statusLearning.
  ///
  /// In en, this message translates to:
  /// **'Learning'**
  String get statusLearning;

  /// No description provided for @statusLearned.
  ///
  /// In en, this message translates to:
  /// **'Learned'**
  String get statusLearned;

  /// No description provided for @emptyDictionaryTitle.
  ///
  /// In en, this message translates to:
  /// **'Your dictionary is empty'**
  String get emptyDictionaryTitle;

  /// No description provided for @emptyDictionaryBody.
  ///
  /// In en, this message translates to:
  /// **'Tap a word in a book and save it after translation.'**
  String get emptyDictionaryBody;

  /// No description provided for @dictionaryLoadError.
  ///
  /// In en, this message translates to:
  /// **'The dictionary could not be loaded.'**
  String get dictionaryLoadError;

  /// No description provided for @chapter.
  ///
  /// In en, this message translates to:
  /// **'Chapter'**
  String get chapter;

  /// No description provided for @readerPageProgress.
  ///
  /// In en, this message translates to:
  /// **'Page {page} of {pageCount} · chapter {chapter} of {chapterCount}'**
  String readerPageProgress(
    int page,
    String pageCount,
    int chapter,
    int chapterCount,
  );

  /// No description provided for @readerCompactProgress.
  ///
  /// In en, this message translates to:
  /// **'{page} of {pageCount} · {percent}%'**
  String readerCompactProgress(int page, String pageCount, int percent);

  /// No description provided for @readerProgressPreview.
  ///
  /// In en, this message translates to:
  /// **'{percent}% · chapter {chapter} of {chapterCount}'**
  String readerProgressPreview(int percent, int chapter, int chapterCount);

  /// No description provided for @previousChapter.
  ///
  /// In en, this message translates to:
  /// **'Previous chapter'**
  String get previousChapter;

  /// No description provided for @nextChapter.
  ///
  /// In en, this message translates to:
  /// **'Next chapter'**
  String get nextChapter;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'ru'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'ru':
      return AppLocalizationsRu();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
