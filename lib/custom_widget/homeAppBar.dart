

import 'package:aponwola_admin/common/SizeConfig.dart';
import 'package:aponwola_admin/common/app_theme.dart';
import 'package:aponwola_admin/controllers/cartController.dart';
import 'package:aponwola_admin/services/api.service.dart';
import 'package:aponwola_admin/view/cart/cart.view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class HomeAppBar extends StatefulWidget implements PreferredSizeWidget {
  final String title;
  final VoidCallback? onTapLeadingIcon;

  HomeAppBar({Key? key,
    this.title = "",
    this.onTapLeadingIcon
  })
      : preferredSize = const Size.fromHeight(kToolbarHeight);

  @override
  final Size preferredSize;

  @override
  State<HomeAppBar> createState() => _HomeAppBarState();
}


class _HomeAppBarState extends State<HomeAppBar> {
  final cartController=Get.put(CartController());

  @override
  Widget build(BuildContext context) {
    return  PreferredSize(
      preferredSize: const Size.fromHeight(50),
      // here the desired height

      child: AppBar(
        titleSpacing: 0,

        title: Padding(
          padding:  EdgeInsets.only(left: MySize.size20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [

              CircleAvatar(
                radius: 22,
                backgroundImage:
                NetworkImage(
                    ApiService.me.image ==""?
                    "https://upload.wikimedia.org/wikipedia/commons/7/7c/Profile_avatar_placeholder_large.png":
                    ApiService.me.image.toString() ),
            ),

              Text(
                " Hello  ${widget.title}",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black, fontSize: MySize.size20),
              ),
            ],
          ),
        ),

        iconTheme: const IconThemeData(color: AppTheme.primaryColor),
        elevation: 0,
        actions: [

          InkWell(
            onTap: ()=>
                Navigator.of(context, rootNavigator: true).push(
                  MaterialPageRoute(
                      builder: (BuildContext context) =>const CartView()),),
            child: Stack(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: MySize.size10,
                    vertical: MySize.size10,
                  ),
                  padding: EdgeInsets.symmetric(
                      horizontal: MySize.size10
                  ),
                  // width: MySize.size50,
                  // height: MySize.size30,
                  decoration: BoxDecoration(
                      // color: AppTheme.o3Grey,
                      borderRadius: BorderRadius.circular(6)
                  ),
                  child: const Icon(MdiIcons.cart,size: 20,),
                ),

              Positioned(
                  top: 0,
                    right: 5,
                    child: Container(
                        decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(6)
                        ),
                        padding: EdgeInsets.symmetric(
                            horizontal: MySize.size5
                        ),
                        child: GetX<CartController>(
                          builder: (cartController) {
                            return Text("${cartController.cartModelList.length}");
                          }
                        )
                    )
              ),
              ],
            ),
          ),

        ],
        // backgroundColor: Colors.black,
        backgroundColor: Colors.transparent,
      ),
    );
  }
}