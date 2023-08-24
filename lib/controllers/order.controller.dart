

import 'package:aponwola_admin/common/constant.dart';
import 'package:aponwola_admin/data/order.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';

class OrderController extends GetxController{
  final FirebaseStorage _storage=FirebaseStorage.instance;
  var orderList= <OrderGroup>[].obs;

var isLoadingOrder=false.obs;

  Future getOrders(context)async {
    print("GET_ORDER");
    isLoadingOrder.value=true;
    // try{
      final order=await firebase.collection('orders').get();
    print(order.docs.first["order"]);
    print(order.docs);
    orderList.value= order.docs.map((doc) => OrderGroup.fromSnapShot(doc)).toList();
      print(orderList);
      isLoadingOrder.value=false;
    // }catch(e){
    //   print(e);
    //   isLoadingOrder.value=false;
    // }
  }


}