import 'package:flutter/foundation.dart';

class User {
  final String firstName;
  final String lastName;
  final Uint8List photo;
  final String password;
  final List<String> nfcTags;

  const User(
      this.firstName, this.lastName, this.photo, this.password, this.nfcTags);
}
