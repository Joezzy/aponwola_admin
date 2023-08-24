
import 'package:aponwola_admin/common/SizeConfig.dart';
import 'package:aponwola_admin/common/app_theme.dart';
import 'package:aponwola_admin/controllers/order.controller.dart';
import 'package:aponwola_admin/data/order.dart';
import 'package:aponwola_admin/data/product.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class FoodDetailView extends StatefulWidget {
 const  FoodDetailView({Key? key,  required this.order}) : super(key: key);
  final OrderData order;
  @override
  State<FoodDetailView> createState() => _FoodDetailViewState();
}

class _FoodDetailViewState extends State<FoodDetailView> {

  final  orderController=Get.put(OrderController());

  bool showPassword=false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          iconTheme: const IconThemeData(color: Colors.black54),
          elevation: 0,
          centerTitle: true,
          title: const Text("Food detail",style:  TextStyle(color: Colors.black),),
        ),


        backgroundColor: AppTheme.whiteBackground,
        body: ListView(
          padding: EdgeInsets.symmetric(horizontal: MySize.size20),

          children: [
            Column(
              children: [
                Container(
                  // height: MySize.size90 * widget.order.products!.length,
                  padding: EdgeInsets.symmetric(horizontal: MySize.size20),
                  decoration: BoxDecoration(
                      color: AppTheme.primaryColor.withOpacity(0.05),
                      borderRadius: BorderRadius.circular(15)
                  ),
                  child: Column(
                    children: [
                      list("Amount","x${widget.order.subtotal!}"),
                      list("Quantity","x${widget.order.quantity!}"),
                    ],
                  ),
                ),

                const   Text("Food items" ,),
                Container(
                  decoration: BoxDecoration(
                      color: AppTheme.primaryColor.withOpacity(0.05),
                      borderRadius: BorderRadius.circular(15)
                  ),
                  height: MySize.size90 * widget.order.products!.length,
                  child: ListView.separated(
                    physics: const NeverScrollableScrollPhysics(),
                    separatorBuilder: (context, index) {
                      return const Divider(thickness: 1,);
                    },
                    itemCount: widget.order.products!.length,
                    itemBuilder: (context,index){
                      Product product=widget.order.products![index];

                      return     ListTile(

                        title: Text(product.name!),
                        subtitle: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("${AppTheme.money(product.price!)}"),
                            Text("${toBeginningOfSentenceCase(product.meal_type)}"),
                            // Text(" ${toBeginningOfSentenceCase(product.meal_type)}".toString()),
                          ],
                        ),

                      );
                    },

                  ),
                )


              ],
            ),
          ],
        )
    );
  }

  ListTile list(label,text) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(text),
      subtitle:  Text(label),
    );
  }
}
