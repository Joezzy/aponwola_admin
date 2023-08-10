import 'package:animations/animations.dart';
import 'package:aponwola_admin/common/SizeConfig.dart';
import 'package:aponwola_admin/common/app_theme.dart';
import 'package:aponwola_admin/controllers/cartController.dart';
import 'package:aponwola_admin/controllers/product.controller.dart';
import 'package:aponwola_admin/custom_widget/btn.dart';
import 'package:aponwola_admin/custom_widget/mainProductCard.dart';
import 'package:aponwola_admin/custom_widget/productCard.dart';
import 'package:aponwola_admin/data/cart.dart';
import 'package:aponwola_admin/data/category.dart';
import 'package:aponwola_admin/data/product.dart';
import 'package:aponwola_admin/view/checkout/checkOut.view.dart';
import 'package:aponwola_admin/view/home/home.view.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartView extends StatefulWidget {
  const CartView({Key? key}) : super(key: key);

  @override
  _CartViewState createState() => _CartViewState();
}

class _CartViewState extends State<CartView> with SingleTickerProviderStateMixin{
  final cartController=Get.put(CartController());



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initMethod();
    cartController.calculateTotal();

  }



  initMethod(){

  }
  @override
  Widget build(BuildContext context) {
    return GetX<CartController>(
        builder: (cartController) {
        return Scaffold(
          backgroundColor: AppTheme.whiteBackground,
          appBar: AppBar(
            backgroundColor: Colors.white,
            iconTheme: const IconThemeData(color: Colors.black54),
            elevation: 0,
            centerTitle: true,
            title: const Text("Cart",style: TextStyle(color: Colors.black),),
          ),
          body:cartController.cartModelList.isEmpty?
                 EmptyCartWidget():
                 cartListWidget(cartController),

          bottomNavigationBar: cartController.cartModelList.isNotEmpty?
          checkOutButton(cartController):null,
        );
      }
    );
  }

  Container checkOutButton(CartController cartController) {
    return Container(
          height: MySize.size110,
          padding: const EdgeInsets.all(20),
          child:  InkWell(
            onTap: (){
              Navigator.of(context, rootNavigator: true).push(
                MaterialPageRoute(
                    builder: (BuildContext context) =>const CheckOutView()));
            },
            child: Container(
              decoration: BoxDecoration(
                  color: AppTheme.primaryColor,
                  borderRadius: BorderRadius.circular(20)
              ),
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children:  [
                const   Text("Check out",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                  Text("${AppTheme.money(cartController.totalFoodPrice.value)}",style: const TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                ],
              ),
            ),
          ),
        );
  }


  ListView cartListWidget(CartController cartController) {
    return ListView(
                padding: const EdgeInsets.all(10),
                children: <Widget>[

                  ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),

                      shrinkWrap: true,
                      itemCount: cartController.cartModelList.length,
                      itemBuilder: (context, index) {
                      CartModel cartModel= cartController.cartModelList[index];
                        // List<Product> productList= cartController.cartModelList[index];

                        return Stack(
                          children: [
                            Container(
                              padding: EdgeInsets.all( MySize.size20),
                              margin: EdgeInsets.symmetric(vertical: MySize.size10,horizontal:  MySize.size10),
                              decoration: BoxDecoration(
                                color: AppTheme.primaryColor.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Column(
                                children: [

                                  ListView.builder(
                                      physics: const NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount:cartModel.productList!.length,
                                      itemBuilder: (context, index) {
                                        Product product= cartModel.productList![index];

                                        return Column(
                                          children: [
                                            if(product.meal_type=="main")
                                            Row(
                                              children: [
                                               Row(
                                                 children: [
                                                   ClipRRect(
                                                     borderRadius: const BorderRadius.only(
                                                       topLeft: Radius.circular(10),
                                                       bottomLeft: Radius.circular(10),
                                                     ),
                                                     child: CachedNetworkImage(
                                                       imageUrl: product.meal_type=="main"? product.image!:"",
                                                       height: MySize.size50,
                                                       width: MySize.size50,
                                                       fit: BoxFit.cover,
                                                     ),
                                                   ),
                                                   Container(
                                                       width: MySize.size200,
                                                       padding: EdgeInsets.symmetric(horizontal: MySize.size10),
                                                       child: Text("${product.meal_type=="main"?product.name:"NA"}", style: TextStyle(fontWeight: FontWeight.bold),)),
                                                 ],
                                               ),
                                                Text("${AppTheme.money(product.price!)}")
                                              ],
                                            ),

                                            if(product.meal_type!="main")
                                            Container(
                                              padding: EdgeInsets.only(left: MySize.size50),
                                              child: Row(
                                                children: [
                                                 Container(
                                                     width: MySize.size230,
                                                     padding: EdgeInsets.symmetric(horizontal: MySize.size10),
                                                     child: Text("${product.name}")),
                                                  Text("${product.price}")
                                                ],
                                              ),
                                            ),

                                          ],
                                        );


                                      }),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            ChipWidget(
                                                child: const  Icon(Icons.remove,color: Colors.blueGrey,),
                                                onTap: (){
                                                  cartController.decreaseItem(cartModel);

                                                }) ,
                                            Padding(
                                              padding: const EdgeInsets.all(10.0),
                                              child: Text("${cartModel.quantity}"),
                                              // child: Text("${cartController.cartModelList.where((proList) => proList==cartModel).toList().length}"),
                                            ),

                                            ChipWidget(
                                                child: const  Icon(Icons.add,color: Colors.blueGrey,),
                                                onTap: (){
                                                  cartController.increaseItem(cartModel);
                                                }) ,
                                          ],
                                        ),

                                        Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: Text("${AppTheme.money(cartModel.subTotal!)}"),
                                        ),


                                      ],
                                    ),
                                  ),

                                ],
                              ),
                            ),
                            Positioned(
                              right: 7,
                                top:15,
                                child: ChipWidget(
                                    child: const  Icon(Icons.close,color: Colors.blueGrey,),
                                    onTap: (){
                                      cartController.removeItem(cartModel!);

                                    })
                            )
                          ],
                        );

                      }),

                ],
              );
  }

  Center EmptyCartWidget() {
    return Center(
          child: Container(
            padding: EdgeInsets.only(bottom: MySize.size200),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset("assets/empty_cart.png",
                height: MySize.size250,),
                const Text("Empty cart!")
              ],
            ),
          ),
        );
  }


}


class ChipWidget extends StatelessWidget {
  final Widget child;
  final VoidCallback onTap;
  const ChipWidget({Key? key,
   required this.child,
  required  this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30)
          ),
          child: child),
    );
  }
}
