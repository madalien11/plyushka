class LogOut {
  final Function deleteAll;
  LogOut({this.deleteAll});

  void logout() {
    this.deleteAll();
  }
}

class AddTokenClass {
  final Function addTokenClass;
  AddTokenClass({this.addTokenClass});

  void add() {
    this.addTokenClass();
  }
}
