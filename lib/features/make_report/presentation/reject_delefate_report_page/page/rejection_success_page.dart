import 'package:flutter/material.dart';
import 'package:leasing_company/core/presentation/widgets/success_operation_widget.dart';
import 'package:leasing_company/generated/l10n.dart';

class RejectionSuccessPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushNamed(context, '/home');
        return false;
      },
      child: SuccessOperationWidget(
          automaticallyImplyLeading: false,
          headLineText: S().rejection,
          successText: S().reportRejectedSuccess,
          infoText: S().dataTransferredToResponsible,
          buttonText: S().goToReportsNavigation,
          onPressed: () =>
              Navigator.popUntil(context, ModalRoute.withName('/home'))),
    );
  }
}
