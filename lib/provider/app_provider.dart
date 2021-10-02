import 'package:festtask/models/description.dart';
import 'package:flutter/material.dart';

class AppProvider extends ChangeNotifier {
  List<Description> _items = <Description>[
    Description("Yemek"),
    Description("Yemek Yapma"),
    Description("Bulaşık Yıkama"),
    Description("Çalışma"),
    Description("Tanışma"),
    Description("Bisiklet"),
    Description("Diş Fırçalama"),
    Description("Otobüs"),
    Description("Kahve İçme"),
    Description("Telefon Görüşmesi"),
    Description("Oyun Oynama"),
    Description("Ev Temizliği"),
    Description("Konser"),
    Description("Hastane Randevusu"),
    Description("Çizim"),
    Description("Aile Zamanı"),
    Description("Bahçe"),
    Description("Ders"),
    Description("Gym"),
    Description("Okuma"),
    Description("Dil Öğrenme"),
    Description("Hazırlanma"),
    Description("Programlama"),
    Description("Alışveriş"),
    Description("Uyku"),
    Description("Öğrenme"),
    Description("Etkinlik"),
    Description("Yürüme"),
    Description("Yazma"),
  ]..sort((a, b) => a.desc.compareTo(b.desc));
  Description _selectedItem;
  List<Description> get items => _items;
  Description get selectedItem => _selectedItem;
  bool _notification = true;
  bool get notification => _notification;
  bool _routineIsFinish;
  bool get routineIsFinish => _routineIsFinish;
  TimeOfDay _time = TimeOfDay.now();
  TimeOfDay get time => _time;
  DateTime _dateTime = DateTime.now();
  get dateTime => _dateTime;
  void setSelectedItem(Description s) {
    _selectedItem = s;
    notifyListeners();
  }

  void setTime(TimeOfDay t) {
    _time = t;
    notifyListeners();
  }

  void setDateTime(DateTime d) {
    _dateTime = d;
    notifyListeners();
  }

  Future<void> setRoutineIsFinish(bool s) async {
    _routineIsFinish = s;
    notifyListeners();
  }

  Future<void> setNotification(bool s) async {
    _notification = s;
    notifyListeners();
  }

  int _nvCurrentIndex = 0;
  int get nvCurrentIndex => _nvCurrentIndex;
  bool _showBottomSheet = true;
  get showBottomSheet => _showBottomSheet;
  bool _extended = false;
  get extended => _extended;
  int _bottomCurrentIndex = 0;
  get bottomCurrentIndex => _bottomCurrentIndex;

  set bottomCurrentIndex(int i) {
    _bottomCurrentIndex = i;
    notifyListeners();
  }

  void setShowBottomSheet(bool s) {
    _showBottomSheet = s;
    notifyListeners();
  }

  void notiNvCurrentIndex(int index) {
    _nvCurrentIndex = index;
    notifyListeners();
  }

  set extended(bool extended) {
    _extended = !extended;
    notifyListeners();
  }
}
