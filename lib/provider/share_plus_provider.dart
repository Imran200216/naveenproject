import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

class ShareProvider with ChangeNotifier {
  bool _isLoading = false;
  String? _errorMessage;

  bool get isLoading => _isLoading;

  String? get errorMessage => _errorMessage;

  Future<void> shareUrl(String url) async {
    try {
      _setLoading(true);
      await Share.share(url);
    } catch (e) {
      _setErrorMessage("Failed to share the URL.");
    } finally {
      _setLoading(false);
    }
  }

  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  void _setErrorMessage(String? message) {
    _errorMessage = message;
    notifyListeners();
  }
}
