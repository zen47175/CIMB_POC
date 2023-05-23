import 'dart:developer';

import 'package:get_storage/get_storage.dart';

final GetStorage authBox = GetStorage();

bool isSignedIn = authBox.read('isSignedIn') ?? false;

void signIn() {
  authBox.write('isSignedIn', true);
  log('Keep Logger');
  isSignedIn = true;
}

void signOut() {
  authBox.write('isSignedIn', false);
  log('Delete Logger');
  isSignedIn = false;
}
