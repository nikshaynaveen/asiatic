import 'package:asiatic/consts/consts.dart';
import 'package:asiatic/controller/cart_controller.dart';
import 'package:asiatic/services/firestore_services.dart';
import 'package:asiatic/views/cart_screen/shipping_screen.dart';
import 'package:asiatic/widgets_common/loading__indicator.dart';
import 'package:asiatic/widgets_common/our_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(CartController());

    return Scaffold(
        bottomNavigationBar: SizedBox(
          height: 60,
          child: ourButton(
            color: redColor,
            onPress: () {
              Get.to(() => const ShippingDetails());
            },
            textColor: whiteColor,
            title: "Proceed to shipping",
          ),
        ),
        backgroundColor: whiteColor,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: "Shopping Cart"
              .text
              .color(darkFontGrey)
              .fontFamily(semibold)
              .make(),
        ),
        body: StreamBuilder(
            stream: FirestoreServices.getCart(currentUser!.uid),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: loadingIndicator(),
                );
              } else if (snapshot.data!.docs.isEmpty) {
                return Center(
                  child: "Cart is empty".text.color(darkFontGrey).make(),
                );
              } else {
                var data = snapshot.data!.docs;
                controller.calculate(data);
                controller.productSnapshot = data;

                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Expanded(
                          child: ListView.builder(
                              itemCount: data.length,
                              itemBuilder: (BuildContext context, int index) {
                                return ListTile(
                                  leading: Image.network(
                                    "${data[index]['img']}",
                                    width: 80,
                                    fit: BoxFit.cover,
                                  ),
                                  title:
                                      "${data[index]['title']} (x${data[index]['qty']})"
                                          .text
                                          .fontFamily(semibold)
                                          .size(16)
                                          .make(),
                                  subtitle: "${data[index]['tprice']}"
                                      .numCurrency
                                      .text
                                      .color(redColor)
                                      .fontFamily(semibold)
                                      .size(14)
                                      .make(),
                                  trailing: const Icon(
                                    Icons.delete,
                                    color: redColor,
                                  ).onTap(() {
                                    FirestoreServices.deleteDocument(
                                        data[index].id);
                                  }),
                                );
                              })),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          "Total price"
                              .text
                              .fontFamily(semibold)
                              .color(whiteColor)
                              .make(),
                          Obx(
                            () => "${controller.totalP.value}"
                                .numCurrency
                                .text
                                .fontFamily(semibold)
                                .color(redColor)
                                .make(),
                          ),
                        ],
                      )
                          .box
                          .padding(const EdgeInsets.all(12))
                          .color(lightGolden)
                          .width(context.screenWidth - 60)
                          .roundedSM
                          .make(),
                      10.heightBox,
                      // SizedBox(
                      //   width: context.screenWidth - 60,
                      //   child: ourButton(
                      //     color: redColor,
                      //     onPress: () {},
                      //     textColor: whiteColor,
                      //     title: "Proceed to shipping",
                      //   ),
                      // ),
                    ],
                  ),
                );
              }
            }));
  }
}
