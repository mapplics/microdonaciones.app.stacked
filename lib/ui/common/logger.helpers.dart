import 'dart:developer' as developer;
import 'package:flutter/material.dart';
import 'package:microdonations/ui/common/app_colors.dart';
import 'package:microdonations/ui/common/app_theme.dart';

enum _LogType {
  info,
  warning,
  error,
  success,
}

class _LogEntry {
  final Object obj;
  final _LogType type;
  final String functionCall;
  late DateTime _at;

  _LogEntry({
    required this.obj,
    required this.type,
    required this.functionCall,
  }) {
    _at = DateTime.now();
  }

  DateTime get at => _at;

  String get log => '[${at.toIso8601String()}] $functionCall $obj';

  String get summary {
    if (obj is FlutterErrorDetails) {
      return (obj as FlutterErrorDetails).exception.toString();
    }

    if (type == _LogType.error) {
      return obj.toString() + ' [$functionCall]';
    }
    return obj.toString();
  }

  String get consoleColor {
    switch (type) {
      case _LogType.error:
        return '\u001b[31m';
      case _LogType.warning:
        return '\u001b[33m';
      case _LogType.success:
        return '\u001b[32m';
      case _LogType.info:
      default:
        return '\u001b[34m';
    }
  }

  Color get color {
    switch (type) {
      case _LogType.error:
        return errorColor;
      case _LogType.warning:
        return warningColor;
      case _LogType.success:
        return sucessColor;
      case _LogType.info:
      default:
        return CustomStylesTheme.secondaryColor;
    }
  }
}

final _logEntries = <_LogEntry>[];

List<_LogEntry> get logEntries => _logEntries;

void logInfo(Object obj) {
  _log(obj, _LogType.info);
}

void logWarn(Object obj) {
  _log(obj, _LogType.warning);
}

void logError(Object obj) {
  _log(obj, _LogType.error);
}

void logSucess(Object obj) {
  _log(obj, _LogType.success);
}

void _log(Object obj, _LogType type) {
  // if (ConfigHelper.isProd()) return;

  /// The trace comes with multiple lines of strings,
  /// (each line is also known as a frame),
  /// so split the trace's string by lines to get all the frames
  var frames = StackTrace.current.toString().split('\n');

  /* The first frame is the current function */
  final functionName = _getFunctionNameFromFrame(frames[2]);

  final entry = _LogEntry(obj: obj, type: type, functionCall: functionName);

  _logEntries.add(entry);

  /// Limito la cantidad de entradas para evitar memory leak
  if (_logEntries.length > 1000) _logEntries.removeAt(0);

  developer.log('${entry.consoleColor}${entry.summary}\x1B[0m');
}

String _getFunctionNameFromFrame(String frame) {
  /* To get rid off the #number thing, get the index of the first whitespace */
  var indexOfWhiteSpace = frame.indexOf(' ');

  /* Create a substring from the first whitespace index till the end of the string */
  var subStr = frame
      .substring(indexOfWhiteSpace)
      .trim()
      .replaceAll('(', '')
      .replaceAll(')', '');

  var splitted = subStr.split(' ');

  var splittedTwo = splitted.last.split(':');

  var column = splittedTwo.removeLast();
  var row = splittedTwo.removeLast();

  return "${splitted.first}:$row:$column";
}
