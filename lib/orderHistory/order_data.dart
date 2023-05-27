import 'package:cloud_firestore/cloud_firestore.dart';

class Order{
  String email, id, tenDV, gia;
  int sl;
  DateTime orderDate;

  Order({
    required this.email,
    required this.id,
    required this.tenDV,
    required this.gia,
    required this.sl,
    required this.orderDate,
  });

  Map<String, dynamic> toJson() {
    return {
      'email': this.email,
      'id': this.id,
      'tenDV': this.tenDV,
      'gia': this.gia,
      'sl': this.sl,
      'orderDate': this.orderDate,
    };
  }

  factory Order.fromJson(Map<String, dynamic> map) {
    return Order(
      email: map['email'] as String,
      id: map['id'] as String,
      tenDV: map['tenDV'] as String,
      gia: map['gia'] as String,
      sl: map['sl'] as int,
      orderDate: map['orderDate'] as DateTime,
    );
  }
}

class OrderSnapshot{
  Order? order;
  DocumentReference? documentReference;

  OrderSnapshot({
    required this.order,
    required this.documentReference,
  });

  factory OrderSnapshot.fromSnapshot(DocumentSnapshot docSnapOrder) {
    return OrderSnapshot(
      order: Order.fromJson(docSnapOrder.data() as Map<String, dynamic>),
      documentReference: docSnapOrder.reference,
    );
  }

  static Future<DocumentReference> datHang(Order order) async{
    return  FirebaseFirestore.instance.collection("Order").add(order.toJson());
  }

  static Stream<List<OrderSnapshot>> listOrder(){
    Stream<QuerySnapshot> streamQS = FirebaseFirestore.instance.collection("Order")
        .snapshots();
    Stream<List<DocumentSnapshot>> streamListDocSnap = streamQS.map(
            (queryInfo) => queryInfo.docs);
    return streamListDocSnap.map((listDS) => listDS.map((ds) => OrderSnapshot.fromSnapshot(ds)).toList()
    );
  }
}