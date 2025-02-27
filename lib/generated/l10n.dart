// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Internet Connection Error`
  String get networkException {
    return Intl.message(
      'Internet Connection Error',
      name: 'networkException',
      desc: '',
      args: [],
    );
  }

  /// `A new update is available, please update the app\n\nYour version: {localVersion}\nAvailable version: {storeVersion}`
  String loadingScreenHasNewUpdate(String localVersion, String storeVersion) {
    return Intl.message(
      'A new update is available, please update the app\n\nYour version: $localVersion\nAvailable version: $storeVersion',
      name: 'loadingScreenHasNewUpdate',
      desc: 'Notification about a new app update',
      args: [localVersion, storeVersion],
    );
  }

  /// `\n\nDescription:{releaseNotes}`
  String loadingScreenUpdateHasNotes(String releaseNotes) {
    return Intl.message(
      '\n\nDescription:$releaseNotes',
      name: 'loadingScreenUpdateHasNotes',
      desc: 'Description',
      args: [releaseNotes],
    );
  }

  /// `Update`
  String get loadingScreenUpdateDialogTitle {
    return Intl.message(
      'Update',
      name: 'loadingScreenUpdateDialogTitle',
      desc: '',
      args: [],
    );
  }

  /// `Update`
  String get loadingScreenUpdateDialogUpdateButtonTitle {
    return Intl.message(
      'Update',
      name: 'loadingScreenUpdateDialogUpdateButtonTitle',
      desc: '',
      args: [],
    );
  }

  /// `Later`
  String get loadingScreenUpdateDialogDismissButtonTitle {
    return Intl.message(
      'Later',
      name: 'loadingScreenUpdateDialogDismissButtonTitle',
      desc: '',
      args: [],
    );
  }

  /// `Uploading {count} items has started!\nDo not close the app and ensure a stable internet connection.`
  String loadingScreenUploadingFilesStarted(int count) {
    return Intl.message(
      'Uploading $count items has started!\nDo not close the app and ensure a stable internet connection.',
      name: 'loadingScreenUploadingFilesStarted',
      desc: 'Popup notification about starting to upload files to the server',
      args: [count],
    );
  }

  /// `Loading the App...`
  String get loadingScreenLoadingAppTitle {
    return Intl.message(
      'Loading the App...',
      name: 'loadingScreenLoadingAppTitle',
      desc: '',
      args: [],
    );
  }

  /// `A new update is available.\n\n`
  String get loadingScreenHasNewUpdateText1 {
    return Intl.message(
      'A new update is available.\n\n',
      name: 'loadingScreenHasNewUpdateText1',
      desc: '',
      args: [],
    );
  }

  /// `Please update the app.\n\n`
  String get loadingScreenHasNewUpdateText2 {
    return Intl.message(
      'Please update the app.\n\n',
      name: 'loadingScreenHasNewUpdateText2',
      desc: '',
      args: [],
    );
  }

  /// `Update`
  String get loadingScreenHasNewUpdateText3 {
    return Intl.message(
      'Update',
      name: 'loadingScreenHasNewUpdateText3',
      desc: '',
      args: [],
    );
  }

  /// `A critical error has occurred\n`
  String get loadingScreenHasBeenCriticalError1 {
    return Intl.message(
      'A critical error has occurred\n',
      name: 'loadingScreenHasBeenCriticalError1',
      desc: '',
      args: [],
    );
  }

  /// `Restart the app within an internet zone.\nIf the issue persists, `
  String get loadingScreenHasBeenCriticalError2 {
    return Intl.message(
      'Restart the app within an internet zone.\nIf the issue persists, ',
      name: 'loadingScreenHasBeenCriticalError2',
      desc: '',
      args: [],
    );
  }

  /// `try again`
  String get loadingScreenHasBeenCriticalError3 {
    return Intl.message(
      'try again',
      name: 'loadingScreenHasBeenCriticalError3',
      desc: '',
      args: [],
    );
  }

  /// ` or `
  String get loadingScreenHasBeenCriticalError4 {
    return Intl.message(
      ' or ',
      name: 'loadingScreenHasBeenCriticalError4',
      desc: '',
      args: [],
    );
  }

  /// `remove files from the app`
  String get loadingScreenHasBeenCriticalError5 {
    return Intl.message(
      'remove files from the app',
      name: 'loadingScreenHasBeenCriticalError5',
      desc: '',
      args: [],
    );
  }

  /// `, then `
  String get loadingScreenHasBeenCriticalError6 {
    return Intl.message(
      ', then ',
      name: 'loadingScreenHasBeenCriticalError6',
      desc: '',
      args: [],
    );
  }

  /// `reinstall the app.`
  String get loadingScreenHasBeenCriticalError7 {
    return Intl.message(
      'reinstall the app.',
      name: 'loadingScreenHasBeenCriticalError7',
      desc: '',
      args: [],
    );
  }

  /// `Retrying...`
  String get loadingScreenRetrying {
    return Intl.message(
      'Retrying...',
      name: 'loadingScreenRetrying',
      desc: '',
      args: [],
    );
  }

  /// `Starting the app in offline mode.`
  String get loadingScreenStartingOfflineMode {
    return Intl.message(
      'Starting the app in offline mode.',
      name: 'loadingScreenStartingOfflineMode',
      desc: '',
      args: [],
    );
  }

  /// `Connecting to the server, please wait...`
  String get loadingScreenConnectingToServer {
    return Intl.message(
      'Connecting to the server, please wait...',
      name: 'loadingScreenConnectingToServer',
      desc: '',
      args: [],
    );
  }

  /// `Retrying sending {progress} / {count}...`
  String loadingScreenRetryingSending(int progress, int count) {
    return Intl.message(
      'Retrying sending $progress / $count...',
      name: 'loadingScreenRetryingSending',
      desc: '',
      args: [progress, count],
    );
  }

  /// `Log into your account`
  String get loginScreenTitle {
    return Intl.message(
      'Log into your account',
      name: 'loginScreenTitle',
      desc: '',
      args: [],
    );
  }

  /// `By clicking “Log In”, I agree to the`
  String get loginScreenUserAgreement1 {
    return Intl.message(
      'By clicking “Log In”, I agree to the',
      name: 'loginScreenUserAgreement1',
      desc: '',
      args: [],
    );
  }

  /// `User Agreement`
  String get loginScreenUserAgreement2 {
    return Intl.message(
      'User Agreement',
      name: 'loginScreenUserAgreement2',
      desc: '',
      args: [],
    );
  }

  /// `and processing of my personal data under the terms of the`
  String get loginScreenUserAgreement3 {
    return Intl.message(
      'and processing of my personal data under the terms of the',
      name: 'loginScreenUserAgreement3',
      desc: '',
      args: [],
    );
  }

  /// `Privacy Policy`
  String get loginScreenUserAgreement4 {
    return Intl.message(
      'Privacy Policy',
      name: 'loginScreenUserAgreement4',
      desc: '',
      args: [],
    );
  }

  /// `By clicking “Log In”, I agree to the processing of my personal data under the terms of the `
  String get loginScreenPrivacy1 {
    return Intl.message(
      'By clicking “Log In”, I agree to the processing of my personal data under the terms of the ',
      name: 'loginScreenPrivacy1',
      desc: '',
      args: [],
    );
  }

  /// `Privacy Policy`
  String get loginScreenPrivacy2 {
    return Intl.message(
      'Privacy Policy',
      name: 'loginScreenPrivacy2',
      desc: '',
      args: [],
    );
  }

  /// `Sign Up`
  String get loginScreenSignupButtonTitle {
    return Intl.message(
      'Sign Up',
      name: 'loginScreenSignupButtonTitle',
      desc: '',
      args: [],
    );
  }

  /// ` or `
  String get loginScreenSignupOrRecoveryPassword {
    return Intl.message(
      ' or ',
      name: 'loginScreenSignupOrRecoveryPassword',
      desc: '',
      args: [],
    );
  }

  /// `Recover Password`
  String get loginScreenRecoveryPasswordLinkTitle {
    return Intl.message(
      'Recover Password',
      name: 'loginScreenRecoveryPasswordLinkTitle',
      desc: '',
      args: [],
    );
  }

  /// `Recover Password`
  String get loginScreenRecoveryPasswordLink2 {
    return Intl.message(
      'Recover Password',
      name: 'loginScreenRecoveryPasswordLink2',
      desc: '',
      args: [],
    );
  }

  /// `Phone Number`
  String get loginScreenPhoneLabel {
    return Intl.message(
      'Phone Number',
      name: 'loginScreenPhoneLabel',
      desc: '',
      args: [],
    );
  }

  /// `* Phone Number`
  String get loginScreenPhoneHint {
    return Intl.message(
      '* Phone Number',
      name: 'loginScreenPhoneHint',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get loginScreenPasswordLabel {
    return Intl.message(
      'Password',
      name: 'loginScreenPasswordLabel',
      desc: '',
      args: [],
    );
  }

  /// `* Password`
  String get loginScreenPasswordHint {
    return Intl.message(
      '* Password',
      name: 'loginScreenPasswordHint',
      desc: '',
      args: [],
    );
  }

  /// `Log In`
  String get loginScreenSignInButtonTitle {
    return Intl.message(
      'Log In',
      name: 'loginScreenSignInButtonTitle',
      desc: '',
      args: [],
    );
  }

  /// `Confirmation code has been sent to the provided phone number`
  String get registerFirstScreenSmsCodeHasBeenSentNotification {
    return Intl.message(
      'Confirmation code has been sent to the provided phone number',
      name: 'registerFirstScreenSmsCodeHasBeenSentNotification',
      desc: '',
      args: [],
    );
  }

  /// `By clicking “Sign Up”, I agree to the`
  String get registerFirstScreenUserAgreement1 {
    return Intl.message(
      'By clicking “Sign Up”, I agree to the',
      name: 'registerFirstScreenUserAgreement1',
      desc: '',
      args: [],
    );
  }

  /// `User Agreement`
  String get registerFirstScreenUserAgreement2 {
    return Intl.message(
      'User Agreement',
      name: 'registerFirstScreenUserAgreement2',
      desc: '',
      args: [],
    );
  }

  /// `and processing of my personal data under the terms of the`
  String get registerFirstScreenUserAgreement3 {
    return Intl.message(
      'and processing of my personal data under the terms of the',
      name: 'registerFirstScreenUserAgreement3',
      desc: '',
      args: [],
    );
  }

  /// `Privacy Policy`
  String get registerFirstScreenUserAgreement4 {
    return Intl.message(
      'Privacy Policy',
      name: 'registerFirstScreenUserAgreement4',
      desc: '',
      args: [],
    );
  }

  /// `By clicking “Sign Up”, I agree to the processing of my personal data under the terms of the `
  String get registerFirstScreenPrivacy1 {
    return Intl.message(
      'By clicking “Sign Up”, I agree to the processing of my personal data under the terms of the ',
      name: 'registerFirstScreenPrivacy1',
      desc: '',
      args: [],
    );
  }

  /// `Privacy Policy`
  String get registerFirstScreenPrivacy2 {
    return Intl.message(
      'Privacy Policy',
      name: 'registerFirstScreenPrivacy2',
      desc: '',
      args: [],
    );
  }

  /// `Registration`
  String get registerFirstScreenTitle {
    return Intl.message(
      'Registration',
      name: 'registerFirstScreenTitle',
      desc: '',
      args: [],
    );
  }

  /// `Last Name`
  String get registerFirstScreenLastnameLabel {
    return Intl.message(
      'Last Name',
      name: 'registerFirstScreenLastnameLabel',
      desc: '',
      args: [],
    );
  }

  /// `First Name`
  String get registerFirstScreenFirstnameLabel {
    return Intl.message(
      'First Name',
      name: 'registerFirstScreenFirstnameLabel',
      desc: '',
      args: [],
    );
  }

  /// `Patronymic`
  String get registerFirstScreenPatronymicLabel {
    return Intl.message(
      'Patronymic',
      name: 'registerFirstScreenPatronymicLabel',
      desc: '',
      args: [],
    );
  }

  /// `Company`
  String get registerFirstScreenCompanyLabel {
    return Intl.message(
      'Company',
      name: 'registerFirstScreenCompanyLabel',
      desc: '',
      args: [],
    );
  }

  /// `Company's TIN`
  String get registerFirstScreenInnOfCompanyLabel {
    return Intl.message(
      'Company\'s TIN',
      name: 'registerFirstScreenInnOfCompanyLabel',
      desc: '',
      args: [],
    );
  }

  /// `Position`
  String get registerFirstScreenPositionLabel {
    return Intl.message(
      'Position',
      name: 'registerFirstScreenPositionLabel',
      desc: '',
      args: [],
    );
  }

  /// `Mobile Phone`
  String get registerFirstScreenPhoneLabel {
    return Intl.message(
      'Mobile Phone',
      name: 'registerFirstScreenPhoneLabel',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get registerFirstScreenEmailLabel {
    return Intl.message(
      'Email',
      name: 'registerFirstScreenEmailLabel',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get registerFirstScreenPasswordLabel {
    return Intl.message(
      'Password',
      name: 'registerFirstScreenPasswordLabel',
      desc: '',
      args: [],
    );
  }

  /// `Confirm Password`
  String get registerFirstScreenPasswordConfirmationLabel {
    return Intl.message(
      'Confirm Password',
      name: 'registerFirstScreenPasswordConfirmationLabel',
      desc: '',
      args: [],
    );
  }

  /// `Passwords do not match`
  String get registerFirstScreenPasswordConfirmationError {
    return Intl.message(
      'Passwords do not match',
      name: 'registerFirstScreenPasswordConfirmationError',
      desc: '',
      args: [],
    );
  }

  /// `Sign Up`
  String get registerFirstScreenSignupButtonTitle {
    return Intl.message(
      'Sign Up',
      name: 'registerFirstScreenSignupButtonTitle',
      desc: '',
      args: [],
    );
  }

  /// `You have successfully registered!`
  String get registerSecondScreenSuccessful {
    return Intl.message(
      'You have successfully registered!',
      name: 'registerSecondScreenSuccessful',
      desc: '',
      args: [],
    );
  }

  /// `Registration Completion`
  String get registerSecondScreenTitle {
    return Intl.message(
      'Registration Completion',
      name: 'registerSecondScreenTitle',
      desc: '',
      args: [],
    );
  }

  /// `The confirmation code has been sent to the provided number “{phone}”.`
  String registerSecondScreenSmsCodeHasBeenSentToPhone(String phone) {
    return Intl.message(
      'The confirmation code has been sent to the provided number “$phone”.',
      name: 'registerSecondScreenSmsCodeHasBeenSentToPhone',
      desc: '',
      args: [phone],
    );
  }

  /// `SMS Code`
  String get registerSecondScreenSmsCodeLabel {
    return Intl.message(
      'SMS Code',
      name: 'registerSecondScreenSmsCodeLabel',
      desc: '',
      args: [],
    );
  }

  /// `Finish Registration`
  String get registerSecondScreenFinishRegistrationButtonTitle {
    return Intl.message(
      'Finish Registration',
      name: 'registerSecondScreenFinishRegistrationButtonTitle',
      desc: '',
      args: [],
    );
  }

  /// `Create`
  String get addArticleScreenCreate {
    return Intl.message(
      'Create',
      name: 'addArticleScreenCreate',
      desc: '',
      args: [],
    );
  }

  /// `Object successfully created`
  String get addArticleScreenObjectSuccessfulCreatedMessage {
    return Intl.message(
      'Object successfully created',
      name: 'addArticleScreenObjectSuccessfulCreatedMessage',
      desc: '',
      args: [],
    );
  }

  /// `Loading...`
  String get addArticleScreenLoading {
    return Intl.message(
      'Loading...',
      name: 'addArticleScreenLoading',
      desc: '',
      args: [],
    );
  }

  /// `TIN not found, select to fill manually`
  String get addArticleScreenInnNotFoundSelectForFillManualy {
    return Intl.message(
      'TIN not found, select to fill manually',
      name: 'addArticleScreenInnNotFoundSelectForFillManualy',
      desc: '',
      args: [],
    );
  }

  /// `Enter TIN`
  String get addArticleScreenEnterInn {
    return Intl.message(
      'Enter TIN',
      name: 'addArticleScreenEnterInn',
      desc: '',
      args: [],
    );
  }

  /// `Company Name`
  String get addArticleScreenCompanyNameLabel {
    return Intl.message(
      'Company Name',
      name: 'addArticleScreenCompanyNameLabel',
      desc: '',
      args: [],
    );
  }

  /// `Address`
  String get addArticleScreenCompanyAddressLabel {
    return Intl.message(
      'Address',
      name: 'addArticleScreenCompanyAddressLabel',
      desc: '',
      args: [],
    );
  }

  /// `Questions and Answers`
  String get helpQuestionsScreenTitle {
    return Intl.message(
      'Questions and Answers',
      name: 'helpQuestionsScreenTitle',
      desc: '',
      args: [],
    );
  }

  /// `No questions and answers available`
  String get helpQuestionsScreenHasNotQuestionsAndAnswers {
    return Intl.message(
      'No questions and answers available',
      name: 'helpQuestionsScreenHasNotQuestionsAndAnswers',
      desc: '',
      args: [],
    );
  }

  /// `Unknown file format or unable to determine`
  String get previewPhotoScreenUnexpectedFileFormat {
    return Intl.message(
      'Unknown file format or unable to determine',
      name: 'previewPhotoScreenUnexpectedFileFormat',
      desc: '',
      args: [],
    );
  }

  /// `Enter comment text`
  String get previewPhotoScreenEnterComment {
    return Intl.message(
      'Enter comment text',
      name: 'previewPhotoScreenEnterComment',
      desc: '',
      args: [],
    );
  }

  /// `Password sent to the provided phone number`
  String get recoveryScreenPasswordHasBeenSentOnSpecifiedPhone {
    return Intl.message(
      'Password sent to the provided phone number',
      name: 'recoveryScreenPasswordHasBeenSentOnSpecifiedPhone',
      desc: '',
      args: [],
    );
  }

  /// `Password Recovery`
  String get recoveryScreenTitle {
    return Intl.message(
      'Password Recovery',
      name: 'recoveryScreenTitle',
      desc: '',
      args: [],
    );
  }

  /// `Enter Phone Number`
  String get recoveryScreenHintTitle {
    return Intl.message(
      'Enter Phone Number',
      name: 'recoveryScreenHintTitle',
      desc: '',
      args: [],
    );
  }

  /// `Phone Number`
  String get recoveryScreenPhoneLabel {
    return Intl.message(
      'Phone Number',
      name: 'recoveryScreenPhoneLabel',
      desc: '',
      args: [],
    );
  }

  /// `* Phone Number`
  String get recoveryScreenPhoneHint {
    return Intl.message(
      '* Phone Number',
      name: 'recoveryScreenPhoneHint',
      desc: '',
      args: [],
    );
  }

  /// `Send Password`
  String get recoveryScreenSendPasswordButtonTitle {
    return Intl.message(
      'Send Password',
      name: 'recoveryScreenSendPasswordButtonTitle',
      desc: '',
      args: [],
    );
  }

  /// `Required field`
  String get reviewTemplateFormStepScreenRequiredInputValidation {
    return Intl.message(
      'Required field',
      name: 'reviewTemplateFormStepScreenRequiredInputValidation',
      desc: '',
      args: [],
    );
  }

  /// `No values available`
  String get reviewTemplateFormStepScreenEmptyDropdown {
    return Intl.message(
      'No values available',
      name: 'reviewTemplateFormStepScreenEmptyDropdown',
      desc: '',
      args: [],
    );
  }

  /// `Select an answer option`
  String get reviewTemplateFormStepScreenDropdownHintText {
    return Intl.message(
      'Select an answer option',
      name: 'reviewTemplateFormStepScreenDropdownHintText',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get reviewTemplateFormStepScreenDatePickerCancelText {
    return Intl.message(
      'Cancel',
      name: 'reviewTemplateFormStepScreenDatePickerCancelText',
      desc: '',
      args: [],
    );
  }

  /// `Save`
  String get reviewTemplateFormStepScreenSaveButtonTitle {
    return Intl.message(
      'Save',
      name: 'reviewTemplateFormStepScreenSaveButtonTitle',
      desc: '',
      args: [],
    );
  }

  /// `Date Selection`
  String get reviewTemplateFormStepScreenChooseData {
    return Intl.message(
      'Date Selection',
      name: 'reviewTemplateFormStepScreenChooseData',
      desc: '',
      args: [],
    );
  }

  /// `Uploads`
  String get uploadsScreenTitle {
    return Intl.message(
      'Uploads',
      name: 'uploadsScreenTitle',
      desc: '',
      args: [],
    );
  }

  /// `Review Creation`
  String get uploadsScreenEntiyActionReviewStoreTitle {
    return Intl.message(
      'Review Creation',
      name: 'uploadsScreenEntiyActionReviewStoreTitle',
      desc: '',
      args: [],
    );
  }

  /// `Review Interruption`
  String get uploadsScreenEntiyActionReviewInterruptTitle {
    return Intl.message(
      'Review Interruption',
      name: 'uploadsScreenEntiyActionReviewInterruptTitle',
      desc: '',
      args: [],
    );
  }

  /// `Review Completion`
  String get uploadsScreenEntiyActionReviewFinishTitle {
    return Intl.message(
      'Review Completion',
      name: 'uploadsScreenEntiyActionReviewFinishTitle',
      desc: '',
      args: [],
    );
  }

  /// `File`
  String get uploadsScreenEntiyActionStepFileUploadTitle {
    return Intl.message(
      'File',
      name: 'uploadsScreenEntiyActionStepFileUploadTitle',
      desc: '',
      args: [],
    );
  }

  /// `Location`
  String get uploadsScreenEntiyActionLocationUploadTitle {
    return Intl.message(
      'Location',
      name: 'uploadsScreenEntiyActionLocationUploadTitle',
      desc: '',
      args: [],
    );
  }

  /// `Comments`
  String get uploadsScreenEntiyActionAttachCommentsTitle {
    return Intl.message(
      'Comments',
      name: 'uploadsScreenEntiyActionAttachCommentsTitle',
      desc: '',
      args: [],
    );
  }

  /// `Violations`
  String get uploadsScreenEntiyActionAttachViolationsTitle {
    return Intl.message(
      'Violations',
      name: 'uploadsScreenEntiyActionAttachViolationsTitle',
      desc: '',
      args: [],
    );
  }

  /// `Deleting Files`
  String get uploadsScreenEntiyActionDeletingFilesTitle {
    return Intl.message(
      'Deleting Files',
      name: 'uploadsScreenEntiyActionDeletingFilesTitle',
      desc: '',
      args: [],
    );
  }

  /// `Review`
  String get uploadsScreenEntiyTypeReviewTitle {
    return Intl.message(
      'Review',
      name: 'uploadsScreenEntiyTypeReviewTitle',
      desc: '',
      args: [],
    );
  }

  /// `File`
  String get uploadsScreenEntiyTypeStepFileTitle {
    return Intl.message(
      'File',
      name: 'uploadsScreenEntiyTypeStepFileTitle',
      desc: '',
      args: [],
    );
  }

  /// `Location`
  String get uploadsScreenEntiyTypeLocationTitle {
    return Intl.message(
      'Location',
      name: 'uploadsScreenEntiyTypeLocationTitle',
      desc: '',
      args: [],
    );
  }

  /// `Identifier copied: {id}`
  String uploadsScreenIdHasBeenCopiedMessage(String id) {
    return Intl.message(
      'Identifier copied: $id',
      name: 'uploadsScreenIdHasBeenCopiedMessage',
      desc: '',
      args: [id],
    );
  }

  /// `Objects`
  String get articlesScreenTitle {
    return Intl.message(
      'Objects',
      name: 'articlesScreenTitle',
      desc: '',
      args: [],
    );
  }

  /// `Wait for their addition or \n`
  String get articlesScreenAvailabledArticleNotFoundCanRegister1 {
    return Intl.message(
      'Wait for their addition or \n',
      name: 'articlesScreenAvailabledArticleNotFoundCanRegister1',
      desc: '',
      args: [],
    );
  }

  /// `create your own`
  String get articlesScreenAvailabledArticleNotFoundCanRegister2 {
    return Intl.message(
      'create your own',
      name: 'articlesScreenAvailabledArticleNotFoundCanRegister2',
      desc: '',
      args: [],
    );
  }

  /// `No available objects, wait for their creation.`
  String get articlesScreenAvailabledArticleNotFoundCantRegister {
    return Intl.message(
      'No available objects, wait for their creation.',
      name: 'articlesScreenAvailabledArticleNotFoundCantRegister',
      desc: '',
      args: [],
    );
  }

  /// `Registering reviews on the server...\n`
  String get articlesScreenRegisterReviews {
    return Intl.message(
      'Registering reviews on the server...\n',
      name: 'articlesScreenRegisterReviews',
      desc: '',
      args: [],
    );
  }

  /// `\nRegistered {current} out of {max}`
  String articlesScreenRegisterReviewsStatus(int current, int max) {
    return Intl.message(
      '\nRegistered $current out of $max',
      name: 'articlesScreenRegisterReviewsStatus',
      desc: '',
      args: [current, max],
    );
  }

  /// `Reviews have been successfully registered. File uploads will continue in offline mode. Do not close the app or disconnect from the internet.\n`
  String get articlesScreenRegisterReviewsFinish {
    return Intl.message(
      'Reviews have been successfully registered. File uploads will continue in offline mode. Do not close the app or disconnect from the internet.\n',
      name: 'articlesScreenRegisterReviewsFinish',
      desc: '',
      args: [],
    );
  }

  /// `Return to the app`
  String get articlesScreenRegisterReviewsFinishGoBack {
    return Intl.message(
      'Return to the app',
      name: 'articlesScreenRegisterReviewsFinishGoBack',
      desc: '',
      args: [],
    );
  }

  /// `An error occurred during review registration. Please try again later.\n`
  String get articlesScreenRegisterReviewsUnxpectedException {
    return Intl.message(
      'An error occurred during review registration. Please try again later.\n',
      name: 'articlesScreenRegisterReviewsUnxpectedException',
      desc: '',
      args: [],
    );
  }

  /// `Return to the app`
  String get articlesScreenRegisterReviewsUnxpectedExceptionGoBack {
    return Intl.message(
      'Return to the app',
      name: 'articlesScreenRegisterReviewsUnxpectedExceptionGoBack',
      desc: '',
      args: [],
    );
  }

  /// `No Internet connection.\nTasks are unavailable.`
  String get articlesScreenNetworkException {
    return Intl.message(
      'No Internet connection.\nTasks are unavailable.',
      name: 'articlesScreenNetworkException',
      desc: '',
      args: [],
    );
  }

  /// `Uploads`
  String get articlesScreenUploadsButtonTitle {
    return Intl.message(
      'Uploads',
      name: 'articlesScreenUploadsButtonTitle',
      desc: '',
      args: [],
    );
  }

  /// `There are requested reviews`
  String get articlesScreenHasRequestedReviews {
    return Intl.message(
      'There are requested reviews',
      name: 'articlesScreenHasRequestedReviews',
      desc: '',
      args: [],
    );
  }

  /// `There are unfinished reviews`
  String get articlesScreenHasNotFinishedReviews {
    return Intl.message(
      'There are unfinished reviews',
      name: 'articlesScreenHasNotFinishedReviews',
      desc: '',
      args: [],
    );
  }

  /// `Create Review`
  String get articlesScreenCreateReviewButtonTitle {
    return Intl.message(
      'Create Review',
      name: 'articlesScreenCreateReviewButtonTitle',
      desc: '',
      args: [],
    );
  }

  /// `Search`
  String get articlesScreenSearchFieldLabel {
    return Intl.message(
      'Search',
      name: 'articlesScreenSearchFieldLabel',
      desc: '',
      args: [],
    );
  }

  /// `Nothing found`
  String get articlesScreenSearchEmpty {
    return Intl.message(
      'Nothing found',
      name: 'articlesScreenSearchEmpty',
      desc: '',
      args: [],
    );
  }

  /// `Events`
  String get notificationsScreenTitle {
    return Intl.message(
      'Events',
      name: 'notificationsScreenTitle',
      desc: '',
      args: [],
    );
  }

  /// `You have no notifications yet`
  String get notificationsScreenYetHaveNotNotifications {
    return Intl.message(
      'You have no notifications yet',
      name: 'notificationsScreenYetHaveNotNotifications',
      desc: '',
      args: [],
    );
  }

  /// `Help`
  String get helpScreenTitle {
    return Intl.message(
      'Help',
      name: 'helpScreenTitle',
      desc: '',
      args: [],
    );
  }

  /// `Questions and Answers`
  String get helpScreenQuestionsAndAnswers {
    return Intl.message(
      'Questions and Answers',
      name: 'helpScreenQuestionsAndAnswers',
      desc: '',
      args: [],
    );
  }

  /// `Write us an email`
  String get helpScreenWriteEmail {
    return Intl.message(
      'Write us an email',
      name: 'helpScreenWriteEmail',
      desc: '',
      args: [],
    );
  }

  /// `Call us`
  String get helpScreenCallUs {
    return Intl.message(
      'Call us',
      name: 'helpScreenCallUs',
      desc: '',
      args: [],
    );
  }

  /// `Export Files`
  String get helpScreenExportFilesButtonTitle {
    return Intl.message(
      'Export Files',
      name: 'helpScreenExportFilesButtonTitle',
      desc: '',
      args: [],
    );
  }

  /// `An unexpected error occurred`
  String get unexpectedException {
    return Intl.message(
      'An unexpected error occurred',
      name: 'unexpectedException',
      desc: '',
      args: [],
    );
  }

  /// `{megabytes} MB cleared.`
  String helpScreenClearedMemoryToast(int megabytes) {
    return Intl.message(
      '$megabytes MB cleared.',
      name: 'helpScreenClearedMemoryToast',
      desc: '',
      args: [megabytes],
    );
  }

  /// `Choose the article type`
  String get chooseCreatingArticleType {
    return Intl.message(
      'Choose the article type',
      name: 'chooseCreatingArticleType',
      desc: '',
      args: [],
    );
  }

  /// `No available inspection article types for creation.\nContact technical support on the 'Help' page`
  String get noAvailableArticleTypes {
    return Intl.message(
      'No available inspection article types for creation.\nContact technical support on the \'Help\' page',
      name: 'noAvailableArticleTypes',
      desc: '',
      args: [],
    );
  }

  /// `No Internet connection.\nInspection article types are unavailable.`
  String get choosingCreatingArticleTypeInternetException {
    return Intl.message(
      'No Internet connection.\nInspection article types are unavailable.',
      name: 'choosingCreatingArticleTypeInternetException',
      desc: '',
      args: [],
    );
  }

  /// `Internet connection error`
  String get chooseReviwTemplateInternetException {
    return Intl.message(
      'Internet connection error',
      name: 'chooseReviwTemplateInternetException',
      desc: '',
      args: [],
    );
  }

  /// `Choose a template`
  String get chooseReviwTemplate {
    return Intl.message(
      'Choose a template',
      name: 'chooseReviwTemplate',
      desc: '',
      args: [],
    );
  }

  /// `There are no available inspection templates for this object`
  String get noAvailableReviwTemplatesForThisArticle {
    return Intl.message(
      'There are no available inspection templates for this object',
      name: 'noAvailableReviwTemplatesForThisArticle',
      desc: '',
      args: [],
    );
  }

  /// `No Internet connection.\nSelection of inspection templates is unavailable.`
  String get chooseReviewTemplateNoInternet {
    return Intl.message(
      'No Internet connection.\nSelection of inspection templates is unavailable.',
      name: 'chooseReviewTemplateNoInternet',
      desc: '',
      args: [],
    );
  }

  /// `Click to continue building the review`
  String get chooseReviwTemplateScreenContinueReview {
    return Intl.message(
      'Click to continue building the review',
      name: 'chooseReviwTemplateScreenContinueReview',
      desc: '',
      args: [],
    );
  }

  /// `Awaiting execution`
  String get chooseReviewTemplateScreenAwaitForContinue {
    return Intl.message(
      'Awaiting execution',
      name: 'chooseReviewTemplateScreenAwaitForContinue',
      desc: '',
      args: [],
    );
  }

  /// `Available for independent review`
  String get chooseReviewTemplateScreenAvailable {
    return Intl.message(
      'Available for independent review',
      name: 'chooseReviewTemplateScreenAvailable',
      desc: '',
      args: [],
    );
  }

  /// `Your message has been sent!`
  String get helpCreateMessageScreenYourMessageSended {
    return Intl.message(
      'Your message has been sent!',
      name: 'helpCreateMessageScreenYourMessageSended',
      desc: '',
      args: [],
    );
  }

  /// `Internet connection error`
  String get helpCreateMessageScreenInternetException {
    return Intl.message(
      'Internet connection error',
      name: 'helpCreateMessageScreenInternetException',
      desc: '',
      args: [],
    );
  }

  /// `Send Message`
  String get helpCreateMessageScreenSendMessage {
    return Intl.message(
      'Send Message',
      name: 'helpCreateMessageScreenSendMessage',
      desc: '',
      args: [],
    );
  }

  /// `Phone Number`
  String get helpCreateMessageScreenPhoneNumber {
    return Intl.message(
      'Phone Number',
      name: 'helpCreateMessageScreenPhoneNumber',
      desc: '',
      args: [],
    );
  }

  /// `Please provide a phone number for feedback.`
  String get helpCreateMessageScreenPhoneNumberDescription {
    return Intl.message(
      'Please provide a phone number for feedback.',
      name: 'helpCreateMessageScreenPhoneNumberDescription',
      desc: '',
      args: [],
    );
  }

  /// `Message Text`
  String get helpCreateMessageScreenMessage {
    return Intl.message(
      'Message Text',
      name: 'helpCreateMessageScreenMessage',
      desc: '',
      args: [],
    );
  }

  /// `Please state the essence of the request in 2-3 sentences.`
  String get helpCreateMessageScreenMessageDescription {
    return Intl.message(
      'Please state the essence of the request in 2-3 sentences.',
      name: 'helpCreateMessageScreenMessageDescription',
      desc: '',
      args: [],
    );
  }

  /// `Send`
  String get helpCreateMessageScreenSend {
    return Intl.message(
      'Send',
      name: 'helpCreateMessageScreenSend',
      desc: '',
      args: [],
    );
  }

  /// `Send Message`
  String get helpScreenSendMessage {
    return Intl.message(
      'Send Message',
      name: 'helpScreenSendMessage',
      desc: '',
      args: [],
    );
  }

  /// `Clear Memory`
  String get helpScreenCleanMemory {
    return Intl.message(
      'Clear Memory',
      name: 'helpScreenCleanMemory',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to delete all files?`
  String get helpScreenCleanMemoryAreYouSure {
    return Intl.message(
      'Are you sure you want to delete all files?',
      name: 'helpScreenCleanMemoryAreYouSure',
      desc: '',
      args: [],
    );
  }

  /// `Cached and unsent files will be lost, this process is irreversible.`
  String get helpScreenCleanMemoryProccessIsIrrevirsable {
    return Intl.message(
      'Cached and unsent files will be lost, this process is irreversible.',
      name: 'helpScreenCleanMemoryProccessIsIrrevirsable',
      desc: '',
      args: [],
    );
  }

  /// `No`
  String get helpScreenCleanMemoryNo {
    return Intl.message(
      'No',
      name: 'helpScreenCleanMemoryNo',
      desc: '',
      args: [],
    );
  }

  /// `Yes`
  String get helpScreenCleanMemoryYes {
    return Intl.message(
      'Yes',
      name: 'helpScreenCleanMemoryYes',
      desc: '',
      args: [],
    );
  }

  /// `Insurance Case`
  String get helpInsuranceCase {
    return Intl.message(
      'Insurance Case',
      name: 'helpInsuranceCase',
      desc: '',
      args: [],
    );
  }

  /// `Create a New Step`
  String get reviewStepsCreateScreenNewStep {
    return Intl.message(
      'Create a New Step',
      name: 'reviewStepsCreateScreenNewStep',
      desc: '',
      args: [],
    );
  }

  /// `Name`
  String get reviewStepsCreateScreenName {
    return Intl.message(
      'Name',
      name: 'reviewStepsCreateScreenName',
      desc: '',
      args: [],
    );
  }

  /// `Brief Description`
  String get reviewStepsCreateScreenDescription {
    return Intl.message(
      'Brief Description',
      name: 'reviewStepsCreateScreenDescription',
      desc: '',
      args: [],
    );
  }

  /// `Photo`
  String get reviewStepsCreateScreenPhoto {
    return Intl.message(
      'Photo',
      name: 'reviewStepsCreateScreenPhoto',
      desc: '',
      args: [],
    );
  }

  /// `Video`
  String get reviewStepsCreateScreenVideo {
    return Intl.message(
      'Video',
      name: 'reviewStepsCreateScreenVideo',
      desc: '',
      args: [],
    );
  }

  /// `Scan Document`
  String get reviewStepsCreateScreenDocumentScan {
    return Intl.message(
      'Scan Document',
      name: 'reviewStepsCreateScreenDocumentScan',
      desc: '',
      args: [],
    );
  }

  /// `File`
  String get reviewStepsCreateScreenFile {
    return Intl.message(
      'File',
      name: 'reviewStepsCreateScreenFile',
      desc: '',
      args: [],
    );
  }

  /// `Create`
  String get reviewStepsCreateScreenCreate {
    return Intl.message(
      'Create',
      name: 'reviewStepsCreateScreenCreate',
      desc: '',
      args: [],
    );
  }

  /// `The upload list is empty`
  String get uploadsScreenUploadsScreenIsEmpty {
    return Intl.message(
      'The upload list is empty',
      name: 'uploadsScreenUploadsScreenIsEmpty',
      desc: '',
      args: [],
    );
  }

  /// `Send saved reviews`
  String get articlesScreenSendSavedArticles {
    return Intl.message(
      'Send saved reviews',
      name: 'articlesScreenSendSavedArticles',
      desc: '',
      args: [],
    );
  }

  /// `{howMany,plural, =1{{howMany} review}=2{{howMany} reviews}other{{howMany} reviews}}`
  String articlesScreenArticlesCount(int howMany) {
    return Intl.plural(
      howMany,
      one: '$howMany review',
      two: '$howMany reviews',
      other: '$howMany reviews',
      name: 'articlesScreenArticlesCount',
      desc: '',
      args: [howMany],
    );
  }

  /// `awaiting sending`
  String get articlesScreenAwaitOfSending {
    return Intl.message(
      'awaiting sending',
      name: 'articlesScreenAwaitOfSending',
      desc: '',
      args: [],
    );
  }

  /// `Search`
  String get articlesScreenSearch {
    return Intl.message(
      'Search',
      name: 'articlesScreenSearch',
      desc: '',
      args: [],
    );
  }

  /// `Unfortunately, nothing was found.`
  String get articlesScreenNothingFound {
    return Intl.message(
      'Unfortunately, nothing was found.',
      name: 'articlesScreenNothingFound',
      desc: '',
      args: [],
    );
  }

  /// `undefined`
  String get onCenterWidgetUndefined {
    return Intl.message(
      'undefined',
      name: 'onCenterWidgetUndefined',
      desc: '',
      args: [],
    );
  }

  /// `Last Name`
  String get profileScreenSurname {
    return Intl.message(
      'Last Name',
      name: 'profileScreenSurname',
      desc: '',
      args: [],
    );
  }

  /// `First Name`
  String get profileScreenName {
    return Intl.message(
      'First Name',
      name: 'profileScreenName',
      desc: '',
      args: [],
    );
  }

  /// `Patronymic`
  String get profileScreenPatronymic {
    return Intl.message(
      'Patronymic',
      name: 'profileScreenPatronymic',
      desc: '',
      args: [],
    );
  }

  /// `Company's TIN`
  String get profileScreenCompanyInn {
    return Intl.message(
      'Company\'s TIN',
      name: 'profileScreenCompanyInn',
      desc: '',
      args: [],
    );
  }

  /// `Position`
  String get profileScreenJobTitle {
    return Intl.message(
      'Position',
      name: 'profileScreenJobTitle',
      desc: '',
      args: [],
    );
  }

  /// `Mobile Phone`
  String get profileScreenPhoneNumber {
    return Intl.message(
      'Mobile Phone',
      name: 'profileScreenPhoneNumber',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get profileScreenEmail {
    return Intl.message(
      'Email',
      name: 'profileScreenEmail',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get profileScreenPassword {
    return Intl.message(
      'Password',
      name: 'profileScreenPassword',
      desc: '',
      args: [],
    );
  }

  /// `Repeat Password`
  String get profileScreenRepeatPassword {
    return Intl.message(
      'Repeat Password',
      name: 'profileScreenRepeatPassword',
      desc: '',
      args: [],
    );
  }

  /// `Save`
  String get profileScreenSave {
    return Intl.message(
      'Save',
      name: 'profileScreenSave',
      desc: '',
      args: [],
    );
  }

  /// `Scan`
  String get makeDocumentPageAndroidScan {
    return Intl.message(
      'Scan',
      name: 'makeDocumentPageAndroidScan',
      desc: '',
      args: [],
    );
  }

  /// `Edit`
  String get makeDocumentPageAndroidCropTitle {
    return Intl.message(
      'Edit',
      name: 'makeDocumentPageAndroidCropTitle',
      desc: '',
      args: [],
    );
  }

  /// `B/W`
  String get makeDocumentPageAndroidBWTitle {
    return Intl.message(
      'B/W',
      name: 'makeDocumentPageAndroidBWTitle',
      desc: '',
      args: [],
    );
  }

  /// `Reset`
  String get makeDocumentPageAndroidCropReset {
    return Intl.message(
      'Reset',
      name: 'makeDocumentPageAndroidCropReset',
      desc: '',
      args: [],
    );
  }

  /// `Create a Document Copy`
  String get makeDocumentPageTitle {
    return Intl.message(
      'Create a Document Copy',
      name: 'makeDocumentPageTitle',
      desc: '',
      args: [],
    );
  }

  /// `Camera Error`
  String get makeMediaPageCameraException {
    return Intl.message(
      'Camera Error',
      name: 'makeMediaPageCameraException',
      desc: '',
      args: [],
    );
  }

  /// `Processing and saving is in progress. Do not close the app, wait for completion.`
  String get makeMediaPageStandBy {
    return Intl.message(
      'Processing and saving is in progress. Do not close the app, wait for completion.',
      name: 'makeMediaPageStandBy',
      desc: '',
      args: [],
    );
  }

  /// `No Camera Access`
  String get makeMediaPageCameraAccesException {
    return Intl.message(
      'No Camera Access',
      name: 'makeMediaPageCameraAccesException',
      desc: '',
      args: [],
    );
  }

  /// `Open App Settings`
  String get makeMediaPageOpenAppSettings {
    return Intl.message(
      'Open App Settings',
      name: 'makeMediaPageOpenAppSettings',
      desc: '',
      args: [],
    );
  }

  /// `No Microphone Access`
  String get makeMediaPageMicAccesException {
    return Intl.message(
      'No Microphone Access',
      name: 'makeMediaPageMicAccesException',
      desc: '',
      args: [],
    );
  }

  /// `Video`
  String get makeMediaPageVideo {
    return Intl.message(
      'Video',
      name: 'makeMediaPageVideo',
      desc: '',
      args: [],
    );
  }

  /// `Photo`
  String get makeMediaPagePhoto {
    return Intl.message(
      'Photo',
      name: 'makeMediaPagePhoto',
      desc: '',
      args: [],
    );
  }

  /// `An unexpected error occurred`
  String get makeMediaPageSomethingWentWrong {
    return Intl.message(
      'An unexpected error occurred',
      name: 'makeMediaPageSomethingWentWrong',
      desc: '',
      args: [],
    );
  }

  /// `undefined`
  String get makeMediaPageUndefined {
    return Intl.message(
      'undefined',
      name: 'makeMediaPageUndefined',
      desc: '',
      args: [],
    );
  }

  /// `Low on space: {freeDiskSpace} MB remaining.`
  String makeReportPageLowSpace(String freeDiskSpace) {
    return Intl.message(
      'Low on space: $freeDiskSpace MB remaining.',
      name: 'makeReportPageLowSpace',
      desc: '',
      args: [freeDiskSpace],
    );
  }

  /// `The file {path} exceeds {mbLimit} MB. Sending is not possible.`
  String makeReportPageHugeFile(String path, String mbLimit) {
    return Intl.message(
      'The file $path exceeds $mbLimit MB. Sending is not possible.',
      name: 'makeReportPageHugeFile',
      desc: '',
      args: [path, mbLimit],
    );
  }

  /// `Take a Photo`
  String get makeReportPageMakePhoto {
    return Intl.message(
      'Take a Photo',
      name: 'makeReportPageMakePhoto',
      desc: '',
      args: [],
    );
  }

  /// `Take Additional Photo`
  String get makeReportPageMakeAdditionalPhoto {
    return Intl.message(
      'Take Additional Photo',
      name: 'makeReportPageMakeAdditionalPhoto',
      desc: '',
      args: [],
    );
  }

  /// `Retake Photo`
  String get makeReportPageRemakePhoto {
    return Intl.message(
      'Retake Photo',
      name: 'makeReportPageRemakePhoto',
      desc: '',
      args: [],
    );
  }

  /// `Missed with comments: \r\n{comments}`
  String makeReportPageMissedWithComments(String comments) {
    return Intl.message(
      'Missed with comments: \r\n$comments',
      name: 'makeReportPageMissedWithComments',
      desc: '',
      args: [comments],
    );
  }

  /// `Record Video`
  String get makeReportPageRemakeVideo {
    return Intl.message(
      'Record Video',
      name: 'makeReportPageRemakeVideo',
      desc: '',
      args: [],
    );
  }

  /// `Record Additional Video`
  String get makeReportPageMakeAdditionalVideo {
    return Intl.message(
      'Record Additional Video',
      name: 'makeReportPageMakeAdditionalVideo',
      desc: '',
      args: [],
    );
  }

  /// `Tap to Watch`
  String get makeReportPageTapToWatch {
    return Intl.message(
      'Tap to Watch',
      name: 'makeReportPageTapToWatch',
      desc: '',
      args: [],
    );
  }

  /// `Make Scan`
  String get makeReportPageMakeScan {
    return Intl.message(
      'Make Scan',
      name: 'makeReportPageMakeScan',
      desc: '',
      args: [],
    );
  }

  /// `Make Additional Scan`
  String get makeReportPageMakeAdditionalScan {
    return Intl.message(
      'Make Additional Scan',
      name: 'makeReportPageMakeAdditionalScan',
      desc: '',
      args: [],
    );
  }

  /// `Retake Scan`
  String get makeReportPageRemakeScan {
    return Intl.message(
      'Retake Scan',
      name: 'makeReportPageRemakeScan',
      desc: '',
      args: [],
    );
  }

  /// `Scan`
  String get makeReportPageScan {
    return Intl.message(
      'Scan',
      name: 'makeReportPageScan',
      desc: '',
      args: [],
    );
  }

  /// `Add File`
  String get makeReportPageAddFile {
    return Intl.message(
      'Add File',
      name: 'makeReportPageAddFile',
      desc: '',
      args: [],
    );
  }

  /// `Add Another File`
  String get makeReportPageAddAnotherFile {
    return Intl.message(
      'Add Another File',
      name: 'makeReportPageAddAnotherFile',
      desc: '',
      args: [],
    );
  }

  /// `Choose Another File`
  String get makeReportPageChooseAnotherFile {
    return Intl.message(
      'Choose Another File',
      name: 'makeReportPageChooseAnotherFile',
      desc: '',
      args: [],
    );
  }

  /// `File`
  String get makeReportPageFile {
    return Intl.message(
      'File',
      name: 'makeReportPageFile',
      desc: '',
      args: [],
    );
  }

  /// `Fill Out the Form`
  String get makeReportPageFillTheForm {
    return Intl.message(
      'Fill Out the Form',
      name: 'makeReportPageFillTheForm',
      desc: '',
      args: [],
    );
  }

  /// `Fill Out Another Form`
  String get makeReportPageFillTheAnotherForm {
    return Intl.message(
      'Fill Out Another Form',
      name: 'makeReportPageFillTheAnotherForm',
      desc: '',
      args: [],
    );
  }

  /// `Tap to Change`
  String get makeReportPageTapToChange {
    return Intl.message(
      'Tap to Change',
      name: 'makeReportPageTapToChange',
      desc: '',
      args: [],
    );
  }

  /// `Administrator's Comment: '{comment}'`
  String makeReportPageAdminComment(String comment) {
    return Intl.message(
      'Administrator\'s Comment: \'$comment\'',
      name: 'makeReportPageAdminComment',
      desc: '',
      args: [comment],
    );
  }

  /// `Are you sure you want to exit?`
  String get makeReportPageAreYouSureForExit {
    return Intl.message(
      'Are you sure you want to exit?',
      name: 'makeReportPageAreYouSureForExit',
      desc: '',
      args: [],
    );
  }

  /// `No`
  String get makeReportPageNo {
    return Intl.message(
      'No',
      name: 'makeReportPageNo',
      desc: '',
      args: [],
    );
  }

  /// `Yes`
  String get makeReportPageYes {
    return Intl.message(
      'Yes',
      name: 'makeReportPageYes',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to delete this report?`
  String get makeReportPageAreYouSureForDelete {
    return Intl.message(
      'Are you sure you want to delete this report?',
      name: 'makeReportPageAreYouSureForDelete',
      desc: '',
      args: [],
    );
  }

  /// `Locating...`
  String get makeReportPageLocating {
    return Intl.message(
      'Locating...',
      name: 'makeReportPageLocating',
      desc: '',
      args: [],
    );
  }

  /// `Sending data to the server...\nPlease wait.`
  String get makeReportPageSendingData {
    return Intl.message(
      'Sending data to the server...\nPlease wait.',
      name: 'makeReportPageSendingData',
      desc: '',
      args: [],
    );
  }

  /// `Add Step`
  String get makeReportPageAddStep {
    return Intl.message(
      'Add Step',
      name: 'makeReportPageAddStep',
      desc: '',
      args: [],
    );
  }

  /// `Issue Detected`
  String get makeReportPageIssueOccured {
    return Intl.message(
      'Issue Detected',
      name: 'makeReportPageIssueOccured',
      desc: '',
      args: [],
    );
  }

  /// `Skip and Finish`
  String get makeReportPageSkipAndFinish {
    return Intl.message(
      'Skip and Finish',
      name: 'makeReportPageSkipAndFinish',
      desc: '',
      args: [],
    );
  }

  /// `Finish`
  String get makeReportPageFinish {
    return Intl.message(
      'Finish',
      name: 'makeReportPageFinish',
      desc: '',
      args: [],
    );
  }

  /// `Continue`
  String get makeReportPageContinue {
    return Intl.message(
      'Continue',
      name: 'makeReportPageContinue',
      desc: '',
      args: [],
    );
  }

  /// `Skip`
  String get makeReportPageSkip {
    return Intl.message(
      'Skip',
      name: 'makeReportPageSkip',
      desc: '',
      args: [],
    );
  }

  /// `Specify the reason for skipping`
  String get makeReportPageReasonForSkip {
    return Intl.message(
      'Specify the reason for skipping',
      name: 'makeReportPageReasonForSkip',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get makeReportPageCancel {
    return Intl.message(
      'Cancel',
      name: 'makeReportPageCancel',
      desc: '',
      args: [],
    );
  }

  /// `Send`
  String get makeReportPageSend {
    return Intl.message(
      'Send',
      name: 'makeReportPageSend',
      desc: '',
      args: [],
    );
  }

  /// `Thank you! The report is created!`
  String get makeReportPageReportIsCreated {
    return Intl.message(
      'Thank you! The report is created!',
      name: 'makeReportPageReportIsCreated',
      desc: '',
      args: [],
    );
  }

  /// `Repeatable Inspection`
  String get makeReportPageRepeatableReport {
    return Intl.message(
      'Repeatable Inspection',
      name: 'makeReportPageRepeatableReport',
      desc: '',
      args: [],
    );
  }

  /// `Would you like to conduct another inspection with this template?`
  String get makeReportPageAnotherReportWithThisTemplate {
    return Intl.message(
      'Would you like to conduct another inspection with this template?',
      name: 'makeReportPageAnotherReportWithThisTemplate',
      desc: '',
      args: [],
    );
  }

  /// `To complete the report, you need to go through the mandatory steps`
  String get makeReportPagePopupMessage {
    return Intl.message(
      'To complete the report, you need to go through the mandatory steps',
      name: 'makeReportPagePopupMessage',
      desc: '',
      args: [],
    );
  }

  /// `View Downloads`
  String get articlesScreenSawDownloads {
    return Intl.message(
      'View Downloads',
      name: 'articlesScreenSawDownloads',
      desc: '',
      args: [],
    );
  }

  /// `You need to choose a company first`
  String get articlesScreenNeedToChooseCompany {
    return Intl.message(
      'You need to choose a company first',
      name: 'articlesScreenNeedToChooseCompany',
      desc: '',
      args: [],
    );
  }

  /// `You need to choose a company on the 'Objects' screen first`
  String get helpScreenNeedToChooseCompany {
    return Intl.message(
      'You need to choose a company on the \'Objects\' screen first',
      name: 'helpScreenNeedToChooseCompany',
      desc: '',
      args: [],
    );
  }

  /// `Choose a Company`
  String get articleAccountSwitcherChooseCompany {
    return Intl.message(
      'Choose a Company',
      name: 'articleAccountSwitcherChooseCompany',
      desc: '',
      args: [],
    );
  }

  /// `Enter text`
  String get myTextFieldDefaultTextHint {
    return Intl.message(
      'Enter text',
      name: 'myTextFieldDefaultTextHint',
      desc: '',
      args: [],
    );
  }

  /// `Enter a number`
  String get myTextFieldDefaultNumberHint {
    return Intl.message(
      'Enter a number',
      name: 'myTextFieldDefaultNumberHint',
      desc: '',
      args: [],
    );
  }

  /// `Enter a date`
  String get myTextFieldDefaultDateHint {
    return Intl.message(
      'Enter a date',
      name: 'myTextFieldDefaultDateHint',
      desc: '',
      args: [],
    );
  }

  /// `Not Enough Disk Space`
  String get makeReportPageNotEnoughDishSpace {
    return Intl.message(
      'Not Enough Disk Space',
      name: 'makeReportPageNotEnoughDishSpace',
      desc: '',
      args: [],
    );
  }

  /// `Insufficient permissions to determine location`
  String get makeReportPageHaveNotLocationPermission {
    return Intl.message(
      'Insufficient permissions to determine location',
      name: 'makeReportPageHaveNotLocationPermission',
      desc: '',
      args: [],
    );
  }

  /// `Undefined State`
  String get makeReportPageUndefinedState {
    return Intl.message(
      'Undefined State',
      name: 'makeReportPageUndefinedState',
      desc: '',
      args: [],
    );
  }

  /// `Open App Settings`
  String get makeReportPageOpenAppSettings {
    return Intl.message(
      'Open App Settings',
      name: 'makeReportPageOpenAppSettings',
      desc: '',
      args: [],
    );
  }

  /// `Video Processing`
  String get videoProcessing {
    return Intl.message(
      'Video Processing',
      name: 'videoProcessing',
      desc: '',
      args: [],
    );
  }

  /// `OK`
  String get ok {
    return Intl.message(
      'OK',
      name: 'ok',
      desc: '',
      args: [],
    );
  }

  /// `Media files are not saved. Save them?`
  String get mediaFilesDoNotSaved {
    return Intl.message(
      'Media files are not saved. Save them?',
      name: 'mediaFilesDoNotSaved',
      desc: '',
      args: [],
    );
  }

  /// `Tasks`
  String get tasksScreenAppBarTitle {
    return Intl.message(
      'Tasks',
      name: 'tasksScreenAppBarTitle',
      desc: '',
      args: [],
    );
  }

  /// `My Tasks`
  String get tasksScreenTabMyTasksTitle {
    return Intl.message(
      'My Tasks',
      name: 'tasksScreenTabMyTasksTitle',
      desc: '',
      args: [],
    );
  }

  /// `Available`
  String get tasksScreenTabAvailableTitle {
    return Intl.message(
      'Available',
      name: 'tasksScreenTabAvailableTitle',
      desc: '',
      args: [],
    );
  }

  /// `Assigned`
  String get tasksScreenFastFilterAssignedStatusTitle {
    return Intl.message(
      'Assigned',
      name: 'tasksScreenFastFilterAssignedStatusTitle',
      desc: '',
      args: [],
    );
  }

  /// `In Progress`
  String get tasksScreenFastFilterAtWorkStatusTitle {
    return Intl.message(
      'In Progress',
      name: 'tasksScreenFastFilterAtWorkStatusTitle',
      desc: '',
      args: [],
    );
  }

  /// `Rejected`
  String get tasksScreenFastFilterRejectedStatusTitle {
    return Intl.message(
      'Rejected',
      name: 'tasksScreenFastFilterRejectedStatusTitle',
      desc: '',
      args: [],
    );
  }

  /// `On Confirmation`
  String get tasksScreenFastFilterOnInspectionStatusTitle {
    return Intl.message(
      'On Confirmation',
      name: 'tasksScreenFastFilterOnInspectionStatusTitle',
      desc: '',
      args: [],
    );
  }

  /// `Completed`
  String get tasksScreenFastFilterCompletedStatusTitle {
    return Intl.message(
      'Completed',
      name: 'tasksScreenFastFilterCompletedStatusTitle',
      desc: '',
      args: [],
    );
  }

  /// `Description`
  String get taskInfoScreenDescriptionTitle {
    return Intl.message(
      'Description',
      name: 'taskInfoScreenDescriptionTitle',
      desc: '',
      args: [],
    );
  }

  /// `Object`
  String get taskInfoScreenArticleTitle {
    return Intl.message(
      'Object',
      name: 'taskInfoScreenArticleTitle',
      desc: '',
      args: [],
    );
  }

  /// `Task Address`
  String get taskInfoScreenAddressTitle {
    return Intl.message(
      'Task Address',
      name: 'taskInfoScreenAddressTitle',
      desc: '',
      args: [],
    );
  }

  /// `Due Date`
  String get taskInfoScreenFinishDateLimitTitle {
    return Intl.message(
      'Due Date',
      name: 'taskInfoScreenFinishDateLimitTitle',
      desc: '',
      args: [],
    );
  }

  /// `Take to Work`
  String get taskInfoScreenTakeToWorkButtonTitle {
    return Intl.message(
      'Take to Work',
      name: 'taskInfoScreenTakeToWorkButtonTitle',
      desc: '',
      args: [],
    );
  }

  /// `Refuse`
  String get taskInfoRefuseButtonTitle {
    return Intl.message(
      'Refuse',
      name: 'taskInfoRefuseButtonTitle',
      desc: '',
      args: [],
    );
  }

  /// `Start Execution {date}`
  String tasksRowStartExecutionAt(DateTime date) {
    final DateFormat dateDateFormat =
        DateFormat('dd.MM.yy', Intl.getCurrentLocale());
    final String dateString = dateDateFormat.format(date);

    return Intl.message(
      'Start Execution $dateString',
      name: 'tasksRowStartExecutionAt',
      desc: '',
      args: [dateString],
    );
  }

  /// `Finish by {date}`
  String tasksRowFinishExecutionAt(DateTime date) {
    final DateFormat dateDateFormat =
        DateFormat('dd.MM.yy', Intl.getCurrentLocale());
    final String dateString = dateDateFormat.format(date);

    return Intl.message(
      'Finish by $dateString',
      name: 'tasksRowFinishExecutionAt',
      desc: '',
      args: [dateString],
    );
  }

  /// `Execute`
  String get taskInfoScreenExecuteButtonTitle {
    return Intl.message(
      'Execute',
      name: 'taskInfoScreenExecuteButtonTitle',
      desc: '',
      args: [],
    );
  }

  /// `Edit`
  String get taskInfoScreenChangeButtonTitle {
    return Intl.message(
      'Edit',
      name: 'taskInfoScreenChangeButtonTitle',
      desc: '',
      args: [],
    );
  }

  /// `Take Photo`
  String get taskExecutionScreenTakePhotoButtonTitle {
    return Intl.message(
      'Take Photo',
      name: 'taskExecutionScreenTakePhotoButtonTitle',
      desc: '',
      args: [],
    );
  }

  /// `Record Video`
  String get taskExecutionScreenTakeVideoButtonTitle {
    return Intl.message(
      'Record Video',
      name: 'taskExecutionScreenTakeVideoButtonTitle',
      desc: '',
      args: [],
    );
  }

  /// `Scan Document`
  String get taskExecutionScreenTakeDocumentButtonTitle {
    return Intl.message(
      'Scan Document',
      name: 'taskExecutionScreenTakeDocumentButtonTitle',
      desc: '',
      args: [],
    );
  }

  /// `Description:`
  String get taskExecutionDescriptionTitle {
    return Intl.message(
      'Description:',
      name: 'taskExecutionDescriptionTitle',
      desc: '',
      args: [],
    );
  }

  /// `Select File`
  String get taskExecutionScreenTakeFileButtonTitle {
    return Intl.message(
      'Select File',
      name: 'taskExecutionScreenTakeFileButtonTitle',
      desc: '',
      args: [],
    );
  }

  /// `Finish`
  String get taskExecutionFinishButtonTitle {
    return Intl.message(
      'Finish',
      name: 'taskExecutionFinishButtonTitle',
      desc: '',
      args: [],
    );
  }

  /// `Photo Example`
  String get taskExecutionStepDetailPhotoExampleTitle {
    return Intl.message(
      'Photo Example',
      name: 'taskExecutionStepDetailPhotoExampleTitle',
      desc: '',
      args: [],
    );
  }

  /// `Description`
  String get taskExecutionStepDetailDescriptionTitle {
    return Intl.message(
      'Description',
      name: 'taskExecutionStepDetailDescriptionTitle',
      desc: '',
      args: [],
    );
  }

  /// `Yes`
  String get boolDialogDefaultApproveTitle {
    return Intl.message(
      'Yes',
      name: 'boolDialogDefaultApproveTitle',
      desc: '',
      args: [],
    );
  }

  /// `No`
  String get boolDialogDefaultDenyTitle {
    return Intl.message(
      'No',
      name: 'boolDialogDefaultDenyTitle',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to delete the file?\n\nThis action is irreversible.`
  String get taskExecutionDeleteFileDialogContent {
    return Intl.message(
      'Are you sure you want to delete the file?\n\nThis action is irreversible.',
      name: 'taskExecutionDeleteFileDialogContent',
      desc: '',
      args: [],
    );
  }

  /// `Loading Error, please try again later`
  String get taskDetailErrorFailedTitle {
    return Intl.message(
      'Loading Error, please try again later',
      name: 'taskDetailErrorFailedTitle',
      desc: '',
      args: [],
    );
  }

  /// `OK`
  String get alertDialogDefaultOkTitle {
    return Intl.message(
      'OK',
      name: 'alertDialogDefaultOkTitle',
      desc: '',
      args: [],
    );
  }

  /// `To complete the task, you need to go through the mandatory steps`
  String get taskExecutionNotAllConditionsCompleted {
    return Intl.message(
      'To complete the task, you need to go through the mandatory steps',
      name: 'taskExecutionNotAllConditionsCompleted',
      desc: '',
      args: [],
    );
  }

  /// `Loading Error, please try again later`
  String get tasksScreenErrorTitle {
    return Intl.message(
      'Loading Error, please try again later',
      name: 'tasksScreenErrorTitle',
      desc: '',
      args: [],
    );
  }

  /// `Creating Task`
  String get addingTask {
    return Intl.message(
      'Creating Task',
      name: 'addingTask',
      desc: '',
      args: [],
    );
  }

  /// `Editing Task`
  String get editingTask {
    return Intl.message(
      'Editing Task',
      name: 'editingTask',
      desc: '',
      args: [],
    );
  }

  /// `Task Type`
  String get taskType {
    return Intl.message(
      'Task Type',
      name: 'taskType',
      desc: '',
      args: [],
    );
  }

  /// `Object`
  String get object {
    return Intl.message(
      'Object',
      name: 'object',
      desc: '',
      args: [],
    );
  }

  /// `Task Address`
  String get taskAddress {
    return Intl.message(
      'Task Address',
      name: 'taskAddress',
      desc: '',
      args: [],
    );
  }

  /// `Due Date`
  String get deadline {
    return Intl.message(
      'Due Date',
      name: 'deadline',
      desc: '',
      args: [],
    );
  }

  /// `Send for Approval`
  String get sendForApproval {
    return Intl.message(
      'Send for Approval',
      name: 'sendForApproval',
      desc: '',
      args: [],
    );
  }

  /// `Start of Execution`
  String get startOfExecution {
    return Intl.message(
      'Start of Execution',
      name: 'startOfExecution',
      desc: '',
      args: [],
    );
  }

  /// `Priority`
  String get priority {
    return Intl.message(
      'Priority',
      name: 'priority',
      desc: '',
      args: [],
    );
  }

  /// `Create`
  String get create {
    return Intl.message(
      'Create',
      name: 'create',
      desc: '',
      args: [],
    );
  }

  /// `Save`
  String get save {
    return Intl.message(
      'Save',
      name: 'save',
      desc: '',
      args: [],
    );
  }

  /// `Pick a Date`
  String get pickDate {
    return Intl.message(
      'Pick a Date',
      name: 'pickDate',
      desc: '',
      args: [],
    );
  }

  /// `Pick an Object`
  String get pickObject {
    return Intl.message(
      'Pick an Object',
      name: 'pickObject',
      desc: '',
      args: [],
    );
  }

  /// `Pick a Task Type`
  String get pickTaskType {
    return Intl.message(
      'Pick a Task Type',
      name: 'pickTaskType',
      desc: '',
      args: [],
    );
  }

  /// `Pick a Priority`
  String get pickPriority {
    return Intl.message(
      'Pick a Priority',
      name: 'pickPriority',
      desc: '',
      args: [],
    );
  }

  /// `Enter Object Address`
  String get enterObjectAddress {
    return Intl.message(
      'Enter Object Address',
      name: 'enterObjectAddress',
      desc: '',
      args: [],
    );
  }

  /// `Low`
  String get low {
    return Intl.message(
      'Low',
      name: 'low',
      desc: '',
      args: [],
    );
  }

  /// `Medium`
  String get medium {
    return Intl.message(
      'Medium',
      name: 'medium',
      desc: '',
      args: [],
    );
  }

  /// `High`
  String get high {
    return Intl.message(
      'High',
      name: 'high',
      desc: '',
      args: [],
    );
  }

  /// `Task`
  String get task {
    return Intl.message(
      'Task',
      name: 'task',
      desc: '',
      args: [],
    );
  }

  /// `Notifications`
  String get notifications {
    return Intl.message(
      'Notifications',
      name: 'notifications',
      desc: '',
      args: [],
    );
  }

  /// `Objects`
  String get objects {
    return Intl.message(
      'Objects',
      name: 'objects',
      desc: '',
      args: [],
    );
  }

  /// `Tasks`
  String get tasks {
    return Intl.message(
      'Tasks',
      name: 'tasks',
      desc: '',
      args: [],
    );
  }

  /// `Help`
  String get help {
    return Intl.message(
      'Help',
      name: 'help',
      desc: '',
      args: [],
    );
  }

  /// `Internet Connection Error`
  String get internetConnectionError {
    return Intl.message(
      'Internet Connection Error',
      name: 'internetConnectionError',
      desc: '',
      args: [],
    );
  }

  /// `Minimum Video Length Not Reached`
  String get minimumVideoLengthNotReached {
    return Intl.message(
      'Minimum Video Length Not Reached',
      name: 'minimumVideoLengthNotReached',
      desc: '',
      args: [],
    );
  }

  /// `Camera`
  String get camera {
    return Intl.message(
      'Camera',
      name: 'camera',
      desc: '',
      args: [],
    );
  }

  /// `Microphone`
  String get microphone {
    return Intl.message(
      'Microphone',
      name: 'microphone',
      desc: '',
      args: [],
    );
  }

  /// `Location`
  String get location {
    return Intl.message(
      'Location',
      name: 'location',
      desc: '',
      args: [],
    );
  }

  /// `To ensure proper app functionality, please grant access to:`
  String get goToSettingsAndGiveAccessTo {
    return Intl.message(
      'To ensure proper app functionality, please grant access to:',
      name: 'goToSettingsAndGiveAccessTo',
      desc: '',
      args: [],
    );
  }

  /// `Access Granted`
  String get accessGranted {
    return Intl.message(
      'Access Granted',
      name: 'accessGranted',
      desc: '',
      args: [],
    );
  }

  /// `Not all required permissions have been granted`
  String get notAllRequiredPermitsHaveBeenIssued {
    return Intl.message(
      'Not all required permissions have been granted',
      name: 'notAllRequiredPermitsHaveBeenIssued',
      desc: '',
      args: [],
    );
  }

  /// `The maximum number of files of this type has been reached`
  String get maximumNumberFilesReached {
    return Intl.message(
      'The maximum number of files of this type has been reached',
      name: 'maximumNumberFilesReached',
      desc: '',
      args: [],
    );
  }

  /// `Create Task`
  String get createTask {
    return Intl.message(
      'Create Task',
      name: 'createTask',
      desc: '',
      args: [],
    );
  }

  /// `Task Created Successfully`
  String get taskCreatedSuccessfully {
    return Intl.message(
      'Task Created Successfully',
      name: 'taskCreatedSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Main`
  String get main {
    return Intl.message(
      'Main',
      name: 'main',
      desc: '',
      args: [],
    );
  }

  /// `Show All`
  String get showAll {
    return Intl.message(
      'Show All',
      name: 'showAll',
      desc: '',
      args: [],
    );
  }

  /// `Hide`
  String get hide {
    return Intl.message(
      'Hide',
      name: 'hide',
      desc: '',
      args: [],
    );
  }

  /// `Account Selection:`
  String get accountSelection {
    return Intl.message(
      'Account Selection:',
      name: 'accountSelection',
      desc: '',
      args: [],
    );
  }

  /// `Search`
  String get search {
    return Intl.message(
      'Search',
      name: 'search',
      desc: '',
      args: [],
    );
  }

  /// `No objects found with this name`
  String get objectsWithThisNameNotFound {
    return Intl.message(
      'No objects found with this name',
      name: 'objectsWithThisNameNotFound',
      desc: '',
      args: [],
    );
  }

  /// `Object Created`
  String get articleRowStatusCreatedTitle {
    return Intl.message(
      'Object Created',
      name: 'articleRowStatusCreatedTitle',
      desc: '',
      args: [],
    );
  }

  /// `Report Requested`
  String get articleRowStatusNeedReportTitle {
    return Intl.message(
      'Report Requested',
      name: 'articleRowStatusNeedReportTitle',
      desc: '',
      args: [],
    );
  }

  /// `Report Building Started`
  String get articleRowStatusUploadingTitle {
    return Intl.message(
      'Report Building Started',
      name: 'articleRowStatusUploadingTitle',
      desc: '',
      args: [],
    );
  }

  /// `Upload Failed`
  String get articleRowStatusUploadFailedTitle {
    return Intl.message(
      'Upload Failed',
      name: 'articleRowStatusUploadFailedTitle',
      desc: '',
      args: [],
    );
  }

  /// `Waiting for Check`
  String get articleRowStatusWaitCheckingTitle {
    return Intl.message(
      'Waiting for Check',
      name: 'articleRowStatusWaitCheckingTitle',
      desc: '',
      args: [],
    );
  }

  /// `Check Denied`
  String get articleRowStatusReportDeniedTitle {
    return Intl.message(
      'Check Denied',
      name: 'articleRowStatusReportDeniedTitle',
      desc: '',
      args: [],
    );
  }

  /// `Check Confirmed`
  String get articleRowStatusReportConfirmedTitle {
    return Intl.message(
      'Check Confirmed',
      name: 'articleRowStatusReportConfirmedTitle',
      desc: '',
      args: [],
    );
  }

  /// `Undefined Status`
  String get articleRowStatusUndefinedTitle {
    return Intl.message(
      'Undefined Status',
      name: 'articleRowStatusUndefinedTitle',
      desc: '',
      args: [],
    );
  }

  /// `Go to create an additional step?`
  String get goToCreateAnAdditionalStep {
    return Intl.message(
      'Go to create an additional step?',
      name: 'goToCreateAnAdditionalStep',
      desc: '',
      args: [],
    );
  }

  /// `Example`
  String get example {
    return Intl.message(
      'Example',
      name: 'example',
      desc: '',
      args: [],
    );
  }

  /// `Next`
  String get toNextStepButtonTitle {
    return Intl.message(
      'Next',
      name: 'toNextStepButtonTitle',
      desc: '',
      args: [],
    );
  }

  /// `required`
  String get required {
    return Intl.message(
      'required',
      name: 'required',
      desc: '',
      args: [],
    );
  }

  /// `Create Additional Step`
  String get createAdditionalStep {
    return Intl.message(
      'Create Additional Step',
      name: 'createAdditionalStep',
      desc: '',
      args: [],
    );
  }

  /// `Step Information`
  String get stepInfo {
    return Intl.message(
      'Step Information',
      name: 'stepInfo',
      desc: '',
      args: [],
    );
  }

  /// `To complete the check, you need to go through all mandatory steps`
  String get notAllStepsHaveBeenCompleted {
    return Intl.message(
      'To complete the check, you need to go through all mandatory steps',
      name: 'notAllStepsHaveBeenCompleted',
      desc: '',
      args: [],
    );
  }

  /// `Comment Text`
  String get commentText {
    return Intl.message(
      'Comment Text',
      name: 'commentText',
      desc: '',
      args: [],
    );
  }

  /// `User Agreement and Privacy Policy`
  String get userAgreementAndPrivacyPolicy {
    return Intl.message(
      'User Agreement and Privacy Policy',
      name: 'userAgreementAndPrivacyPolicy',
      desc: '',
      args: [],
    );
  }

  /// `No internet connection.\nNotifications are unavailable.`
  String get noInternetConnectionNotifications {
    return Intl.message(
      'No internet connection.\nNotifications are unavailable.',
      name: 'noInternetConnectionNotifications',
      desc: '',
      args: [],
    );
  }

  /// `No available tasks`
  String get noAvailableTasks {
    return Intl.message(
      'No available tasks',
      name: 'noAvailableTasks',
      desc: '',
      args: [],
    );
  }

  /// `Comment`
  String get comment {
    return Intl.message(
      'Comment',
      name: 'comment',
      desc: '',
      args: [],
    );
  }

  /// `Review`
  String get review {
    return Intl.message(
      'Review',
      name: 'review',
      desc: '',
      args: [],
    );
  }

  /// `Review Template`
  String get reviewTemplate {
    return Intl.message(
      'Review Template',
      name: 'reviewTemplate',
      desc: '',
      args: [],
    );
  }

  /// `Reviews`
  String get reviews {
    return Intl.message(
      'Reviews',
      name: 'reviews',
      desc: '',
      args: [],
    );
  }

  /// `Go`
  String get reviewsModalInfoRedirectButton {
    return Intl.message(
      'Go',
      name: 'reviewsModalInfoRedirectButton',
      desc: '',
      args: [],
    );
  }

  /// `Later`
  String get reviewsModalInfoLaterButton {
    return Intl.message(
      'Later',
      name: 'reviewsModalInfoLaterButton',
      desc: '',
      args: [],
    );
  }

  /// `No checks are scheduled or started. Please wait for them to be assigned or create one yourself.`
  String get noChecksScheduledOrStarted {
    return Intl.message(
      'No checks are scheduled or started. Please wait for them to be assigned or create one yourself.',
      name: 'noChecksScheduledOrStarted',
      desc: '',
      args: [],
    );
  }

  /// `No scheduled checks`
  String get noScheduledChecks {
    return Intl.message(
      'No scheduled checks',
      name: 'noScheduledChecks',
      desc: '',
      args: [],
    );
  }

  /// `There are no checks that need to be finalized`
  String get noInReworkChecks {
    return Intl.message(
      'There are no checks that need to be finalized',
      name: 'noInReworkChecks',
      desc: '',
      args: [],
    );
  }

  /// `No checks in progress`
  String get noStartedChecks {
    return Intl.message(
      'No checks in progress',
      name: 'noStartedChecks',
      desc: '',
      args: [],
    );
  }

  /// `No checks found with this name`
  String get checksWithThisNameNotFound {
    return Intl.message(
      'No checks found with this name',
      name: 'checksWithThisNameNotFound',
      desc: '',
      args: [],
    );
  }

  /// `All`
  String get all {
    return Intl.message(
      'All',
      name: 'all',
      desc: '',
      args: [],
    );
  }

  /// `Turn on GPS`
  String get turnOnGPS {
    return Intl.message(
      'Turn on GPS',
      name: 'turnOnGPS',
      desc: '',
      args: [],
    );
  }

  /// `Turn on HMS Core location services`
  String get turnOnLocationServices {
    return Intl.message(
      'Turn on HMS Core location services',
      name: 'turnOnLocationServices',
      desc: '',
      args: [],
    );
  }

  /// `No access to get exact location`
  String get noAccessToGetExactLocation {
    return Intl.message(
      'No access to get exact location',
      name: 'noAccessToGetExactLocation',
      desc: '',
      args: [],
    );
  }

  /// `No access to get location`
  String get noAccessToGetLocation {
    return Intl.message(
      'No access to get location',
      name: 'noAccessToGetLocation',
      desc: '',
      args: [],
    );
  }

  /// `Fill in the field`
  String get fillInTheField {
    return Intl.message(
      'Fill in the field',
      name: 'fillInTheField',
      desc: '',
      args: [],
    );
  }

  /// `Step Type`
  String get stepType {
    return Intl.message(
      'Step Type',
      name: 'stepType',
      desc: '',
      args: [],
    );
  }

  /// `{itemsName} missing`
  String itemsMissing(String itemsName) {
    return Intl.message(
      '$itemsName missing',
      name: 'itemsMissing',
      desc: '',
      args: [itemsName],
    );
  }

  /// `Creation of {itemsName} not available`
  String itemCreationNotAvailable(String itemsName) {
    return Intl.message(
      'Creation of $itemsName not available',
      name: 'itemCreationNotAvailable',
      desc: '',
      args: [itemsName],
    );
  }

  /// `Creation of {itemsName} is not available according to the settings set by the administrator.`
  String creationOfItemsIsNotAvailableDescription(Object itemsName) {
    return Intl.message(
      'Creation of $itemsName is not available according to the settings set by the administrator.',
      name: 'creationOfItemsIsNotAvailableDescription',
      desc: '',
      args: [itemsName],
    );
  }

  /// `Go to main`
  String get toMain {
    return Intl.message(
      'Go to main',
      name: 'toMain',
      desc: '',
      args: [],
    );
  }

  /// `Necessary Actions for Task`
  String get necessaryActionsForTask {
    return Intl.message(
      'Necessary Actions for Task',
      name: 'necessaryActionsForTask',
      desc: '',
      args: [],
    );
  }

  /// `objects`
  String get missingObjectsName {
    return Intl.message(
      'objects',
      name: 'missingObjectsName',
      desc: '',
      args: [],
    );
  }

  /// `reviews`
  String get missingReviewsName {
    return Intl.message(
      'reviews',
      name: 'missingReviewsName',
      desc: '',
      args: [],
    );
  }

  /// `tasks`
  String get missingTasksName {
    return Intl.message(
      'tasks',
      name: 'missingTasksName',
      desc: '',
      args: [],
    );
  }

  /// `Wait for their assignment or\n`
  String get waitForTheirAppointmentOr {
    return Intl.message(
      'Wait for their assignment or\n',
      name: 'waitForTheirAppointmentOr',
      desc: '',
      args: [],
    );
  }

  /// `Error:`
  String get error {
    return Intl.message(
      'Error:',
      name: 'error',
      desc: '',
      args: [],
    );
  }

  /// `Location is being determined`
  String get locationDetermining {
    return Intl.message(
      'Location is being determined',
      name: 'locationDetermining',
      desc: '',
      args: [],
    );
  }

  /// `Please wait`
  String get pleaseWait {
    return Intl.message(
      'Please wait',
      name: 'pleaseWait',
      desc: '',
      args: [],
    );
  }

  /// `The speed of location determination depends on current conditions: satellite availability, cloud cover, and building interference.`
  String get locatingDescription {
    return Intl.message(
      'The speed of location determination depends on current conditions: satellite availability, cloud cover, and building interference.',
      name: 'locatingDescription',
      desc: '',
      args: [],
    );
  }

  /// `If you are indoors, move closer to a window or go outside.`
  String get locatingRecommendation {
    return Intl.message(
      'If you are indoors, move closer to a window or go outside.',
      name: 'locatingRecommendation',
      desc: '',
      args: [],
    );
  }

  /// `At the moment, the location could not be determined. Attempts will be made during the Review process.`
  String get startReviewWithoutInitialLocation {
    return Intl.message(
      'At the moment, the location could not be determined. Attempts will be made during the Review process.',
      name: 'startReviewWithoutInitialLocation',
      desc: '',
      args: [],
    );
  }

  /// `High`
  String get accuracyHigh {
    return Intl.message(
      'High',
      name: 'accuracyHigh',
      desc: '',
      args: [],
    );
  }

  /// `Medium`
  String get accuracyMedium {
    return Intl.message(
      'Medium',
      name: 'accuracyMedium',
      desc: '',
      args: [],
    );
  }

  /// `Low`
  String get accuracyLow {
    return Intl.message(
      'Low',
      name: 'accuracyLow',
      desc: '',
      args: [],
    );
  }

  /// `Try again`
  String get tryAgain {
    return Intl.message(
      'Try again',
      name: 'tryAgain',
      desc: '',
      args: [],
    );
  }

  /// `Proceed to Review`
  String get proceedToReview {
    return Intl.message(
      'Proceed to Review',
      name: 'proceedToReview',
      desc: '',
      args: [],
    );
  }

  /// `Failed to determine location`
  String get failedToDetermineLocation {
    return Intl.message(
      'Failed to determine location',
      name: 'failedToDetermineLocation',
      desc: '',
      args: [],
    );
  }

  /// `No task types available`
  String get haveNoTaskTypesAvailable {
    return Intl.message(
      'No task types available',
      name: 'haveNoTaskTypesAvailable',
      desc: '',
      args: [],
    );
  }

  /// `No templates available`
  String get haveNoTemplatesAvailable {
    return Intl.message(
      'No templates available',
      name: 'haveNoTemplatesAvailable',
      desc: '',
      args: [],
    );
  }

  /// `No objects available`
  String get haveNoArticlesAvailable {
    return Intl.message(
      'No objects available',
      name: 'haveNoArticlesAvailable',
      desc: '',
      args: [],
    );
  }

  /// `Without available Objects it is impossible to create a check or task`
  String get reviewOrTaskCanNotBeCreatedWithoutAvailableArticles {
    return Intl.message(
      'Without available Objects it is impossible to create a check or task',
      name: 'reviewOrTaskCanNotBeCreatedWithoutAvailableArticles',
      desc: '',
      args: [],
    );
  }

  /// `Independent creation of objects is not available in accordance with the settings set by the administrator`
  String get independentCreationArticlesIsNotAvailableBySystemSettings {
    return Intl.message(
      'Independent creation of objects is not available in accordance with the settings set by the administrator',
      name: 'independentCreationArticlesIsNotAvailableBySystemSettings',
      desc: '',
      args: [],
    );
  }

  /// `Wait for Objects to be added or `
  String get waitCreationArticlesOr {
    return Intl.message(
      'Wait for Objects to be added or ',
      name: 'waitCreationArticlesOr',
      desc: '',
      args: [],
    );
  }

  /// `Failed to connect to the server, there is no saved data for working offline.`
  String get errorNoConnectionDescription {
    return Intl.message(
      'Failed to connect to the server, there is no saved data for working offline.',
      name: 'errorNoConnectionDescription',
      desc: '',
      args: [],
    );
  }

  /// `Check your internet connection and try again.`
  String get checkYourInternetConnectionAndTryAgain {
    return Intl.message(
      'Check your internet connection and try again.',
      name: 'checkYourInternetConnectionAndTryAgain',
      desc: '',
      args: [],
    );
  }

  /// `Audio recording`
  String get audioRecording {
    return Intl.message(
      'Audio recording',
      name: 'audioRecording',
      desc: '',
      args: [],
    );
  }

  /// `Audio file name`
  String get audioFileName {
    return Intl.message(
      'Audio file name',
      name: 'audioFileName',
      desc: '',
      args: [],
    );
  }

  /// `Audio`
  String get audio {
    return Intl.message(
      'Audio',
      name: 'audio',
      desc: '',
      args: [],
    );
  }

  /// `Picture`
  String get picture {
    return Intl.message(
      'Picture',
      name: 'picture',
      desc: '',
      args: [],
    );
  }

  /// `The number of selected images is exceeded. Maximum - `
  String get numberOfImagesExceeded {
    return Intl.message(
      'The number of selected images is exceeded. Maximum - ',
      name: 'numberOfImagesExceeded',
      desc: '',
      args: [],
    );
  }

  /// `Min {minDuration} sec / Max {maxDuration} sec`
  String audioRecordingRestrictions(String minDuration, String maxDuration) {
    return Intl.message(
      'Min $minDuration sec / Max $maxDuration sec',
      name: 'audioRecordingRestrictions',
      desc: '',
      args: [minDuration, maxDuration],
    );
  }

  /// `The minimum duration of the audio recording has not been reached`
  String get minimumAudioLengthNotReached {
    return Intl.message(
      'The minimum duration of the audio recording has not been reached',
      name: 'minimumAudioLengthNotReached',
      desc: '',
      args: [],
    );
  }

  /// `Select an action`
  String get selectAnAction {
    return Intl.message(
      'Select an action',
      name: 'selectAnAction',
      desc: '',
      args: [],
    );
  }

  /// `Copy step`
  String get copyStep {
    return Intl.message(
      'Copy step',
      name: 'copyStep',
      desc: '',
      args: [],
    );
  }

  /// `Create a new step`
  String get createNewStep {
    return Intl.message(
      'Create a new step',
      name: 'createNewStep',
      desc: '',
      args: [],
    );
  }

  /// `Copying a step`
  String get copyingStep {
    return Intl.message(
      'Copying a step',
      name: 'copyingStep',
      desc: '',
      args: [],
    );
  }

  /// `Instruction`
  String get instruction {
    return Intl.message(
      'Instruction',
      name: 'instruction',
      desc: '',
      args: [],
    );
  }

  /// `Copying a step allows you to reproduce repeatable processes`
  String get copyingStepInstruction {
    return Intl.message(
      'Copying a step allows you to reproduce repeatable processes',
      name: 'copyingStepInstruction',
      desc: '',
      args: [],
    );
  }

  /// `Specify a new name for the step`
  String get specifyNewStepName {
    return Intl.message(
      'Specify a new name for the step',
      name: 'specifyNewStepName',
      desc: '',
      args: [],
    );
  }

  /// `Number of copies`
  String get numberOfCopies {
    return Intl.message(
      'Number of copies',
      name: 'numberOfCopies',
      desc: '',
      args: [],
    );
  }

  /// `Copy a section`
  String get copySection {
    return Intl.message(
      'Copy a section',
      name: 'copySection',
      desc: '',
      args: [],
    );
  }

  /// `Copying a section`
  String get copyingSection {
    return Intl.message(
      'Copying a section',
      name: 'copyingSection',
      desc: '',
      args: [],
    );
  }

  /// `Section name`
  String get sectionName {
    return Intl.message(
      'Section name',
      name: 'sectionName',
      desc: '',
      args: [],
    );
  }

  /// `Copying a group of steps allows you to reproduce repeatable processes`
  String get copyingSectionInstruction {
    return Intl.message(
      'Copying a group of steps allows you to reproduce repeatable processes',
      name: 'copyingSectionInstruction',
      desc: '',
      args: [],
    );
  }

  /// `Enter a new section name`
  String get enterNewSectionName {
    return Intl.message(
      'Enter a new section name',
      name: 'enterNewSectionName',
      desc: '',
      args: [],
    );
  }

  /// `You can specify the name of the copied steps in the review step itself`
  String get youCanSpecifyNameCopiedSteps {
    return Intl.message(
      'You can specify the name of the copied steps in the review step itself',
      name: 'youCanSpecifyNameCopiedSteps',
      desc: '',
      args: [],
    );
  }

  /// `Steps completed`
  String get stepsCompleted {
    return Intl.message(
      'Steps completed',
      name: 'stepsCompleted',
      desc: '',
      args: [],
    );
  }

  /// `Enter your registration ID`
  String get enterIdForRegistration {
    return Intl.message(
      'Enter your registration ID',
      name: 'enterIdForRegistration',
      desc: '',
      args: [],
    );
  }

  /// `Enter your ID`
  String get enterIdSecondScreen {
    return Intl.message(
      'Enter your ID',
      name: 'enterIdSecondScreen',
      desc: '',
      args: [],
    );
  }

  /// `To identify your account, enter your ID.\n`
  String get enterIdForAccountIdentification {
    return Intl.message(
      'To identify your account, enter your ID.\n',
      name: 'enterIdForAccountIdentification',
      desc: '',
      args: [],
    );
  }

  /// `The ID can be obtained from the Manager, the counterpart, or it can be placed directly on the Object`
  String get getIdFromManager {
    return Intl.message(
      'The ID can be obtained from the Manager, the counterpart, or it can be placed directly on the Object',
      name: 'getIdFromManager',
      desc: '',
      args: [],
    );
  }

  /// `Enter your Email`
  String get enterEmail {
    return Intl.message(
      'Enter your Email',
      name: 'enterEmail',
      desc: '',
      args: [],
    );
  }

  /// `Enter your last name`
  String get enterLastName {
    return Intl.message(
      'Enter your last name',
      name: 'enterLastName',
      desc: '',
      args: [],
    );
  }

  /// `Enter your first name`
  String get enterName {
    return Intl.message(
      'Enter your first name',
      name: 'enterName',
      desc: '',
      args: [],
    );
  }

  /// `Enter your company`
  String get enterCompany {
    return Intl.message(
      'Enter your company',
      name: 'enterCompany',
      desc: '',
      args: [],
    );
  }

  /// `Registration was successful`
  String get registrationSuccess {
    return Intl.message(
      'Registration was successful',
      name: 'registrationSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Switch to authorization`
  String get switchToSignIn {
    return Intl.message(
      'Switch to authorization',
      name: 'switchToSignIn',
      desc: '',
      args: [],
    );
  }

  /// `To login to the app you will receive a message with a password`
  String get youWillGetMessageWithPassword {
    return Intl.message(
      'To login to the app you will receive a message with a password',
      name: 'youWillGetMessageWithPassword',
      desc: '',
      args: [],
    );
  }

  /// `After confirmation of your account you will receive a message with password for authorization`
  String get youWillGetPasswordAfterVerification {
    return Intl.message(
      'After confirmation of your account you will receive a message with password for authorization',
      name: 'youWillGetPasswordAfterVerification',
      desc: '',
      args: [],
    );
  }

  /// `Wait for verification`
  String get waitForVerification {
    return Intl.message(
      'Wait for verification',
      name: 'waitForVerification',
      desc: '',
      args: [],
    );
  }

  /// `You’re not tied to any company`
  String get youAreNotLinkedToAnyCompany {
    return Intl.message(
      'You’re not tied to any company',
      name: 'youAreNotLinkedToAnyCompany',
      desc: '',
      args: [],
    );
  }

  /// `Delegate`
  String get toDelegate {
    return Intl.message(
      'Delegate',
      name: 'toDelegate',
      desc: '',
      args: [],
    );
  }

  /// `Rejection`
  String get rejection {
    return Intl.message(
      'Rejection',
      name: 'rejection',
      desc: '',
      args: [],
    );
  }

  /// `Reasons for rejection`
  String get rejectionReason {
    return Intl.message(
      'Reasons for rejection',
      name: 'rejectionReason',
      desc: '',
      args: [],
    );
  }

  /// `Contractor phone number`
  String get contractorPhoneNumber {
    return Intl.message(
      'Contractor phone number',
      name: 'contractorPhoneNumber',
      desc: '',
      args: [],
    );
  }

  /// `New Contractor phone number`
  String get newContractorPhoneNumber {
    return Intl.message(
      'New Contractor phone number',
      name: 'newContractorPhoneNumber',
      desc: '',
      args: [],
    );
  }

  /// `Enter the position`
  String get enterPosition {
    return Intl.message(
      'Enter the position',
      name: 'enterPosition',
      desc: '',
      args: [],
    );
  }

  /// `Report rejected`
  String get reportRejectedSuccess {
    return Intl.message(
      'Report rejected',
      name: 'reportRejectedSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Data transferred to the responsible person`
  String get dataTransferredToResponsible {
    return Intl.message(
      'Data transferred to the responsible person',
      name: 'dataTransferredToResponsible',
      desc: '',
      args: [],
    );
  }

  /// `Go to Reports`
  String get goToReportsNavigation {
    return Intl.message(
      'Go to Reports',
      name: 'goToReportsNavigation',
      desc: '',
      args: [],
    );
  }

  /// `delegation`
  String get delegation {
    return Intl.message(
      'delegation',
      name: 'delegation',
      desc: '',
      args: [],
    );
  }

  /// `Enter the Contractor’s phone number to delegate.\n`
  String get enterContractorPhoneNumberToDelegate {
    return Intl.message(
      'Enter the Contractor’s phone number to delegate.\n',
      name: 'enterContractorPhoneNumberToDelegate',
      desc: '',
      args: [],
    );
  }

  /// `If the Contractor is not registered in the system, you need to enter the necessary information about the Contractor`
  String get ifContractorUnregisteredEnterInfoAbout {
    return Intl.message(
      'If the Contractor is not registered in the system, you need to enter the necessary information about the Contractor',
      name: 'ifContractorUnregisteredEnterInfoAbout',
      desc: '',
      args: [],
    );
  }

  /// `Delegation was successful`
  String get delegationSuccess {
    return Intl.message(
      'Delegation was successful',
      name: 'delegationSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Report was delegated to the selected Contractor`
  String get reportWasDelegatedToChosenContractor {
    return Intl.message(
      'Report was delegated to the selected Contractor',
      name: 'reportWasDelegatedToChosenContractor',
      desc: '',
      args: [],
    );
  }

  /// `Delegation is not possible`
  String get delegationImpossible {
    return Intl.message(
      'Delegation is not possible',
      name: 'delegationImpossible',
      desc: '',
      args: [],
    );
  }

  /// `The Contractor whose delegation was executed was not registered`
  String get contractorDelegateToIsUnregistered {
    return Intl.message(
      'The Contractor whose delegation was executed was not registered',
      name: 'contractorDelegateToIsUnregistered',
      desc: '',
      args: [],
    );
  }

  /// `Self-creation of an contractor is not available according to administrator settings.`
  String get selfContractorCreationIsImpossible {
    return Intl.message(
      'Self-creation of an contractor is not available according to administrator settings.',
      name: 'selfContractorCreationIsImpossible',
      desc: '',
      args: [],
    );
  }

  /// `Taken to Work`
  String get gotToWork {
    return Intl.message(
      'Taken to Work',
      name: 'gotToWork',
      desc: '',
      args: [],
    );
  }

  /// `Creating or Uploading`
  String get creatingOrUploading {
    return Intl.message(
      'Creating or Uploading',
      name: 'creatingOrUploading',
      desc: '',
      args: [],
    );
  }

  /// `Sending`
  String get sending {
    return Intl.message(
      'Sending',
      name: 'sending',
      desc: '',
      args: [],
    );
  }

  /// `Delegated`
  String get delegated {
    return Intl.message(
      'Delegated',
      name: 'delegated',
      desc: '',
      args: [],
    );
  }

  /// `Deleted`
  String get deleted {
    return Intl.message(
      'Deleted',
      name: 'deleted',
      desc: '',
      args: [],
    );
  }

  /// `Created`
  String get created {
    return Intl.message(
      'Created',
      name: 'created',
      desc: '',
      args: [],
    );
  }

  /// `Need rework`
  String get isNeedRework {
    return Intl.message(
      'Need rework',
      name: 'isNeedRework',
      desc: '',
      args: [],
    );
  }

  /// `Impossible to take the report into operation`
  String get canNotGetToWork {
    return Intl.message(
      'Impossible to take the report into operation',
      name: 'canNotGetToWork',
      desc: '',
      args: [],
    );
  }

  /// `The report has already been taken over by another Contractor`
  String get reportAlreadyGotToWork {
    return Intl.message(
      'The report has already been taken over by another Contractor',
      name: 'reportAlreadyGotToWork',
      desc: '',
      args: [],
    );
  }

  /// `Select a different report to work with`
  String get chooseAnotherReport {
    return Intl.message(
      'Select a different report to work with',
      name: 'chooseAnotherReport',
      desc: '',
      args: [],
    );
  }

  /// `Signing Review with Simple Electronic Signature`
  String get signReviewTitle {
    return Intl.message(
      'Signing Review with Simple Electronic Signature',
      name: 'signReviewTitle',
      desc: '',
      args: [],
    );
  }

  /// `By clicking the 'Submit' button, you confirm the relevance, accuracy, and compliance of the information provided in the review.`
  String get signReviewDescription {
    return Intl.message(
      'By clicking the \'Submit\' button, you confirm the relevance, accuracy, and compliance of the information provided in the review.',
      name: 'signReviewDescription',
      desc: '',
      args: [],
    );
  }

  /// `I accept the `
  String get linkedCheckBoxPrivacyAgreementFirst {
    return Intl.message(
      'I accept the ',
      name: 'linkedCheckBoxPrivacyAgreementFirst',
      desc: '',
      args: [],
    );
  }

  /// `agreement`
  String get linkedCheckBoxPrivacyAgreementSecond {
    return Intl.message(
      'agreement',
      name: 'linkedCheckBoxPrivacyAgreementSecond',
      desc: '',
      args: [],
    );
  }

  /// ` on the use of a simple electronic signature`
  String get linkedCheckBoxPrivacyAgreementThird {
    return Intl.message(
      ' on the use of a simple electronic signature',
      name: 'linkedCheckBoxPrivacyAgreementThird',
      desc: '',
      args: [],
    );
  }

  /// `Submit and send`
  String get linkedCheckBoxSendButton {
    return Intl.message(
      'Submit and send',
      name: 'linkedCheckBoxSendButton',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get linkedCheckBoxCancelButton {
    return Intl.message(
      'Cancel',
      name: 'linkedCheckBoxCancelButton',
      desc: '',
      args: [],
    );
  }

  /// `Groups`
  String get articleListSortGroup {
    return Intl.message(
      'Groups',
      name: 'articleListSortGroup',
      desc: '',
      args: [],
    );
  }

  /// `All`
  String get articleListSortAll {
    return Intl.message(
      'All',
      name: 'articleListSortAll',
      desc: '',
      args: [],
    );
  }

  /// `To main objects`
  String get articleDetailsToMainArticles {
    return Intl.message(
      'To main objects',
      name: 'articleDetailsToMainArticles',
      desc: '',
      args: [],
    );
  }

  /// `Contains objects: {number}`
  String articleDetailsContainsObjects(String number) {
    return Intl.message(
      'Contains objects: $number',
      name: 'articleDetailsContainsObjects',
      desc: '',
      args: [number],
    );
  }

  /// `Object passport`
  String get articlePassportHeader {
    return Intl.message(
      'Object passport',
      name: 'articlePassportHeader',
      desc: '',
      args: [],
    );
  }

  /// `Characteristics`
  String get articlePassportBodyTitle {
    return Intl.message(
      'Characteristics',
      name: 'articlePassportBodyTitle',
      desc: '',
      args: [],
    );
  }

  /// `Object type`
  String get articlePassportArticleType {
    return Intl.message(
      'Object type',
      name: 'articlePassportArticleType',
      desc: '',
      args: [],
    );
  }

  /// `Log out and delete your account`
  String get logOutAndDeleteYourAccount {
    return Intl.message(
      'Log out and delete your account',
      name: 'logOutAndDeleteYourAccount',
      desc: '',
      args: [],
    );
  }

  /// `Not registered`
  String get accountDoesNotExist {
    return Intl.message(
      'Not registered',
      name: 'accountDoesNotExist',
      desc: '',
      args: [],
    );
  }

  /// `Confirm the action`
  String get confirmTheAction {
    return Intl.message(
      'Confirm the action',
      name: 'confirmTheAction',
      desc: '',
      args: [],
    );
  }

  /// `By clicking the confirm button, you exit the application and delete your account along with the relevant personal data.`
  String get deleteAccountDialogDescription {
    return Intl.message(
      'By clicking the confirm button, you exit the application and delete your account along with the relevant personal data.',
      name: 'deleteAccountDialogDescription',
      desc: '',
      args: [],
    );
  }

  /// `Confirm`
  String get confirm {
    return Intl.message(
      'Confirm',
      name: 'confirm',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'kk'),
      Locale.fromSubtags(languageCode: 'ru'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
