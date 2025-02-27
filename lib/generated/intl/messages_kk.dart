// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a kk locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'kk';

  static String m0(number) => "Объектілерден тұрады: ${number}";

  static String m1(howMany) =>
      "${Intl.plural(howMany, one: '${howMany} тексеру', two: '${howMany} тексеру', other: '${howMany} тексерулер')}";

  static String m2(current, max) => "\n${current} ${max} тіркелді";

  static String m3(minDuration, maxDuration) =>
      "Мин ${minDuration} сек / Макс ${maxDuration} сек";

  static String m4(itemsName) =>
      "${itemsName} әкімші орнатқан баптауларға сәйкес дербес жасау қолжетімді емес";

  static String m5(megabytes) => "${megabytes}Мб жойылды";

  static String m6(itemsName) => "${itemsName} жасау қолжетімді емес";

  static String m7(itemsName) => "${itemsName} жоқ";

  static String m8(localVersion, storeVersion) =>
      " Жаңа жаңартуды қолжетімді, қосымшаны жаңарту қажет\n\nСіздің нұсқаңыз: ${localVersion}\nҚол жетімді нұсқа ${storeVersion}";

  static String m9(progress, count) =>
      "Қайта жібереміз ${progress} / ${count}...";

  static String m10(releaseNotes) => "\n\nСипаты: ${releaseNotes}";

  static String m11(count) =>
      "${count}Объектілерді қосымша жүктеу басталды!\nҚосымшаны өшірмеңіз және интернетке тұрақты қосылуды қамтамасыз етіңіз..";

  static String m12(comment) => "әкімшісінің түсініктемесі: «${comment}»";

  static String m13(path, mbLimit) =>
      "${path} файлдың салмағы  ${mbLimit} мб-тан асады. Жіберу мүмкін емес.";

  static String m14(freeDiskSpace) => "Бос орын аз қалды: ${freeDiskSpace} мб.";

  static String m15(comments) => "Түсініктемемен өткізілген: \r\n${comments}";

  static String m16(phone) =>
      "Растау коды көрсетілген «${phone}» нөміріне жіберілді.";

  static String m17(date) => "${date} дейін орындау";

  static String m18(date) => "${date} орындауды бастау";

  static String m19(id) => "Сәйкестендіргіш көшірілды: ${id}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "accessGranted":
            MessageLookupByLibrary.simpleMessage("Рұқсат берілген"),
        "accountDoesNotExist":
            MessageLookupByLibrary.simpleMessage("Тіркелмеген"),
        "accountSelection":
            MessageLookupByLibrary.simpleMessage("Аккаунтты таңдау:"),
        "accuracyHigh": MessageLookupByLibrary.simpleMessage("Жоғары"),
        "accuracyLow": MessageLookupByLibrary.simpleMessage("Төмен"),
        "accuracyMedium": MessageLookupByLibrary.simpleMessage("Орташа"),
        "addArticleScreenCompanyAddressLabel":
            MessageLookupByLibrary.simpleMessage("Мекенжай"),
        "addArticleScreenCompanyNameLabel":
            MessageLookupByLibrary.simpleMessage("Атауы"),
        "addArticleScreenCreate": MessageLookupByLibrary.simpleMessage("Жасау"),
        "addArticleScreenEnterInn":
            MessageLookupByLibrary.simpleMessage("ЖСН/БСН енгізіңіз"),
        "addArticleScreenInnNotFoundSelectForFillManualy":
            MessageLookupByLibrary.simpleMessage(
                "ЖСН/БСН табылмады қолмен толтыру үшін таңдаңыз "),
        "addArticleScreenLoading":
            MessageLookupByLibrary.simpleMessage("Жүктеу..."),
        "addArticleScreenObjectSuccessfulCreatedMessage":
            MessageLookupByLibrary.simpleMessage("Объект сәтті жасалды"),
        "addingTask": MessageLookupByLibrary.simpleMessage("Тапсырманы жасау"),
        "alertDialogDefaultOkTitle": MessageLookupByLibrary.simpleMessage("OK"),
        "all": MessageLookupByLibrary.simpleMessage("Барлығы"),
        "articleAccountSwitcherChooseCompany":
            MessageLookupByLibrary.simpleMessage("Компанияны таңдаңыз"),
        "articleDetailsContainsObjects": m0,
        "articleDetailsToMainArticles":
            MessageLookupByLibrary.simpleMessage("Негізгі объектілерге"),
        "articleListSortAll": MessageLookupByLibrary.simpleMessage("Барлығы"),
        "articleListSortGroup": MessageLookupByLibrary.simpleMessage("Топтар"),
        "articlePassportArticleType":
            MessageLookupByLibrary.simpleMessage("Объекттің түрі"),
        "articlePassportBodyTitle":
            MessageLookupByLibrary.simpleMessage("Сипаттамалары"),
        "articlePassportHeader":
            MessageLookupByLibrary.simpleMessage("Объектінің паспорты"),
        "articleRowStatusCreatedTitle":
            MessageLookupByLibrary.simpleMessage("Объект жасалды"),
        "articleRowStatusNeedReportTitle":
            MessageLookupByLibrary.simpleMessage("Тексеру сұралды"),
        "articleRowStatusReportConfirmedTitle":
            MessageLookupByLibrary.simpleMessage("Тексеру қабылданды"),
        "articleRowStatusReportDeniedTitle":
            MessageLookupByLibrary.simpleMessage("Тексеруден бас тартылды"),
        "articleRowStatusUndefinedTitle":
            MessageLookupByLibrary.simpleMessage("Белгісіз мәртебе"),
        "articleRowStatusUploadFailedTitle":
            MessageLookupByLibrary.simpleMessage("Жүктеу қатесі"),
        "articleRowStatusUploadingTitle":
            MessageLookupByLibrary.simpleMessage("Тексеруді құру басталды"),
        "articleRowStatusWaitCheckingTitle":
            MessageLookupByLibrary.simpleMessage("Тексеруді күтуде"),
        "articlesScreenArticlesCount": m1,
        "articlesScreenAvailabledArticleNotFoundCanRegister1":
            MessageLookupByLibrary.simpleMessage(
                "Олардың қосылуын күтіңіз немесе \n"),
        "articlesScreenAvailabledArticleNotFoundCanRegister2":
            MessageLookupByLibrary.simpleMessage("өзіңіз жасаңыз"),
        "articlesScreenAvailabledArticleNotFoundCantRegister":
            MessageLookupByLibrary.simpleMessage(
                "Қолжетімді объектілер жоқ, олардың жасалуын күтіңіз."),
        "articlesScreenAwaitOfSending":
            MessageLookupByLibrary.simpleMessage("жіберу күтілуде"),
        "articlesScreenCreateReviewButtonTitle":
            MessageLookupByLibrary.simpleMessage("Тексеруді жасау"),
        "articlesScreenHasNotFinishedReviews":
            MessageLookupByLibrary.simpleMessage("Аяқталмаған тексерулер бар"),
        "articlesScreenHasRequestedReviews":
            MessageLookupByLibrary.simpleMessage("Сұралған тексерулер бар"),
        "articlesScreenNeedToChooseCompany":
            MessageLookupByLibrary.simpleMessage(
                "Алдымен компанияны таңдау қажет"),
        "articlesScreenNetworkException": MessageLookupByLibrary.simpleMessage(
            "Интернетке қосылу жоқ.\nТапсырмалар қолжетімді емес."),
        "articlesScreenNothingFound": MessageLookupByLibrary.simpleMessage(
            "Өкінішке қарай ештеңе табылмады."),
        "articlesScreenRegisterReviews": MessageLookupByLibrary.simpleMessage(
            "Серверде тексерулерді тіркеу...\n"),
        "articlesScreenRegisterReviewsFinish": MessageLookupByLibrary.simpleMessage(
            "Тексерулер сәтті тіркелді және файлдарды жүктеу автономды режимде жалғасады, қосымшаны және интернетті өшірмеңіз.\n"),
        "articlesScreenRegisterReviewsFinishGoBack":
            MessageLookupByLibrary.simpleMessage("Қосымшаға оралу"),
        "articlesScreenRegisterReviewsStatus": m2,
        "articlesScreenRegisterReviewsUnxpectedException":
            MessageLookupByLibrary.simpleMessage(
                "Тексерулерді тіркеу кезінде қате орын алды, кейінірек әрекетті қайталап көріңіз.\n"),
        "articlesScreenRegisterReviewsUnxpectedExceptionGoBack":
            MessageLookupByLibrary.simpleMessage("Қосымшаға оралу"),
        "articlesScreenSawDownloads":
            MessageLookupByLibrary.simpleMessage("Жүктеулерді қарап шығу"),
        "articlesScreenSearch": MessageLookupByLibrary.simpleMessage("Іздеу"),
        "articlesScreenSearchEmpty":
            MessageLookupByLibrary.simpleMessage("Ештеңе табылмады"),
        "articlesScreenSearchFieldLabel":
            MessageLookupByLibrary.simpleMessage("Іздеу"),
        "articlesScreenSendSavedArticles": MessageLookupByLibrary.simpleMessage(
            "Сақталған тексерулерді жіберу"),
        "articlesScreenTitle":
            MessageLookupByLibrary.simpleMessage("Объектілер"),
        "articlesScreenUploadsButtonTitle":
            MessageLookupByLibrary.simpleMessage("Жүктеулер"),
        "audio": MessageLookupByLibrary.simpleMessage("Аудио"),
        "audioFileName":
            MessageLookupByLibrary.simpleMessage("Аудио файл атауы"),
        "audioRecording": MessageLookupByLibrary.simpleMessage("Аудио жазу"),
        "audioRecordingRestrictions": m3,
        "boolDialogDefaultApproveTitle":
            MessageLookupByLibrary.simpleMessage("Иә"),
        "boolDialogDefaultDenyTitle":
            MessageLookupByLibrary.simpleMessage("Жоқ"),
        "camera": MessageLookupByLibrary.simpleMessage("Камера"),
        "canNotGetToWork": MessageLookupByLibrary.simpleMessage(
            "Жұмысқа қабылдау мүмкін емес"),
        "checkYourInternetConnectionAndTryAgain":
            MessageLookupByLibrary.simpleMessage(
                "Өзіңіздің интернет байланысыңызды тексеріп, қайта көріңіз."),
        "checksWithThisNameNotFound": MessageLookupByLibrary.simpleMessage(
            "Мұндай атауы бар тексерулер табылмады"),
        "chooseAnotherReport": MessageLookupByLibrary.simpleMessage(
            "Жұмыс үшін басқа тексеруді таңдаңыз"),
        "chooseCreatingArticleType":
            MessageLookupByLibrary.simpleMessage("Объекті түрін таңдаңыз"),
        "chooseReviewTemplateNoInternet": MessageLookupByLibrary.simpleMessage(
            "Интернетке қосылыс жоқ.\nҚарап шығу үлгісін таңдау қолжетімді емес."),
        "chooseReviewTemplateScreenAvailable":
            MessageLookupByLibrary.simpleMessage(
                "Дербес тексеру үшін қолжетімді"),
        "chooseReviewTemplateScreenAwaitForContinue":
            MessageLookupByLibrary.simpleMessage("Орындалуын күтуде"),
        "chooseReviwTemplate":
            MessageLookupByLibrary.simpleMessage("Үлгіні таңдау"),
        "chooseReviwTemplateInternetException":
            MessageLookupByLibrary.simpleMessage("Интернетке қосылу қатесі"),
        "chooseReviwTemplateScreenContinueReview":
            MessageLookupByLibrary.simpleMessage(
                "НТексеруді құрастыруды жалғастыру үшін басыңыз"),
        "choosingCreatingArticleTypeInternetException":
            MessageLookupByLibrary.simpleMessage(
                "Интернетке қосылу жоқ.\nТексеру объектілерінің түрлері қол жетімді емес."),
        "comment": MessageLookupByLibrary.simpleMessage("Түсініктеме"),
        "commentText":
            MessageLookupByLibrary.simpleMessage("Түсініктеме мәтіні"),
        "confirm": MessageLookupByLibrary.simpleMessage("Растау"),
        "confirmTheAction":
            MessageLookupByLibrary.simpleMessage("Әрекетті растаңыз"),
        "contractorDelegateToIsUnregistered":
            MessageLookupByLibrary.simpleMessage(
                "Делегация жүзеге асырылған Орындаушы тіркелмеген"),
        "contractorPhoneNumber":
            MessageLookupByLibrary.simpleMessage("Орындаушының телефон нөмірі"),
        "copySection": MessageLookupByLibrary.simpleMessage("Бөлімді көшіру"),
        "copyStep": MessageLookupByLibrary.simpleMessage("Қадамды көшіру"),
        "copyingSection":
            MessageLookupByLibrary.simpleMessage("Бөлімді көшіру"),
        "copyingSectionInstruction": MessageLookupByLibrary.simpleMessage(
            "Қадамдар тобын көшіру қайталанатын процестерді ойнатуға мүмкіндік береді"),
        "copyingStep": MessageLookupByLibrary.simpleMessage("Қадамды көшіру"),
        "copyingStepInstruction": MessageLookupByLibrary.simpleMessage(
            "Қадамды көшіру қайталанатын процестерді ойнатуға мүмкіндік береді"),
        "create": MessageLookupByLibrary.simpleMessage("Жасау"),
        "createAdditionalStep":
            MessageLookupByLibrary.simpleMessage("Қосымша қадам жасау"),
        "createNewStep":
            MessageLookupByLibrary.simpleMessage("Жаңа қадам жасаңыз"),
        "createTask": MessageLookupByLibrary.simpleMessage("Тапсырманы жасау"),
        "created": MessageLookupByLibrary.simpleMessage("Құрылды"),
        "creatingOrUploading":
            MessageLookupByLibrary.simpleMessage("Жасау немесе жүктеу"),
        "creationOfItemsIsNotAvailableDescription": m4,
        "dataTransferredToResponsible": MessageLookupByLibrary.simpleMessage(
            "Деректер жауапты тұлғаға берілді"),
        "deadline": MessageLookupByLibrary.simpleMessage("Орындау мерзімі"),
        "delegated": MessageLookupByLibrary.simpleMessage("Өкілетті"),
        "delegation": MessageLookupByLibrary.simpleMessage("Делегация"),
        "delegationImpossible":
            MessageLookupByLibrary.simpleMessage("Делегация мүмкін емес"),
        "delegationSuccess":
            MessageLookupByLibrary.simpleMessage("Делегация сәтті өтті"),
        "deleteAccountDialogDescription": MessageLookupByLibrary.simpleMessage(
            "Растау түймесін басу арқылы сіз қолданбадан шығып, есептік жазбаңызды тиісті жеке деректермен бірге жоясыз."),
        "deleted": MessageLookupByLibrary.simpleMessage("Жойылды"),
        "editingTask":
            MessageLookupByLibrary.simpleMessage("Тапсырманы редакциялау"),
        "enterCompany":
            MessageLookupByLibrary.simpleMessage("Компанияны енгізіңіз"),
        "enterContractorPhoneNumberToDelegate":
            MessageLookupByLibrary.simpleMessage(
                "Өкілдік ету үшін Орындаушының телефон нөмірін енгізіңіз.\n"),
        "enterEmail": MessageLookupByLibrary.simpleMessage(
            "Электрондық поштаны енгізіңіз"),
        "enterIdForAccountIdentification": MessageLookupByLibrary.simpleMessage(
            "Есептік жазбаны анықтау үшін ID енгізіңіз.\n"),
        "enterIdForRegistration": MessageLookupByLibrary.simpleMessage(
            "Тіркелу үшін ID нөмірін енгізіңіз"),
        "enterIdSecondScreen":
            MessageLookupByLibrary.simpleMessage("ID нөмірін енгізіңіз"),
        "enterLastName":
            MessageLookupByLibrary.simpleMessage("Фамилияны енгізіңіз"),
        "enterName": MessageLookupByLibrary.simpleMessage("Атын енгізіңіз"),
        "enterNewSectionName": MessageLookupByLibrary.simpleMessage(
            "Бөлімнің жаңа атауын көрсетіңіз"),
        "enterObjectAddress": MessageLookupByLibrary.simpleMessage(
            "Объектінің мекенжайын таңдаңыз"),
        "enterPosition":
            MessageLookupByLibrary.simpleMessage("Лауазымды енгізіңіз"),
        "error": MessageLookupByLibrary.simpleMessage("Қате:"),
        "errorNoConnectionDescription": MessageLookupByLibrary.simpleMessage(
            "Серверге қосылу мүмкін болмады, оффлайн режимде жұмыс жасау үшін сақталған деректер жоқ."),
        "example": MessageLookupByLibrary.simpleMessage("Мысал"),
        "failedToDetermineLocation": MessageLookupByLibrary.simpleMessage(
            "Орналасу орнын анықтау мүмкін болмады"),
        "fillInTheField":
            MessageLookupByLibrary.simpleMessage("Өрісті толтырыңыз"),
        "getIdFromManager": MessageLookupByLibrary.simpleMessage(
            "Идентификаторды менеджерден, контрагенттен алуға болады немесе оны тікелей объектіге орналастыруға болады"),
        "goToCreateAnAdditionalStep": MessageLookupByLibrary.simpleMessage(
            "Қосымша қадам жасауға көшу керек пе?"),
        "goToReportsNavigation":
            MessageLookupByLibrary.simpleMessage("Тексерулерге өтіңіз"),
        "goToSettingsAndGiveAccessTo": MessageLookupByLibrary.simpleMessage(
            "Қосымшаның дұрыс жұмыс істеуі үшін рұқсат беру қажет:"),
        "gotToWork": MessageLookupByLibrary.simpleMessage("Жұмысқа қабылданды"),
        "haveNoArticlesAvailable":
            MessageLookupByLibrary.simpleMessage("Қолжетімді нысандар жоқ"),
        "haveNoTaskTypesAvailable": MessageLookupByLibrary.simpleMessage(
            "Тапсырма түрлері қолжетімді емес"),
        "haveNoTemplatesAvailable":
            MessageLookupByLibrary.simpleMessage("Үлгілер қолжетімді емес"),
        "help": MessageLookupByLibrary.simpleMessage("Көмек"),
        "helpCreateMessageScreenInternetException":
            MessageLookupByLibrary.simpleMessage("Интернетке қосылу қатесі"),
        "helpCreateMessageScreenMessage":
            MessageLookupByLibrary.simpleMessage("Хабар мәтіні"),
        "helpCreateMessageScreenMessageDescription":
            MessageLookupByLibrary.simpleMessage(
                "Өтініштің мәнін 2-3 сөйлемде баяндаңыз."),
        "helpCreateMessageScreenPhoneNumber":
            MessageLookupByLibrary.simpleMessage("Телефон нөмірі"),
        "helpCreateMessageScreenPhoneNumberDescription":
            MessageLookupByLibrary.simpleMessage(
                "Кері байланыс үшін телефон нөмірін көрсетіңіз."),
        "helpCreateMessageScreenSend":
            MessageLookupByLibrary.simpleMessage("Жіберу"),
        "helpCreateMessageScreenSendMessage":
            MessageLookupByLibrary.simpleMessage("Хабарды жіберу"),
        "helpCreateMessageScreenYourMessageSended":
            MessageLookupByLibrary.simpleMessage("Сіздің хабарыңыз жіберілді!"),
        "helpInsuranceCase":
            MessageLookupByLibrary.simpleMessage("Сақтандыру жағдайы"),
        "helpQuestionsScreenHasNotQuestionsAndAnswers":
            MessageLookupByLibrary.simpleMessage("Сұрақтар мен жауаптар жоқ"),
        "helpQuestionsScreenTitle":
            MessageLookupByLibrary.simpleMessage("Сұрақтар мен жауаптар"),
        "helpScreenCallUs":
            MessageLookupByLibrary.simpleMessage("Бізге қоңырау шалыңыз"),
        "helpScreenCleanMemory":
            MessageLookupByLibrary.simpleMessage("Жадты тазалау"),
        "helpScreenCleanMemoryAreYouSure": MessageLookupByLibrary.simpleMessage(
            "Барлық файлдарды жойғыңыз келетініе сенімдісіз бе?"),
        "helpScreenCleanMemoryNo": MessageLookupByLibrary.simpleMessage("Жоқ"),
        "helpScreenCleanMemoryProccessIsIrrevirsable":
            MessageLookupByLibrary.simpleMessage(
                "Кэштелген және жіберілмеген файлдар жоғалады, қайта айналмайтын процесс."),
        "helpScreenCleanMemoryYes": MessageLookupByLibrary.simpleMessage("Иә"),
        "helpScreenClearedMemoryToast": m5,
        "helpScreenExportFilesButtonTitle":
            MessageLookupByLibrary.simpleMessage("Файлдарды түсіру"),
        "helpScreenNeedToChooseCompany": MessageLookupByLibrary.simpleMessage(
            "Алдымен «Объектілер» экранында компанияны таңдау керек"),
        "helpScreenQuestionsAndAnswers":
            MessageLookupByLibrary.simpleMessage("Сұрақтар мен жауаптар"),
        "helpScreenSendMessage":
            MessageLookupByLibrary.simpleMessage("Хабарды жіберу"),
        "helpScreenTitle": MessageLookupByLibrary.simpleMessage("Көмек"),
        "helpScreenWriteEmail":
            MessageLookupByLibrary.simpleMessage("Бізге поштаға жазыңыз"),
        "hide": MessageLookupByLibrary.simpleMessage("Жасыру"),
        "high": MessageLookupByLibrary.simpleMessage("Жоғары"),
        "ifContractorUnregisteredEnterInfoAbout":
            MessageLookupByLibrary.simpleMessage(
                "Егер Орындаушы жүйеде тіркелмеген болса, орындаушы туралы қажетті ақпаратты енгізу қажет"),
        "independentCreationArticlesIsNotAvailableBySystemSettings":
            MessageLookupByLibrary.simpleMessage(
                "Әкімші орнатқан параметрлерге сәйкес нысандарды тәуелсіз құру мүмкін емес"),
        "instruction": MessageLookupByLibrary.simpleMessage("Нұсқаулық"),
        "internetConnectionError":
            MessageLookupByLibrary.simpleMessage("Интернетке қосылу қатесі"),
        "isNeedRework":
            MessageLookupByLibrary.simpleMessage("Пысықтауды қажет етеді"),
        "itemCreationNotAvailable": m6,
        "itemsMissing": m7,
        "linkedCheckBoxCancelButton":
            MessageLookupByLibrary.simpleMessage("Болдырмау"),
        "linkedCheckBoxPrivacyAgreementFirst":
            MessageLookupByLibrary.simpleMessage(
                "Мен қарапайым электрондық қолтаңбаны "),
        "linkedCheckBoxPrivacyAgreementSecond":
            MessageLookupByLibrary.simpleMessage("пайдалану келісімін "),
        "linkedCheckBoxPrivacyAgreementThird":
            MessageLookupByLibrary.simpleMessage(" қабылдаймын"),
        "linkedCheckBoxSendButton":
            MessageLookupByLibrary.simpleMessage("Қол қойып жіберу"),
        "loadingScreenConnectingToServer": MessageLookupByLibrary.simpleMessage(
            "Сервермен қосылудамыз, күте тұрыңыз..."),
        "loadingScreenHasBeenCriticalError1":
            MessageLookupByLibrary.simpleMessage("Сыни қате орын алды\n"),
        "loadingScreenHasBeenCriticalError2": MessageLookupByLibrary.simpleMessage(
            "Интернет қолданысының аймағындағы қосымшаны қайта іске қосыңыз.\nЕгер проблема сақталса -"),
        "loadingScreenHasBeenCriticalError3":
            MessageLookupByLibrary.simpleMessage("әрекетті қайталап көріңіз"),
        "loadingScreenHasBeenCriticalError4":
            MessageLookupByLibrary.simpleMessage(" немесе "),
        "loadingScreenHasBeenCriticalError5":
            MessageLookupByLibrary.simpleMessage(
                "қосымшадан файлдарды түсіріңіз"),
        "loadingScreenHasBeenCriticalError6":
            MessageLookupByLibrary.simpleMessage(", содан кейін "),
        "loadingScreenHasBeenCriticalError7":
            MessageLookupByLibrary.simpleMessage("қосымшаны қайта орнатыңыз."),
        "loadingScreenHasNewUpdate": m8,
        "loadingScreenHasNewUpdateText1": MessageLookupByLibrary.simpleMessage(
            "Жаңа жаңарту қолжетімді.\n\n"),
        "loadingScreenHasNewUpdateText2":
            MessageLookupByLibrary.simpleMessage("Қосымшаны жаңартыңыз.\n\n"),
        "loadingScreenHasNewUpdateText3":
            MessageLookupByLibrary.simpleMessage("Жаңарту"),
        "loadingScreenLoadingAppTitle":
            MessageLookupByLibrary.simpleMessage("Қосымшаны жүктейміз..."),
        "loadingScreenRetrying": MessageLookupByLibrary.simpleMessage(
            "Әрекетті қайталап көрейік..."),
        "loadingScreenRetryingSending": m9,
        "loadingScreenStartingOfflineMode":
            MessageLookupByLibrary.simpleMessage(
                "Қосымшаны offline режимінде іске қосу."),
        "loadingScreenUpdateDialogDismissButtonTitle":
            MessageLookupByLibrary.simpleMessage("Кейінірек"),
        "loadingScreenUpdateDialogTitle":
            MessageLookupByLibrary.simpleMessage("Жаңарту"),
        "loadingScreenUpdateDialogUpdateButtonTitle":
            MessageLookupByLibrary.simpleMessage("Жаңарту"),
        "loadingScreenUpdateHasNotes": m10,
        "loadingScreenUploadingFilesStarted": m11,
        "locatingDescription": MessageLookupByLibrary.simpleMessage(
            "Орналасқан жерін анықтау жылдамдығы ағымдағы жағдайларға байланысты: спутниктердің қолжетімділігі, бұлттылық, ғимарат түріндегі кедергілер."),
        "locatingRecommendation": MessageLookupByLibrary.simpleMessage(
            "Егер сіз үй-жайдың ішінде болсаңыз, терезеге келіңіз немесе көшеге шығыңыз."),
        "location": MessageLookupByLibrary.simpleMessage("Орналасқан жері"),
        "locationDetermining":
            MessageLookupByLibrary.simpleMessage("Орналасқан жері анықталуда"),
        "logOutAndDeleteYourAccount": MessageLookupByLibrary.simpleMessage(
            "Шығу және есептік жазбаны жою"),
        "loginScreenPasswordHint":
            MessageLookupByLibrary.simpleMessage("* Құпиясөз"),
        "loginScreenPasswordLabel":
            MessageLookupByLibrary.simpleMessage("Құпиясөз"),
        "loginScreenPhoneHint":
            MessageLookupByLibrary.simpleMessage("* Телефон нөмірі"),
        "loginScreenPhoneLabel":
            MessageLookupByLibrary.simpleMessage("Телефон нөмірі"),
        "loginScreenPrivacy1": MessageLookupByLibrary.simpleMessage(
            "«Кіру» түймешігін басу арқылы менің жеке ақпаратымды "),
        "loginScreenPrivacy2": MessageLookupByLibrary.simpleMessage(
            "Құпиялылық саясаты шартымен өңдеуге келісемін "),
        "loginScreenRecoveryPasswordLink2":
            MessageLookupByLibrary.simpleMessage("Құпиясөзді қалпына келтіру"),
        "loginScreenRecoveryPasswordLinkTitle":
            MessageLookupByLibrary.simpleMessage("Құпиясөзді қалпына келтіру"),
        "loginScreenSignInButtonTitle":
            MessageLookupByLibrary.simpleMessage("Кіру"),
        "loginScreenSignupButtonTitle":
            MessageLookupByLibrary.simpleMessage("Тіркелу"),
        "loginScreenSignupOrRecoveryPassword":
            MessageLookupByLibrary.simpleMessage(" немесе "),
        "loginScreenTitle":
            MessageLookupByLibrary.simpleMessage("Өз аккаунтыңызға кіріңіз"),
        "loginScreenUserAgreement1": MessageLookupByLibrary.simpleMessage(
            "«Кіру» түймешігін басу арқылы"),
        "loginScreenUserAgreement2":
            MessageLookupByLibrary.simpleMessage("Пайдаланушы келісімімен"),
        "loginScreenUserAgreement3": MessageLookupByLibrary.simpleMessage(
            "және менің дербес ақпаратымды"),
        "loginScreenUserAgreement4": MessageLookupByLibrary.simpleMessage(
            "Құпиялылық саясаты шарттарымен өңдеуге келісемін"),
        "low": MessageLookupByLibrary.simpleMessage("Төмен"),
        "main": MessageLookupByLibrary.simpleMessage("Басты"),
        "makeDocumentPageAndroidBWTitle":
            MessageLookupByLibrary.simpleMessage("Қ/А"),
        "makeDocumentPageAndroidCropReset":
            MessageLookupByLibrary.simpleMessage("Болдырмау"),
        "makeDocumentPageAndroidCropTitle":
            MessageLookupByLibrary.simpleMessage("Редакциялау"),
        "makeDocumentPageAndroidScan":
            MessageLookupByLibrary.simpleMessage("Сканерлеу"),
        "makeDocumentPageTitle":
            MessageLookupByLibrary.simpleMessage("Құжаттың көшірмесін жасау"),
        "makeMediaPageCameraAccesException":
            MessageLookupByLibrary.simpleMessage("Камераға рұқсат жоқ"),
        "makeMediaPageCameraException":
            MessageLookupByLibrary.simpleMessage("Камера қатесі"),
        "makeMediaPageMicAccesException":
            MessageLookupByLibrary.simpleMessage("Микрофонға рұқсат жоқ"),
        "makeMediaPageOpenAppSettings":
            MessageLookupByLibrary.simpleMessage("Қосымша баптауларын ашу"),
        "makeMediaPagePhoto": MessageLookupByLibrary.simpleMessage("Сурет"),
        "makeMediaPageSomethingWentWrong": MessageLookupByLibrary.simpleMessage(
            "Қандай да бір қате орын алды"),
        "makeMediaPageStandBy": MessageLookupByLibrary.simpleMessage(
            "Өңдеу және сақтау жүргізілуде, қосымшаны жаппаңыз, аяқталуын күтіңіз"),
        "makeMediaPageUndefined":
            MessageLookupByLibrary.simpleMessage("undefined"),
        "makeMediaPageVideo":
            MessageLookupByLibrary.simpleMessage("Бейнежазба"),
        "makeReportPageAddAnotherFile":
            MessageLookupByLibrary.simpleMessage("Қосымша файл қосу"),
        "makeReportPageAddFile":
            MessageLookupByLibrary.simpleMessage("Файлды қосу"),
        "makeReportPageAddStep":
            MessageLookupByLibrary.simpleMessage("Қадамды қосу"),
        "makeReportPageAdminComment": m12,
        "makeReportPageAnotherReportWithThisTemplate":
            MessageLookupByLibrary.simpleMessage(
                "Осы үлгі бойынша тағы бір тексеруді жүргізгіңіз келе ме?"),
        "makeReportPageAreYouSureForDelete":
            MessageLookupByLibrary.simpleMessage(
                "Осы тексеруді жойғыңыз келе ме?"),
        "makeReportPageAreYouSureForExit": MessageLookupByLibrary.simpleMessage(
            "Шыққыңыз келетініне сенімдісіз бе?"),
        "makeReportPageCancel":
            MessageLookupByLibrary.simpleMessage("Болдырмау"),
        "makeReportPageChooseAnotherFile":
            MessageLookupByLibrary.simpleMessage("Басқа файлды таңдау"),
        "makeReportPageContinue":
            MessageLookupByLibrary.simpleMessage("Жалғастыру"),
        "makeReportPageFile": MessageLookupByLibrary.simpleMessage("Файл"),
        "makeReportPageFillTheAnotherForm":
            MessageLookupByLibrary.simpleMessage("Қосымша нысанды толтыру"),
        "makeReportPageFillTheForm":
            MessageLookupByLibrary.simpleMessage("Нысанды толтыру"),
        "makeReportPageFinish": MessageLookupByLibrary.simpleMessage("Аяқтау"),
        "makeReportPageHaveNotLocationPermission":
            MessageLookupByLibrary.simpleMessage(
                "Орналасқан жерін анықтау үшін құқықтар жеткіліксіз"),
        "makeReportPageHugeFile": m13,
        "makeReportPageIssueOccured":
            MessageLookupByLibrary.simpleMessage("Бұзушылық анықталды"),
        "makeReportPageLocating": MessageLookupByLibrary.simpleMessage(
            "Орналасқан жерді анықтаймын..."),
        "makeReportPageLowSpace": m14,
        "makeReportPageMakeAdditionalPhoto":
            MessageLookupByLibrary.simpleMessage("Қосымша суретке түсіру"),
        "makeReportPageMakeAdditionalScan":
            MessageLookupByLibrary.simpleMessage("Қосымша скан жасау"),
        "makeReportPageMakeAdditionalVideo":
            MessageLookupByLibrary.simpleMessage("Қосымша бейне жазу"),
        "makeReportPageMakePhoto":
            MessageLookupByLibrary.simpleMessage("Суретке түсіру"),
        "makeReportPageMakeScan":
            MessageLookupByLibrary.simpleMessage("Скан жасау"),
        "makeReportPageMissedWithComments": m15,
        "makeReportPageNo": MessageLookupByLibrary.simpleMessage("Жоқ"),
        "makeReportPageNotEnoughDishSpace":
            MessageLookupByLibrary.simpleMessage("Бос орын жеткіліксіз"),
        "makeReportPageOpenAppSettings":
            MessageLookupByLibrary.simpleMessage("Қосымшаның баптауларын ашу"),
        "makeReportPagePopupMessage": MessageLookupByLibrary.simpleMessage(
            "Тексеруді аяқтау үшін міндетті қадамдардан өту қажет"),
        "makeReportPageReasonForSkip": MessageLookupByLibrary.simpleMessage(
            "Өткізіп жіберу себебін көрсетіңіз"),
        "makeReportPageRemakePhoto":
            MessageLookupByLibrary.simpleMessage("Суретті қайта түсіру"),
        "makeReportPageRemakeScan":
            MessageLookupByLibrary.simpleMessage("Сканды қайта түсіру"),
        "makeReportPageRemakeVideo":
            MessageLookupByLibrary.simpleMessage("Бейнені жазу"),
        "makeReportPageRepeatableReport":
            MessageLookupByLibrary.simpleMessage("Қайталанатын тексеру"),
        "makeReportPageReportIsCreated":
            MessageLookupByLibrary.simpleMessage("Рахмет! Тексеру жасалды!"),
        "makeReportPageScan": MessageLookupByLibrary.simpleMessage("Скан"),
        "makeReportPageSend": MessageLookupByLibrary.simpleMessage("Жіберу"),
        "makeReportPageSendingData": MessageLookupByLibrary.simpleMessage(
            "Деректерді серверге жібереміз...\nКүте тұрыңыз."),
        "makeReportPageSkip":
            MessageLookupByLibrary.simpleMessage("Өткізіп жіберу "),
        "makeReportPageSkipAndFinish":
            MessageLookupByLibrary.simpleMessage("Өткізіп жіберу және аяқтау"),
        "makeReportPageTapToChange":
            MessageLookupByLibrary.simpleMessage("Өзгерту үшін басыңыз"),
        "makeReportPageTapToWatch":
            MessageLookupByLibrary.simpleMessage("Қарап шығу үшін басыңыз"),
        "makeReportPageUndefinedState":
            MessageLookupByLibrary.simpleMessage("Анықталмаған күй"),
        "makeReportPageYes": MessageLookupByLibrary.simpleMessage("Иә"),
        "maximumNumberFilesReached": MessageLookupByLibrary.simpleMessage(
            "Осы типтегі файлдардың максималды санына қол жеткізілді"),
        "mediaFilesDoNotSaved": MessageLookupByLibrary.simpleMessage(
            "Медиафайлдар сақталмаған. Сақтау керек пе?"),
        "medium": MessageLookupByLibrary.simpleMessage("Орташа"),
        "microphone": MessageLookupByLibrary.simpleMessage("Микрофон"),
        "minimumAudioLengthNotReached": MessageLookupByLibrary.simpleMessage(
            "Аудиожазбаның минималды ұзақтығына қол жеткізілмеді"),
        "minimumVideoLengthNotReached": MessageLookupByLibrary.simpleMessage(
            "Бейненің ең аз ұзақтығына қол жеткізілмеді"),
        "missingObjectsName":
            MessageLookupByLibrary.simpleMessage("объектілер"),
        "missingReviewsName":
            MessageLookupByLibrary.simpleMessage("тексерулер"),
        "missingTasksName": MessageLookupByLibrary.simpleMessage("міндеттер"),
        "myTextFieldDefaultDateHint":
            MessageLookupByLibrary.simpleMessage("Күнді енгізіңіз"),
        "myTextFieldDefaultNumberHint":
            MessageLookupByLibrary.simpleMessage("Санды енгізіңіз"),
        "myTextFieldDefaultTextHint":
            MessageLookupByLibrary.simpleMessage("Мәтінді енгізіңіз"),
        "necessaryActionsForTask": MessageLookupByLibrary.simpleMessage(
            "Тапсырма бойынша қажетті әрекеттер"),
        "networkException":
            MessageLookupByLibrary.simpleMessage("Интернетке қосылу қатесі "),
        "newContractorPhoneNumber": MessageLookupByLibrary.simpleMessage(
            "Жаңа Орындаушының телефон нөмірі"),
        "noAccessToGetExactLocation": MessageLookupByLibrary.simpleMessage(
            "Нақты орналасу орнын алу үшін рұқсат жоқ"),
        "noAccessToGetLocation": MessageLookupByLibrary.simpleMessage(
            "Орналасу орнын алу үшін рұқсат жоқ"),
        "noAvailableArticleTypes": MessageLookupByLibrary.simpleMessage(
            "Жасау үшін қарау объектілерінің қолжетімді түрлері жоқ.\n«Көмек» бетінде техникалық қолдаумен хабарласыңыз"),
        "noAvailableReviwTemplatesForThisArticle":
            MessageLookupByLibrary.simpleMessage(
                "Бұл объект үшін қолжетімді қарау үлгілері жоқ"),
        "noAvailableTasks":
            MessageLookupByLibrary.simpleMessage("Қолжетімді тапсырмалар жоқ"),
        "noChecksScheduledOrStarted": MessageLookupByLibrary.simpleMessage(
            "Тексерулер жоқ. Оларды тағайындауды күтіңіз немесе өзіңіз жасаңыз"),
        "noInReworkChecks": MessageLookupByLibrary.simpleMessage(
            "Пысықтауды қажет ететін тексерулер жоқ"),
        "noInternetConnectionNotifications":
            MessageLookupByLibrary.simpleMessage(
                "Интернетке қосылыс жоқ.\nХабарландырулар қолжетімді емес."),
        "noScheduledChecks": MessageLookupByLibrary.simpleMessage(
            "Тағайындалған тексерулер жоқ"),
        "noStartedChecks":
            MessageLookupByLibrary.simpleMessage("Жұмыста тексерулер жоқ"),
        "notAllRequiredPermitsHaveBeenIssued":
            MessageLookupByLibrary.simpleMessage(
                "Барлық қажетті рұқсаттар берілмеген"),
        "notAllStepsHaveBeenCompleted": MessageLookupByLibrary.simpleMessage(
            "Тексеруді аяқтау үшін барлық міндетті қадамдардан өту қажет"),
        "notifications": MessageLookupByLibrary.simpleMessage("Хабарламалар"),
        "notificationsScreenTitle":
            MessageLookupByLibrary.simpleMessage("Оқиғалар"),
        "notificationsScreenYetHaveNotNotifications":
            MessageLookupByLibrary.simpleMessage("Сізге хабарландыру әлі жоқ"),
        "numberOfCopies":
            MessageLookupByLibrary.simpleMessage("Көшірмелер саны"),
        "numberOfImagesExceeded": MessageLookupByLibrary.simpleMessage(
            "Таңдалған суреттердің саны асып кетті. Максимум - "),
        "object": MessageLookupByLibrary.simpleMessage("Объект"),
        "objects": MessageLookupByLibrary.simpleMessage("Объектілер"),
        "objectsWithThisNameNotFound": MessageLookupByLibrary.simpleMessage(
            "Мұндай атауы бар объектілер табылмады"),
        "ok": MessageLookupByLibrary.simpleMessage("ОК"),
        "onCenterWidgetUndefined":
            MessageLookupByLibrary.simpleMessage("undefined"),
        "pickDate": MessageLookupByLibrary.simpleMessage("Күнді таңдау"),
        "pickObject": MessageLookupByLibrary.simpleMessage("Объектіні таңдау"),
        "pickPriority":
            MessageLookupByLibrary.simpleMessage("Басымдықты таңдаңыз"),
        "pickTaskType":
            MessageLookupByLibrary.simpleMessage("Тапсырма түрін таңдаңыз"),
        "picture": MessageLookupByLibrary.simpleMessage("Сурет"),
        "pleaseWait": MessageLookupByLibrary.simpleMessage("Күте тұрыңыз"),
        "previewPhotoScreenEnterComment": MessageLookupByLibrary.simpleMessage(
            "Түсініктеме мәтінін енгізіңіз"),
        "previewPhotoScreenUnexpectedFileFormat":
            MessageLookupByLibrary.simpleMessage(
                "Белгісіз файл форматы немесе оны анықтау мүмкін болмады"),
        "priority": MessageLookupByLibrary.simpleMessage("Басымдық"),
        "proceedToReview":
            MessageLookupByLibrary.simpleMessage("Тексеруге өтіңіз"),
        "profileScreenCompanyInn":
            MessageLookupByLibrary.simpleMessage("Компанияның ЖСН/БСН"),
        "profileScreenEmail": MessageLookupByLibrary.simpleMessage("Email"),
        "profileScreenJobTitle":
            MessageLookupByLibrary.simpleMessage("Лауазым"),
        "profileScreenName": MessageLookupByLibrary.simpleMessage("Аты"),
        "profileScreenPassword":
            MessageLookupByLibrary.simpleMessage("Құпиясөз"),
        "profileScreenPatronymic":
            MessageLookupByLibrary.simpleMessage("Әкесінің аты"),
        "profileScreenPhoneNumber":
            MessageLookupByLibrary.simpleMessage("Ұялы телефон"),
        "profileScreenRepeatPassword":
            MessageLookupByLibrary.simpleMessage("Құпиясөзді қайталаңыз"),
        "profileScreenSave": MessageLookupByLibrary.simpleMessage("Сақтау"),
        "profileScreenSurname": MessageLookupByLibrary.simpleMessage("Тегі"),
        "recoveryScreenHintTitle":
            MessageLookupByLibrary.simpleMessage("Телефон нөмірін енгізіңіз"),
        "recoveryScreenPasswordHasBeenSentOnSpecifiedPhone":
            MessageLookupByLibrary.simpleMessage(
                "Құпиясөз көрсетілген телефон нөміріне жіберілді"),
        "recoveryScreenPhoneHint":
            MessageLookupByLibrary.simpleMessage("* Телефон нөмірі"),
        "recoveryScreenPhoneLabel":
            MessageLookupByLibrary.simpleMessage("Телефон нөмірі"),
        "recoveryScreenSendPasswordButtonTitle":
            MessageLookupByLibrary.simpleMessage("Құпиясөзді жіберу"),
        "recoveryScreenTitle":
            MessageLookupByLibrary.simpleMessage("Құпиясөзді қалпына келтіру"),
        "registerFirstScreenCompanyLabel":
            MessageLookupByLibrary.simpleMessage("Компания"),
        "registerFirstScreenEmailLabel":
            MessageLookupByLibrary.simpleMessage("Email"),
        "registerFirstScreenFirstnameLabel":
            MessageLookupByLibrary.simpleMessage("Аты"),
        "registerFirstScreenInnOfCompanyLabel":
            MessageLookupByLibrary.simpleMessage("Компанияның ЖСН/БСН"),
        "registerFirstScreenLastnameLabel":
            MessageLookupByLibrary.simpleMessage(" Тегі"),
        "registerFirstScreenPasswordConfirmationError":
            MessageLookupByLibrary.simpleMessage("Құпиясөз сәйкес келмейді"),
        "registerFirstScreenPasswordConfirmationLabel":
            MessageLookupByLibrary.simpleMessage("Құпиясөзді қайталаңыз"),
        "registerFirstScreenPasswordLabel":
            MessageLookupByLibrary.simpleMessage("Құпиясөз"),
        "registerFirstScreenPatronymicLabel":
            MessageLookupByLibrary.simpleMessage("Әкесінің аты"),
        "registerFirstScreenPhoneLabel":
            MessageLookupByLibrary.simpleMessage("Ұялы телефон"),
        "registerFirstScreenPositionLabel":
            MessageLookupByLibrary.simpleMessage("Лауазым"),
        "registerFirstScreenPrivacy1": MessageLookupByLibrary.simpleMessage(
            "«Тіркелу» түймешігін басу арқылы менің дербес ақпаратымды "),
        "registerFirstScreenPrivacy2": MessageLookupByLibrary.simpleMessage(
            "Құпиялылық саясаты шартымен өңдеуге келісемін"),
        "registerFirstScreenSignupButtonTitle":
            MessageLookupByLibrary.simpleMessage("Тіркелу"),
        "registerFirstScreenSmsCodeHasBeenSentNotification":
            MessageLookupByLibrary.simpleMessage(
                "Растау коды көрсетілген телефон нөміріне жіберілді"),
        "registerFirstScreenTitle":
            MessageLookupByLibrary.simpleMessage("Тіркеу"),
        "registerFirstScreenUserAgreement1":
            MessageLookupByLibrary.simpleMessage(
                "«Тіркелу» түймешігін басу арқылы мен"),
        "registerFirstScreenUserAgreement2":
            MessageLookupByLibrary.simpleMessage("Пайдаланушы келісімімен"),
        "registerFirstScreenUserAgreement3":
            MessageLookupByLibrary.simpleMessage(
                "және менің дербес ақпаратымды"),
        "registerFirstScreenUserAgreement4":
            MessageLookupByLibrary.simpleMessage(
                "Құпиялылық саясаты шартымен өңдеуге келісемін"),
        "registerSecondScreenFinishRegistrationButtonTitle":
            MessageLookupByLibrary.simpleMessage("Тіркеуді аяқтау"),
        "registerSecondScreenSmsCodeHasBeenSentToPhone": m16,
        "registerSecondScreenSmsCodeLabel":
            MessageLookupByLibrary.simpleMessage("Смс-код"),
        "registerSecondScreenSuccessful":
            MessageLookupByLibrary.simpleMessage(" Сіз сәтті тіркелдіңіз!"),
        "registerSecondScreenTitle":
            MessageLookupByLibrary.simpleMessage("Тіркеуді аяқтау"),
        "registrationSuccess":
            MessageLookupByLibrary.simpleMessage("Тіркеу сәтті өтті"),
        "rejection": MessageLookupByLibrary.simpleMessage("Бас тарту"),
        "rejectionReason":
            MessageLookupByLibrary.simpleMessage("Бас тарту себебі"),
        "reportAlreadyGotToWork": MessageLookupByLibrary.simpleMessage(
            "Тексеру басқа Орындаушының жұмысына алынды"),
        "reportRejectedSuccess":
            MessageLookupByLibrary.simpleMessage("Тексеру тоқтатылды"),
        "reportWasDelegatedToChosenContractor":
            MessageLookupByLibrary.simpleMessage(
                "Тексеру таңдалған Орындаушыға берілді"),
        "required": MessageLookupByLibrary.simpleMessage("міндетті"),
        "review": MessageLookupByLibrary.simpleMessage("Тексеру"),
        "reviewOrTaskCanNotBeCreatedWithoutAvailableArticles":
            MessageLookupByLibrary.simpleMessage(
                "Қол жетімді нысандарсыз чекті немесе тапсырманы жасау мүмкін емес"),
        "reviewStepsCreateScreenCreate":
            MessageLookupByLibrary.simpleMessage("Жасау"),
        "reviewStepsCreateScreenDescription":
            MessageLookupByLibrary.simpleMessage("Қысқаша сипаты"),
        "reviewStepsCreateScreenDocumentScan":
            MessageLookupByLibrary.simpleMessage("Құжатты сканерлеу"),
        "reviewStepsCreateScreenFile":
            MessageLookupByLibrary.simpleMessage("Файл"),
        "reviewStepsCreateScreenName":
            MessageLookupByLibrary.simpleMessage("Атауы"),
        "reviewStepsCreateScreenNewStep":
            MessageLookupByLibrary.simpleMessage("Жаңа қадам жасау"),
        "reviewStepsCreateScreenPhoto":
            MessageLookupByLibrary.simpleMessage("Сурет"),
        "reviewStepsCreateScreenVideo":
            MessageLookupByLibrary.simpleMessage("Бейне"),
        "reviewTemplate":
            MessageLookupByLibrary.simpleMessage("Тексеру үлгісі"),
        "reviewTemplateFormStepScreenChooseData":
            MessageLookupByLibrary.simpleMessage("Күнді таңдау"),
        "reviewTemplateFormStepScreenDatePickerCancelText":
            MessageLookupByLibrary.simpleMessage("Болдырмау"),
        "reviewTemplateFormStepScreenDropdownHintText":
            MessageLookupByLibrary.simpleMessage("Жауап нұсқасын таңдаңыз "),
        "reviewTemplateFormStepScreenEmptyDropdown":
            MessageLookupByLibrary.simpleMessage("Таңдау үшін мән жоқ"),
        "reviewTemplateFormStepScreenRequiredInputValidation":
            MessageLookupByLibrary.simpleMessage("Толтыру үшін міндетті"),
        "reviewTemplateFormStepScreenSaveButtonTitle":
            MessageLookupByLibrary.simpleMessage("Сақтау"),
        "reviews": MessageLookupByLibrary.simpleMessage("Тексерулер"),
        "reviewsModalInfoLaterButton":
            MessageLookupByLibrary.simpleMessage("Кейінірек"),
        "reviewsModalInfoRedirectButton":
            MessageLookupByLibrary.simpleMessage("Бару"),
        "save": MessageLookupByLibrary.simpleMessage("Сақтау"),
        "search": MessageLookupByLibrary.simpleMessage("Іздеу"),
        "sectionName": MessageLookupByLibrary.simpleMessage("Бөлім атауы"),
        "selectAnAction":
            MessageLookupByLibrary.simpleMessage("Әрекетті таңдаңыз"),
        "selfContractorCreationIsImpossible": MessageLookupByLibrary.simpleMessage(
            "Орындаушыны өзіңіз жасау әкімші орнатқан параметрлерге сәйкес қол жетімді емес."),
        "sendForApproval":
            MessageLookupByLibrary.simpleMessage("Келісуге жіберу"),
        "sending": MessageLookupByLibrary.simpleMessage("Жіберу"),
        "showAll": MessageLookupByLibrary.simpleMessage("Барлығын көрсету"),
        "signReviewDescription": MessageLookupByLibrary.simpleMessage(
            "«Жіберу» түймесін басу арқылы сіз тексеруде көрсетілген ақпараттың сәйкестігін, сенімділігін және сәйкестігін растайсыз."),
        "signReviewTitle": MessageLookupByLibrary.simpleMessage(
            "Қарапайым электронды қолтаңбамен тексеруге қол қою"),
        "specifyNewStepName":
            MessageLookupByLibrary.simpleMessage("Қадамға жаңа атау беріңіз"),
        "startOfExecution":
            MessageLookupByLibrary.simpleMessage("Орындауды бастау"),
        "startReviewWithoutInitialLocation": MessageLookupByLibrary.simpleMessage(
            "Қазіргі уақытта орынды анықтау мүмкін болмады. Тексеруден өту барысында әрекеттер жасалады."),
        "stepInfo":
            MessageLookupByLibrary.simpleMessage("Қадам туралы ақпарат"),
        "stepType": MessageLookupByLibrary.simpleMessage("Қадамның түрі"),
        "stepsCompleted": MessageLookupByLibrary.simpleMessage("Қадамдар өтті"),
        "switchToSignIn":
            MessageLookupByLibrary.simpleMessage("Авторизацияға өтіңіз"),
        "task": MessageLookupByLibrary.simpleMessage("Тапсырма"),
        "taskAddress":
            MessageLookupByLibrary.simpleMessage("Тапсырма мекенжайы"),
        "taskCreatedSuccessfully":
            MessageLookupByLibrary.simpleMessage("Тапсырма сәтті жасалды"),
        "taskDetailErrorFailedTitle": MessageLookupByLibrary.simpleMessage(
            "Жүктеу қатесі, әрекетті кейіннен қайталап көріңіз"),
        "taskExecutionDeleteFileDialogContent":
            MessageLookupByLibrary.simpleMessage(
                "Файлды шынымен жойғыңыз келе ме?\n\nҚайта айналмайтын әрекет"),
        "taskExecutionDescriptionTitle":
            MessageLookupByLibrary.simpleMessage("Сипаты:"),
        "taskExecutionFinishButtonTitle":
            MessageLookupByLibrary.simpleMessage("Аяқтау"),
        "taskExecutionNotAllConditionsCompleted":
            MessageLookupByLibrary.simpleMessage(
                "Тапсырманы аяқтау үшін міндетті қадамдардан өту қажет"),
        "taskExecutionScreenTakeDocumentButtonTitle":
            MessageLookupByLibrary.simpleMessage("Құжатты сканерлеу"),
        "taskExecutionScreenTakeFileButtonTitle":
            MessageLookupByLibrary.simpleMessage("Файлды таңдау"),
        "taskExecutionScreenTakePhotoButtonTitle":
            MessageLookupByLibrary.simpleMessage("Суретке түсіру"),
        "taskExecutionScreenTakeVideoButtonTitle":
            MessageLookupByLibrary.simpleMessage("Бейнені жазу"),
        "taskExecutionStepDetailDescriptionTitle":
            MessageLookupByLibrary.simpleMessage("Сипаты"),
        "taskExecutionStepDetailPhotoExampleTitle":
            MessageLookupByLibrary.simpleMessage("Сурет-мысал"),
        "taskInfoRefuseButtonTitle":
            MessageLookupByLibrary.simpleMessage("Бас тарту"),
        "taskInfoScreenAddressTitle":
            MessageLookupByLibrary.simpleMessage("Тапсырма мекенжайы"),
        "taskInfoScreenArticleTitle":
            MessageLookupByLibrary.simpleMessage("Объект"),
        "taskInfoScreenChangeButtonTitle":
            MessageLookupByLibrary.simpleMessage("Редакциялау"),
        "taskInfoScreenDescriptionTitle":
            MessageLookupByLibrary.simpleMessage("Сипаты"),
        "taskInfoScreenExecuteButtonTitle":
            MessageLookupByLibrary.simpleMessage("Орындау"),
        "taskInfoScreenFinishDateLimitTitle":
            MessageLookupByLibrary.simpleMessage("Орындау мерзімі"),
        "taskInfoScreenTakeToWorkButtonTitle":
            MessageLookupByLibrary.simpleMessage("Жұмысқа алу"),
        "taskType": MessageLookupByLibrary.simpleMessage("Тапсырма түрі"),
        "tasks": MessageLookupByLibrary.simpleMessage("Тапсырмалар"),
        "tasksRowFinishExecutionAt": m17,
        "tasksRowStartExecutionAt": m18,
        "tasksScreenAppBarTitle":
            MessageLookupByLibrary.simpleMessage("Тапсырмалар"),
        "tasksScreenErrorTitle": MessageLookupByLibrary.simpleMessage(
            "Жүктеу қатесі, кейінірек көріңіз"),
        "tasksScreenFastFilterAssignedStatusTitle":
            MessageLookupByLibrary.simpleMessage("Тағайындалғандар"),
        "tasksScreenFastFilterAtWorkStatusTitle":
            MessageLookupByLibrary.simpleMessage("Жұмыста"),
        "tasksScreenFastFilterCompletedStatusTitle":
            MessageLookupByLibrary.simpleMessage("Аяқталғандар"),
        "tasksScreenFastFilterOnInspectionStatusTitle":
            MessageLookupByLibrary.simpleMessage("Растау бойынша"),
        "tasksScreenFastFilterRejectedStatusTitle":
            MessageLookupByLibrary.simpleMessage("Қабылданбағандар"),
        "tasksScreenTabAvailableTitle":
            MessageLookupByLibrary.simpleMessage("Бөлімше"),
        "tasksScreenTabMyTasksTitle":
            MessageLookupByLibrary.simpleMessage("Менің тапсырмаларым"),
        "toDelegate": MessageLookupByLibrary.simpleMessage("Өкілдік ету"),
        "toMain": MessageLookupByLibrary.simpleMessage("Басты бетке"),
        "toNextStepButtonTitle":
            MessageLookupByLibrary.simpleMessage("Бұдан әрі"),
        "tryAgain": MessageLookupByLibrary.simpleMessage("Әрекетті қайталау"),
        "turnOnGPS": MessageLookupByLibrary.simpleMessage("GPS қосыңыз"),
        "turnOnLocationServices": MessageLookupByLibrary.simpleMessage(
            "HMS Core геолокация қызметтерін қосыңыз "),
        "unexpectedException": MessageLookupByLibrary.simpleMessage(
            "Қандай да бір қате орын алды"),
        "uploadsScreenEntiyActionAttachCommentsTitle":
            MessageLookupByLibrary.simpleMessage("Түсініктеме"),
        "uploadsScreenEntiyActionAttachViolationsTitle":
            MessageLookupByLibrary.simpleMessage("Бұзушылықтар"),
        "uploadsScreenEntiyActionDeletingFilesTitle":
            MessageLookupByLibrary.simpleMessage("Файлдарды жою"),
        "uploadsScreenEntiyActionLocationUploadTitle":
            MessageLookupByLibrary.simpleMessage("Орналасқан жері"),
        "uploadsScreenEntiyActionReviewFinishTitle":
            MessageLookupByLibrary.simpleMessage("Тексеруді аяқтау"),
        "uploadsScreenEntiyActionReviewInterruptTitle":
            MessageLookupByLibrary.simpleMessage("Тексеруді тоқтату"),
        "uploadsScreenEntiyActionReviewStoreTitle":
            MessageLookupByLibrary.simpleMessage("Тексеруді жасау"),
        "uploadsScreenEntiyActionStepFileUploadTitle":
            MessageLookupByLibrary.simpleMessage("Файл"),
        "uploadsScreenEntiyTypeLocationTitle":
            MessageLookupByLibrary.simpleMessage("Орналасқан жері"),
        "uploadsScreenEntiyTypeReviewTitle":
            MessageLookupByLibrary.simpleMessage("Тексеру"),
        "uploadsScreenEntiyTypeStepFileTitle":
            MessageLookupByLibrary.simpleMessage("Файл"),
        "uploadsScreenIdHasBeenCopiedMessage": m19,
        "uploadsScreenTitle": MessageLookupByLibrary.simpleMessage("Жүктеулер"),
        "uploadsScreenUploadsScreenIsEmpty":
            MessageLookupByLibrary.simpleMessage("Жүктеулер тізімі бос"),
        "userAgreementAndPrivacyPolicy": MessageLookupByLibrary.simpleMessage(
            "Пайдаланушы келісімімен және құпиялылық саясатымен"),
        "videoProcessing":
            MessageLookupByLibrary.simpleMessage("Бейнені өңдеу"),
        "waitCreationArticlesOr": MessageLookupByLibrary.simpleMessage(
            "Нысандардың қосылуын күтіңіз немесе "),
        "waitForTheirAppointmentOr": MessageLookupByLibrary.simpleMessage(
            "Оларды тағайындауды күтіңіз немесе\n"),
        "waitForVerification":
            MessageLookupByLibrary.simpleMessage("Тексеруді күтіңіз"),
        "youAreNotLinkedToAnyCompany":
            MessageLookupByLibrary.simpleMessage("Сіз Компанияға байланбайсыз"),
        "youCanSpecifyNameCopiedSteps": MessageLookupByLibrary.simpleMessage(
            "Көшірілген қадамдардың атын тексеру қадамының өзінде көрсетуге болады"),
        "youWillGetMessageWithPassword": MessageLookupByLibrary.simpleMessage(
            "Қолданбаға кіру үшін сізге пароль туралы хабарлама келеді"),
        "youWillGetPasswordAfterVerification": MessageLookupByLibrary.simpleMessage(
            "Есептік жазбаны растағаннан кейін сізге авторизация үшін пароль бар хабарлама келеді")
      };
}
