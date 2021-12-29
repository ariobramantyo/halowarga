import 'package:get/get.dart';
import 'package:intl/intl.dart';

class YearController extends GetxController {
  var year = int.parse(DateFormat('yyyy').format(DateTime.now())).obs;

  void increaseYear() {
    if (year.value !=
        int.parse(DateFormat('yyyy').format(DateTime.now())) + 1) {
      year++;
    }
  }

  void decreaseYear() {
    year--;
  }

  bool isMaxYear() {
    return year.value ==
        int.parse(DateFormat('yyyy').format(DateTime.now())) + 1;
  }
}
