import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:salebee/Screen/expense/other_expense.dart';
import 'package:salebee/utils.dart';

List<String> tabs = [
  'January',
  'February',
  'March',
  'April',
  'May',
  'June',
  'July',
  'August',
  'September',
  'October',
  'November'
      'December'
];
class Approved extends StatelessWidget {
  const Approved({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 60),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 10),
                  child: Row(children: [
                    Text('Total Balance: ',style: TextStyle(
                        color: Colors.grey,
                      fontSize: 20
                    ),),
                    Text('1000',style: TextStyle(
                      fontWeight: FontWeight.w600,
                        fontSize: 20
                    ),),
                    Text(' BDT',style: TextStyle(
                        color: Colors.grey.withOpacity(.5),
                        fontSize: 20
                    ),)
                  ],),
                ),
                Expanded(
                  child: DefaultTabController(
                    length: 11,
                    child: Column(
                      children: [
                        TabBar(
                          indicator: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: primaryColor),
                          isScrollable: true,
                          indicatorColor: Colors.black,
                          labelColor: Colors.black,
                          tabs: tabs
                              .map((tab) => Tab(
                            icon: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(tab),
                            ),
                          ))
                              .toList(),
                        ),
                        SizedBox(height: 10,),

                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 0.0),
                            child: TabBarView(
                              physics: const AlwaysScrollableScrollPhysics(),
                              // physics: NeverScrollableScrollPhysics(),
                              children: tabs
                                  .map((e) => SingleChildScrollView(
                                scrollDirection: Axis.vertical,
                                child: Column(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10),
                                          border: Border.all(color: Colors.grey.withOpacity(.5)),
                                        color:blue.withOpacity(.1)
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: IntrinsicHeight(
                                          child: Row(
                                            children: [
                                            Expanded(child: Image.asset('images/food.png',height: 30,)),
                                            const VerticalDivider(
                                              thickness: 1,
                                              color: Colors.grey,
                                            ),
                                            SizedBox(width: 10,),
                                            Expanded(
                                              flex: 5,
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Text('Lunch'),
                                                      SizedBox(height: 5,),
                                                      Text('30 July 2022',style: TextStyle(
                                                          color: Colors.grey.withOpacity(.7)
                                                      ),),
                                                      SizedBox(height: 5,),
                                                      Row(
                                                        children: [
                                                          Text('250',style: TextStyle(
                                                              fontSize: 16,
                                                            fontWeight: FontWeight.w600
                                                          ),),
                                                          Text(' BDT',style: TextStyle(
                                                              color: Colors.grey.withOpacity(.7)
                                                          ),)
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                  Icon(Icons.arrow_forward_ios_outlined,size: 14,)
                                                ],
                                              ),
                                            )
                                          ],),
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 10,),
                                    Container(
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10),
                                          border: Border.all(color: Colors.grey.withOpacity(.5)),
                                          color:blue.withOpacity(.1)
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: IntrinsicHeight(
                                          child: Row(
                                            children: [
                                              Expanded(child: Image.asset('images/food.png',height: 30,)),
                                              const VerticalDivider(
                                                thickness: 1,
                                                color: Colors.grey,
                                              ),
                                              SizedBox(width: 10,),
                                              Expanded(
                                                flex: 5,
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Text('Lunch'),
                                                        SizedBox(height: 5,),
                                                        Text('30 July 2022',style: TextStyle(
                                                            color: Colors.grey.withOpacity(.7)
                                                        ),),
                                                        SizedBox(height: 5,),
                                                        Row(
                                                          children: [
                                                            Text('250',style: TextStyle(
                                                                fontSize: 16,
                                                                fontWeight: FontWeight.w600
                                                            ),),
                                                            Text(' BDT',style: TextStyle(
                                                                color: Colors.grey.withOpacity(.7)
                                                            ),)
                                                          ],
                                                        )
                                                      ],
                                                    ),
                                                    Icon(Icons.arrow_forward_ios_outlined,size: 14,)
                                                  ],
                                                ),
                                              )
                                            ],),
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 10,),
                                    Container(
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10),
                                          border: Border.all(color: Colors.grey.withOpacity(.5)),
                                          color:blue.withOpacity(.1)
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: IntrinsicHeight(
                                          child: Row(
                                            children: [
                                              Expanded(child: Image.asset('images/food.png',height: 30,)),
                                              const VerticalDivider(
                                                thickness: 1,
                                                color: Colors.grey,
                                              ),
                                              SizedBox(width: 10,),
                                              Expanded(
                                                flex: 5,
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Text('Lunch'),
                                                        SizedBox(height: 5,),
                                                        Text('30 July 2022',style: TextStyle(
                                                            color: Colors.grey.withOpacity(.7)
                                                        ),),
                                                        SizedBox(height: 5,),
                                                        Row(
                                                          children: [
                                                            Text('250',style: TextStyle(
                                                                fontSize: 16,
                                                                fontWeight: FontWeight.w600
                                                            ),),
                                                            Text(' BDT',style: TextStyle(
                                                                color: Colors.grey.withOpacity(.7)
                                                            ),)
                                                          ],
                                                        )
                                                      ],
                                                    ),
                                                    Icon(Icons.arrow_forward_ios_outlined,size: 14,)
                                                  ],
                                                ),
                                              )
                                            ],),
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 10,),
                                    Container(
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10),
                                          border: Border.all(color: Colors.grey.withOpacity(.5)),
                                          color:blue.withOpacity(.1)
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: IntrinsicHeight(
                                          child: Row(
                                            children: [
                                              Expanded(child: Image.asset('images/food.png',height: 30,)),
                                              const VerticalDivider(
                                                thickness: 1,
                                                color: Colors.grey,
                                              ),
                                              SizedBox(width: 10,),
                                              Expanded(
                                                flex: 5,
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Text('Lunch'),
                                                        SizedBox(height: 5,),
                                                        Text('30 July 2022',style: TextStyle(
                                                            color: Colors.grey.withOpacity(.7)
                                                        ),),
                                                        SizedBox(height: 5,),
                                                        Row(
                                                          children: [
                                                            Text('250',style: TextStyle(
                                                                fontSize: 16,
                                                                fontWeight: FontWeight.w600
                                                            ),),
                                                            Text(' BDT',style: TextStyle(
                                                                color: Colors.grey.withOpacity(.7)
                                                            ),)
                                                          ],
                                                        )
                                                      ],
                                                    ),
                                                    Icon(Icons.arrow_forward_ios_outlined,size: 14,)
                                                  ],
                                                ),
                                              )
                                            ],),
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 10,),
                                    Container(
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10),
                                          border: Border.all(color: Colors.grey.withOpacity(.5)),
                                          color:blue.withOpacity(.1)
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: IntrinsicHeight(
                                          child: Row(
                                            children: [
                                              Expanded(child: Image.asset('images/food.png',height: 30,)),
                                              const VerticalDivider(
                                                thickness: 1,
                                                color: Colors.grey,
                                              ),
                                              SizedBox(width: 10,),
                                              Expanded(
                                                flex: 5,
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Text('Lunch'),
                                                        SizedBox(height: 5,),
                                                        Text('30 July 2022',style: TextStyle(
                                                            color: Colors.grey.withOpacity(.7)
                                                        ),),
                                                        SizedBox(height: 5,),
                                                        Row(
                                                          children: [
                                                            Text('250',style: TextStyle(
                                                                fontSize: 16,
                                                                fontWeight: FontWeight.w600
                                                            ),),
                                                            Text(' BDT',style: TextStyle(
                                                                color: Colors.grey.withOpacity(.7)
                                                            ),)
                                                          ],
                                                        )
                                                      ],
                                                    ),
                                                    Icon(Icons.arrow_forward_ios_outlined,size: 14,)
                                                  ],
                                                ),
                                              )
                                            ],),
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 10,),
                                    Container(
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10),
                                          border: Border.all(color: Colors.grey.withOpacity(.5)),
                                          color:blue.withOpacity(.1)
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: IntrinsicHeight(
                                          child: Row(
                                            children: [
                                              Expanded(child: Image.asset('images/food.png',height: 30,)),
                                              const VerticalDivider(
                                                thickness: 1,
                                                color: Colors.grey,
                                              ),
                                              SizedBox(width: 10,),
                                              Expanded(
                                                flex: 5,
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Text('Lunch'),
                                                        SizedBox(height: 5,),
                                                        Text('30 July 2022',style: TextStyle(
                                                            color: Colors.grey.withOpacity(.7)
                                                        ),),
                                                        SizedBox(height: 5,),
                                                        Row(
                                                          children: [
                                                            Text('250',style: TextStyle(
                                                                fontSize: 16,
                                                                fontWeight: FontWeight.w600
                                                            ),),
                                                            Text(' BDT',style: TextStyle(
                                                                color: Colors.grey.withOpacity(.7)
                                                            ),)
                                                          ],
                                                        )
                                                      ],
                                                    ),
                                                    Icon(Icons.arrow_forward_ios_outlined,size: 14,)
                                                  ],
                                                ),
                                              )
                                            ],),
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 10,),
                                    Container(
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10),
                                          border: Border.all(color: Colors.grey.withOpacity(.5)),
                                          color:blue.withOpacity(.1)
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: IntrinsicHeight(
                                          child: Row(
                                            children: [
                                              Expanded(child: Image.asset('images/food.png',height: 30,)),
                                              const VerticalDivider(
                                                thickness: 1,
                                                color: Colors.grey,
                                              ),
                                              SizedBox(width: 10,),
                                              Expanded(
                                                flex: 5,
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Text('Lunch'),
                                                        SizedBox(height: 5,),
                                                        Text('30 July 2022',style: TextStyle(
                                                            color: Colors.grey.withOpacity(.7)
                                                        ),),
                                                        SizedBox(height: 5,),
                                                        Row(
                                                          children: [
                                                            Text('250',style: TextStyle(
                                                                fontSize: 16,
                                                                fontWeight: FontWeight.w600
                                                            ),),
                                                            Text(' BDT',style: TextStyle(
                                                                color: Colors.grey.withOpacity(.7)
                                                            ),)
                                                          ],
                                                        )
                                                      ],
                                                    ),
                                                    Icon(Icons.arrow_forward_ios_outlined,size: 14,)
                                                  ],
                                                ),
                                              )
                                            ],),
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 10,),
                                    Container(
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10),
                                          border: Border.all(color: Colors.grey.withOpacity(.5)),
                                          color:blue.withOpacity(.1)
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: IntrinsicHeight(
                                          child: Row(
                                            children: [
                                              Expanded(child: Image.asset('images/food.png',height: 30,)),
                                              const VerticalDivider(
                                                thickness: 1,
                                                color: Colors.grey,
                                              ),
                                              SizedBox(width: 10,),
                                              Expanded(
                                                flex: 5,
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Text('Lunch'),
                                                        SizedBox(height: 5,),
                                                        Text('30 July 2022',style: TextStyle(
                                                            color: Colors.grey.withOpacity(.7)
                                                        ),),
                                                        SizedBox(height: 5,),
                                                        Row(
                                                          children: [
                                                            Text('250',style: TextStyle(
                                                                fontSize: 16,
                                                                fontWeight: FontWeight.w600
                                                            ),),
                                                            Text(' BDT',style: TextStyle(
                                                                color: Colors.grey.withOpacity(.7)
                                                            ),)
                                                          ],
                                                        )
                                                      ],
                                                    ),
                                                    Icon(Icons.arrow_forward_ios_outlined,size: 14,)
                                                  ],
                                                ),
                                              )
                                            ],),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              ).toList(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: InkWell(
                onTap: (){
                  Get.to(OtherExpense());
                },
                child: Container(
                  height: 48,
                  width: size.width,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      color: darkBlue
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Center(
                      child: Text('Add New Expense',textAlign:TextAlign.center,style: TextStyle(
                          color: Colors.white
                      ),),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
