import 'control_memo.dart';
import 'control_platform.dart';
import 'control_subscription.dart';

Future<dynamic> getAny({
  required String type,
  required String name,
}) async {
  switch (type) {
    case 'platform':
      return getPlatform(platform: name);
    case 'subscription':
      return getSubscription(serviceName: name);
    case 'memo':
      return getMemo(title: name);
    default:
      return;
  }
}
