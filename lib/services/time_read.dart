import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TimeRead {
  static Text show({required DateTime dateTime, TextStyle? style, String? label}) {
    final timeNow = DateTime.now();
    final stringLabel = (label != null )? '$label: ' : ''; 
    // const style = TextStyle(color: Colors.black54, fontSize: 13);
    if (timeNow.year == dateTime.year) {
      if (timeNow.month == dateTime.month && timeNow.day == dateTime.day) {
        return Text('$stringLabel'
          '${DateFormat('hh:mm a').format(dateTime)}',
          style: style,
        );
      } else {
        return Text('$stringLabel'
          '${DateFormat.MMMMd('id_ID').format(dateTime)}',
          style: style,
        );
      }
    } else {
      return Text('$stringLabel'
        '${DateFormat.yMMMMd('id_ID').format(dateTime)}',
        style: style,
      );
    }
  }
}
