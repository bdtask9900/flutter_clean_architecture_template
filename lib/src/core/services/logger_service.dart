
import 'package:logger/logger.dart';

import '../constants/constants.dart';


const _productionLogging =
    String.fromEnvironment('PRODUCTION_LOGGING', defaultValue: 'false') ==
        'false';
final _logFilter =
    _productionLogging ? DevelopmentFilter() : ProductionFilter();

final loggerWithStack =
    Logger(printer: PrettyPrinter(methodCount: 3), filter: _logFilter);

final logger =
    Logger(printer: PrettyPrinter(methodCount: 0), filter: _logFilter);

DateTime? _lastTimedLog;
void loggerTimed(String message) {
  final now = DateTime.now();
  if (_lastTimedLog != null) {
    final diff = now.difference(_lastTimedLog!);
    logger.t('$message: $diff');
  } else {
    logger.t(message);
  }
  _lastTimedLog = now;
}


class LoggerService {
  void logInfo(String message) {
    print('[INFO]: $message');
  }

  void logWarning(String message) {
    print('[WARNING]: $message');
  }

  void logError(String message) {
    print('[ERROR]: $message');
  }

  void logDebug(String message) {
    if (AppConstants.DEBUG_MODE) {
      print('[DEBUG]: $message');
    }
  }
}

