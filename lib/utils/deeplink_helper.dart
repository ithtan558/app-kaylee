import 'package:anth_package/anth_package.dart';
import 'package:kaylee/models/models.dart' as models;
import 'package:kaylee/screens/screens.dart';

class DeepLinkHelper {
  DeepLinkHelper._();

  static PageIntent? handleLink({String? link}) {
    if (link?.isNotEmpty ?? false) {
      final uri = Uri.tryParse(link!);
      if (uri != null) {
        if (uri.path == '/supplier/order/detail') {
          final orderId = int.tryParse(uri.queryParameters['order_id'] ?? '');
          if (orderId != null) {
            return PageIntent(
              screen: MyOrderDetailScreen,
              bundle: Bundle(
                models.Order(id: orderId),
              ),
            );
          }
        } else if (uri.path == '/product/detail') {
          final productId =
              int.tryParse(uri.queryParameters['product_id'] ?? '');
          final supplierId =
              int.tryParse(uri.queryParameters['supplier_id'] ?? '');
          if (productId != null && supplierId != null) {
            return PageIntent(
              screen: SupplierProductDetailScreen,
              bundle: Bundle(
                SupplierProductDetailScreenData(
                  product: models.Product(id: productId),
                  supplier: models.Supplier(id: supplierId),
                  openFrom: ProductDetailScreenOpenFrom.notification,
                ),
              ),
            );
          }
        } else if (uri.path == '/notification/detail') {
          final notificationId =
              int.tryParse(uri.queryParameters['notification_id'] ?? '');
          if (notificationId != null) {
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
        } else if (uri.path == '/supplier') {
          final supplierId =
              int.tryParse(uri.queryParameters['supplier_id'] ?? '');
          if (supplierId != null) {
            return PageIntent(
              screen: SupplierProdListScreen,
              bundle: Bundle(models.Supplier(id: supplierId)),
            );
          }
        }
        if (uri.path == '/account/huong-dan-su-dung') {
          return PageIntent(
            screen: GuideScreen,
          );
        }
      }
    }
    return null;
  }

  ///[ifNOtFound]: khi [link] ko xác định đc trang cần navigate tới => return screen đc chỉ định
  static PageIntent? handleNotificationLink(
      {String? link, PageIntent? ifNOtFound}) {
    return handleLink(link: link) ?? ifNOtFound;
  }
}
