// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a ru locale. All the
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
  String get localeName => 'ru';

  static String m0(number) => "Содержит объектов: ${number}";

  static String m1(howMany) =>
      "${Intl.plural(howMany, one: '${howMany} проверка', two: '${howMany} проверки', other: '${howMany} проверок')}";

  static String m2(current, max) => "\nЗарегистрировано ${current} из ${max}";

  static String m3(minDuration, maxDuration) =>
      "Мин ${minDuration} сек / Макс ${maxDuration} сек";

  static String m4(itemsName) =>
      "Самостоятельное создание ${itemsName} недоступно в соответствии с настройками, установленными администратором.";

  static String m5(megabytes) => "Удалено ${megabytes} мб.";

  static String m6(itemsName) => "Создание ${itemsName} недоступно";

  static String m7(itemsName) => "${itemsName} отсутствуют";

  static String m8(localVersion, storeVersion) =>
      "Доступно новое обновление, необходимо обновить приложение\n\nВаша версия: ${localVersion}\nДоступная версия ${storeVersion}";

  static String m9(progress, count) =>
      "Повторно отправляем ${progress} / ${count}...";

  static String m10(releaseNotes) => "\n\nОписание: ${releaseNotes}";

  static String m11(count) =>
      "Догрузка ${count} объектов начата!\nНе выключайте приложение и обеспечьте стабильное соединение с интернетом.";

  static String m12(comment) => "Комментарий администратора: «${comment}»";

  static String m13(path, mbLimit) =>
      "Файл ${path} имеет вес более ${mbLimit} мб. Отправка невозможна.";

  static String m14(freeDiskSpace) =>
      "Осталось мало свободного места: ${freeDiskSpace} мб.";

  static String m15(comments) => "Пропущен c комментарием: \r\n${comments}";

  static String m16(phone) =>
      "Код подтверждения отправлен на указанный номер «${phone}».";

  static String m17(date) => "Выполнить до ${date}";

  static String m18(date) => "Старт выполнения ${date}";

  static String m19(id) => "Идентификатор скопирован: ${id}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "accessGranted":
            MessageLookupByLibrary.simpleMessage("Доступ предоставлен"),
        "accountDoesNotExist":
            MessageLookupByLibrary.simpleMessage("Не зарегистрирован"),
        "accountSelection":
            MessageLookupByLibrary.simpleMessage("Выбор аккаунта:"),
        "accuracyHigh": MessageLookupByLibrary.simpleMessage("Высокая"),
        "accuracyLow": MessageLookupByLibrary.simpleMessage("Низкая"),
        "accuracyMedium": MessageLookupByLibrary.simpleMessage("Средняя"),
        "addArticleScreenCompanyAddressLabel":
            MessageLookupByLibrary.simpleMessage("Адрес"),
        "addArticleScreenCompanyNameLabel":
            MessageLookupByLibrary.simpleMessage("Название"),
        "addArticleScreenCreate":
            MessageLookupByLibrary.simpleMessage("Создать"),
        "addArticleScreenEnterInn":
            MessageLookupByLibrary.simpleMessage("Введите ИНН"),
        "addArticleScreenInnNotFoundSelectForFillManualy":
            MessageLookupByLibrary.simpleMessage(
                "ИНН не найден, выберите чтобы заполнить вручную"),
        "addArticleScreenLoading":
            MessageLookupByLibrary.simpleMessage("Загрузка..."),
        "addArticleScreenObjectSuccessfulCreatedMessage":
            MessageLookupByLibrary.simpleMessage("Объект успешно создан"),
        "addingTask": MessageLookupByLibrary.simpleMessage("Создание задачи"),
        "alertDialogDefaultOkTitle": MessageLookupByLibrary.simpleMessage("OK"),
        "all": MessageLookupByLibrary.simpleMessage("Все"),
        "articleAccountSwitcherChooseCompany":
            MessageLookupByLibrary.simpleMessage("Выберите компанию"),
        "articleDetailsContainsObjects": m0,
        "articleDetailsToMainArticles":
            MessageLookupByLibrary.simpleMessage("К главным объектам"),
        "articleListSortAll": MessageLookupByLibrary.simpleMessage("Все"),
        "articleListSortGroup": MessageLookupByLibrary.simpleMessage("Группы"),
        "articlePassportArticleType":
            MessageLookupByLibrary.simpleMessage("Тип объекта"),
        "articlePassportBodyTitle":
            MessageLookupByLibrary.simpleMessage("Характеристики"),
        "articlePassportHeader":
            MessageLookupByLibrary.simpleMessage("Паспорт объекта"),
        "articleRowStatusCreatedTitle":
            MessageLookupByLibrary.simpleMessage("Объект создан"),
        "articleRowStatusNeedReportTitle":
            MessageLookupByLibrary.simpleMessage("Запрошена проверка"),
        "articleRowStatusReportConfirmedTitle":
            MessageLookupByLibrary.simpleMessage("Проверка принята"),
        "articleRowStatusReportDeniedTitle":
            MessageLookupByLibrary.simpleMessage("Проверка отклонена"),
        "articleRowStatusUndefinedTitle":
            MessageLookupByLibrary.simpleMessage("Неизвестный статус"),
        "articleRowStatusUploadFailedTitle":
            MessageLookupByLibrary.simpleMessage("Ошибка загрузки"),
        "articleRowStatusUploadingTitle":
            MessageLookupByLibrary.simpleMessage("Построение проверки начато"),
        "articleRowStatusWaitCheckingTitle":
            MessageLookupByLibrary.simpleMessage("Ожидает проверки"),
        "articlesScreenArticlesCount": m1,
        "articlesScreenAvailabledArticleNotFoundCanRegister1":
            MessageLookupByLibrary.simpleMessage(
                "Ожидайте их добавления или \n"),
        "articlesScreenAvailabledArticleNotFoundCanRegister2":
            MessageLookupByLibrary.simpleMessage("создайте самостоятельно"),
        "articlesScreenAvailabledArticleNotFoundCantRegister":
            MessageLookupByLibrary.simpleMessage(
                "Доступные объекты отсутствуют, ожидайте их создания."),
        "articlesScreenAwaitOfSending":
            MessageLookupByLibrary.simpleMessage("в ожидании отправки"),
        "articlesScreenCreateReviewButtonTitle":
            MessageLookupByLibrary.simpleMessage("Создать проверку"),
        "articlesScreenHasNotFinishedReviews":
            MessageLookupByLibrary.simpleMessage("Есть незавершенные проверки"),
        "articlesScreenHasRequestedReviews":
            MessageLookupByLibrary.simpleMessage("Есть запрошенные проверки"),
        "articlesScreenNeedToChooseCompany":
            MessageLookupByLibrary.simpleMessage(
                "Для начала необходимо выбрать компанию"),
        "articlesScreenNetworkException": MessageLookupByLibrary.simpleMessage(
            "Подключение к Интернету отсутствует.\nЗадачи недоступны."),
        "articlesScreenNothingFound": MessageLookupByLibrary.simpleMessage(
            "К сожалению ничего не найдено."),
        "articlesScreenRegisterReviews": MessageLookupByLibrary.simpleMessage(
            "Регистрация проверок на сервере...\n"),
        "articlesScreenRegisterReviewsFinish": MessageLookupByLibrary.simpleMessage(
            "Проверки успешно зарегистрированы, загрузка файлов продолжится в автономном режиме, не выключайте приложение и интернет.\n"),
        "articlesScreenRegisterReviewsFinishGoBack":
            MessageLookupByLibrary.simpleMessage("Вернуться в приложение"),
        "articlesScreenRegisterReviewsStatus": m2,
        "articlesScreenRegisterReviewsUnxpectedException":
            MessageLookupByLibrary.simpleMessage(
                "Во время регистрации проверок произошла ошибка, попробуйте позже.\n"),
        "articlesScreenRegisterReviewsUnxpectedExceptionGoBack":
            MessageLookupByLibrary.simpleMessage("Вернуться в приложение"),
        "articlesScreenSawDownloads":
            MessageLookupByLibrary.simpleMessage("Просмотреть загрузки"),
        "articlesScreenSearch": MessageLookupByLibrary.simpleMessage("Поиск"),
        "articlesScreenSearchEmpty":
            MessageLookupByLibrary.simpleMessage("Ничего не найдено"),
        "articlesScreenSearchFieldLabel":
            MessageLookupByLibrary.simpleMessage("Поиск"),
        "articlesScreenSendSavedArticles": MessageLookupByLibrary.simpleMessage(
            "Отправить сохраненные проверки"),
        "articlesScreenTitle": MessageLookupByLibrary.simpleMessage("Объекты"),
        "articlesScreenUploadsButtonTitle":
            MessageLookupByLibrary.simpleMessage("Загрузки"),
        "audio": MessageLookupByLibrary.simpleMessage("Аудио"),
        "audioFileName":
            MessageLookupByLibrary.simpleMessage("Название аудиофайла"),
        "audioRecording": MessageLookupByLibrary.simpleMessage("Запись аудио"),
        "audioRecordingRestrictions": m3,
        "boolDialogDefaultApproveTitle":
            MessageLookupByLibrary.simpleMessage("Да"),
        "boolDialogDefaultDenyTitle":
            MessageLookupByLibrary.simpleMessage("Нет"),
        "camera": MessageLookupByLibrary.simpleMessage("Камера"),
        "canNotGetToWork":
            MessageLookupByLibrary.simpleMessage("Взять в работу невозможно"),
        "checkYourInternetConnectionAndTryAgain":
            MessageLookupByLibrary.simpleMessage(
                "Проверьте своё подключение к интернету и повторите попытку."),
        "checksWithThisNameNotFound": MessageLookupByLibrary.simpleMessage(
            "Проверки с таким названием не найдены"),
        "chooseAnotherReport": MessageLookupByLibrary.simpleMessage(
            "Выберите для работы другую проверку"),
        "chooseCreatingArticleType":
            MessageLookupByLibrary.simpleMessage("Выберите тип объекта"),
        "chooseReviewTemplateNoInternet": MessageLookupByLibrary.simpleMessage(
            "Подключение к Интернету отсутствует.\nВыбор шаблона осмотра недоступен."),
        "chooseReviewTemplateScreenAvailable":
            MessageLookupByLibrary.simpleMessage(
                "Доступно для самостоятельной проверки"),
        "chooseReviewTemplateScreenAwaitForContinue":
            MessageLookupByLibrary.simpleMessage("Ожидает выполнения"),
        "chooseReviwTemplate":
            MessageLookupByLibrary.simpleMessage("Выберите шаблон"),
        "chooseReviwTemplateInternetException":
            MessageLookupByLibrary.simpleMessage("Ошибка интернет-соединения"),
        "chooseReviwTemplateScreenContinueReview":
            MessageLookupByLibrary.simpleMessage(
                "Нажмите чтобы продолжить построение проверки"),
        "choosingCreatingArticleTypeInternetException":
            MessageLookupByLibrary.simpleMessage(
                "Подключение к Интернету отсутствует.\nТипы объектов осмотра недоступны."),
        "comment": MessageLookupByLibrary.simpleMessage("Комментарий"),
        "commentText":
            MessageLookupByLibrary.simpleMessage("Текст комментария"),
        "confirm": MessageLookupByLibrary.simpleMessage("Подтвердить"),
        "confirmTheAction":
            MessageLookupByLibrary.simpleMessage("Подтвердите действие"),
        "contractorDelegateToIsUnregistered": MessageLookupByLibrary.simpleMessage(
            "Исполнитель, которому была осуществлена делегация, не зарегистрирован"),
        "contractorPhoneNumber":
            MessageLookupByLibrary.simpleMessage("Номер телефона Исполнителя"),
        "copySection":
            MessageLookupByLibrary.simpleMessage("Скопировать раздел"),
        "copyStep": MessageLookupByLibrary.simpleMessage("Скопировать шаг"),
        "copyingSection":
            MessageLookupByLibrary.simpleMessage("Копирование раздела"),
        "copyingSectionInstruction": MessageLookupByLibrary.simpleMessage(
            "Копирование группы шагов позволяет воспроизвести повторяемые процессы"),
        "copyingStep": MessageLookupByLibrary.simpleMessage("Копирование шага"),
        "copyingStepInstruction": MessageLookupByLibrary.simpleMessage(
            "Копирование шага позволяет воспроизвести повторяемые процессы"),
        "create": MessageLookupByLibrary.simpleMessage("Создать"),
        "createAdditionalStep":
            MessageLookupByLibrary.simpleMessage("Создать дополнительный шаг"),
        "createNewStep":
            MessageLookupByLibrary.simpleMessage("Создать новый шаг"),
        "createTask": MessageLookupByLibrary.simpleMessage("Создать задачу"),
        "created": MessageLookupByLibrary.simpleMessage("Создана"),
        "creatingOrUploading":
            MessageLookupByLibrary.simpleMessage("Создание или загрузка"),
        "creationOfItemsIsNotAvailableDescription": m4,
        "dataTransferredToResponsible": MessageLookupByLibrary.simpleMessage(
            "Данные переданы ответственному лицу"),
        "deadline": MessageLookupByLibrary.simpleMessage("Срок выполнения"),
        "delegated": MessageLookupByLibrary.simpleMessage("Делегирована"),
        "delegation": MessageLookupByLibrary.simpleMessage("Делегирование"),
        "delegationImpossible":
            MessageLookupByLibrary.simpleMessage("Делегирование невозможно"),
        "delegationSuccess": MessageLookupByLibrary.simpleMessage(
            "Делегирование прошло успешно"),
        "deleteAccountDialogDescription": MessageLookupByLibrary.simpleMessage(
            "Нажимая кнопку подтвердить, вы выходите из приложения и удаляете вашу учетную запись вместе с соответствующими личными данными."),
        "deleted": MessageLookupByLibrary.simpleMessage("Удалена"),
        "editingTask":
            MessageLookupByLibrary.simpleMessage("Редактирование задачи"),
        "enterCompany":
            MessageLookupByLibrary.simpleMessage("Введите компанию"),
        "enterContractorPhoneNumberToDelegate":
            MessageLookupByLibrary.simpleMessage(
                "Для делегирования введите номер телефона Исполнителя.\n"),
        "enterEmail": MessageLookupByLibrary.simpleMessage("Введите Email"),
        "enterIdForAccountIdentification": MessageLookupByLibrary.simpleMessage(
            "Для идентификации аккаунта введите ID.\n"),
        "enterIdForRegistration": MessageLookupByLibrary.simpleMessage(
            "Введите номер ID для регистрации"),
        "enterIdSecondScreen":
            MessageLookupByLibrary.simpleMessage("Введите номер ID"),
        "enterLastName":
            MessageLookupByLibrary.simpleMessage("Введите фамилию"),
        "enterName": MessageLookupByLibrary.simpleMessage("Введите имя"),
        "enterNewSectionName": MessageLookupByLibrary.simpleMessage(
            "Укажите новое название раздела"),
        "enterObjectAddress":
            MessageLookupByLibrary.simpleMessage("Выберите адрес объекта"),
        "enterPosition":
            MessageLookupByLibrary.simpleMessage("Введите должность"),
        "error": MessageLookupByLibrary.simpleMessage("Ошибка:"),
        "errorNoConnectionDescription": MessageLookupByLibrary.simpleMessage(
            "Не удалось подключиться к серверу, сохраненные  данные для работы в оффлайн режиме отсутствуют."),
        "example": MessageLookupByLibrary.simpleMessage("Пример"),
        "failedToDetermineLocation": MessageLookupByLibrary.simpleMessage(
            "Не удалось определить местоположение"),
        "fillInTheField":
            MessageLookupByLibrary.simpleMessage("Заполните поле"),
        "getIdFromManager": MessageLookupByLibrary.simpleMessage(
            "Получить ID можно у Менеджера, контрагента, либо он может быть размещен непосредственно на Объекте"),
        "goToCreateAnAdditionalStep": MessageLookupByLibrary.simpleMessage(
            "Перейти к созданию дополнительного шага?"),
        "goToReportsNavigation":
            MessageLookupByLibrary.simpleMessage("Перейти к Проверкам"),
        "goToSettingsAndGiveAccessTo": MessageLookupByLibrary.simpleMessage(
            "Для корректной работы приложения необходимо предоставить доступ:"),
        "gotToWork": MessageLookupByLibrary.simpleMessage("Взята в работу"),
        "haveNoArticlesAvailable":
            MessageLookupByLibrary.simpleMessage("Нет доступных объектов"),
        "haveNoTaskTypesAvailable":
            MessageLookupByLibrary.simpleMessage("Нет доступных типов задач"),
        "haveNoTemplatesAvailable":
            MessageLookupByLibrary.simpleMessage("Нет доступных шаблонов"),
        "help": MessageLookupByLibrary.simpleMessage("Помощь"),
        "helpCreateMessageScreenInternetException":
            MessageLookupByLibrary.simpleMessage("Ошибка интернет-соединения"),
        "helpCreateMessageScreenMessage":
            MessageLookupByLibrary.simpleMessage("Текст сообщения"),
        "helpCreateMessageScreenMessageDescription":
            MessageLookupByLibrary.simpleMessage(
                "Изложите, пожалуйста, суть обращения в 2-3 предложениях."),
        "helpCreateMessageScreenPhoneNumber":
            MessageLookupByLibrary.simpleMessage("Номер телефона"),
        "helpCreateMessageScreenPhoneNumberDescription":
            MessageLookupByLibrary.simpleMessage(
                "Укажите, пожалуйста, номер телефона для обратной связи."),
        "helpCreateMessageScreenSend":
            MessageLookupByLibrary.simpleMessage("Отправить"),
        "helpCreateMessageScreenSendMessage":
            MessageLookupByLibrary.simpleMessage("Отправить сообщение"),
        "helpCreateMessageScreenYourMessageSended":
            MessageLookupByLibrary.simpleMessage("Ваше сообщение отправлено!"),
        "helpInsuranceCase":
            MessageLookupByLibrary.simpleMessage("Страховой случай"),
        "helpQuestionsScreenHasNotQuestionsAndAnswers":
            MessageLookupByLibrary.simpleMessage("Нет вопросов и ответов"),
        "helpQuestionsScreenTitle":
            MessageLookupByLibrary.simpleMessage("Вопросы и ответы"),
        "helpScreenCallUs":
            MessageLookupByLibrary.simpleMessage("Позвоните нам"),
        "helpScreenCleanMemory":
            MessageLookupByLibrary.simpleMessage("Очистить память"),
        "helpScreenCleanMemoryAreYouSure": MessageLookupByLibrary.simpleMessage(
            "Вы уверены что хотите удалить все файлы?"),
        "helpScreenCleanMemoryNo": MessageLookupByLibrary.simpleMessage("Нет"),
        "helpScreenCleanMemoryProccessIsIrrevirsable":
            MessageLookupByLibrary.simpleMessage(
                "Кэшированные и неотправленные файлы будут утеряны, процесс необратим."),
        "helpScreenCleanMemoryYes": MessageLookupByLibrary.simpleMessage("Да"),
        "helpScreenClearedMemoryToast": m5,
        "helpScreenExportFilesButtonTitle":
            MessageLookupByLibrary.simpleMessage("Выгрузить файлы"),
        "helpScreenNeedToChooseCompany": MessageLookupByLibrary.simpleMessage(
            "Для начала нужно выбрать компанию на экране «Объекты»"),
        "helpScreenQuestionsAndAnswers":
            MessageLookupByLibrary.simpleMessage("Вопросы и ответы"),
        "helpScreenSendMessage":
            MessageLookupByLibrary.simpleMessage("Отправить сообщение"),
        "helpScreenTitle": MessageLookupByLibrary.simpleMessage("Помощь"),
        "helpScreenWriteEmail":
            MessageLookupByLibrary.simpleMessage("Напишите нам на почту"),
        "hide": MessageLookupByLibrary.simpleMessage("Скрыть"),
        "high": MessageLookupByLibrary.simpleMessage("Высокий"),
        "ifContractorUnregisteredEnterInfoAbout":
            MessageLookupByLibrary.simpleMessage(
                "Если Исполнитель не зарегистрирован в системе, нужно ввести необходимую информацию об Исполнителе"),
        "independentCreationArticlesIsNotAvailableBySystemSettings":
            MessageLookupByLibrary.simpleMessage(
                "Самостоятельное создание объектов недоступно в соответствии с настройками установленными администратором"),
        "instruction": MessageLookupByLibrary.simpleMessage("Инструкция"),
        "internetConnectionError":
            MessageLookupByLibrary.simpleMessage("Ошибка интернет-соединения"),
        "isNeedRework":
            MessageLookupByLibrary.simpleMessage("Требуют доработки"),
        "itemCreationNotAvailable": m6,
        "itemsMissing": m7,
        "linkedCheckBoxCancelButton":
            MessageLookupByLibrary.simpleMessage("Отменить"),
        "linkedCheckBoxPrivacyAgreementFirst":
            MessageLookupByLibrary.simpleMessage("Принимаю "),
        "linkedCheckBoxPrivacyAgreementSecond":
            MessageLookupByLibrary.simpleMessage("соглашение об использовании"),
        "linkedCheckBoxPrivacyAgreementThird":
            MessageLookupByLibrary.simpleMessage(
                " простой электронной подписи"),
        "linkedCheckBoxSendButton":
            MessageLookupByLibrary.simpleMessage("Подписать и отправить"),
        "loadingScreenConnectingToServer": MessageLookupByLibrary.simpleMessage(
            "Соединяемся с сервером, пожалуйста подождите..."),
        "loadingScreenHasBeenCriticalError1":
            MessageLookupByLibrary.simpleMessage(
                "Произошла критическая ошибка\n"),
        "loadingScreenHasBeenCriticalError2": MessageLookupByLibrary.simpleMessage(
            "Перезапустите приложение в зоне действия интернета.\nЕсли проблема сохраняется -"),
        "loadingScreenHasBeenCriticalError3":
            MessageLookupByLibrary.simpleMessage("попробуйте снова"),
        "loadingScreenHasBeenCriticalError4":
            MessageLookupByLibrary.simpleMessage(" или "),
        "loadingScreenHasBeenCriticalError5":
            MessageLookupByLibrary.simpleMessage(
                "выгрузите файлы из приложения"),
        "loadingScreenHasBeenCriticalError6":
            MessageLookupByLibrary.simpleMessage(", а затем"),
        "loadingScreenHasBeenCriticalError7":
            MessageLookupByLibrary.simpleMessage("переустановите приложение."),
        "loadingScreenHasNewUpdate": m8,
        "loadingScreenHasNewUpdateText1": MessageLookupByLibrary.simpleMessage(
            "Доступно новое обновление.\n\n"),
        "loadingScreenHasNewUpdateText2": MessageLookupByLibrary.simpleMessage(
            "Пожалуйста обновите приложение.\n\n"),
        "loadingScreenHasNewUpdateText3":
            MessageLookupByLibrary.simpleMessage("Обновить"),
        "loadingScreenLoadingAppTitle":
            MessageLookupByLibrary.simpleMessage("Загружаем приложение..."),
        "loadingScreenRetrying":
            MessageLookupByLibrary.simpleMessage("Пробуем снова..."),
        "loadingScreenRetryingSending": m9,
        "loadingScreenStartingOfflineMode":
            MessageLookupByLibrary.simpleMessage(
                "Запуск приложения в оффлайн режиме."),
        "loadingScreenUpdateDialogDismissButtonTitle":
            MessageLookupByLibrary.simpleMessage("Позже"),
        "loadingScreenUpdateDialogTitle":
            MessageLookupByLibrary.simpleMessage("Обновление"),
        "loadingScreenUpdateDialogUpdateButtonTitle":
            MessageLookupByLibrary.simpleMessage("Обновить"),
        "loadingScreenUpdateHasNotes": m10,
        "loadingScreenUploadingFilesStarted": m11,
        "locatingDescription": MessageLookupByLibrary.simpleMessage(
            "Скорость определения местоположения зависит от текущих условий: доступности спутников, облачности, помех в виде зданий."),
        "locatingRecommendation": MessageLookupByLibrary.simpleMessage(
            "Если вы находитесь внутри помещения, подойдите к окну или выйдите на улицу."),
        "location": MessageLookupByLibrary.simpleMessage("Местоположение"),
        "locationDetermining":
            MessageLookupByLibrary.simpleMessage("Местоположение определяется"),
        "logOutAndDeleteYourAccount":
            MessageLookupByLibrary.simpleMessage("Выйти и удалить аккаунт"),
        "loginScreenPasswordHint":
            MessageLookupByLibrary.simpleMessage("* Пароль"),
        "loginScreenPasswordLabel":
            MessageLookupByLibrary.simpleMessage("Пароль"),
        "loginScreenPhoneHint":
            MessageLookupByLibrary.simpleMessage("* Номер телефона"),
        "loginScreenPhoneLabel":
            MessageLookupByLibrary.simpleMessage("Номер телефона"),
        "loginScreenPrivacy1": MessageLookupByLibrary.simpleMessage(
            "Нажимая «Войти», я соглашаюсь с обработкой моей персональной информации на условиях "),
        "loginScreenPrivacy2":
            MessageLookupByLibrary.simpleMessage("Политики конфиденциальности"),
        "loginScreenRecoveryPasswordLink2":
            MessageLookupByLibrary.simpleMessage("Восстановить пароль"),
        "loginScreenRecoveryPasswordLinkTitle":
            MessageLookupByLibrary.simpleMessage("Восстановить пароль"),
        "loginScreenSignInButtonTitle":
            MessageLookupByLibrary.simpleMessage("Войти"),
        "loginScreenSignupButtonTitle":
            MessageLookupByLibrary.simpleMessage("Зарегистрироваться"),
        "loginScreenSignupOrRecoveryPassword":
            MessageLookupByLibrary.simpleMessage(" или "),
        "loginScreenTitle":
            MessageLookupByLibrary.simpleMessage("Войдите в свой аккаунт"),
        "loginScreenUserAgreement1": MessageLookupByLibrary.simpleMessage(
            "Нажимая «Войти», я соглашаюсь с"),
        "loginScreenUserAgreement2": MessageLookupByLibrary.simpleMessage(
            "Пользовательским соглашением"),
        "loginScreenUserAgreement3": MessageLookupByLibrary.simpleMessage(
            "и с обработкой моей персональной информации на условиях"),
        "loginScreenUserAgreement4":
            MessageLookupByLibrary.simpleMessage("Политики конфиденциальности"),
        "low": MessageLookupByLibrary.simpleMessage("Низкий"),
        "main": MessageLookupByLibrary.simpleMessage("Главная"),
        "makeDocumentPageAndroidBWTitle":
            MessageLookupByLibrary.simpleMessage("Ч/Б"),
        "makeDocumentPageAndroidCropReset":
            MessageLookupByLibrary.simpleMessage("Отменить"),
        "makeDocumentPageAndroidCropTitle":
            MessageLookupByLibrary.simpleMessage("Редактирование"),
        "makeDocumentPageAndroidScan":
            MessageLookupByLibrary.simpleMessage("Сканирование"),
        "makeDocumentPageTitle":
            MessageLookupByLibrary.simpleMessage("Создание копии документа"),
        "makeMediaPageCameraAccesException":
            MessageLookupByLibrary.simpleMessage("Нет доступа к камере"),
        "makeMediaPageCameraException":
            MessageLookupByLibrary.simpleMessage("Ошибка камеры"),
        "makeMediaPageMicAccesException":
            MessageLookupByLibrary.simpleMessage("Нет доступа к микрофону"),
        "makeMediaPageOpenAppSettings": MessageLookupByLibrary.simpleMessage(
            "Открыть настройки приложения"),
        "makeMediaPagePhoto": MessageLookupByLibrary.simpleMessage("Фото"),
        "makeMediaPageSomethingWentWrong":
            MessageLookupByLibrary.simpleMessage("Произошла какая-то ошибка"),
        "makeMediaPageStandBy": MessageLookupByLibrary.simpleMessage(
            "Происходит обработка и сохранение, не закрывайте приложение, дождитесь завершения"),
        "makeMediaPageUndefined":
            MessageLookupByLibrary.simpleMessage("undefined"),
        "makeMediaPageVideo":
            MessageLookupByLibrary.simpleMessage("Видеозапись"),
        "makeReportPageAddAnotherFile":
            MessageLookupByLibrary.simpleMessage("Добавить доп. файл"),
        "makeReportPageAddFile":
            MessageLookupByLibrary.simpleMessage("Добавить файл"),
        "makeReportPageAddStep":
            MessageLookupByLibrary.simpleMessage("Добавить шаг"),
        "makeReportPageAdminComment": m12,
        "makeReportPageAnotherReportWithThisTemplate":
            MessageLookupByLibrary.simpleMessage(
                "Хотите провести еще один осмотр по данному шаблону?"),
        "makeReportPageAreYouSureForDelete":
            MessageLookupByLibrary.simpleMessage(
                "Вы уверены что хотите удалить данную проверку?"),
        "makeReportPageAreYouSureForExit": MessageLookupByLibrary.simpleMessage(
            "Вы уверены что хотите выйти?"),
        "makeReportPageCancel":
            MessageLookupByLibrary.simpleMessage("Отменить"),
        "makeReportPageChooseAnotherFile":
            MessageLookupByLibrary.simpleMessage("Выбрать другой файл"),
        "makeReportPageContinue":
            MessageLookupByLibrary.simpleMessage("Продолжить"),
        "makeReportPageFile": MessageLookupByLibrary.simpleMessage("Файл"),
        "makeReportPageFillTheAnotherForm":
            MessageLookupByLibrary.simpleMessage("Заполнить доп. форму"),
        "makeReportPageFillTheForm":
            MessageLookupByLibrary.simpleMessage("Заполнить форму"),
        "makeReportPageFinish":
            MessageLookupByLibrary.simpleMessage("Завершить"),
        "makeReportPageHaveNotLocationPermission":
            MessageLookupByLibrary.simpleMessage(
                "Недостаточно прав для определения местоположения"),
        "makeReportPageHugeFile": m13,
        "makeReportPageIssueOccured":
            MessageLookupByLibrary.simpleMessage("Выявлено нарушение"),
        "makeReportPageLocating":
            MessageLookupByLibrary.simpleMessage("Определяю местоположение..."),
        "makeReportPageLowSpace": m14,
        "makeReportPageMakeAdditionalPhoto":
            MessageLookupByLibrary.simpleMessage("Сделать доп. фото"),
        "makeReportPageMakeAdditionalScan":
            MessageLookupByLibrary.simpleMessage("Сделать доп. скан"),
        "makeReportPageMakeAdditionalVideo":
            MessageLookupByLibrary.simpleMessage("Записать доп. видео"),
        "makeReportPageMakePhoto":
            MessageLookupByLibrary.simpleMessage("Сделать фото"),
        "makeReportPageMakeScan":
            MessageLookupByLibrary.simpleMessage("Сделать скан"),
        "makeReportPageMissedWithComments": m15,
        "makeReportPageNo": MessageLookupByLibrary.simpleMessage("Нет"),
        "makeReportPageNotEnoughDishSpace":
            MessageLookupByLibrary.simpleMessage(
                "Недостаточно свободного места"),
        "makeReportPageOpenAppSettings": MessageLookupByLibrary.simpleMessage(
            "Открыть настройки приложения"),
        "makeReportPagePopupMessage": MessageLookupByLibrary.simpleMessage(
            "Для завершения проверки необходимо пройти обязательные шаги"),
        "makeReportPageReasonForSkip":
            MessageLookupByLibrary.simpleMessage("Укажите причину пропуска"),
        "makeReportPageRemakePhoto":
            MessageLookupByLibrary.simpleMessage("Переснять фото"),
        "makeReportPageRemakeScan":
            MessageLookupByLibrary.simpleMessage("Переснять скан"),
        "makeReportPageRemakeVideo":
            MessageLookupByLibrary.simpleMessage("Записать видео"),
        "makeReportPageRepeatableReport":
            MessageLookupByLibrary.simpleMessage("Повторяемый осмотр"),
        "makeReportPageReportIsCreated":
            MessageLookupByLibrary.simpleMessage("Спасибо! Проверка создана!"),
        "makeReportPageScan": MessageLookupByLibrary.simpleMessage("Скан"),
        "makeReportPageSend": MessageLookupByLibrary.simpleMessage("Отправить"),
        "makeReportPageSendingData": MessageLookupByLibrary.simpleMessage(
            "Отправляем данные на сервер...\nПожалуйста подождите."),
        "makeReportPageSkip":
            MessageLookupByLibrary.simpleMessage("Пропустить"),
        "makeReportPageSkipAndFinish":
            MessageLookupByLibrary.simpleMessage("Пропустить и завершить"),
        "makeReportPageTapToChange":
            MessageLookupByLibrary.simpleMessage("Нажмите для изменения"),
        "makeReportPageTapToWatch":
            MessageLookupByLibrary.simpleMessage("Нажмите для просмотра"),
        "makeReportPageUndefinedState":
            MessageLookupByLibrary.simpleMessage("Неопределенное состояние"),
        "makeReportPageYes": MessageLookupByLibrary.simpleMessage("Да"),
        "maximumNumberFilesReached": MessageLookupByLibrary.simpleMessage(
            "Достигнуто максимальное количество файлов данного типа"),
        "mediaFilesDoNotSaved": MessageLookupByLibrary.simpleMessage(
            "Медиафайлы не сохранены. Сохранить?"),
        "medium": MessageLookupByLibrary.simpleMessage("Средний"),
        "microphone": MessageLookupByLibrary.simpleMessage("Микрофон"),
        "minimumAudioLengthNotReached": MessageLookupByLibrary.simpleMessage(
            "Не достигнута минимальная продолжительность аудиозаписи"),
        "minimumVideoLengthNotReached": MessageLookupByLibrary.simpleMessage(
            "Не достигнута минимальная продолжительность видео"),
        "missingObjectsName": MessageLookupByLibrary.simpleMessage("объектов"),
        "missingReviewsName": MessageLookupByLibrary.simpleMessage("проверок"),
        "missingTasksName": MessageLookupByLibrary.simpleMessage("задач"),
        "myTextFieldDefaultDateHint":
            MessageLookupByLibrary.simpleMessage("Введите дату"),
        "myTextFieldDefaultNumberHint":
            MessageLookupByLibrary.simpleMessage("Введите число"),
        "myTextFieldDefaultTextHint":
            MessageLookupByLibrary.simpleMessage("Введите текст"),
        "necessaryActionsForTask": MessageLookupByLibrary.simpleMessage(
            "Необходимые действия по задаче"),
        "networkException":
            MessageLookupByLibrary.simpleMessage("Ошибка интернет-соединения"),
        "newContractorPhoneNumber": MessageLookupByLibrary.simpleMessage(
            "Номер телефона нового Исполнителя"),
        "noAccessToGetExactLocation": MessageLookupByLibrary.simpleMessage(
            "Нет доступа для получения точного местоположения"),
        "noAccessToGetLocation": MessageLookupByLibrary.simpleMessage(
            "Нет доступа для получения местоположения"),
        "noAvailableArticleTypes": MessageLookupByLibrary.simpleMessage(
            "Нет доступных типов объектов осмотра для создания.\nСвяжитесь с технической поддержкой\nна странице «Помощь»"),
        "noAvailableReviwTemplatesForThisArticle":
            MessageLookupByLibrary.simpleMessage(
                "Для данного объекта нет доступных шаблонов осмотров"),
        "noAvailableTasks": MessageLookupByLibrary.simpleMessage(
            "Доступные задачи отсутствуют"),
        "noChecksScheduledOrStarted": MessageLookupByLibrary.simpleMessage(
            "Проверки отсутствуют. Ожидайте их назначения или создайте самостоятельно"),
        "noInReworkChecks": MessageLookupByLibrary.simpleMessage(
            "Проверки, требующие доработки, отсутствуют"),
        "noInternetConnectionNotifications":
            MessageLookupByLibrary.simpleMessage(
                "Подключение к Интернету отсутствует.\nУведомления недоступны."),
        "noScheduledChecks": MessageLookupByLibrary.simpleMessage(
            "Назначенные проверки отсутствуют"),
        "noStartedChecks": MessageLookupByLibrary.simpleMessage(
            "Проверки в работе отсутствуют"),
        "notAllRequiredPermitsHaveBeenIssued":
            MessageLookupByLibrary.simpleMessage(
                "Выданы не все необходимые разрешения"),
        "notAllStepsHaveBeenCompleted": MessageLookupByLibrary.simpleMessage(
            "Для завершения проверки необходимо пройти все обязательные шаги"),
        "notifications": MessageLookupByLibrary.simpleMessage("Уведомления"),
        "notificationsScreenTitle":
            MessageLookupByLibrary.simpleMessage("События"),
        "notificationsScreenYetHaveNotNotifications":
            MessageLookupByLibrary.simpleMessage("У вас еще нет уведомлений"),
        "numberOfCopies":
            MessageLookupByLibrary.simpleMessage("Количество копий"),
        "numberOfImagesExceeded": MessageLookupByLibrary.simpleMessage(
            "Количество выбранных картинок превышено. Максимум - "),
        "object": MessageLookupByLibrary.simpleMessage("Объект"),
        "objects": MessageLookupByLibrary.simpleMessage("Объекты"),
        "objectsWithThisNameNotFound": MessageLookupByLibrary.simpleMessage(
            "Объектов с таким названием не найдено"),
        "ok": MessageLookupByLibrary.simpleMessage("ОК"),
        "onCenterWidgetUndefined":
            MessageLookupByLibrary.simpleMessage("undefined"),
        "pickDate": MessageLookupByLibrary.simpleMessage("Выберите дату"),
        "pickObject": MessageLookupByLibrary.simpleMessage("Выберите объект"),
        "pickPriority":
            MessageLookupByLibrary.simpleMessage("Выберите приоритет"),
        "pickTaskType":
            MessageLookupByLibrary.simpleMessage("Выберите тип задачи"),
        "picture": MessageLookupByLibrary.simpleMessage("Картинка"),
        "pleaseWait":
            MessageLookupByLibrary.simpleMessage("Пожалуйста, подождите"),
        "previewPhotoScreenEnterComment":
            MessageLookupByLibrary.simpleMessage("Введите текст комментария"),
        "previewPhotoScreenUnexpectedFileFormat":
            MessageLookupByLibrary.simpleMessage(
                "Неизвестный формат файла или не удалось его определить"),
        "priority": MessageLookupByLibrary.simpleMessage("Приоритет"),
        "proceedToReview":
            MessageLookupByLibrary.simpleMessage("Перейти к Проверке"),
        "profileScreenCompanyInn":
            MessageLookupByLibrary.simpleMessage("ИНН компании"),
        "profileScreenEmail": MessageLookupByLibrary.simpleMessage("Email"),
        "profileScreenJobTitle":
            MessageLookupByLibrary.simpleMessage("Должность"),
        "profileScreenName": MessageLookupByLibrary.simpleMessage("Имя"),
        "profileScreenPassword": MessageLookupByLibrary.simpleMessage("Пароль"),
        "profileScreenPatronymic":
            MessageLookupByLibrary.simpleMessage("Отчество"),
        "profileScreenPhoneNumber":
            MessageLookupByLibrary.simpleMessage("Мобильный телефон"),
        "profileScreenRepeatPassword":
            MessageLookupByLibrary.simpleMessage("Повторите пароль"),
        "profileScreenSave": MessageLookupByLibrary.simpleMessage("Сохранить"),
        "profileScreenSurname": MessageLookupByLibrary.simpleMessage("Фамилия"),
        "recoveryScreenHintTitle":
            MessageLookupByLibrary.simpleMessage("Введите номер телефона"),
        "recoveryScreenPasswordHasBeenSentOnSpecifiedPhone":
            MessageLookupByLibrary.simpleMessage(
                "Пароль отправлен на указанный номер телефона"),
        "recoveryScreenPhoneHint":
            MessageLookupByLibrary.simpleMessage("* Номер телефона"),
        "recoveryScreenPhoneLabel":
            MessageLookupByLibrary.simpleMessage("Номер телефона"),
        "recoveryScreenSendPasswordButtonTitle":
            MessageLookupByLibrary.simpleMessage("Отправить пароль"),
        "recoveryScreenTitle":
            MessageLookupByLibrary.simpleMessage("Восстановление пароля"),
        "registerFirstScreenCompanyLabel":
            MessageLookupByLibrary.simpleMessage("Компания"),
        "registerFirstScreenEmailLabel":
            MessageLookupByLibrary.simpleMessage("Email"),
        "registerFirstScreenFirstnameLabel":
            MessageLookupByLibrary.simpleMessage("Имя"),
        "registerFirstScreenInnOfCompanyLabel":
            MessageLookupByLibrary.simpleMessage("ИНН компании"),
        "registerFirstScreenLastnameLabel":
            MessageLookupByLibrary.simpleMessage("Фамилия"),
        "registerFirstScreenPasswordConfirmationError":
            MessageLookupByLibrary.simpleMessage("Пароль не соответствует"),
        "registerFirstScreenPasswordConfirmationLabel":
            MessageLookupByLibrary.simpleMessage("Повторите пароль"),
        "registerFirstScreenPasswordLabel":
            MessageLookupByLibrary.simpleMessage("Пароль"),
        "registerFirstScreenPatronymicLabel":
            MessageLookupByLibrary.simpleMessage("Отчество"),
        "registerFirstScreenPhoneLabel":
            MessageLookupByLibrary.simpleMessage("Мобильный телефон"),
        "registerFirstScreenPositionLabel":
            MessageLookupByLibrary.simpleMessage("Должность"),
        "registerFirstScreenPrivacy1": MessageLookupByLibrary.simpleMessage(
            "Нажимая «Зарегистрироваться», я соглашаюсь с обработкой моей персональной информации на условиях "),
        "registerFirstScreenPrivacy2":
            MessageLookupByLibrary.simpleMessage("Политики конфиденциальности"),
        "registerFirstScreenSignupButtonTitle":
            MessageLookupByLibrary.simpleMessage("Зарегистрироваться"),
        "registerFirstScreenSmsCodeHasBeenSentNotification":
            MessageLookupByLibrary.simpleMessage(
                "Код подтверждения отправлен на указанный номер телефона"),
        "registerFirstScreenTitle":
            MessageLookupByLibrary.simpleMessage("Регистрация"),
        "registerFirstScreenUserAgreement1":
            MessageLookupByLibrary.simpleMessage(
                "Нажимая «Зарегистрироваться», я соглашаюсь с"),
        "registerFirstScreenUserAgreement2":
            MessageLookupByLibrary.simpleMessage(
                "Пользовательским соглашением"),
        "registerFirstScreenUserAgreement3":
            MessageLookupByLibrary.simpleMessage(
                "и с обработкой моей персональной информации на условиях"),
        "registerFirstScreenUserAgreement4":
            MessageLookupByLibrary.simpleMessage("Политики конфиденциальности"),
        "registerSecondScreenFinishRegistrationButtonTitle":
            MessageLookupByLibrary.simpleMessage("Завершить регистрацию"),
        "registerSecondScreenSmsCodeHasBeenSentToPhone": m16,
        "registerSecondScreenSmsCodeLabel":
            MessageLookupByLibrary.simpleMessage("Смс-код"),
        "registerSecondScreenSuccessful": MessageLookupByLibrary.simpleMessage(
            "Вы успешно зарегистрировались!"),
        "registerSecondScreenTitle":
            MessageLookupByLibrary.simpleMessage("Завершение регистрации"),
        "registrationSuccess":
            MessageLookupByLibrary.simpleMessage("Регистрация прошла успешно"),
        "rejection": MessageLookupByLibrary.simpleMessage("Отказ"),
        "rejectionReason":
            MessageLookupByLibrary.simpleMessage("Причина отказа"),
        "reportAlreadyGotToWork": MessageLookupByLibrary.simpleMessage(
            "Проверка уже взята в работу другим Исполнителем"),
        "reportRejectedSuccess":
            MessageLookupByLibrary.simpleMessage("Проверка отменена"),
        "reportWasDelegatedToChosenContractor":
            MessageLookupByLibrary.simpleMessage(
                "Проверка была делегирована выбранному исполнителю"),
        "required": MessageLookupByLibrary.simpleMessage("обязательный"),
        "review": MessageLookupByLibrary.simpleMessage("Проверка"),
        "reviewOrTaskCanNotBeCreatedWithoutAvailableArticles":
            MessageLookupByLibrary.simpleMessage(
                "Без доступных Объектов невозможно создать проверку или задачу"),
        "reviewStepsCreateScreenCreate":
            MessageLookupByLibrary.simpleMessage("Создать"),
        "reviewStepsCreateScreenDescription":
            MessageLookupByLibrary.simpleMessage("Краткое описание"),
        "reviewStepsCreateScreenDocumentScan":
            MessageLookupByLibrary.simpleMessage("Сканировать документ"),
        "reviewStepsCreateScreenFile":
            MessageLookupByLibrary.simpleMessage("Файл"),
        "reviewStepsCreateScreenName":
            MessageLookupByLibrary.simpleMessage("Название"),
        "reviewStepsCreateScreenNewStep":
            MessageLookupByLibrary.simpleMessage("Создание нового шага"),
        "reviewStepsCreateScreenPhoto":
            MessageLookupByLibrary.simpleMessage("Фото"),
        "reviewStepsCreateScreenVideo":
            MessageLookupByLibrary.simpleMessage("Видео"),
        "reviewTemplate":
            MessageLookupByLibrary.simpleMessage("Шаблон проверки"),
        "reviewTemplateFormStepScreenChooseData":
            MessageLookupByLibrary.simpleMessage("Выбор даты"),
        "reviewTemplateFormStepScreenDatePickerCancelText":
            MessageLookupByLibrary.simpleMessage("Отменить"),
        "reviewTemplateFormStepScreenDropdownHintText":
            MessageLookupByLibrary.simpleMessage("    Выберите вариант ответа"),
        "reviewTemplateFormStepScreenEmptyDropdown":
            MessageLookupByLibrary.simpleMessage("Нет значений для выбора"),
        "reviewTemplateFormStepScreenRequiredInputValidation":
            MessageLookupByLibrary.simpleMessage("Обязательно для заполнения"),
        "reviewTemplateFormStepScreenSaveButtonTitle":
            MessageLookupByLibrary.simpleMessage("Сохранить"),
        "reviews": MessageLookupByLibrary.simpleMessage("Проверки"),
        "reviewsModalInfoLaterButton":
            MessageLookupByLibrary.simpleMessage("Позже"),
        "reviewsModalInfoRedirectButton":
            MessageLookupByLibrary.simpleMessage("Перейти"),
        "save": MessageLookupByLibrary.simpleMessage("Сохранить"),
        "search": MessageLookupByLibrary.simpleMessage("Поиск"),
        "sectionName": MessageLookupByLibrary.simpleMessage("Название раздела"),
        "selectAnAction":
            MessageLookupByLibrary.simpleMessage("Выберите действие"),
        "selfContractorCreationIsImpossible": MessageLookupByLibrary.simpleMessage(
            "Самостоятельное создание исполнителя недоступно в соответствии с настройками установленными администратором."),
        "sendForApproval":
            MessageLookupByLibrary.simpleMessage("Отправить на согласование"),
        "sending": MessageLookupByLibrary.simpleMessage("Отправка"),
        "showAll": MessageLookupByLibrary.simpleMessage("Показать все"),
        "signReviewDescription": MessageLookupByLibrary.simpleMessage(
            "Нажимая кнопку «Отправить», вы подтверждаете актуальность, достоверность и соответствие представленных сведений указанных в проверке."),
        "signReviewTitle": MessageLookupByLibrary.simpleMessage(
            "Подписание Проверки простой электронной подписью"),
        "specifyNewStepName": MessageLookupByLibrary.simpleMessage(
            "Укажите новое название для шага"),
        "startOfExecution":
            MessageLookupByLibrary.simpleMessage("Старт выполнения"),
        "startReviewWithoutInitialLocation": MessageLookupByLibrary.simpleMessage(
            "В данный момент не удалось определить местоположение. Попытки  будут производиться в течение прохождения Проверки."),
        "stepInfo": MessageLookupByLibrary.simpleMessage("Информация о шаге"),
        "stepType": MessageLookupByLibrary.simpleMessage("Тип шага"),
        "stepsCompleted":
            MessageLookupByLibrary.simpleMessage("Пройдено шагов"),
        "switchToSignIn":
            MessageLookupByLibrary.simpleMessage("Перейти к авторизации"),
        "task": MessageLookupByLibrary.simpleMessage("Задача"),
        "taskAddress": MessageLookupByLibrary.simpleMessage("Адрес задачи"),
        "taskCreatedSuccessfully":
            MessageLookupByLibrary.simpleMessage("Задача успешно создана"),
        "taskDetailErrorFailedTitle": MessageLookupByLibrary.simpleMessage(
            "Ошибка загрузки, попробуйте позже"),
        "taskExecutionDeleteFileDialogContent":
            MessageLookupByLibrary.simpleMessage(
                "Вы действительно хотите удалить файл?\n\nДействие необратимо"),
        "taskExecutionDescriptionTitle":
            MessageLookupByLibrary.simpleMessage("Описание:"),
        "taskExecutionFinishButtonTitle":
            MessageLookupByLibrary.simpleMessage("Завершить"),
        "taskExecutionNotAllConditionsCompleted":
            MessageLookupByLibrary.simpleMessage(
                "Для завершения задачи необходимо пройти обязательные шаги"),
        "taskExecutionScreenTakeDocumentButtonTitle":
            MessageLookupByLibrary.simpleMessage("Сканировать документ"),
        "taskExecutionScreenTakeFileButtonTitle":
            MessageLookupByLibrary.simpleMessage("Выбрать файл"),
        "taskExecutionScreenTakePhotoButtonTitle":
            MessageLookupByLibrary.simpleMessage("Сделать фото"),
        "taskExecutionScreenTakeVideoButtonTitle":
            MessageLookupByLibrary.simpleMessage("Записать видео"),
        "taskExecutionStepDetailDescriptionTitle":
            MessageLookupByLibrary.simpleMessage("Описание"),
        "taskExecutionStepDetailPhotoExampleTitle":
            MessageLookupByLibrary.simpleMessage("Фото-пример"),
        "taskInfoRefuseButtonTitle":
            MessageLookupByLibrary.simpleMessage("Отказаться"),
        "taskInfoScreenAddressTitle":
            MessageLookupByLibrary.simpleMessage("Адрес задачи"),
        "taskInfoScreenArticleTitle":
            MessageLookupByLibrary.simpleMessage("Объект"),
        "taskInfoScreenChangeButtonTitle":
            MessageLookupByLibrary.simpleMessage("Редактировать"),
        "taskInfoScreenDescriptionTitle":
            MessageLookupByLibrary.simpleMessage("Описание"),
        "taskInfoScreenExecuteButtonTitle":
            MessageLookupByLibrary.simpleMessage("Выполнить"),
        "taskInfoScreenFinishDateLimitTitle":
            MessageLookupByLibrary.simpleMessage("Срок выполнения"),
        "taskInfoScreenTakeToWorkButtonTitle":
            MessageLookupByLibrary.simpleMessage("Взять в работу"),
        "taskType": MessageLookupByLibrary.simpleMessage("Тип задачи"),
        "tasks": MessageLookupByLibrary.simpleMessage("Задачи"),
        "tasksRowFinishExecutionAt": m17,
        "tasksRowStartExecutionAt": m18,
        "tasksScreenAppBarTitle":
            MessageLookupByLibrary.simpleMessage("Задачи"),
        "tasksScreenErrorTitle": MessageLookupByLibrary.simpleMessage(
            "Ошибка загрузки, попробуйте позже"),
        "tasksScreenFastFilterAssignedStatusTitle":
            MessageLookupByLibrary.simpleMessage("Назначенные"),
        "tasksScreenFastFilterAtWorkStatusTitle":
            MessageLookupByLibrary.simpleMessage("В работе"),
        "tasksScreenFastFilterCompletedStatusTitle":
            MessageLookupByLibrary.simpleMessage("Завершенные"),
        "tasksScreenFastFilterOnInspectionStatusTitle":
            MessageLookupByLibrary.simpleMessage("На подтверждении"),
        "tasksScreenFastFilterRejectedStatusTitle":
            MessageLookupByLibrary.simpleMessage("Отклоненные"),
        "tasksScreenTabAvailableTitle":
            MessageLookupByLibrary.simpleMessage("Доступные"),
        "tasksScreenTabMyTasksTitle":
            MessageLookupByLibrary.simpleMessage("Мои задачи"),
        "toDelegate": MessageLookupByLibrary.simpleMessage("Делегировать"),
        "toMain": MessageLookupByLibrary.simpleMessage("На главную"),
        "toNextStepButtonTitle": MessageLookupByLibrary.simpleMessage("Далее"),
        "tryAgain": MessageLookupByLibrary.simpleMessage("Повторить попытку"),
        "turnOnGPS": MessageLookupByLibrary.simpleMessage("Включите GPS"),
        "turnOnLocationServices": MessageLookupByLibrary.simpleMessage(
            "Включите службы геолокации HMS Core"),
        "unexpectedException":
            MessageLookupByLibrary.simpleMessage("Произошла какая-то ошибка"),
        "uploadsScreenEntiyActionAttachCommentsTitle":
            MessageLookupByLibrary.simpleMessage("Комментарии"),
        "uploadsScreenEntiyActionAttachViolationsTitle":
            MessageLookupByLibrary.simpleMessage("Нарушения"),
        "uploadsScreenEntiyActionDeletingFilesTitle":
            MessageLookupByLibrary.simpleMessage("Удаление файлов"),
        "uploadsScreenEntiyActionLocationUploadTitle":
            MessageLookupByLibrary.simpleMessage("Местоположение"),
        "uploadsScreenEntiyActionReviewFinishTitle":
            MessageLookupByLibrary.simpleMessage("Завершение проверки"),
        "uploadsScreenEntiyActionReviewInterruptTitle":
            MessageLookupByLibrary.simpleMessage("Прекращение проверки"),
        "uploadsScreenEntiyActionReviewStoreTitle":
            MessageLookupByLibrary.simpleMessage("Создание проверки"),
        "uploadsScreenEntiyActionStepFileUploadTitle":
            MessageLookupByLibrary.simpleMessage("Файл"),
        "uploadsScreenEntiyTypeLocationTitle":
            MessageLookupByLibrary.simpleMessage("Местоположение"),
        "uploadsScreenEntiyTypeReviewTitle":
            MessageLookupByLibrary.simpleMessage("Проверка"),
        "uploadsScreenEntiyTypeStepFileTitle":
            MessageLookupByLibrary.simpleMessage("Файл"),
        "uploadsScreenIdHasBeenCopiedMessage": m19,
        "uploadsScreenTitle": MessageLookupByLibrary.simpleMessage("Загрузки"),
        "uploadsScreenUploadsScreenIsEmpty":
            MessageLookupByLibrary.simpleMessage("Список загрузок пуст"),
        "userAgreementAndPrivacyPolicy": MessageLookupByLibrary.simpleMessage(
            "Пользовательским соглашением и политикой конфиденциальности"),
        "videoProcessing":
            MessageLookupByLibrary.simpleMessage("Обработка видео"),
        "waitCreationArticlesOr": MessageLookupByLibrary.simpleMessage(
            "Ожидайте добавления Объектов или "),
        "waitForTheirAppointmentOr": MessageLookupByLibrary.simpleMessage(
            "Ожидайте их назначения или\n"),
        "waitForVerification":
            MessageLookupByLibrary.simpleMessage("Ожидайте верификации"),
        "youAreNotLinkedToAnyCompany":
            MessageLookupByLibrary.simpleMessage("Вы не привязаны к компании"),
        "youCanSpecifyNameCopiedSteps": MessageLookupByLibrary.simpleMessage(
            "Название скопированных шагов вы можете указать в самом шаге проверки"),
        "youWillGetMessageWithPassword": MessageLookupByLibrary.simpleMessage(
            "Для входа в приложение Вам придет сообщение с паролем"),
        "youWillGetPasswordAfterVerification": MessageLookupByLibrary.simpleMessage(
            "После подтверждения аккаунта Вам придет сообщение с паролем для авторизации")
      };
}
