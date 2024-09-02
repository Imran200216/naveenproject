import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delightful_toast/delight_toast.dart';
import 'package:delightful_toast/toast/components/toast_card.dart';
import 'package:delightful_toast/toast/utils/enums.dart';
import 'package:empprojectdemo/modals/event_data_model.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:empprojectdemo/constants/colors.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class EventProvider extends ChangeNotifier {
  final TextEditingController eventNameController = TextEditingController();
  final TextEditingController eventDateController = TextEditingController();
  final TextEditingController eventOrganizerController =
      TextEditingController();
  final TextEditingController eventDurationTimeController =
      TextEditingController();

  String? selectVolunteerStatus;
  final List<String> listVolunteerStatus = ["Yes", "No"];

  /// Image picking functionality
  final ImagePicker _picker = ImagePicker();
  final List<XFile> _selectedImages = [];
  final PageController _pageController = PageController();

  List<XFile> get selectedImages => _selectedImages;

  PageController get pageController => _pageController;

  Future<void> pickImages(BuildContext context) async {
    try {
      final List<XFile>? images = await _picker.pickMultiImage();
      if (images != null) {
        _selectedImages.addAll(images);
        notifyListeners();
      }
    } catch (e) {
      print('Failed to pick images: $e');
      DelightToastBar(
        snackbarDuration: const Duration(seconds: 5),
        autoDismiss: true,
        builder: (context) => ToastCard(
          color: AppColors.failureToastColor,
          leading: Icon(
            Icons.error,
            color: AppColors.whiteColor,
            size: 28,
          ),
          title: Text(
            "Failed to pick an image!",
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

  List<Widget> get pageViewItems {
    final List<Widget> items = [];

    if (selectedImages.isNotEmpty) {
      items.addAll(
        selectedImages.map((image) => Image.file(
              File(image.path),
              height: 300,
              width: double.infinity,
              fit: BoxFit.cover,
            )),
      );
    }

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

    return items;
  }

  final CollectionReference _tasksCollection =
      FirebaseFirestore.instance.collection('organizationEvents');

  /// Save event to Firestore and upload images to Firebase Storage
  Future<void> addEvent(BuildContext context) async {
    try {
      // Upload images to Firebase Storage and get URLs
      List<String> imageUrls = await _uploadImages();

      // Create EventData object
      EventData eventData = EventData(
        eventName: eventNameController.text.trim(),
        eventDate: eventDateController.text.trim(),
        eventOrganizer: eventOrganizerController.text.trim(),
        eventDuration: eventDurationTimeController.text.trim(),
        volunteerStatus: selectVolunteerStatus ?? '',
        eventImages: imageUrls,
      );

      // Add event data to Firestore collection
      await _tasksCollection.add(eventData.toMap());

      // Show success toast
      DelightToastBar(
        position: DelightSnackbarPosition.top,
        autoDismiss: true,
        snackbarDuration: const Duration(seconds: 5),
        builder: (context) => ToastCard(
          color: AppColors.successToastColor,
          leading: Icon(
            Icons.logout,
            color: AppColors.whiteColor,
            size: 28,
          ),
          title: Text(
            "Events added successfully!",
            style: GoogleFonts.montserrat(
              fontWeight: FontWeight.w600,
              fontSize: 14,
              color: AppColors.whiteColor,
            ),
          ),
        ),
      ).show(context);

      /// clearing all the text fields
      eventNameController.clear();
      eventDurationTimeController.clear();
      eventOrganizerController.clear();
      eventDurationTimeController.clear();
      selectVolunteerStatus = "";
      selectedImages.clear();
    } catch (e) {
      print('Failed to add event: $e');
      DelightToastBar(
        snackbarDuration: const Duration(seconds: 5),
        autoDismiss: true,
        builder: (context) => ToastCard(
          color: AppColors.failureToastColor,
          leading: Icon(
            Icons.error,
            color: AppColors.whiteColor,
            size: 28,
          ),
          title: Text(
            "Event not added!",
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

  /// Upload selected images to Firebase Storage
  Future<List<String>> _uploadImages() async {
    List<String> imageUrls = [];
    for (var image in _selectedImages) {
      String fileName =
          'events/${DateTime.now().millisecondsSinceEpoch}_${image.name}';
      Reference storageRef = FirebaseStorage.instance.ref().child(fileName);
      UploadTask uploadTask = storageRef.putFile(File(image.path));
      TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => {});
      String imageUrl = await taskSnapshot.ref.getDownloadURL();
      imageUrls.add(imageUrl);
    }
    return imageUrls;
  }

  /// date picking functionality
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

  /// time picking functionality
  Future<void> selectTime(
      BuildContext context, TextEditingController controller) async {
    final TimeOfDay? time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData().copyWith(
            dialogBackgroundColor: AppColors.whiteColor,
          ),
          child: child!,
        );
      },
    );

    if (time != null) {
      final formattedTime = time.format(context);
      controller.text = formattedTime;
      notifyListeners();
    }
  }

  List<EventData> _events = [];

  List<EventData> get events => _events;

  EventProvider() {
    fetchEvents(); // Fetch events when the provider is initialized
  }

  Future<void> fetchEvents() async {
    try {
      final QuerySnapshot snapshot = await _tasksCollection.get();
      _events = snapshot.docs
          .map((doc) => EventData.fromMap(doc.data() as Map<String, dynamic>))
          .toList();
      notifyListeners(); // Notify listeners to update the UI
    } catch (e) {
      print('Failed to fetch events: $e');
      // You may want to handle this with a toast or other UI feedback
    }
  }

  final PageController _eventTaskDetailScreenPageController =
  PageController();

  PageController get eventTaskDetailScreenPageController =>
      _eventTaskDetailScreenPageController;


}
