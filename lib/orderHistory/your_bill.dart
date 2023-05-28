import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:vinpearl_app/auth.dart';
import 'package:vinpearl_app/orderHistory/order_data.dart';

// class OrderHistoryPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final user = Auth().currentUser;
//
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Lịch sử đặt vé'),
//       ),
//       body: StreamBuilder<List<OrderSnapshot>>(
//         stream: OrderSnapshot.listOrder(),
//         builder: (context, snapshot) {
//           if (!snapshot.hasData || snapshot.data!.isEmpty) {
//             return const Center(
//               child: Text('Chưa đặt vé nào.'),
//             );
//           }
//
//           return ListView.builder(
//             itemCount: snapshot.data!.length,
//             itemBuilder: (context, index) {
//               final order = snapshot.data![index].order!;
//
//               return ListTile(
//                 title: Text(order.tenDV),
//                 subtitle: Text(order.orderDate.toString()),
//                 trailing: Text(order.gia),
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
// }


class OrderHistoryPage extends StatefulWidget {
  @override
  _OrderHistoryPageState createState() => _OrderHistoryPageState();
}

class _OrderHistoryPageState extends State<OrderHistoryPage> {
  late Stream<List<OrderSnapshot>> _orderStream;

  @override
  void initState() {
    super.initState();
    _orderStream = OrderSnapshot.listOrder();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Padding(
          padding: EdgeInsets.only(left: 70),
          child: Text('Your Bill'),
        ),
      ),
      body: StreamBuilder<List<OrderSnapshot>>(
        stream: OrderSnapshot.listOrder(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: Text("Lỗi hiển thị", style: TextStyle(color: Colors.red),
              ),
            );
          }else if(!snapshot.hasData){
            return const Center(
              child: CircularProgressIndicator(),
            );
          }else{
            List<OrderSnapshot> orderList = snapshot.data!;
            return ListView.builder(
              itemCount: orderList.length,
              itemBuilder: (context, index) {
                OrderSnapshot orderSnapshot = orderList[index];
                return Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(20),
                      child: Column(
                        children: [
                          Text("id"),
                          Text("Emaill: "),
                          Text(orderSnapshot.order!.orderDate.toString()),
                          Text("Dịch vụ: //Tên dịch vụ"),
                          Text("Tổng tiền: //Tổng tiền"),
                        ],
                      ),
                    )

                  ],
                );
              },
            );
          }
        },
      ),
    );
  }
}
