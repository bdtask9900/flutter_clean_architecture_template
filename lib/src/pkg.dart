export '../main.dart';
export 'di.dart';
export 'my_app.dart';
export 'core/routes/routes.dart';
export 'features/splash/splash.dart';
export 'features/home/home.dart';
export 'features/auth/auth.dart';
export 'core/services/logger_service.dart';





const kLOGTAG = "[benemoy-Flutter]";
const kLOGENABLE = true;

printLog(dynamic data) {
  if (kLOGENABLE) {
    print("$kLOGTAG: ${data.toString()}");
    // log('benemoy:: ${data.toString()}');
  }
}

void printWrapped(String text) {
  final pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
  pattern.allMatches(text).forEach((match) => print(match.group(0)));
}
