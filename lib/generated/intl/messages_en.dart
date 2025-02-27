// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
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
  String get localeName => 'en';

  static String m0(number) => "Contains objects: ${number}";

  static String m1(howMany) =>
      "${Intl.plural(howMany, one: '${howMany} review', two: '${howMany} reviews', other: '${howMany} reviews')}";

  static String m2(current, max) => "\nRegistered ${current} out of ${max}";

  static String m3(minDuration, maxDuration) =>
      "Min ${minDuration} sec / Max ${maxDuration} sec";

  static String m4(itemsName) =>
      "Creation of ${itemsName} is not available according to the settings set by the administrator.";

  static String m5(megabytes) => "${megabytes} MB cleared.";

  static String m6(itemsName) => "Creation of ${itemsName} not available";

  static String m7(itemsName) => "${itemsName} missing";

  static String m8(localVersion, storeVersion) =>
      "A new update is available, please update the app\n\nYour version: ${localVersion}\nAvailable version: ${storeVersion}";

  static String m9(progress, count) =>
      "Retrying sending ${progress} / ${count}...";

  static String m10(releaseNotes) => "\n\nDescription:${releaseNotes}";

  static String m11(count) =>
      "Uploading ${count} items has started!\nDo not close the app and ensure a stable internet connection.";

  static String m12(comment) => "Administrator\'s Comment: \'${comment}\'";

  static String m13(path, mbLimit) =>
      "The file ${path} exceeds ${mbLimit} MB. Sending is not possible.";

  static String m14(freeDiskSpace) =>
      "Low on space: ${freeDiskSpace} MB remaining.";

  static String m15(comments) => "Missed with comments: \r\n${comments}";

  static String m16(phone) =>
      "The confirmation code has been sent to the provided number “${phone}”.";

  static String m17(date) => "Finish by ${date}";

  static String m18(date) => "Start Execution ${date}";

  static String m19(id) => "Identifier copied: ${id}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "accessGranted": MessageLookupByLibrary.simpleMessage("Access Granted"),
        "accountDoesNotExist":
            MessageLookupByLibrary.simpleMessage("Not registered"),
        "accountSelection":
            MessageLookupByLibrary.simpleMessage("Account Selection:"),
        "accuracyHigh": MessageLookupByLibrary.simpleMessage("High"),
        "accuracyLow": MessageLookupByLibrary.simpleMessage("Low"),
        "accuracyMedium": MessageLookupByLibrary.simpleMessage("Medium"),
        "addArticleScreenCompanyAddressLabel":
            MessageLookupByLibrary.simpleMessage("Address"),
        "addArticleScreenCompanyNameLabel":
            MessageLookupByLibrary.simpleMessage("Company Name"),
        "addArticleScreenCreate":
            MessageLookupByLibrary.simpleMessage("Create"),
        "addArticleScreenEnterInn":
            MessageLookupByLibrary.simpleMessage("Enter TIN"),
        "addArticleScreenInnNotFoundSelectForFillManualy":
            MessageLookupByLibrary.simpleMessage(
                "TIN not found, select to fill manually"),
        "addArticleScreenLoading":
            MessageLookupByLibrary.simpleMessage("Loading..."),
        "addArticleScreenObjectSuccessfulCreatedMessage":
            MessageLookupByLibrary.simpleMessage("Object successfully created"),
        "addingTask": MessageLookupByLibrary.simpleMessage("Creating Task"),
        "alertDialogDefaultOkTitle": MessageLookupByLibrary.simpleMessage("OK"),
        "all": MessageLookupByLibrary.simpleMessage("All"),
        "articleAccountSwitcherChooseCompany":
            MessageLookupByLibrary.simpleMessage("Choose a Company"),
        "articleDetailsContainsObjects": m0,
        "articleDetailsToMainArticles":
            MessageLookupByLibrary.simpleMessage("To main objects"),
        "articleListSortAll": MessageLookupByLibrary.simpleMessage("All"),
        "articleListSortGroup": MessageLookupByLibrary.simpleMessage("Groups"),
        "articlePassportArticleType":
            MessageLookupByLibrary.simpleMessage("Object type"),
        "articlePassportBodyTitle":
            MessageLookupByLibrary.simpleMessage("Characteristics"),
        "articlePassportHeader":
            MessageLookupByLibrary.simpleMessage("Object passport"),
        "articleRowStatusCreatedTitle":
            MessageLookupByLibrary.simpleMessage("Object Created"),
        "articleRowStatusNeedReportTitle":
            MessageLookupByLibrary.simpleMessage("Report Requested"),
        "articleRowStatusReportConfirmedTitle":
            MessageLookupByLibrary.simpleMessage("Check Confirmed"),
        "articleRowStatusReportDeniedTitle":
            MessageLookupByLibrary.simpleMessage("Check Denied"),
        "articleRowStatusUndefinedTitle":
            MessageLookupByLibrary.simpleMessage("Undefined Status"),
        "articleRowStatusUploadFailedTitle":
            MessageLookupByLibrary.simpleMessage("Upload Failed"),
        "articleRowStatusUploadingTitle":
            MessageLookupByLibrary.simpleMessage("Report Building Started"),
        "articleRowStatusWaitCheckingTitle":
            MessageLookupByLibrary.simpleMessage("Waiting for Check"),
        "articlesScreenArticlesCount": m1,
        "articlesScreenAvailabledArticleNotFoundCanRegister1":
            MessageLookupByLibrary.simpleMessage(
                "Wait for their addition or \n"),
        "articlesScreenAvailabledArticleNotFoundCanRegister2":
            MessageLookupByLibrary.simpleMessage("create your own"),
        "articlesScreenAvailabledArticleNotFoundCantRegister":
            MessageLookupByLibrary.simpleMessage(
                "No available objects, wait for their creation."),
        "articlesScreenAwaitOfSending":
            MessageLookupByLibrary.simpleMessage("awaiting sending"),
        "articlesScreenCreateReviewButtonTitle":
            MessageLookupByLibrary.simpleMessage("Create Review"),
        "articlesScreenHasNotFinishedReviews":
            MessageLookupByLibrary.simpleMessage(
                "There are unfinished reviews"),
        "articlesScreenHasRequestedReviews":
            MessageLookupByLibrary.simpleMessage("There are requested reviews"),
        "articlesScreenNeedToChooseCompany":
            MessageLookupByLibrary.simpleMessage(
                "You need to choose a company first"),
        "articlesScreenNetworkException": MessageLookupByLibrary.simpleMessage(
            "No Internet connection.\nTasks are unavailable."),
        "articlesScreenNothingFound": MessageLookupByLibrary.simpleMessage(
            "Unfortunately, nothing was found."),
        "articlesScreenRegisterReviews": MessageLookupByLibrary.simpleMessage(
            "Registering reviews on the server...\n"),
        "articlesScreenRegisterReviewsFinish": MessageLookupByLibrary.simpleMessage(
            "Reviews have been successfully registered. File uploads will continue in offline mode. Do not close the app or disconnect from the internet.\n"),
        "articlesScreenRegisterReviewsFinishGoBack":
            MessageLookupByLibrary.simpleMessage("Return to the app"),
        "articlesScreenRegisterReviewsStatus": m2,
        "articlesScreenRegisterReviewsUnxpectedException":
            MessageLookupByLibrary.simpleMessage(
                "An error occurred during review registration. Please try again later.\n"),
        "articlesScreenRegisterReviewsUnxpectedExceptionGoBack":
            MessageLookupByLibrary.simpleMessage("Return to the app"),
        "articlesScreenSawDownloads":
            MessageLookupByLibrary.simpleMessage("View Downloads"),
        "articlesScreenSearch": MessageLookupByLibrary.simpleMessage("Search"),
        "articlesScreenSearchEmpty":
            MessageLookupByLibrary.simpleMessage("Nothing found"),
        "articlesScreenSearchFieldLabel":
            MessageLookupByLibrary.simpleMessage("Search"),
        "articlesScreenSendSavedArticles":
            MessageLookupByLibrary.simpleMessage("Send saved reviews"),
        "articlesScreenTitle": MessageLookupByLibrary.simpleMessage("Objects"),
        "articlesScreenUploadsButtonTitle":
            MessageLookupByLibrary.simpleMessage("Uploads"),
        "audio": MessageLookupByLibrary.simpleMessage("Audio"),
        "audioFileName":
            MessageLookupByLibrary.simpleMessage("Audio file name"),
        "audioRecording":
            MessageLookupByLibrary.simpleMessage("Audio recording"),
        "audioRecordingRestrictions": m3,
        "boolDialogDefaultApproveTitle":
            MessageLookupByLibrary.simpleMessage("Yes"),
        "boolDialogDefaultDenyTitle":
            MessageLookupByLibrary.simpleMessage("No"),
        "camera": MessageLookupByLibrary.simpleMessage("Camera"),
        "canNotGetToWork": MessageLookupByLibrary.simpleMessage(
            "Impossible to take the report into operation"),
        "checkYourInternetConnectionAndTryAgain":
            MessageLookupByLibrary.simpleMessage(
                "Check your internet connection and try again."),
        "checksWithThisNameNotFound": MessageLookupByLibrary.simpleMessage(
            "No checks found with this name"),
        "chooseAnotherReport": MessageLookupByLibrary.simpleMessage(
            "Select a different report to work with"),
        "chooseCreatingArticleType":
            MessageLookupByLibrary.simpleMessage("Choose the article type"),
        "chooseReviewTemplateNoInternet": MessageLookupByLibrary.simpleMessage(
            "No Internet connection.\nSelection of inspection templates is unavailable."),
        "chooseReviewTemplateScreenAvailable":
            MessageLookupByLibrary.simpleMessage(
                "Available for independent review"),
        "chooseReviewTemplateScreenAwaitForContinue":
            MessageLookupByLibrary.simpleMessage("Awaiting execution"),
        "chooseReviwTemplate":
            MessageLookupByLibrary.simpleMessage("Choose a template"),
        "chooseReviwTemplateInternetException":
            MessageLookupByLibrary.simpleMessage("Internet connection error"),
        "chooseReviwTemplateScreenContinueReview":
            MessageLookupByLibrary.simpleMessage(
                "Click to continue building the review"),
        "choosingCreatingArticleTypeInternetException":
            MessageLookupByLibrary.simpleMessage(
                "No Internet connection.\nInspection article types are unavailable."),
        "comment": MessageLookupByLibrary.simpleMessage("Comment"),
        "commentText": MessageLookupByLibrary.simpleMessage("Comment Text"),
        "confirm": MessageLookupByLibrary.simpleMessage("Confirm"),
        "confirmTheAction":
            MessageLookupByLibrary.simpleMessage("Confirm the action"),
        "contractorDelegateToIsUnregistered": MessageLookupByLibrary.simpleMessage(
            "The Contractor whose delegation was executed was not registered"),
        "contractorPhoneNumber":
            MessageLookupByLibrary.simpleMessage("Contractor phone number"),
        "copySection": MessageLookupByLibrary.simpleMessage("Copy a section"),
        "copyStep": MessageLookupByLibrary.simpleMessage("Copy step"),
        "copyingSection":
            MessageLookupByLibrary.simpleMessage("Copying a section"),
        "copyingSectionInstruction": MessageLookupByLibrary.simpleMessage(
            "Copying a group of steps allows you to reproduce repeatable processes"),
        "copyingStep": MessageLookupByLibrary.simpleMessage("Copying a step"),
        "copyingStepInstruction": MessageLookupByLibrary.simpleMessage(
            "Copying a step allows you to reproduce repeatable processes"),
        "create": MessageLookupByLibrary.simpleMessage("Create"),
        "createAdditionalStep":
            MessageLookupByLibrary.simpleMessage("Create Additional Step"),
        "createNewStep":
            MessageLookupByLibrary.simpleMessage("Create a new step"),
        "createTask": MessageLookupByLibrary.simpleMessage("Create Task"),
        "created": MessageLookupByLibrary.simpleMessage("Created"),
        "creatingOrUploading":
            MessageLookupByLibrary.simpleMessage("Creating or Uploading"),
        "creationOfItemsIsNotAvailableDescription": m4,
        "dataTransferredToResponsible": MessageLookupByLibrary.simpleMessage(
            "Data transferred to the responsible person"),
        "deadline": MessageLookupByLibrary.simpleMessage("Due Date"),
        "delegated": MessageLookupByLibrary.simpleMessage("Delegated"),
        "delegation": MessageLookupByLibrary.simpleMessage("delegation"),
        "delegationImpossible":
            MessageLookupByLibrary.simpleMessage("Delegation is not possible"),
        "delegationSuccess":
            MessageLookupByLibrary.simpleMessage("Delegation was successful"),
        "deleteAccountDialogDescription": MessageLookupByLibrary.simpleMessage(
            "By clicking the confirm button, you exit the application and delete your account along with the relevant personal data."),
        "deleted": MessageLookupByLibrary.simpleMessage("Deleted"),
        "editingTask": MessageLookupByLibrary.simpleMessage("Editing Task"),
        "enterCompany":
            MessageLookupByLibrary.simpleMessage("Enter your company"),
        "enterContractorPhoneNumberToDelegate":
            MessageLookupByLibrary.simpleMessage(
                "Enter the Contractor’s phone number to delegate.\n"),
        "enterEmail": MessageLookupByLibrary.simpleMessage("Enter your Email"),
        "enterIdForAccountIdentification": MessageLookupByLibrary.simpleMessage(
            "To identify your account, enter your ID.\n"),
        "enterIdForRegistration":
            MessageLookupByLibrary.simpleMessage("Enter your registration ID"),
        "enterIdSecondScreen":
            MessageLookupByLibrary.simpleMessage("Enter your ID"),
        "enterLastName":
            MessageLookupByLibrary.simpleMessage("Enter your last name"),
        "enterName":
            MessageLookupByLibrary.simpleMessage("Enter your first name"),
        "enterNewSectionName":
            MessageLookupByLibrary.simpleMessage("Enter a new section name"),
        "enterObjectAddress":
            MessageLookupByLibrary.simpleMessage("Enter Object Address"),
        "enterPosition":
            MessageLookupByLibrary.simpleMessage("Enter the position"),
        "error": MessageLookupByLibrary.simpleMessage("Error:"),
        "errorNoConnectionDescription": MessageLookupByLibrary.simpleMessage(
            "Failed to connect to the server, there is no saved data for working offline."),
        "example": MessageLookupByLibrary.simpleMessage("Example"),
        "failedToDetermineLocation": MessageLookupByLibrary.simpleMessage(
            "Failed to determine location"),
        "fillInTheField":
            MessageLookupByLibrary.simpleMessage("Fill in the field"),
        "getIdFromManager": MessageLookupByLibrary.simpleMessage(
            "The ID can be obtained from the Manager, the counterpart, or it can be placed directly on the Object"),
        "goToCreateAnAdditionalStep": MessageLookupByLibrary.simpleMessage(
            "Go to create an additional step?"),
        "goToReportsNavigation":
            MessageLookupByLibrary.simpleMessage("Go to Reports"),
        "goToSettingsAndGiveAccessTo": MessageLookupByLibrary.simpleMessage(
            "To ensure proper app functionality, please grant access to:"),
        "gotToWork": MessageLookupByLibrary.simpleMessage("Taken to Work"),
        "haveNoArticlesAvailable":
            MessageLookupByLibrary.simpleMessage("No objects available"),
        "haveNoTaskTypesAvailable":
            MessageLookupByLibrary.simpleMessage("No task types available"),
        "haveNoTemplatesAvailable":
            MessageLookupByLibrary.simpleMessage("No templates available"),
        "help": MessageLookupByLibrary.simpleMessage("Help"),
        "helpCreateMessageScreenInternetException":
            MessageLookupByLibrary.simpleMessage("Internet connection error"),
        "helpCreateMessageScreenMessage":
            MessageLookupByLibrary.simpleMessage("Message Text"),
        "helpCreateMessageScreenMessageDescription":
            MessageLookupByLibrary.simpleMessage(
                "Please state the essence of the request in 2-3 sentences."),
        "helpCreateMessageScreenPhoneNumber":
            MessageLookupByLibrary.simpleMessage("Phone Number"),
        "helpCreateMessageScreenPhoneNumberDescription":
            MessageLookupByLibrary.simpleMessage(
                "Please provide a phone number for feedback."),
        "helpCreateMessageScreenSend":
            MessageLookupByLibrary.simpleMessage("Send"),
        "helpCreateMessageScreenSendMessage":
            MessageLookupByLibrary.simpleMessage("Send Message"),
        "helpCreateMessageScreenYourMessageSended":
            MessageLookupByLibrary.simpleMessage("Your message has been sent!"),
        "helpInsuranceCase":
            MessageLookupByLibrary.simpleMessage("Insurance Case"),
        "helpQuestionsScreenHasNotQuestionsAndAnswers":
            MessageLookupByLibrary.simpleMessage(
                "No questions and answers available"),
        "helpQuestionsScreenTitle":
            MessageLookupByLibrary.simpleMessage("Questions and Answers"),
        "helpScreenCallUs": MessageLookupByLibrary.simpleMessage("Call us"),
        "helpScreenCleanMemory":
            MessageLookupByLibrary.simpleMessage("Clear Memory"),
        "helpScreenCleanMemoryAreYouSure": MessageLookupByLibrary.simpleMessage(
            "Are you sure you want to delete all files?"),
        "helpScreenCleanMemoryNo": MessageLookupByLibrary.simpleMessage("No"),
        "helpScreenCleanMemoryProccessIsIrrevirsable":
            MessageLookupByLibrary.simpleMessage(
                "Cached and unsent files will be lost, this process is irreversible."),
        "helpScreenCleanMemoryYes": MessageLookupByLibrary.simpleMessage("Yes"),
        "helpScreenClearedMemoryToast": m5,
        "helpScreenExportFilesButtonTitle":
            MessageLookupByLibrary.simpleMessage("Export Files"),
        "helpScreenNeedToChooseCompany": MessageLookupByLibrary.simpleMessage(
            "You need to choose a company on the \'Objects\' screen first"),
        "helpScreenQuestionsAndAnswers":
            MessageLookupByLibrary.simpleMessage("Questions and Answers"),
        "helpScreenSendMessage":
            MessageLookupByLibrary.simpleMessage("Send Message"),
        "helpScreenTitle": MessageLookupByLibrary.simpleMessage("Help"),
        "helpScreenWriteEmail":
            MessageLookupByLibrary.simpleMessage("Write us an email"),
        "hide": MessageLookupByLibrary.simpleMessage("Hide"),
        "high": MessageLookupByLibrary.simpleMessage("High"),
        "ifContractorUnregisteredEnterInfoAbout":
            MessageLookupByLibrary.simpleMessage(
                "If the Contractor is not registered in the system, you need to enter the necessary information about the Contractor"),
        "independentCreationArticlesIsNotAvailableBySystemSettings":
            MessageLookupByLibrary.simpleMessage(
                "Independent creation of objects is not available in accordance with the settings set by the administrator"),
        "instruction": MessageLookupByLibrary.simpleMessage("Instruction"),
        "internetConnectionError":
            MessageLookupByLibrary.simpleMessage("Internet Connection Error"),
        "isNeedRework": MessageLookupByLibrary.simpleMessage("Need rework"),
        "itemCreationNotAvailable": m6,
        "itemsMissing": m7,
        "linkedCheckBoxCancelButton":
            MessageLookupByLibrary.simpleMessage("Cancel"),
        "linkedCheckBoxPrivacyAgreementFirst":
            MessageLookupByLibrary.simpleMessage("I accept the "),
        "linkedCheckBoxPrivacyAgreementSecond":
            MessageLookupByLibrary.simpleMessage("agreement"),
        "linkedCheckBoxPrivacyAgreementThird":
            MessageLookupByLibrary.simpleMessage(
                " on the use of a simple electronic signature"),
        "linkedCheckBoxSendButton":
            MessageLookupByLibrary.simpleMessage("Submit and send"),
        "loadingScreenConnectingToServer": MessageLookupByLibrary.simpleMessage(
            "Connecting to the server, please wait..."),
        "loadingScreenHasBeenCriticalError1":
            MessageLookupByLibrary.simpleMessage(
                "A critical error has occurred\n"),
        "loadingScreenHasBeenCriticalError2": MessageLookupByLibrary.simpleMessage(
            "Restart the app within an internet zone.\nIf the issue persists, "),
        "loadingScreenHasBeenCriticalError3":
            MessageLookupByLibrary.simpleMessage("try again"),
        "loadingScreenHasBeenCriticalError4":
            MessageLookupByLibrary.simpleMessage(" or "),
        "loadingScreenHasBeenCriticalError5":
            MessageLookupByLibrary.simpleMessage("remove files from the app"),
        "loadingScreenHasBeenCriticalError6":
            MessageLookupByLibrary.simpleMessage(", then "),
        "loadingScreenHasBeenCriticalError7":
            MessageLookupByLibrary.simpleMessage("reinstall the app."),
        "loadingScreenHasNewUpdate": m8,
        "loadingScreenHasNewUpdateText1": MessageLookupByLibrary.simpleMessage(
            "A new update is available.\n\n"),
        "loadingScreenHasNewUpdateText2":
            MessageLookupByLibrary.simpleMessage("Please update the app.\n\n"),
        "loadingScreenHasNewUpdateText3":
            MessageLookupByLibrary.simpleMessage("Update"),
        "loadingScreenLoadingAppTitle":
            MessageLookupByLibrary.simpleMessage("Loading the App..."),
        "loadingScreenRetrying":
            MessageLookupByLibrary.simpleMessage("Retrying..."),
        "loadingScreenRetryingSending": m9,
        "loadingScreenStartingOfflineMode":
            MessageLookupByLibrary.simpleMessage(
                "Starting the app in offline mode."),
        "loadingScreenUpdateDialogDismissButtonTitle":
            MessageLookupByLibrary.simpleMessage("Later"),
        "loadingScreenUpdateDialogTitle":
            MessageLookupByLibrary.simpleMessage("Update"),
        "loadingScreenUpdateDialogUpdateButtonTitle":
            MessageLookupByLibrary.simpleMessage("Update"),
        "loadingScreenUpdateHasNotes": m10,
        "loadingScreenUploadingFilesStarted": m11,
        "locatingDescription": MessageLookupByLibrary.simpleMessage(
            "The speed of location determination depends on current conditions: satellite availability, cloud cover, and building interference."),
        "locatingRecommendation": MessageLookupByLibrary.simpleMessage(
            "If you are indoors, move closer to a window or go outside."),
        "location": MessageLookupByLibrary.simpleMessage("Location"),
        "locationDetermining": MessageLookupByLibrary.simpleMessage(
            "Location is being determined"),
        "logOutAndDeleteYourAccount": MessageLookupByLibrary.simpleMessage(
            "Log out and delete your account"),
        "loginScreenPasswordHint":
            MessageLookupByLibrary.simpleMessage("* Password"),
        "loginScreenPasswordLabel":
            MessageLookupByLibrary.simpleMessage("Password"),
        "loginScreenPhoneHint":
            MessageLookupByLibrary.simpleMessage("* Phone Number"),
        "loginScreenPhoneLabel":
            MessageLookupByLibrary.simpleMessage("Phone Number"),
        "loginScreenPrivacy1": MessageLookupByLibrary.simpleMessage(
            "By clicking “Log In”, I agree to the processing of my personal data under the terms of the "),
        "loginScreenPrivacy2":
            MessageLookupByLibrary.simpleMessage("Privacy Policy"),
        "loginScreenRecoveryPasswordLink2":
            MessageLookupByLibrary.simpleMessage("Recover Password"),
        "loginScreenRecoveryPasswordLinkTitle":
            MessageLookupByLibrary.simpleMessage("Recover Password"),
        "loginScreenSignInButtonTitle":
            MessageLookupByLibrary.simpleMessage("Log In"),
        "loginScreenSignupButtonTitle":
            MessageLookupByLibrary.simpleMessage("Sign Up"),
        "loginScreenSignupOrRecoveryPassword":
            MessageLookupByLibrary.simpleMessage(" or "),
        "loginScreenTitle":
            MessageLookupByLibrary.simpleMessage("Log into your account"),
        "loginScreenUserAgreement1": MessageLookupByLibrary.simpleMessage(
            "By clicking “Log In”, I agree to the"),
        "loginScreenUserAgreement2":
            MessageLookupByLibrary.simpleMessage("User Agreement"),
        "loginScreenUserAgreement3": MessageLookupByLibrary.simpleMessage(
            "and processing of my personal data under the terms of the"),
        "loginScreenUserAgreement4":
            MessageLookupByLibrary.simpleMessage("Privacy Policy"),
        "low": MessageLookupByLibrary.simpleMessage("Low"),
        "main": MessageLookupByLibrary.simpleMessage("Main"),
        "makeDocumentPageAndroidBWTitle":
            MessageLookupByLibrary.simpleMessage("B/W"),
        "makeDocumentPageAndroidCropReset":
            MessageLookupByLibrary.simpleMessage("Reset"),
        "makeDocumentPageAndroidCropTitle":
            MessageLookupByLibrary.simpleMessage("Edit"),
        "makeDocumentPageAndroidScan":
            MessageLookupByLibrary.simpleMessage("Scan"),
        "makeDocumentPageTitle":
            MessageLookupByLibrary.simpleMessage("Create a Document Copy"),
        "makeMediaPageCameraAccesException":
            MessageLookupByLibrary.simpleMessage("No Camera Access"),
        "makeMediaPageCameraException":
            MessageLookupByLibrary.simpleMessage("Camera Error"),
        "makeMediaPageMicAccesException":
            MessageLookupByLibrary.simpleMessage("No Microphone Access"),
        "makeMediaPageOpenAppSettings":
            MessageLookupByLibrary.simpleMessage("Open App Settings"),
        "makeMediaPagePhoto": MessageLookupByLibrary.simpleMessage("Photo"),
        "makeMediaPageSomethingWentWrong": MessageLookupByLibrary.simpleMessage(
            "An unexpected error occurred"),
        "makeMediaPageStandBy": MessageLookupByLibrary.simpleMessage(
            "Processing and saving is in progress. Do not close the app, wait for completion."),
        "makeMediaPageUndefined":
            MessageLookupByLibrary.simpleMessage("undefined"),
        "makeMediaPageVideo": MessageLookupByLibrary.simpleMessage("Video"),
        "makeReportPageAddAnotherFile":
            MessageLookupByLibrary.simpleMessage("Add Another File"),
        "makeReportPageAddFile":
            MessageLookupByLibrary.simpleMessage("Add File"),
        "makeReportPageAddStep":
            MessageLookupByLibrary.simpleMessage("Add Step"),
        "makeReportPageAdminComment": m12,
        "makeReportPageAnotherReportWithThisTemplate":
            MessageLookupByLibrary.simpleMessage(
                "Would you like to conduct another inspection with this template?"),
        "makeReportPageAreYouSureForDelete":
            MessageLookupByLibrary.simpleMessage(
                "Are you sure you want to delete this report?"),
        "makeReportPageAreYouSureForExit": MessageLookupByLibrary.simpleMessage(
            "Are you sure you want to exit?"),
        "makeReportPageCancel": MessageLookupByLibrary.simpleMessage("Cancel"),
        "makeReportPageChooseAnotherFile":
            MessageLookupByLibrary.simpleMessage("Choose Another File"),
        "makeReportPageContinue":
            MessageLookupByLibrary.simpleMessage("Continue"),
        "makeReportPageFile": MessageLookupByLibrary.simpleMessage("File"),
        "makeReportPageFillTheAnotherForm":
            MessageLookupByLibrary.simpleMessage("Fill Out Another Form"),
        "makeReportPageFillTheForm":
            MessageLookupByLibrary.simpleMessage("Fill Out the Form"),
        "makeReportPageFinish": MessageLookupByLibrary.simpleMessage("Finish"),
        "makeReportPageHaveNotLocationPermission":
            MessageLookupByLibrary.simpleMessage(
                "Insufficient permissions to determine location"),
        "makeReportPageHugeFile": m13,
        "makeReportPageIssueOccured":
            MessageLookupByLibrary.simpleMessage("Issue Detected"),
        "makeReportPageLocating":
            MessageLookupByLibrary.simpleMessage("Locating..."),
        "makeReportPageLowSpace": m14,
        "makeReportPageMakeAdditionalPhoto":
            MessageLookupByLibrary.simpleMessage("Take Additional Photo"),
        "makeReportPageMakeAdditionalScan":
            MessageLookupByLibrary.simpleMessage("Make Additional Scan"),
        "makeReportPageMakeAdditionalVideo":
            MessageLookupByLibrary.simpleMessage("Record Additional Video"),
        "makeReportPageMakePhoto":
            MessageLookupByLibrary.simpleMessage("Take a Photo"),
        "makeReportPageMakeScan":
            MessageLookupByLibrary.simpleMessage("Make Scan"),
        "makeReportPageMissedWithComments": m15,
        "makeReportPageNo": MessageLookupByLibrary.simpleMessage("No"),
        "makeReportPageNotEnoughDishSpace":
            MessageLookupByLibrary.simpleMessage("Not Enough Disk Space"),
        "makeReportPageOpenAppSettings":
            MessageLookupByLibrary.simpleMessage("Open App Settings"),
        "makeReportPagePopupMessage": MessageLookupByLibrary.simpleMessage(
            "To complete the report, you need to go through the mandatory steps"),
        "makeReportPageReasonForSkip": MessageLookupByLibrary.simpleMessage(
            "Specify the reason for skipping"),
        "makeReportPageRemakePhoto":
            MessageLookupByLibrary.simpleMessage("Retake Photo"),
        "makeReportPageRemakeScan":
            MessageLookupByLibrary.simpleMessage("Retake Scan"),
        "makeReportPageRemakeVideo":
            MessageLookupByLibrary.simpleMessage("Record Video"),
        "makeReportPageRepeatableReport":
            MessageLookupByLibrary.simpleMessage("Repeatable Inspection"),
        "makeReportPageReportIsCreated": MessageLookupByLibrary.simpleMessage(
            "Thank you! The report is created!"),
        "makeReportPageScan": MessageLookupByLibrary.simpleMessage("Scan"),
        "makeReportPageSend": MessageLookupByLibrary.simpleMessage("Send"),
        "makeReportPageSendingData": MessageLookupByLibrary.simpleMessage(
            "Sending data to the server...\nPlease wait."),
        "makeReportPageSkip": MessageLookupByLibrary.simpleMessage("Skip"),
        "makeReportPageSkipAndFinish":
            MessageLookupByLibrary.simpleMessage("Skip and Finish"),
        "makeReportPageTapToChange":
            MessageLookupByLibrary.simpleMessage("Tap to Change"),
        "makeReportPageTapToWatch":
            MessageLookupByLibrary.simpleMessage("Tap to Watch"),
        "makeReportPageUndefinedState":
            MessageLookupByLibrary.simpleMessage("Undefined State"),
        "makeReportPageYes": MessageLookupByLibrary.simpleMessage("Yes"),
        "maximumNumberFilesReached": MessageLookupByLibrary.simpleMessage(
            "The maximum number of files of this type has been reached"),
        "mediaFilesDoNotSaved": MessageLookupByLibrary.simpleMessage(
            "Media files are not saved. Save them?"),
        "medium": MessageLookupByLibrary.simpleMessage("Medium"),
        "microphone": MessageLookupByLibrary.simpleMessage("Microphone"),
        "minimumAudioLengthNotReached": MessageLookupByLibrary.simpleMessage(
            "The minimum duration of the audio recording has not been reached"),
        "minimumVideoLengthNotReached": MessageLookupByLibrary.simpleMessage(
            "Minimum Video Length Not Reached"),
        "missingObjectsName": MessageLookupByLibrary.simpleMessage("objects"),
        "missingReviewsName": MessageLookupByLibrary.simpleMessage("reviews"),
        "missingTasksName": MessageLookupByLibrary.simpleMessage("tasks"),
        "myTextFieldDefaultDateHint":
            MessageLookupByLibrary.simpleMessage("Enter a date"),
        "myTextFieldDefaultNumberHint":
            MessageLookupByLibrary.simpleMessage("Enter a number"),
        "myTextFieldDefaultTextHint":
            MessageLookupByLibrary.simpleMessage("Enter text"),
        "necessaryActionsForTask":
            MessageLookupByLibrary.simpleMessage("Necessary Actions for Task"),
        "networkException":
            MessageLookupByLibrary.simpleMessage("Internet Connection Error"),
        "newContractorPhoneNumber":
            MessageLookupByLibrary.simpleMessage("New Contractor phone number"),
        "noAccessToGetExactLocation": MessageLookupByLibrary.simpleMessage(
            "No access to get exact location"),
        "noAccessToGetLocation":
            MessageLookupByLibrary.simpleMessage("No access to get location"),
        "noAvailableArticleTypes": MessageLookupByLibrary.simpleMessage(
            "No available inspection article types for creation.\nContact technical support on the \'Help\' page"),
        "noAvailableReviwTemplatesForThisArticle":
            MessageLookupByLibrary.simpleMessage(
                "There are no available inspection templates for this object"),
        "noAvailableTasks":
            MessageLookupByLibrary.simpleMessage("No available tasks"),
        "noChecksScheduledOrStarted": MessageLookupByLibrary.simpleMessage(
            "No checks are scheduled or started. Please wait for them to be assigned or create one yourself."),
        "noInReworkChecks": MessageLookupByLibrary.simpleMessage(
            "There are no checks that need to be finalized"),
        "noInternetConnectionNotifications":
            MessageLookupByLibrary.simpleMessage(
                "No internet connection.\nNotifications are unavailable."),
        "noScheduledChecks":
            MessageLookupByLibrary.simpleMessage("No scheduled checks"),
        "noStartedChecks":
            MessageLookupByLibrary.simpleMessage("No checks in progress"),
        "notAllRequiredPermitsHaveBeenIssued":
            MessageLookupByLibrary.simpleMessage(
                "Not all required permissions have been granted"),
        "notAllStepsHaveBeenCompleted": MessageLookupByLibrary.simpleMessage(
            "To complete the check, you need to go through all mandatory steps"),
        "notifications": MessageLookupByLibrary.simpleMessage("Notifications"),
        "notificationsScreenTitle":
            MessageLookupByLibrary.simpleMessage("Events"),
        "notificationsScreenYetHaveNotNotifications":
            MessageLookupByLibrary.simpleMessage(
                "You have no notifications yet"),
        "numberOfCopies":
            MessageLookupByLibrary.simpleMessage("Number of copies"),
        "numberOfImagesExceeded": MessageLookupByLibrary.simpleMessage(
            "The number of selected images is exceeded. Maximum - "),
        "object": MessageLookupByLibrary.simpleMessage("Object"),
        "objects": MessageLookupByLibrary.simpleMessage("Objects"),
        "objectsWithThisNameNotFound": MessageLookupByLibrary.simpleMessage(
            "No objects found with this name"),
        "ok": MessageLookupByLibrary.simpleMessage("OK"),
        "onCenterWidgetUndefined":
            MessageLookupByLibrary.simpleMessage("undefined"),
        "pickDate": MessageLookupByLibrary.simpleMessage("Pick a Date"),
        "pickObject": MessageLookupByLibrary.simpleMessage("Pick an Object"),
        "pickPriority": MessageLookupByLibrary.simpleMessage("Pick a Priority"),
        "pickTaskType":
            MessageLookupByLibrary.simpleMessage("Pick a Task Type"),
        "picture": MessageLookupByLibrary.simpleMessage("Picture"),
        "pleaseWait": MessageLookupByLibrary.simpleMessage("Please wait"),
        "previewPhotoScreenEnterComment":
            MessageLookupByLibrary.simpleMessage("Enter comment text"),
        "previewPhotoScreenUnexpectedFileFormat":
            MessageLookupByLibrary.simpleMessage(
                "Unknown file format or unable to determine"),
        "priority": MessageLookupByLibrary.simpleMessage("Priority"),
        "proceedToReview":
            MessageLookupByLibrary.simpleMessage("Proceed to Review"),
        "profileScreenCompanyInn":
            MessageLookupByLibrary.simpleMessage("Company\'s TIN"),
        "profileScreenEmail": MessageLookupByLibrary.simpleMessage("Email"),
        "profileScreenJobTitle":
            MessageLookupByLibrary.simpleMessage("Position"),
        "profileScreenName": MessageLookupByLibrary.simpleMessage("First Name"),
        "profileScreenPassword":
            MessageLookupByLibrary.simpleMessage("Password"),
        "profileScreenPatronymic":
            MessageLookupByLibrary.simpleMessage("Patronymic"),
        "profileScreenPhoneNumber":
            MessageLookupByLibrary.simpleMessage("Mobile Phone"),
        "profileScreenRepeatPassword":
            MessageLookupByLibrary.simpleMessage("Repeat Password"),
        "profileScreenSave": MessageLookupByLibrary.simpleMessage("Save"),
        "profileScreenSurname":
            MessageLookupByLibrary.simpleMessage("Last Name"),
        "recoveryScreenHintTitle":
            MessageLookupByLibrary.simpleMessage("Enter Phone Number"),
        "recoveryScreenPasswordHasBeenSentOnSpecifiedPhone":
            MessageLookupByLibrary.simpleMessage(
                "Password sent to the provided phone number"),
        "recoveryScreenPhoneHint":
            MessageLookupByLibrary.simpleMessage("* Phone Number"),
        "recoveryScreenPhoneLabel":
            MessageLookupByLibrary.simpleMessage("Phone Number"),
        "recoveryScreenSendPasswordButtonTitle":
            MessageLookupByLibrary.simpleMessage("Send Password"),
        "recoveryScreenTitle":
            MessageLookupByLibrary.simpleMessage("Password Recovery"),
        "registerFirstScreenCompanyLabel":
            MessageLookupByLibrary.simpleMessage("Company"),
        "registerFirstScreenEmailLabel":
            MessageLookupByLibrary.simpleMessage("Email"),
        "registerFirstScreenFirstnameLabel":
            MessageLookupByLibrary.simpleMessage("First Name"),
        "registerFirstScreenInnOfCompanyLabel":
            MessageLookupByLibrary.simpleMessage("Company\'s TIN"),
        "registerFirstScreenLastnameLabel":
            MessageLookupByLibrary.simpleMessage("Last Name"),
        "registerFirstScreenPasswordConfirmationError":
            MessageLookupByLibrary.simpleMessage("Passwords do not match"),
        "registerFirstScreenPasswordConfirmationLabel":
            MessageLookupByLibrary.simpleMessage("Confirm Password"),
        "registerFirstScreenPasswordLabel":
            MessageLookupByLibrary.simpleMessage("Password"),
        "registerFirstScreenPatronymicLabel":
            MessageLookupByLibrary.simpleMessage("Patronymic"),
        "registerFirstScreenPhoneLabel":
            MessageLookupByLibrary.simpleMessage("Mobile Phone"),
        "registerFirstScreenPositionLabel":
            MessageLookupByLibrary.simpleMessage("Position"),
        "registerFirstScreenPrivacy1": MessageLookupByLibrary.simpleMessage(
            "By clicking “Sign Up”, I agree to the processing of my personal data under the terms of the "),
        "registerFirstScreenPrivacy2":
            MessageLookupByLibrary.simpleMessage("Privacy Policy"),
        "registerFirstScreenSignupButtonTitle":
            MessageLookupByLibrary.simpleMessage("Sign Up"),
        "registerFirstScreenSmsCodeHasBeenSentNotification":
            MessageLookupByLibrary.simpleMessage(
                "Confirmation code has been sent to the provided phone number"),
        "registerFirstScreenTitle":
            MessageLookupByLibrary.simpleMessage("Registration"),
        "registerFirstScreenUserAgreement1":
            MessageLookupByLibrary.simpleMessage(
                "By clicking “Sign Up”, I agree to the"),
        "registerFirstScreenUserAgreement2":
            MessageLookupByLibrary.simpleMessage("User Agreement"),
        "registerFirstScreenUserAgreement3":
            MessageLookupByLibrary.simpleMessage(
                "and processing of my personal data under the terms of the"),
        "registerFirstScreenUserAgreement4":
            MessageLookupByLibrary.simpleMessage("Privacy Policy"),
        "registerSecondScreenFinishRegistrationButtonTitle":
            MessageLookupByLibrary.simpleMessage("Finish Registration"),
        "registerSecondScreenSmsCodeHasBeenSentToPhone": m16,
        "registerSecondScreenSmsCodeLabel":
            MessageLookupByLibrary.simpleMessage("SMS Code"),
        "registerSecondScreenSuccessful": MessageLookupByLibrary.simpleMessage(
            "You have successfully registered!"),
        "registerSecondScreenTitle":
            MessageLookupByLibrary.simpleMessage("Registration Completion"),
        "registrationSuccess":
            MessageLookupByLibrary.simpleMessage("Registration was successful"),
        "rejection": MessageLookupByLibrary.simpleMessage("Rejection"),
        "rejectionReason":
            MessageLookupByLibrary.simpleMessage("Reasons for rejection"),
        "reportAlreadyGotToWork": MessageLookupByLibrary.simpleMessage(
            "The report has already been taken over by another Contractor"),
        "reportRejectedSuccess":
            MessageLookupByLibrary.simpleMessage("Report rejected"),
        "reportWasDelegatedToChosenContractor":
            MessageLookupByLibrary.simpleMessage(
                "Report was delegated to the selected Contractor"),
        "required": MessageLookupByLibrary.simpleMessage("required"),
        "review": MessageLookupByLibrary.simpleMessage("Review"),
        "reviewOrTaskCanNotBeCreatedWithoutAvailableArticles":
            MessageLookupByLibrary.simpleMessage(
                "Without available Objects it is impossible to create a check or task"),
        "reviewStepsCreateScreenCreate":
            MessageLookupByLibrary.simpleMessage("Create"),
        "reviewStepsCreateScreenDescription":
            MessageLookupByLibrary.simpleMessage("Brief Description"),
        "reviewStepsCreateScreenDocumentScan":
            MessageLookupByLibrary.simpleMessage("Scan Document"),
        "reviewStepsCreateScreenFile":
            MessageLookupByLibrary.simpleMessage("File"),
        "reviewStepsCreateScreenName":
            MessageLookupByLibrary.simpleMessage("Name"),
        "reviewStepsCreateScreenNewStep":
            MessageLookupByLibrary.simpleMessage("Create a New Step"),
        "reviewStepsCreateScreenPhoto":
            MessageLookupByLibrary.simpleMessage("Photo"),
        "reviewStepsCreateScreenVideo":
            MessageLookupByLibrary.simpleMessage("Video"),
        "reviewTemplate":
            MessageLookupByLibrary.simpleMessage("Review Template"),
        "reviewTemplateFormStepScreenChooseData":
            MessageLookupByLibrary.simpleMessage("Date Selection"),
        "reviewTemplateFormStepScreenDatePickerCancelText":
            MessageLookupByLibrary.simpleMessage("Cancel"),
        "reviewTemplateFormStepScreenDropdownHintText":
            MessageLookupByLibrary.simpleMessage("Select an answer option"),
        "reviewTemplateFormStepScreenEmptyDropdown":
            MessageLookupByLibrary.simpleMessage("No values available"),
        "reviewTemplateFormStepScreenRequiredInputValidation":
            MessageLookupByLibrary.simpleMessage("Required field"),
        "reviewTemplateFormStepScreenSaveButtonTitle":
            MessageLookupByLibrary.simpleMessage("Save"),
        "reviews": MessageLookupByLibrary.simpleMessage("Reviews"),
        "reviewsModalInfoLaterButton":
            MessageLookupByLibrary.simpleMessage("Later"),
        "reviewsModalInfoRedirectButton":
            MessageLookupByLibrary.simpleMessage("Go"),
        "save": MessageLookupByLibrary.simpleMessage("Save"),
        "search": MessageLookupByLibrary.simpleMessage("Search"),
        "sectionName": MessageLookupByLibrary.simpleMessage("Section name"),
        "selectAnAction":
            MessageLookupByLibrary.simpleMessage("Select an action"),
        "selfContractorCreationIsImpossible": MessageLookupByLibrary.simpleMessage(
            "Self-creation of an contractor is not available according to administrator settings."),
        "sendForApproval":
            MessageLookupByLibrary.simpleMessage("Send for Approval"),
        "sending": MessageLookupByLibrary.simpleMessage("Sending"),
        "showAll": MessageLookupByLibrary.simpleMessage("Show All"),
        "signReviewDescription": MessageLookupByLibrary.simpleMessage(
            "By clicking the \'Submit\' button, you confirm the relevance, accuracy, and compliance of the information provided in the review."),
        "signReviewTitle": MessageLookupByLibrary.simpleMessage(
            "Signing Review with Simple Electronic Signature"),
        "specifyNewStepName": MessageLookupByLibrary.simpleMessage(
            "Specify a new name for the step"),
        "startOfExecution":
            MessageLookupByLibrary.simpleMessage("Start of Execution"),
        "startReviewWithoutInitialLocation": MessageLookupByLibrary.simpleMessage(
            "At the moment, the location could not be determined. Attempts will be made during the Review process."),
        "stepInfo": MessageLookupByLibrary.simpleMessage("Step Information"),
        "stepType": MessageLookupByLibrary.simpleMessage("Step Type"),
        "stepsCompleted":
            MessageLookupByLibrary.simpleMessage("Steps completed"),
        "switchToSignIn":
            MessageLookupByLibrary.simpleMessage("Switch to authorization"),
        "task": MessageLookupByLibrary.simpleMessage("Task"),
        "taskAddress": MessageLookupByLibrary.simpleMessage("Task Address"),
        "taskCreatedSuccessfully":
            MessageLookupByLibrary.simpleMessage("Task Created Successfully"),
        "taskDetailErrorFailedTitle": MessageLookupByLibrary.simpleMessage(
            "Loading Error, please try again later"),
        "taskExecutionDeleteFileDialogContent":
            MessageLookupByLibrary.simpleMessage(
                "Are you sure you want to delete the file?\n\nThis action is irreversible."),
        "taskExecutionDescriptionTitle":
            MessageLookupByLibrary.simpleMessage("Description:"),
        "taskExecutionFinishButtonTitle":
            MessageLookupByLibrary.simpleMessage("Finish"),
        "taskExecutionNotAllConditionsCompleted":
            MessageLookupByLibrary.simpleMessage(
                "To complete the task, you need to go through the mandatory steps"),
        "taskExecutionScreenTakeDocumentButtonTitle":
            MessageLookupByLibrary.simpleMessage("Scan Document"),
        "taskExecutionScreenTakeFileButtonTitle":
            MessageLookupByLibrary.simpleMessage("Select File"),
        "taskExecutionScreenTakePhotoButtonTitle":
            MessageLookupByLibrary.simpleMessage("Take Photo"),
        "taskExecutionScreenTakeVideoButtonTitle":
            MessageLookupByLibrary.simpleMessage("Record Video"),
        "taskExecutionStepDetailDescriptionTitle":
            MessageLookupByLibrary.simpleMessage("Description"),
        "taskExecutionStepDetailPhotoExampleTitle":
            MessageLookupByLibrary.simpleMessage("Photo Example"),
        "taskInfoRefuseButtonTitle":
            MessageLookupByLibrary.simpleMessage("Refuse"),
        "taskInfoScreenAddressTitle":
            MessageLookupByLibrary.simpleMessage("Task Address"),
        "taskInfoScreenArticleTitle":
            MessageLookupByLibrary.simpleMessage("Object"),
        "taskInfoScreenChangeButtonTitle":
            MessageLookupByLibrary.simpleMessage("Edit"),
        "taskInfoScreenDescriptionTitle":
            MessageLookupByLibrary.simpleMessage("Description"),
        "taskInfoScreenExecuteButtonTitle":
            MessageLookupByLibrary.simpleMessage("Execute"),
        "taskInfoScreenFinishDateLimitTitle":
            MessageLookupByLibrary.simpleMessage("Due Date"),
        "taskInfoScreenTakeToWorkButtonTitle":
            MessageLookupByLibrary.simpleMessage("Take to Work"),
        "taskType": MessageLookupByLibrary.simpleMessage("Task Type"),
        "tasks": MessageLookupByLibrary.simpleMessage("Tasks"),
        "tasksRowFinishExecutionAt": m17,
        "tasksRowStartExecutionAt": m18,
        "tasksScreenAppBarTitle": MessageLookupByLibrary.simpleMessage("Tasks"),
        "tasksScreenErrorTitle": MessageLookupByLibrary.simpleMessage(
            "Loading Error, please try again later"),
        "tasksScreenFastFilterAssignedStatusTitle":
            MessageLookupByLibrary.simpleMessage("Assigned"),
        "tasksScreenFastFilterAtWorkStatusTitle":
            MessageLookupByLibrary.simpleMessage("In Progress"),
        "tasksScreenFastFilterCompletedStatusTitle":
            MessageLookupByLibrary.simpleMessage("Completed"),
        "tasksScreenFastFilterOnInspectionStatusTitle":
            MessageLookupByLibrary.simpleMessage("On Confirmation"),
        "tasksScreenFastFilterRejectedStatusTitle":
            MessageLookupByLibrary.simpleMessage("Rejected"),
        "tasksScreenTabAvailableTitle":
            MessageLookupByLibrary.simpleMessage("Available"),
        "tasksScreenTabMyTasksTitle":
            MessageLookupByLibrary.simpleMessage("My Tasks"),
        "toDelegate": MessageLookupByLibrary.simpleMessage("Delegate"),
        "toMain": MessageLookupByLibrary.simpleMessage("Go to main"),
        "toNextStepButtonTitle": MessageLookupByLibrary.simpleMessage("Next"),
        "tryAgain": MessageLookupByLibrary.simpleMessage("Try again"),
        "turnOnGPS": MessageLookupByLibrary.simpleMessage("Turn on GPS"),
        "turnOnLocationServices": MessageLookupByLibrary.simpleMessage(
            "Turn on HMS Core location services"),
        "unexpectedException": MessageLookupByLibrary.simpleMessage(
            "An unexpected error occurred"),
        "uploadsScreenEntiyActionAttachCommentsTitle":
            MessageLookupByLibrary.simpleMessage("Comments"),
        "uploadsScreenEntiyActionAttachViolationsTitle":
            MessageLookupByLibrary.simpleMessage("Violations"),
        "uploadsScreenEntiyActionDeletingFilesTitle":
            MessageLookupByLibrary.simpleMessage("Deleting Files"),
        "uploadsScreenEntiyActionLocationUploadTitle":
            MessageLookupByLibrary.simpleMessage("Location"),
        "uploadsScreenEntiyActionReviewFinishTitle":
            MessageLookupByLibrary.simpleMessage("Review Completion"),
        "uploadsScreenEntiyActionReviewInterruptTitle":
            MessageLookupByLibrary.simpleMessage("Review Interruption"),
        "uploadsScreenEntiyActionReviewStoreTitle":
            MessageLookupByLibrary.simpleMessage("Review Creation"),
        "uploadsScreenEntiyActionStepFileUploadTitle":
            MessageLookupByLibrary.simpleMessage("File"),
        "uploadsScreenEntiyTypeLocationTitle":
            MessageLookupByLibrary.simpleMessage("Location"),
        "uploadsScreenEntiyTypeReviewTitle":
            MessageLookupByLibrary.simpleMessage("Review"),
        "uploadsScreenEntiyTypeStepFileTitle":
            MessageLookupByLibrary.simpleMessage("File"),
        "uploadsScreenIdHasBeenCopiedMessage": m19,
        "uploadsScreenTitle": MessageLookupByLibrary.simpleMessage("Uploads"),
        "uploadsScreenUploadsScreenIsEmpty":
            MessageLookupByLibrary.simpleMessage("The upload list is empty"),
        "userAgreementAndPrivacyPolicy": MessageLookupByLibrary.simpleMessage(
            "User Agreement and Privacy Policy"),
        "videoProcessing":
            MessageLookupByLibrary.simpleMessage("Video Processing"),
        "waitCreationArticlesOr": MessageLookupByLibrary.simpleMessage(
            "Wait for Objects to be added or "),
        "waitForTheirAppointmentOr": MessageLookupByLibrary.simpleMessage(
            "Wait for their assignment or\n"),
        "waitForVerification":
            MessageLookupByLibrary.simpleMessage("Wait for verification"),
        "youAreNotLinkedToAnyCompany": MessageLookupByLibrary.simpleMessage(
            "You’re not tied to any company"),
        "youCanSpecifyNameCopiedSteps": MessageLookupByLibrary.simpleMessage(
            "You can specify the name of the copied steps in the review step itself"),
        "youWillGetMessageWithPassword": MessageLookupByLibrary.simpleMessage(
            "To login to the app you will receive a message with a password"),
        "youWillGetPasswordAfterVerification": MessageLookupByLibrary.simpleMessage(
            "After confirmation of your account you will receive a message with password for authorization")
      };
}
