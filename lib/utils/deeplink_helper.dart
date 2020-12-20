import 'package:anth_package/anth_package.dart';
import 'package:kaylee/models/models.dart' as models;
import 'package:kaylee/screens/screens.dart';

class DeepLinkHelper {
  DeepLinkHelper._();

  static PageIntent handleLink({String link}) {
    final uri = Uri.tryParse(link);
    if (uri.isNotNull) {
      if (uri.path == '/supplier/order/detail') {
        final orderId = int.tryParse(uri.queryParameters['order_id']);
        if (orderId.isNotNull) {
          return PageIntent(
            screen: MyOrderDetailScreen,
            bundle: Bundle(
              models.Order(id: orderId),
            ),
          );
        }
      } else if (uri.path == '/product/detail') {
        final productId = int.tryParse(uri.queryParameters['product_id']);
        final supplierId = int.tryParse(uri.queryParameters['supplier_id']);
        if (productId.isNotNull && supplierId.isNotNull) {
          return PageIntent(
            screen: ProductDetailScreen,
            bundle: Bundle(
              ProductDetailScreenData(
                product: models.Product(id: productId),
                supplier: models.Supplier(id: supplierId),
                openFrom: ProductDetailScreenOpenFrom.notification,
              ),
            ),
          );
        }
      } else if (uri.path == '/notification/detail') {
        final notificationId =
            int.tryParse(uri.queryParameters['notification_id']);
        if (notificationId.isNotNull) {
          return PageIntent(
            screen: NotifyDetailScreen,
            bundle: Bundle(
              models.Notification(
                id: notificationId,
                status: models.NotificationStatus.notRead,
              ),
            ),
          );
        }
      }
    }
    return null;
  }

  ///[ifNOtFound] trả về page chỉ định khi [link] ko xác định đc trang cần navigate tới
  static PageIntent handleNotificationLink(
      {String link, PageIntent ifNOtFound}) {
    return handleLink(link: link) ?? ifNOtFound;
  }
}
