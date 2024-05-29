import 'package:asiatic/consts/consts.dart';
import 'package:asiatic/services/firestore_services.dart';
import 'package:asiatic/views/orders_screen/orders_details.dart';
import 'package:asiatic/widgets_common/loading__indicator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class OrdersSCreen extends StatelessWidget {
  const OrdersSCreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: "My Orders".text.color(darkFontGrey).fontFamily(semibold).make(),
      ),
      body: StreamBuilder(
        stream: FirestoreServices.getAllOrders(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: loadingIndicator(),
            );
          } else if (snapshot.data!.docs.isEmpty) {
            return "No orders yet!".text.color(darkFontGrey).makeCentered();
          } else {
            var data = snapshot.data!.docs;

            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  leading: "${index + 1}"
                      .text
                      .fontFamily(bold)
                      .color(darkFontGrey)
                      .xl
                      .make(),
                  title: data[index]['order_code']
                      .toString()
                      .text
                      .color(redColor)
                      .fontFamily(semibold)
                      .make(),
                  subtitle: data[index]['total_amount']
                      .toString()
                      .numCurrency
                      .text
                      .fontFamily(bold)
                      .make(),
                  trailing: IconButton(
                      onPressed: () {
                        Get.to(() => OrdersDetails(
                              data: data[index],
                            ));
                      },
                      icon: const Icon(
                        Icons.arrow_forward_ios,
                        color: darkFontGrey,
                      )),
                );
              },
            );
          }
        },
      ),
    );
  }
}
