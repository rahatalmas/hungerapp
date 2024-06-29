class Ordermodel {
  int orderId;
  int orderedUserId;
  int orderedFoodId;
  int quantity;
  bool orderStatus;

  Ordermodel({
    required this.orderId,
    required this.orderedUserId,
    required this.orderedFoodId,
    required this.quantity,
    required this.orderStatus,
  });

  factory Ordermodel.fromJson(Map<String, dynamic> json) => Ordermodel(
        orderId: json['order_id'],
        orderedUserId: json['ordered_user_id'],
        orderedFoodId: json['ordered_food_id'],
        quantity: json['quantity'],
        orderStatus: json['order_status'],
      );

  Map<String, dynamic> toJson() => {
        'order_id': orderId,
        'ordered_user_id': orderedUserId,
        'ordered_food_id': orderedFoodId,
        'quantity': quantity,
        'order_status': orderStatus,
      };
}

