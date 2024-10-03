class AsyncUtils {
  static Future<T?> safeExecute<T>(Future<T> Function() action, {Function? onError}) async {
    try {
      return await action();
    } catch (e) {
      if (onError != null) {
        onError(e);
      }
      return null;
    }
  }

  static Future<void> delayExecution(int milliseconds) async {
    await Future.delayed(Duration(milliseconds: milliseconds));
  }
}
