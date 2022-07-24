import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:madproject/modules/models/order.dart';
import 'package:madproject/modules/models/product.dart';
import 'package:madproject/modules/repository/order_repo.dart';
import 'package:madproject/modules/repository/project_repo.dart';
import 'package:madproject/modules/services/order_services.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  OrdersRepo ordersRepo = OrdersRepo.getInstance();
  //List<Product> _list_products = [];
  
  // _getList() async
  // {
  //   Future<List<Product>> future_list =ProductRepository().read();
  //   List<Product> list_products =  await future_list;
  //   _list_products=list_products;
  // }
  

  

  
  dynamic dropdownValue = "ALL";
  List<DropdownMenuItem<String>> item_list = [
    DropdownMenuItem(child: Text("PENDING"), value: "PENDING"),
    DropdownMenuItem(child: Text("DELIVERED"), value: "DELIVERED"),
    DropdownMenuItem(child: Text("CANCELLED"), value: "CANCELLED"),
    DropdownMenuItem(child: Text("ALL"), value: "ALL")
  ];

  // String _getnamebyid(String id)
  // {
  //   int index = _list_products.indexWhere((element) => element.id==id);
  //   return _list_products[index].name;
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Center(
            child: Text(
          "Orders List",
          style: TextStyle(color: Colors.black , fontSize: 25 , fontWeight:FontWeight.bold)
        )),
      ),
      body: SafeArea(
          child: Column(children: [
        DropdownButton(
          items: item_list,
          onChanged: (dynamic newValue) {
            setState(() {
              
              dropdownValue = newValue;
              
            });
          },
          value: dropdownValue
        ),
        FutureBuilder(
          future: ordersRepo.getOrders(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Text("Some error has occured");
            } else {
              List<Order> list = OrderServies().convertOrders(snapshot.data);
              //_getList();

              return Expanded(
                child: ListView.builder(
                    itemCount: list.length,
                    itemBuilder: (context, index) {
                           if(list[index].order_status==dropdownValue )
                           {
                              return Padding(
                        padding:  EdgeInsets.fromLTRB(8, 20, 8, 10),
                        child: Container(
                            alignment: Alignment.center,
                            height: 150,
                            width: 60,
                            decoration: BoxDecoration(
                                color: Colors.blue[300],
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey,
                                        blurRadius: 5,
                                        spreadRadius: 2,
                                        offset: Offset(5,10)

                                      )
                                    ]
                                    ),
                            child: Column(
                              children: [
                                  Padding(
                                    padding:  EdgeInsets.only(top: 10),
                                    child: Text(
                                      "Order ID : ${list[index].id}",
                                      style: GoogleFonts.lato(fontSize: 23, color:Colors.black , fontWeight: FontWeight.bold)
                                    ),
                                  ),
                                  Expanded(
                                    child: ListView.builder(
                                      itemCount: list[index].products_list.length,
                                      itemBuilder: ((context, i) {
                                      return ListTile(
                                        
                                        title: Padding(
                                          padding: const EdgeInsets.only(left: 10),
                                          child: Text("Product ID : "+"${list[index].products_list[i]['product_id']}",style: GoogleFonts.lato(fontSize: 18, color:Colors.black)),
                                        ),
                                      );
                                    }))),
                                       
                                      Text("Price : " + "${list[index].price}",
                                      style: GoogleFonts.lato(fontSize: 17, color:Colors.black)),
                                      Text("Status : " + "${list[index].order_status}",
                                      style: GoogleFonts.lato(fontSize: 17, color:Colors.black)),
                                      Text("Zone : " + "${list[index].delivery_zone}",
                                      style: GoogleFonts.lato(fontSize: 17, color:Colors.black))
                                                                ,
                                  ],
                            )),);

                           }   
                           else if(dropdownValue=="ALL")
                           {
                             return Padding(
                        padding:  EdgeInsets.fromLTRB(8, 20, 8, 8),
                        child: Container(
                            alignment: Alignment.center,
                            height: 150,
                            width: 60,
                            
                            
                            decoration: BoxDecoration(

                                
                                color: Colors.blue[300],
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey,
                                        blurRadius: 5,
                                        spreadRadius: 2,
                                        offset: Offset(5,10)

                                      )
                                    ]
                                    
                                    ),
                                    
                            child: Column(
                              children: [
                                
                                  Padding(
                                    padding: EdgeInsets.only(left: 5),
                                    child: Text(
                                      "Order ID : ${list[index].id}",
                                      style: GoogleFonts.lato(fontSize: 23, color:Colors.black , fontWeight: FontWeight.bold)
                                    ),
                                  ),
                                   Expanded(
                                    child: ListView.builder(
                                      itemCount: list[index].products_list.length,
                                      itemBuilder: ((context, i) {
                                      return Padding(
                                        padding: EdgeInsets.only(left: 30),
                                        child: Text("Product ID :"+"${list[index].products_list[i]['product_id']}",style: GoogleFonts.lato(fontSize: 18, color:Colors.black)),
                                      );
                                    }))),
                                
                                Text("Price : " + "${list[index].price}",
                                    style: GoogleFonts.lato(fontSize: 17, color:Colors.black)),
                                Text("Status : " + "${list[index].order_status}",
                                    style: GoogleFonts.lato(fontSize: 17, color:Colors.black)),
                                Text("Zone : " + "${list[index].delivery_zone}",
                                    style: GoogleFonts.lato(fontSize: 17, color:Colors.black))
                              ],
                            )),
                      );
                           }
                           else{
                             return SizedBox.shrink();
                             
                             
                             
                           }

                      
                    }),
              );
            }
          },
        )
      ])),
      // body: SafeArea(
      //     child: FutureBuilder(
      //   future: ordersRepo.getOrders(),
      //   builder: (context, snapshot) {
      //     if (snapshot.connectionState == ConnectionState.waiting) {
      //       return const Center(child: CircularProgressIndicator());
      //     } else if (snapshot.hasError) {
      //       return Text("Some error has occured");
      //     } else {
      //       List<Order> list = OrderServies().convertOrders(snapshot.data);

      //       return ListView.builder(
      //           itemCount: list.length,
      //           itemBuilder: (context, index) {
      //             // return ListTile(

      //             //   leading: Text("Order ID : ${list[index].id}"+"Product_id"+"${list[index].products_list[0]['product_id']}"+"  "+"${list[index].price}"+"  "+"${list[index].order_status}"+"     "+"${list[index].delivery_zone}", style: TextStyle(color: Colors.black, fontSize: 12),),
      //             //   //leading: Text("${list[index].date}"),

      //             // );
      //             return Padding(
      //               padding: const EdgeInsets.all(8.0),
      //               child: Container(
      //                   alignment: Alignment.center,

      //                   height: 120,
      //                   width: 60,
      //                   decoration: BoxDecoration(color: Colors.black26, borderRadius: BorderRadius.all(Radius.circular(20)) ),
      //                   child: Column(

      //                     children: [

      //                       if(list[index].order_status=="")
      //                       Text(
      //                         "Order ID : ${list[index].id}",
      //                         style:
      //                             TextStyle(color: Colors.black, fontSize: 20 ,),
      //                       ),

      //                       Text("Product_id : "+"${list[index].products_list[0]['product_id']}" , style: TextStyle(fontSize: 18),),
      //                       Text("Price : " + "${list[index].price}",style: TextStyle(fontSize: 18)),
      //                       Text("Status : " + "${list[index].order_status}",style: TextStyle(fontSize: 18)),
      //                       Text("Zone : " + "${list[index].delivery_zone}",style: TextStyle(fontSize: 18))
      //                     ],
      //                   )),
      //             );
      //           });
      //     }
      //   },
      // )),
    );
  }
}
