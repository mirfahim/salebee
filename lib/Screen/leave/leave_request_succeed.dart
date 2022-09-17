import 'package:flutter/material.dart';
import 'package:salebee/utils.dart';

class LeaveRequestSucceed extends StatelessWidget {
  const LeaveRequestSucceed({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroudColor,
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          color: backgroudColor,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                Image.asset('images/leave_request_sent_successfully.png'),
                const Text('Leave Request Sent successfully'
                    'Please wait for the approval',textAlign: TextAlign.center,style: TextStyle(
                    color: Color(0xFF203856),fontSize: 18, fontWeight: FontWeight.w400,
                ),),
                const SizedBox(height: 40,),
                Row(
                  children: [
                    Expanded(child: InkWell(
                      onTap: (){},
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            color: const Color(0xFF2563EB)
                        ),
                        child: const Padding(
                          padding: EdgeInsets.all(12.0),
                          child: Text('Go to Home',
                            textAlign: TextAlign.center,
                              style: TextStyle(
                              color: Colors.white,fontSize: 12, fontWeight: FontWeight.w600,
                        ),),
                        ),
                      ),
                    )),
                    const SizedBox(width: 20,),
                    Expanded(child: InkWell(
                      onTap: (){},
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            color: Colors.white,
                          border: Border.all(
                            color: const Color(0xFFD2DDEC)
                          )
                        ),
                        child: const Padding(
                          padding: EdgeInsets.all(12.0),
                          child: Text('View Details',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Color(0xFF16A34A),fontWeight: FontWeight.w600,fontSize: 12
                            ),),
                        ),
                      ),
                    ))
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
