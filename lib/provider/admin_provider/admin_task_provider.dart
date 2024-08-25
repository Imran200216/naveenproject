import 'package:flutter/cupertino.dart';

class AdminTaskProvider extends ChangeNotifier {
  final TextEditingController taskNameController = TextEditingController();

  final TextEditingController taskAssignedPersonController =
      TextEditingController();

  final TextEditingController taskGivenPersonController =
      TextEditingController();

  final TextEditingController startDateTimeController = TextEditingController();

  final TextEditingController dueDateTimeController = TextEditingController();
}
