import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:delightful_toast/delight_toast.dart';
import 'package:delightful_toast/toast/components/toast_card.dart';
import 'package:delightful_toast/toast/utils/enums.dart';
import 'package:empprojectdemo/constants/colors.dart';
import 'package:empprojectdemo/modals/AdminTaskSchedultModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class AdminTaskProvider extends ChangeNotifier {
  final PageController _pageController = PageController();

  PageController get pageController => _pageController;

  final TextEditingController taskNameController = TextEditingController();
  final TextEditingController taskAssignedPersonController =
      TextEditingController();
  final TextEditingController taskGivenPersonController =
      TextEditingController();
  final TextEditingController startDateTimeController = TextEditingController();
  final TextEditingController dueDateTimeController = TextEditingController();

  final ImagePicker _picker = ImagePicker();
  final List<XFile> _selectedImages = [];

  List<XFile> get selectedImages => _selectedImages;

  Future<void> selectDate(
      BuildContext context, TextEditingController controller) async {
    final DateTime? date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1980),
      lastDate: DateTime(2500),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData().copyWith(
            dialogBackgroundColor: AppColors.whiteColor,
          ),
          child: child!,
        );
      },
    );

    if (date != null) {
      final formattedDate = DateFormat("dd MMM yyyy").format(date);
      controller.text = formattedDate.toString();
      notifyListeners();
    }
  }

  Future<void> pickImages() async {
    try {
      final List<XFile>? images = await _picker.pickMultiImage();
      if (images != null) {
        _selectedImages.addAll(images);
        notifyListeners();
      }
    } catch (e) {
      print('Failed to pick images: $e');
    }
  }

  Future<List<String>> uploadImages() async {
    List<String> imageUrls = [];
    try {
      final storage = FirebaseStorage.instance;
      for (XFile image in _selectedImages) {
        final file = File(image.path);
        final fileName = path.basename(file.path);
        final storageRef = storage.ref().child('task_images/$fileName');

        await storageRef.putFile(file);
        final downloadUrl = await storageRef.getDownloadURL();
        imageUrls.add(downloadUrl);
      }
    } catch (e) {
      print('Failed to upload images: $e');
    }
    return imageUrls;
  }

  final CollectionReference _tasksCollection =
      FirebaseFirestore.instance.collection('adminTaskScheduleToEmployee');

  Future<void> addTaskToEmployees(BuildContext context) async {
    try {
      final DateTime startDate =
          DateFormat("dd MMM yyyy").parse(startDateTimeController.text.trim());
      final DateTime dueDate =
          DateFormat("dd MMM yyyy").parse(dueDateTimeController.text.trim());

      final imageUrls = await uploadImages();

      AdminTaskScheduleModel newTask = AdminTaskScheduleModel(
        taskName: taskNameController.text.trim(),
        taskAssignedPerson: taskAssignedPersonController.text.trim(),
        taskGivenPerson: taskGivenPersonController.text.trim(),
        taskStartedDate: Timestamp.fromDate(startDate),
        taskDueDate: Timestamp.fromDate(dueDate),
        taskImages: imageUrls,
      );

      await _tasksCollection.add(newTask.toMap()).then((value) {
        taskNameController.clear();
        taskAssignedPersonController.clear();
        taskGivenPersonController.clear();
        startDateTimeController.clear();
        dueDateTimeController.clear();
        _selectedImages.clear();

        DelightToastBar(
          position: DelightSnackbarPosition.top,
          autoDismiss: true,
          snackbarDuration: const Duration(seconds: 5),
          builder: (context) => ToastCard(
            color: AppColors.successToastColor,
            leading: SvgPicture.asset(
              "assets/images/svg/auth-success-icon.svg",
              height: 28,
              width: 28,
              fit: BoxFit.cover,
              color: AppColors.whiteColor,
            ),
            title: Text(
              "Task added to the database!",
              style: GoogleFonts.montserrat(
                fontWeight: FontWeight.w600,
                fontSize: 14,
                color: AppColors.whiteColor,
              ),
            ),
          ),
        ).show(context);
      });

      notifyListeners();
    } catch (e) {
      print('Failed to add task: $e');

      DelightToastBar(
        position: DelightSnackbarPosition.top,
        autoDismiss: true,
        snackbarDuration: const Duration(seconds: 5),
        builder: (context) => ToastCard(
          color: AppColors.failureToastColor,
          leading: SvgPicture.asset(
            "assets/images/svg/auth-error-icon.svg",
            height: 28,
            width: 28,
            fit: BoxFit.cover,
            color: AppColors.whiteColor,
          ),
          title: Text(
            "Failed to add task. Please try again.",
            style: GoogleFonts.montserrat(
              fontWeight: FontWeight.w600,
              fontSize: 14,
              color: AppColors.whiteColor,
            ),
          ),
        ),
      ).show(context);
    }
  }

  final List<AdminTaskScheduleModel> _tasks = [];

  List<AdminTaskScheduleModel> get tasks => _tasks;

  Future<List<AdminTaskScheduleModel>> fetchTasks() async {
    try {
      final querySnapshot = await _tasksCollection.get();
      return querySnapshot.docs
          .map((doc) => AdminTaskScheduleModel.fromMap(
              doc.data() as Map<String, dynamic>))
          .toList();
    } catch (e) {
      print('Failed to fetch tasks: $e');
      return [];
    }
  }

  List<Widget> get pageViewItems {
    final List<Widget> items = [
      DottedBorder(
        dashPattern: const [6, 6],
        borderType: BorderType.RRect,
        radius: const Radius.circular(12),
        padding: const EdgeInsets.all(6),
        color: AppColors.subTitleColor,
        child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(12)),
          child: Container(
            height: 300,
            width: double.infinity,
            color: Colors.grey.shade200,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    'assets/images/svg/upload-icon.svg',
                    height: 60,
                    width: 60,
                    fit: BoxFit.cover,
                    color: AppColors.subTitleColor,
                  ),
                  const SizedBox(height: 14),
                  Text(
                    "Upload an image for the task",
                    style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.w500,
                      color: AppColors.subTitleColor,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    ];

    if (selectedImages.isNotEmpty) {
      items.addAll(
        selectedImages.map((image) => Image.file(
              File(image.path),
              height: 300,
              width: double.infinity,
              fit: BoxFit.cover,
            )),
      );
      items.add(
        DottedBorder(
          dashPattern: const [6, 6],
          borderType: BorderType.RRect,
          radius: const Radius.circular(12),
          padding: const EdgeInsets.all(6),
          color: AppColors.subTitleColor,
          child: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(12)),
            child: Container(
              height: 300,
              width: double.infinity,
              color: Colors.grey.shade200,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      'assets/images/svg/upload-icon.svg',
                      height: 60,
                      width: 60,
                      fit: BoxFit.cover,
                      color: AppColors.subTitleColor,
                    ),
                    const SizedBox(height: 14),
                    Text(
                      "Upload an image for the task",
                      style: GoogleFonts.montserrat(
                        fontWeight: FontWeight.w500,
                        color: AppColors.subTitleColor,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    }

    return items;
  }
}
