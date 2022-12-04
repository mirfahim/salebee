import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:salebee/Model/expense/getTransportExpenseModel.dart';
import 'package:salebee/Model/expense/get_other_expense_model.dart';
import 'package:salebee/Screen/expense/expense_create/expense_create_front.dart';
import 'package:salebee/Screen/expense/expense_create/other_expense.dart';
import 'package:salebee/Screen/expense/expense_list_claimed/other_claimed/expense_pdf_preview_other.dart';
import 'package:salebee/repository/expense_repository.dart';
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
  'November',
  'December'
];
class OtherClaimedList extends StatefulWidget {
  const OtherClaimedList({Key? key}) : super(key: key);

  @override
  State<OtherClaimedList> createState() => _ApprovedState();
}

class _ApprovedState extends State<OtherClaimedList> {
  ExpenseRepository expenseRepository = ExpenseRepository();
  String vehicleName = "";
  double totalBalance = 0.0;
  int selectMonth = int.parse(DateTime.now().toString().substring(5,7));

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(


        backgroundColor: primaryColorLight,
        appBar: AppBar(
          backgroundColor: primaryColorLight,
          title: Text("Other Expense Claimed", style: TextStyle(
            color: Colors.black,
          ),),
        ),
        body: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 60),
              child: Column(
                children: [

                  Expanded(
                    child: DefaultTabController(
                      initialIndex: selectMonth -1,
                      length: 12,
                      child: Column(
                        children: [
                          TabBar(
                            indicator: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: primaryColor),
                            isScrollable: true,
                            indicatorColor: Colors.black,
                            labelColor: Colors.black,
                            onTap: (i){
                              setState((){
                                selectMonth = i+1;
                              });
                            },
                            tabs: tabs
                                .map((tab) => Tab(
                              icon: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(tab),
                              ),
                            ))
                                .toList(),
                          ),
                          FutureBuilder<GetOtherExpenseModel>(
                            future: expenseRepository.getOtherExpense(), // async work
                            builder: (BuildContext context, AsyncSnapshot<GetOtherExpenseModel> snapshot) {


                              if(snapshot.data == null){
                                print("snapshot no data found");
                              } else  {


                                totalBalance =  snapshot.data!.result!.fold<double>(0, (previousValue, element) => previousValue + element.expense!);
                                print("total amount is  $totalBalance");

                              }

                              switch (snapshot.connectionState) {
                                case ConnectionState.waiting:
                                  return Center(
                                      child: LoadingAnimationWidget.twistingDots(
                                        leftDotColor: const Color(0xFF8686E3),
                                        rightDotColor: const Color(0xFFEA3799),
                                        size: 100,
                                      ));
                                default:
                                  if (snapshot.hasError)
                                    return Center(child: Text('No Data Found'));
                                  if (snapshot.data == null) {
                                    return Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  } else {
                                    return  Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 10),
                                          child: Row(children: [
                                            const Text('Total Expense: ',style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 20
                                            ),),
                                            Text(totalBalance.toString(),style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 20
                                            ),),
                                            Text(' BDT',style: TextStyle(
                                                color: Colors.grey.withOpacity(.5),
                                                fontSize: 20
                                            ),)
                                          ],),
                                        ),
                                        Container(
                                          height: MediaQuery.of(context).size.height -300,
                                          child: ListView.builder(
                                              itemCount: snapshot.data!.result!.length,
                                              itemBuilder: (BuildContext context, index){
                                                var data =  snapshot.data!.result![index];





                                                return selectMonth == int.parse(data.createdOn.toString().substring(5,7))
                                                    ?
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
                                                          Expanded(child: Image.asset('images/transportation.png',height: 30,)),
                                                          const VerticalDivider(
                                                            thickness: 1,
                                                            color: Colors.grey,
                                                          ),
                                                          const SizedBox(width: 10,),
                                                          Expanded(
                                                            flex: 5,
                                                            child: Row(
                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                              children: [
                                                                Column(
                                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                                  children: [
                                                                   // Text(vehicleName),
                                                                    const SizedBox(height: 5,),
                                                                    Text(data.createdOn.toString().substring(0,10),style: TextStyle(
                                                                        color: Colors.grey.withOpacity(.7)
                                                                    ),),
                                                                    const SizedBox(height: 5,),
                                                                    Row(
                                                                      children: [
                                                                        Text(data.expense.toString(),style: TextStyle(
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
                                                                const Icon(Icons.arrow_forward_ios_outlined,size: 14,)
                                                              ],
                                                            ),
                                                          ),

                                                        ],),
                                                    ),
                                                  ),
                                                )
                                                    : Container();
                                              }),
                                        ),
                                        GestureDetector(
                                            onTap: (){
                                              Navigator.of(context).push(
                                                MaterialPageRoute(
                                                  builder: (builder) => PdfPreviewPage(invoice: snapshot.data! ),
                                                ),
                                              );
                                            },
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [

                                                Container(
                                                  height: 50,
                                                  width: 50,
                                                  decoration: BoxDecoration(
                                                      image: DecorationImage(
                                                          image: AssetImage(  'images/Icons/utility_expense.png',)
                                                      )
                                                  ),
                                                ),
                                                Text("View PDF", style: TextStyle(
                                                    color: Colors.black54
                                                ),),
                                              ],
                                            )
                                        ),
                                      ],
                                    );
                                  }
                              }

                            },
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
                    Get.to(ExpenseCreateFront());
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
        )
    );
  }
}
