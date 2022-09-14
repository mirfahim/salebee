import 'package:flutter/material.dart';
import 'package:salebee/Model/getAssignedTaskModel.dart';
import 'package:salebee/utils.dart';

import '../../repository/add_task_repository.dart';

class AllTask extends StatefulWidget {
  const AllTask({Key? key}) : super(key: key);

  @override
  State<AllTask> createState() => _AssignedToMeState();
}

class _AssignedToMeState extends State<AllTask> {
  TaskRepository taskRepository = TaskRepository();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return FutureBuilder<GetAssignedTaskModel>(
      future: taskRepository.getAssignedTaskController(), // async work
      builder: (BuildContext context, AsyncSnapshot<GetAssignedTaskModel> snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting: return Text('Loading....');
          default:
            if (snapshot.hasError)
              return Text('Error: ${snapshot.error}');
            else
              return ListView.builder(
                  itemCount: snapshot.data!.result!.length,
                  itemBuilder: (context, index) {
                    var data = snapshot.data!.result![index];
                    return Stack(
                      children: [
                        Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6)
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(6),
                                          color: Colors.redAccent
                                      ),
                                      child:  Padding(
                                        padding: EdgeInsets.symmetric(horizontal: 12.0,vertical: 8),
                                        child: Text(data!.priorityName!,style: TextStyle(
                                            color: Colors.white
                                        ),),
                                      ),
                                    ),
                                    const Text('Jul 27',style: TextStyle(
                                        color: Colors.grey
                                    ),)
                                  ],
                                ),
                                const SizedBox(height: 10,),
                                Text('Fix a meeting with ${data!.leadName!}',style: TextStyle(
                                    fontWeight: FontWeight.w600
                                ),),
                                SizedBox(height: 10,),
                                Text(data.taskDesc!,
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 14
                                  ),),
                                const SizedBox(height: 30,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(children: const [
                                      Icon(Icons.calendar_today,color: Colors.grey,),
                                      SizedBox(width: 5,),
                                      Text('29 Jul 2021 10:30 AM',
                                        style: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 14
                                        ),),
                                    ],),
                                    const Text('+5 days',
                                      style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 14
                                      ),),
                                  ],
                                ),
                                const SizedBox(height: 15,),
                                Row(
                                  children: [
                                    Icon(Icons.share,color: Colors.grey,),
                                    SizedBox(width: 5,),
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
                                    const Text('+12',
                                      style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 14
                                      ),),
                                    SizedBox(width: 15,),
                                    Icon(Icons.remove_red_eye,color: Colors.grey,),
                                    SizedBox(width: 10,),
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
                                    const Text('+22',
                                      style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 14
                                      ),),
                                  ],
                                ),
                                const SizedBox(height: 15,),
                                Row(
                                  children: [
                                    Icon(Icons.send,color: Colors.grey,),
                                    SizedBox(width: 10,),
                                    Container(
                                      decoration: const BoxDecoration(
                                          shape: BoxShape.circle
                                      ),
                                      child: const CircleAvatar(
                                        radius: 12,
                                        backgroundImage: AssetImage('images/person.jpg',),
                                      ),
                                    ),
                                    SizedBox(width: 5,),
                                    Text(data!.assignedPerson!,
                                      style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 14
                                      ),)
                                  ],
                                ),
                                const SizedBox(height: 30,),
                                Row(
                                  children: const [
                                    Text('Contact',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600
                                      ),),
                                    SizedBox(width: 10,),
                                    Text('Rahat Mahmud (Chief Executive Officer)',
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 14,
                                      ),),
                                  ],
                                ),
                                Row(
                                  children:  [
                                    Container(
                                      width: 50,
                                    ),
                                    const SizedBox(width: 10,),
                                    const Text('01911111111',
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 14,
                                      ),),
                                  ],
                                ),
                                const SizedBox(height: 20,),
                                Row(
                                  children: [
                                    const Text('Status',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600
                                      ),),
                                    const SizedBox(width: 10,),
                                    Container(
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(6),
                                          border: Border.all(color: Colors.grey)
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: const [
                                            Text('Initialized',style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.w600
                                            ),),
                                            Icon(Icons.keyboard_arrow_down_outlined,color: Colors.grey,)
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                const SizedBox(height: 10,),
                                Row(
                                  children: [
                                    const Text('Pick Any',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600
                                      ),),
                                    SizedBox(width: 10,),
                                    Card(
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(100)
                                      ),
                                      child: Container(
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Icon(Icons.chat,color: primaryColor,),
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 5,),
                                    Card(
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(100)
                                      ),
                                      child: Container(
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Icon(Icons.call,color: primaryColor,),
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 5,),
                                    Card(
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(100)
                                      ),
                                      child: Container(
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Icon(Icons.messenger,color: primaryColor,),
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 5,),
                                    Card(
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(100)
                                      ),
                                      child: Container(
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Icon(Icons.more_horiz,color: primaryColor,),
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
                                        const Text('Action',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600
                                          ),),
                                        SizedBox(width: 10,),
                                        Card(
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(100)
                                          ),
                                          child: Container(
                                            decoration: BoxDecoration(
                                                shape: BoxShape.circle
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Icon(Icons.edit,color: primaryColor,),
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: 5,),
                                        Card(
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(100)
                                          ),
                                          child: Container(
                                            decoration: BoxDecoration(
                                                shape: BoxShape.circle
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Icon(Icons.delete,color: Colors.red,),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Container(
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
                                          children: const [
                                            Icon(Icons.map,color: Colors.white,),
                                            SizedBox(width: 5,),
                                            Text('Visit',style: TextStyle(
                                                color: Colors.white
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
                        )
                      ],
                    );
                  }
              );
        }
      },
    );
  }
}
