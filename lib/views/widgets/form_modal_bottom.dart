import 'package:flutter/material.dart';

/// Menampilan ModalBottomSheet.
///
/// Digunakan untuk form tambah atau edit pada task maupun note
void showFormModalBottom(BuildContext context, Widget showWidget) {
  showModalBottomSheet(
    context: context,
    builder: (context) {
      return SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: showWidget,
        ),
      );
    },
    isScrollControlled: true,
  );
}
