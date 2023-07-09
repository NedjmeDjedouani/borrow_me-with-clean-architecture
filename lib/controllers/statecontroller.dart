import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:test_app/core/error/exceptions.dart';

class StateController extends GetxController {
  var isLoading = false.obs;
  var error = "".obs;
  Logger logger = Logger();
  Future excute(Future Function() function) async {
    try {
      error.value = "";
      isLoading.value = true;
      await function();
    } on Failure catch (e) {
      logger.e(e);
      error.value = e.message;
    } catch (e) {
      logger.e(e);
      error.value = "something went wrong";
    }
  }
}
