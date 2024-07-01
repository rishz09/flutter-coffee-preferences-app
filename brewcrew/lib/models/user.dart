class UserCustom {
  final String uid;

  UserCustom({required this.uid});
}

class UserData {
  final String uid, name, sugars;
  final int strength;

  UserData(
      {required this.uid,
      required this.name,
      required this.sugars,
      required this.strength});
}
