import 'package:flutter/material.dart';
import 'package:salebee/utils.dart';

class AssignedToMe extends StatelessWidget {
  const AssignedToMe({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 8),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12)
              ),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              color: const Color(0xFFFAF5FF)
                            ),
                            child: const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 12.0,vertical: 8),
                              child: Text('Low',style: TextStyle(
                                color: Color(0xFF9333EA),
                                fontSize: 12
                              ),),
                            ),
                          ),
                          const Text('Jul 27',style: TextStyle(
                            color: Color(0xFF7C8DB5),
                              fontSize: 10
                          ),)
                        ],
                      ),
                    const SizedBox(height: 10,),
                    const Text('Fix a meeting with Proxima Ltd',style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      color: Color(0xFF0C162C)
                    ),),
                    const SizedBox(height: 10,),
                     const Text('Lorem ipsum dolor sit amet, consectetur adipiscing elit',
                      style: TextStyle(
                        color: Color(0xFF7C8DB5),
                        fontSize: 12
                    ),),
                    const SizedBox(height: 30,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(children: const [
                          Icon(Icons.calendar_today,color: Colors.grey,size: 12,),
                          SizedBox(width: 5,),
                          Text('29 Jul 2021 10:30 AM',
                            style: TextStyle(
                                color: Colors.grey,
                                fontSize: 12
                            ),),
                        ],),
                        const Text('+5 days',
                          style: TextStyle(
                              color: Colors.grey,
                              fontSize: 12
                          ),),
                      ],
                    ),
                    const SizedBox(height: 15,),
                    Row(
                      children: [
                        const Icon(Icons.share,color: Colors.grey,size: 12),
                        const SizedBox(width: 5,),
                        Container(
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle
                          ),
                          child: const CircleAvatar(
                            radius: 12,
                            backgroundImage: AssetImage('images/person.jpg',),
                          ),
                        ),
                        Container(
                          transform: Matrix4.translationValues(-10, 0, 0.0),
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle
                          ),
                          child: const CircleAvatar(
                            radius: 12,
                            backgroundImage: AssetImage('images/person.jpg',),
                          ),
                        ),
                        Container(
                          transform: Matrix4.translationValues(-20, 0, 0.0),
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle
                          ),
                          child: const CircleAvatar(
                            radius: 12,
                            backgroundImage: AssetImage('images/person.jpg',),
                          ),
                        ),
                        Container(
                          transform: Matrix4.translationValues(-15, 0, 0.0),
                          child: const Text('+12',
                            style: TextStyle(
                                color: Colors.grey,
                                fontSize: 12
                            ),),
                        ),
                        const SizedBox(width: 15,),
                        const Icon(Icons.remove_red_eye,color: Colors.grey,size: 12,),
                        const SizedBox(width: 10,),
                        Container(
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle
                          ),
                          child: const CircleAvatar(
                            radius: 12,
                            backgroundImage: AssetImage('images/person.jpg',),
                          ),
                        ),
                        Container(
                          transform: Matrix4.translationValues(-10, 0, 0.0),
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle
                          ),
                          child: const CircleAvatar(
                            radius: 12,
                            backgroundImage: AssetImage('images/person.jpg',),
                          ),
                        ),
                        Container(
                          transform: Matrix4.translationValues(-20, 0, 0.0),
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle
                          ),
                          child: const CircleAvatar(
                            radius: 12,
                            backgroundImage: AssetImage('images/person.jpg',),
                          ),
                        ),
                        Container(
                          transform: Matrix4.translationValues(-15, 0, 0.0),
                          child: const Text('+22',
                            style: TextStyle(
                                color: Colors.grey,
                                fontSize: 8
                            ),),
                        ),
                      ],
                    ),
                    const SizedBox(height: 15,),
                    Row(
                      children: [
                        const Icon(Icons.send,color: Colors.grey,size: 12,),
                        const SizedBox(width: 10,),
                        Container(
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle
                          ),
                          child: const CircleAvatar(
                            radius: 12,
                            backgroundImage: AssetImage('images/person.jpg',),
                          ),
                        ),
                        const SizedBox(width: 5,),
                        const Text('Rayhan Uddin',
                          style: TextStyle(
                              color: Colors.grey,
                              fontSize: 12
                          ),)
                      ],
                    ),
                    const SizedBox(height: 30,),
                    Row(
                      children:  [
                        Text('Contact:',
                          style: TextStyle(
                              color: text,
                              fontSize: 12,
                              fontWeight: FontWeight.w400
                          ),),
                        const SizedBox(width: 10,),
                        const Text('Rahat Mahmud (Chief Executive Officer)',
                          style: TextStyle(
                              color: Colors.grey,
                              fontSize: 12,
                          ),),
                      ],
                    ),
                    Row(
                      children:  [
                        Container(
                          width: 42,
                        ),
                        const SizedBox(width: 10,),
                        const Text('01911111111',
                          style: TextStyle(
                              color: Colors.grey,
                              fontSize: 12,
                          ),),
                      ],
                    ),
                    const SizedBox(height: 20,),
                    Row(
                      children: [
                         Text('Status:',
                          style: TextStyle(
                              color: text,
                              fontSize: 12,
                              fontWeight: FontWeight.w400
                          ),),
                        const SizedBox(width: 10,),
                        Container(
                          width: 120,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            border: Border.all(color: tabBarUnSelectedColor)
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 6.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children:  [
                                 Text('Initialized',style: TextStyle(
                                  color: text,
                                  fontWeight: FontWeight.w400,
                                   fontSize: 12
                                ),),
                                const Icon(Icons.keyboard_arrow_down_outlined,color: Colors.grey,)
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 10,),
                    Row(
                      children: [
                         Text('Pick Any:',
                          style: TextStyle(
                              color: text,
                              fontSize: 12,
                              fontWeight: FontWeight.w400
                          ),),
                        const SizedBox(width: 10,),
                        Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(100)
                          ),
                          child: Container(
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle
                            ),
                            child: const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Icon(Icons.chat,color: Color(0xFF1E40AF),size: 12,),
                            ),
                          ),
                        ),
                        const SizedBox(width: 5,),
                        Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(100)
                          ),
                          child: Container(
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle
                            ),
                            child: const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Icon(Icons.call,color: Color(0xFF1E40AF),size: 12,),
                            ),
                          ),
                        ),
                        const SizedBox(width: 5,),
                        Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(100)
                          ),
                          child: Container(
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle
                            ),
                            child: const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Icon(Icons.local_post_office_rounded,
                                color: Color(0xFF1E40AF),size: 12,),
                            ),
                          ),
                        ),
                        const SizedBox(width: 5,),
                        Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(100)
                          ),
                          child: Container(
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle
                            ),
                            child: const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Icon(Icons.more_horiz,color: Color(0xFF1E40AF),
                              size: 12,),
                            ),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 10,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                             Text('Action:',
                              style: TextStyle(
                                  color: text,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400
                              ),),
                            const SizedBox(width: 20,),
                            Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(100)
                              ),
                              child: Container(
                                decoration: const BoxDecoration(
                                    shape: BoxShape.circle
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Icon(Icons.edit,color: primaryColor,size: 12,),
                                ),
                              ),
                            ),
                            const SizedBox(width: 5,),
                            Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(100)
                              ),
                              child: Container(
                                decoration: const BoxDecoration(
                                    shape: BoxShape.circle
                                ),
                                child: const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Icon(Icons.delete,color: Colors.red, size: 12,),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Container(
                          width: 80,
                          decoration: BoxDecoration(
                            color: primaryColor,
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(30),
                                topRight: Radius.circular(30),
                                bottomLeft: Radius.circular(30),
                              bottomRight: Radius.circular(30)
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 3),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Icon(Icons.map,color: Colors.white,size: 14,),
                                SizedBox(width: 5,),
                                Text('Visit',style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14
                                ),)
                              ],
                            ),
                          ),
                        )

                      ],
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
