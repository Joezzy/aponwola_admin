import 'dart:math';


import 'package:animations/animations.dart';
import 'package:aponwola_admin/common/SizeConfig.dart';
import 'package:aponwola_admin/common/app_theme.dart';
import 'package:aponwola_admin/common/constant.dart';
import 'package:aponwola_admin/controllers/auth.controller.dart';
import 'package:aponwola_admin/controllers/category.controller.dart';
import 'package:aponwola_admin/controllers/product.controller.dart';
import 'package:aponwola_admin/custom_widget/animatedWidget.dart';
import 'package:aponwola_admin/custom_widget/homeAppBar.dart';
import 'package:aponwola_admin/custom_widget/productCard.dart';
import 'package:aponwola_admin/data/category.dart';
import 'package:aponwola_admin/data/dropdownClass.dart';
import 'package:aponwola_admin/data/foodOptions.dart';
import 'package:aponwola_admin/data/product.dart';
import 'package:aponwola_admin/view/home/detail.view.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class HomeView extends StatefulWidget {
   HomeView({Key? key}) : super(key: key);


  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> with SingleTickerProviderStateMixin {
  final _transitionType = ContainerTransitionType.fade;
  bool startAnimation = false;

  late final AnimationController _animationController=AnimationController(vsync: this,duration: const Duration(seconds: 1));
  late final Animation<Offset> _offsetAnimation=Tween<Offset>(begin:Offset.zero,end: Offset(0,1.5))
      .animate(
    CurvedAnimation(parent: _animationController, curve: Curves.elasticIn)
  );

  final categoryController=Get.put(CategoryController());
  final productController=Get.put(ProductController());
  final authController=Get.put(AuthController());

  late PageController _pageController;
  int _currentPage = 0;

  @override
  void initState() {
    // TODO: implement initState
    _pageController =
        PageController(initialPage: _currentPage, viewportFraction: 0.9);
    categoryController.getCategories();
    productController.getProducts();
    // authController.loadProfile();

    super.initState();
    // _pageController.position.haveDimensions;
    initMethod();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _animationController.dispose();
    _pageController.dispose();
  }

  initMethod(){
    Future.delayed(const Duration(seconds: 1)).then((val) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        setState(() {
          startAnimation = true;
        });
      });
    });
    Future.delayed(const Duration(seconds: 2)).then((val) {
      _pageController.animateToPage(_pageController.page!.toInt() + 1,
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeIn
      );

    });
    // setState(() {

    // });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.grey.withOpacity(.05),
      appBar: HomeAppBar(),
      body: Container(
        height: MySize.screenHeight,
        padding: const EdgeInsets.only(top: 5),
        child: ListView(
          physics: const NeverScrollableScrollPhysics(),
          children: <Widget>[

            const Header( text:"Daily lunch"),
            GetX<CategoryController>(
              builder: (categoryController) {
                return categoryController.isLoadingCategory.value?
               const  CupertinoActivityIndicator()
                    :AspectRatio(
                  aspectRatio: 1.7,
                  child: PageView.builder(
                      itemCount: categoryController.categoryList.length,
                      physics: const ClampingScrollPhysics(),
                      controller: _pageController,
                      itemBuilder: (context, index) {


                        return  categoryController.categoryList[index].type=="daily"?
                          carouselView(index,categoryController):Container();
                      }),
                );
              }
            ),

            const Header(text:"Category"),
            Container(
              child: SizedBox(
                height: MySize.screenHeight,
                child: SlideTransition(
                  position: _offsetAnimation,
                  child: ListView.builder(
                    padding: EdgeInsets.only(
                      // bottom: MySize.size600,
                      left: MySize.size10,
                      right: MySize.size10,
                    ),
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: categoryController.categoryList.length,
                      itemBuilder: (context, index) {
                        Category cat= categoryController.categoryList[index];

                        return
                          cat.type=="normal"?
                          AnimatedContainer(
                            curve: Curves.easeInOut,
                            duration: Duration(milliseconds:500 + (index * 500)),
                            transform: Matrix4.translationValues(startAnimation ? 0
                                : MySize.screenWidth, 0, 0),
                            child: Category2Card(category: cat)):Container();

                      }),
                ),
              ),
            ),


          ],
        ),
      ),
    );
  }



  Widget carouselView(int index,categoryController) {
    return AnimatedBuilder(
      animation: _pageController,
      builder: (context, child) {
        double value = 0.00;
        if (_pageController.position.haveDimensions) {
          value = index.toDouble() - (_pageController.page ?? 0);
          value = (value * 0.1).clamp(-1, 1);
          print("value $value index $index");
        }

        return Transform.rotate(
          angle: pi * value,
          child:
          AnimatedContainerWrapper(
            transitionType: _transitionType,
            closedBuilder: (BuildContext _, VoidCallback openContainer) {
              return CarouselCard(data: categoryController.categoryList[index],openContainer: openContainer,);
            },
            
            // onClosed: false,
            child:  DetailsView(data: categoryController.categoryList[index]),


          ),

          // carouselCard(categoryController.categoryList[index]),
        );
      },
    );
  }
  // Obx(() => Text("${controller.name}"));

  // Widget carouselCard(Category data) {


  //   return CarouselCard(context: context);
  // }
}



class Header extends StatelessWidget {
  const Header({
    super.key,
    this.text=""
  });
final String text;
  @override
  Widget build(BuildContext context) {
    return Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: [
                Text(text, textAlign: TextAlign.left,
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Colors.grey,
                        fontSize: MySize.size16)),
              ],
            ),
          );
  }
}





