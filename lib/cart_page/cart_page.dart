import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:vinpearl_app/auth.dart';
import 'package:vinpearl_app/cart_page/cart_data.dart';
import 'package:vinpearl_app/your_bill_page/order_data.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final  User? user = Auth().currentUser;

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartData>(context);
    final List<dynamic> cartItems = cartProvider.cartItems; // gọi provider và gán list để sử dụng
    double totalPrice = cartProvider.calculateTotalPrice();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Container(
            padding: EdgeInsets.only(left: 100),
            child: Text('Cart',)),
      ),
      body: ListView.builder(
        itemCount: cartItems.length,
        itemBuilder: (context, index) {
          final item = cartItems[index]; // mỗi item ở đây là 1 snapshot ( resort, restaurantt, ... )
          return Slidable(
            startActionPane: const ActionPane(
              motion: ScrollMotion(),
              children: [],
            ),
            endActionPane: ActionPane(
              motion: ScrollMotion(),
              children: [
                SlidableAction(
                  onPressed: (context) {
                    cartProvider.removeFromCart(item);
                  },
                  icon: Icons.delete_forever,
                  foregroundColor: Colors.red,
                  backgroundColor: Colors.red[50]!,
                )
              ]
            ),
            child: Container(
              padding: const EdgeInsets.all(5.0),
              margin: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                color: Colors.grey[300]
              ),
              child: Row(
                children: [
                  Container(
                    width: 150,
                    height: 100,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(30),
                      // tại vì là dynamic nên trong item sẽ nhiều kiểu khác nhau nên sẽ không truyền thẳng là item.resortService.anh[0] đc
                        // vì thằng khác vd như restaurant sẽ lỗi nên thay vào đó ta tạo hàm get lấy thông tin của mỗi kiểu ở mỗi trang
                        // data service của nó
                      child: Image.network(item.getAnh(),fit: BoxFit.cover,)),
                  ),
                  const SizedBox(width: 5,),
                  Expanded(
                    flex: 3,
                    child: Column(
                      children: [
                        Text(item.getTenDV(), style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                        ),
                        Row(
                          children: [
                            IconButton(
                              icon: const Icon(Icons.remove),
                              onPressed: () {
                                setState(() {
                                  item.decreaseQuantity(); // Decrease quantity
                                });
                              },
                            ),
                            Text(
                              item.getQuantity().toString() // giảm số lượng
                            ),
                            IconButton(
                              icon: const Icon(Icons.add),
                              onPressed: () {
                                setState(() {
                                  item.increaseQuantity(); //tăng sô lương
                                });
                              },
                            ),
                          ],
                        ),
                        Text(
                          item.getGia().toStringAsFixed(0) + " VND", // hiển thị giá của mỗi item
                          style: const TextStyle(color: Colors.orange, fontWeight: FontWeight.bold, fontSize: 15),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),

      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
        color: Colors.teal[100],
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Tổng tiền: ${totalPrice.toStringAsFixed(0)}',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            ElevatedButton(
              onPressed: () async{
                Order order = Order(
                  orders: cartItems.map((item) => OrderItem(
                    tenDV: item.getTenDV(),
                    sl: item.getQuantity(),
                    gia: totalPrice.toString(),
                    orderDate: DateTime.now(),
                  )).toList(),
                  email: user?.email,
                );

                try{
                  await OrderSnapshot.addOrderToFirebase(order);
                  cartItems.clear();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text("Đặt thành công"))
                  );
                }catch(e){
                  print('Error: $e');
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Có lỗi xảy ra. Vui lòng thử lại sau."))
                  );
                }

                // try {
                //   await OrderSnapshot.datHang(orders, user!.email!);
                //   cartItems.clear();
                //   ScaffoldMessenger.of(context).showSnackBar(
                //       const SnackBar(
                //           content: Text('Đã đặt thành công')
                //       )
                //   );
                // } catch (e) {
                //   print('Error: $e');
                //   ScaffoldMessenger.of(context).showSnackBar(
                //       SnackBar(
                //           content: Text('Có lỗi xảy ra. Vui lòng thử lại sau.')
                //       )
                //   );
                // }
              },
              child: const Text('Đặt Vé'),
              style: ElevatedButton.styleFrom(
                elevation: 10,
                backgroundColor: Colors.orange,
                shadowColor: Colors.grey,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)
                ),
                minimumSize: const Size(110, 50),
              ),
            ),

          ],
        ),
      ),
    );
  }
}