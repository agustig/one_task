import 'package:flutter/material.dart';

void showFormDialog(BuildContext context, Widget showWidget) {
  showModalBottomSheet(
    context: context,
    builder: (context) {
      return SingleChildScrollView(
        child: Container(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: showWidget,
        ),
      );
    },
    isScrollControlled: true,
  );
}
