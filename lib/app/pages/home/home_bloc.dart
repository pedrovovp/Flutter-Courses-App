import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:rxdart/rxdart.dart';

class HomeBloc extends BlocBase {

  BehaviorSubject<bool> _drawerController = BehaviorSubject<bool>();
  Sink<bool> get drawerInput => _drawerController.sink;
  Stream<bool> get drawerOutput => _drawerController.stream;

  bool showUserDetails = false;

  changeDetails() {
    showUserDetails == true ? showUserDetails=false : showUserDetails=true; 
    drawerInput.add(showUserDetails);
  }

  @override
  void dispose() {
    super.dispose();
  }
}
