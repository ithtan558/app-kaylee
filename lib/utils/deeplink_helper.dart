import 'package:anth_package/anth_package.dart';
import 'package:kaylee/models/models.dart';
import 'package:kaylee/screens/screens.dart';

class DeepLinkHelper {
  static PageIntent handleLink({String link}) {
    final uri = Uri.tryParse(link);
    if (uri.isNotNull) {
      if (uri.path == '/supplier/order/detail') {
        final orderId = int.tryParse(uri.queryParameters['order_id']);
        if (orderId.isNotNull) {
          return PageIntent(
            screen: MyOrderDetailScreen,
            bundle: Bundle(
              Order(id: orderId),
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
                product: Product(id: productId),
                supplier: Supplier(id: supplierId),
              ),
            ),
          );
        }
      }
    }
    return null;
  }

  ///[ifNOtFound] trả về page chỉ định khi [link] ko xác định đc trang cần navigate tới
  ///[ifNOtFound] is null => return trang [NotificationScreen]
  static PageIntent handleNotificationLink(
      {String link, PageIntent ifNOtFound}) {
    return handleLink(link: link) ??
        ifNOtFound ??
        PageIntent(screen: NotificationScreen);
  }
}
