import 'package:permission_handler/permission_handler.dart';

class PermissionHelper {
  static Future<bool> requestPermissions() async {
    final micStatus = await Permission.microphone.request();
    final storageStatus = await Permission.storage.request();

    // لو كنت تستهدف Android 11 أو أعلى:
    final manageStorageStatus =
        await Permission.manageExternalStorage.request();

    return micStatus.isGranted &&
        (storageStatus.isGranted || manageStorageStatus.isGranted);
  }
}
