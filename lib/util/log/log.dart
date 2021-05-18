import 'package:flutter/cupertino.dart';
import 'package:logging/logging.dart';

class Log {
  static Logger? _logger;

  static void init() {
    Logger.root.level = Level.ALL;
    Logger.root.onRecord.listen((LogRecord rec) {
      debugPrint('${rec.level.name}: ${rec.time}: ${rec.message}');
    });
    _logger ??= Logger('LOGGER NAME');
  }

  static void info(dynamic message, [Object? error, StackTrace? stackTrace]) =>
      _logger!.log(Level.INFO, message, error, stackTrace);

  // static void warning(dynamic message, [Object error, StackTrace stackTrace]) =>
  //     _logger.log(Level.WARNING, message, error, stackTrace);

  // static void config(dynamic message, [Object error, StackTrace stackTrace]) =>
  //     _logger.log(Level.CONFIG, message, error, stackTrace);

  // static void finest(dynamic message, [Object error, StackTrace stackTrace]) =>
  //     _logger.log(Level.FINEST, message, error, stackTrace);

  // static void finer(dynamic message, [Object error, StackTrace stackTrace]) =>
  //     _logger.log(Level.FINER, message, error, stackTrace);

  // static void fine(dynamic message, [Object error, StackTrace stackTrace]) =>
  //     _logger.log(Level.FINE, message, error, stackTrace);

  // static void severe(dynamic message, [Object error, StackTrace stackTrace]) =>
  //     _logger.log(Level.SEVERE, message, error, stackTrace);

  // static void shout(dynamic message, [Object error, StackTrace stackTrace]) =>
  //     _logger.log(Level.SHOUT, message, error, stackTrace);
}
