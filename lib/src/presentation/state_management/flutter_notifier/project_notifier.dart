import 'package:flutter/cupertino.dart';

class ProjectNotifier extends ChangeNotifier {
  int _currentProject = -1;
  int get currentProject => _currentProject;
  set setCurrentProject(int project) {
    _currentProject = project;
    notifyListeners();
  }
}
