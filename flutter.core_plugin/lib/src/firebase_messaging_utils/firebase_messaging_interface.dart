abstract class FirebaseMessagingInterface {
  ///handle sau khi tap vào notification
  ///e.g: như navigate tới screen
  void onOpenNotification(Map<String, dynamic>? data);
}
