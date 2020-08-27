OrderStatus parseOrderStatusFromInt(status) {
  switch (status) {
    case 1:
      return OrderStatus.ordered;
    case 2:
      return OrderStatus.waiting;
    case 3:
      return OrderStatus.finished;
    case 4:
      return OrderStatus.not_paid;
    case 5:
      return OrderStatus.cancel;
    default:
      return null;
  }
}

int parseToIntFromOrderStatus(OrderStatus status) {
  switch (status) {
    case OrderStatus.ordered:
      return 1;
    case OrderStatus.waiting:
      return 2;
    case OrderStatus.finished:
      return 3;
    case OrderStatus.not_paid:
      return 4;
    case OrderStatus.cancel:
      return 5;
    default:
      return null;
  }
}

enum OrderStatus {
  ordered,
  waiting,
  finished,
  not_paid,
  cancel,
}
