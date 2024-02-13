import 'package:nasiya_app/utils/constants.dart';
import 'package:workmanager/workmanager.dart';

callbackDispatcher() {
  Workmanager().executeTask((taskName, inputData) async {
    // await Utils.sendSms();

    final appRepository = Constants.appRepository;



    return Future.value(true);
  });
}