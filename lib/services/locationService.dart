import 'package:flutter/material.dart';

class LocationService extends ChangeNotifier {
  String location = "Hyderabad";
  int choice = 0;
  bool sortChoice = true;
  setLocation(String newLocation) {
    location = newLocation;
    notifyListeners();
  }

  setChoice(int newChoice) {
    choice = newChoice;
    notifyListeners();
  }

  setSortChoice(bool newSortChoice) {
    sortChoice = newSortChoice;
    notifyListeners();
  }
}
