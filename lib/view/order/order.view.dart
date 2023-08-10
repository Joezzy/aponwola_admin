

import 'package:aponwola_admin/common/SizeConfig.dart';
import 'package:aponwola_admin/common/app_theme.dart';
import 'package:aponwola_admin/controllers/auth.controller.dart';
import 'package:aponwola_admin/controllers/order.controller.dart';
import 'package:aponwola_admin/custom_widget/btn.dart';
import 'package:aponwola_admin/custom_widget/txt.dart';
import 'package:aponwola_admin/data/order.dart';
import 'package:aponwola_admin/routes/app.routes.dart';
import 'package:aponwola_admin/view/order/orderDetail.view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class OrderView extends StatefulWidget {
  OrderView({Key? key}) : super(key: key);

  @override
  State<OrderView> createState() => _OrderViewState();
}

class _OrderViewState extends State<OrderView> {

  final  orderController=Get.put(OrderController());

  bool showPassword=false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    orderController.getOrders(context);

  }
  @override
  Widget build(BuildContext context) {
    return  GetX<OrderController>(
      builder: (orderController) {
        return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              iconTheme: const IconThemeData(color: Colors.black54),
              elevation: 0,
              centerTitle: true,
              title: const Text("Orders",style: TextStyle(color: Colors.black),),
            ),


            backgroundColor: AppTheme.whiteBackground,
          body: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: MySize.screenHeight,
                  child: ListView.builder(
                    padding: EdgeInsets.symmetric(horizontal: MySize.size23),
                    itemCount: orderController.orderList.length,
                    itemBuilder: (context,index){
                      OrderGroup order=orderController.orderList[index];
                      return   Container(
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        decoration:  BoxDecoration(
                            color: AppTheme.primaryColor.withOpacity(0.05),
                          borderRadius: BorderRadius.circular(15)
                        ),
                        child: ListTile(
                          title: Text(order.id!),
                          subtitle: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Amount: ${AppTheme.money(order.order!.first!.total!)}"),
                              Text("Quantity: ${order.order!.first!.quantity!}".toString()),
                            ],
                          ),

                          trailing: InkWell(
                              onTap: (){
                                // productController.deleteProduct(product.id!);
                              },
                              child:const  Icon(MdiIcons.close,color: Colors.red,)),
                          onTap: (){
                            Navigator.of(context, rootNavigator: true).push(
                              MaterialPageRoute(
                                  builder: (BuildContext context) => OrderDetailView(orderGroup: order)),);
                          },
                        ),
                      );
                    },


                  ),
                )

              ],
            ),
          )
        );
      }
    );
  }
}
