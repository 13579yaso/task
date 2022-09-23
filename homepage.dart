import 'dart:async';

import 'package:flutter/material.dart';
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {



  //now creat busines logic of app
  int seconds=0,minutes=0,hours=0;
  String digitSeconds="00",digitMinutes="00",digitHours="00";
  Timer? timer;
  bool started =false;
List labs=[];


//create stop timer function
  void stop(){
    timer!.cancel();
    setState((){
     started=false;
    });
  }
  //create reset function
  void reset(){
    timer!.cancel();
    setState((){
     seconds=0;
      hours=0;
      minutes=0;

      digitHours="00";
      digitMinutes="00";
      digitSeconds="00";

     started=false;
    });
  }
  void addLabs(){
    String lab="$digitHours:$digitMinutes:$digitSeconds";
    setState((){
      labs.add(lab);
    });
    }
    //create start timer function
  void start(){
    started=true;
   timer=Timer.periodic(Duration(seconds: 1),
           (timer) {
     int localSeconds=seconds +1;
     int localMinutes=minutes;
     int localHours=hours;
     if(localSeconds> 59){
       if(localMinutes> 59){
         localHours++;
         localMinutes=0;
       }else{
         localMinutes++;
         localSeconds=0;
       }
     }
     setState((){
     seconds=localSeconds;
     minutes=localMinutes;
     hours=localHours;
     digitSeconds=(seconds >=10)?"$seconds":"0$seconds";
     digitHours=(hours >=10)?"$hours":"0$hours";
     digitMinutes=(minutes >=10)?"$minutes":"0$minutes";
     });

   });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
  backgroundColor:const Color (0xFF1C2757),
      body: SafeArea(
        child:Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
         Center(
           child: Text(
             'StopWatch App',style: TextStyle(
             color: Colors.white,
             fontSize: 28,
             fontWeight: FontWeight.bold,
           ),
           ),
         ),
              SizedBox(
                height: 20,
              ),
              Center(
                child: Text(
                  '$digitHours:$digitMinutes:$digitSeconds',style: TextStyle(
                  color: Colors.white,
                  fontSize: 75,
                  fontWeight: FontWeight.w500,
                ),
                ),
              ),
              Container(
                height: 300,
                decoration: BoxDecoration(
                  color: Color(0xFF323F68),
                  borderRadius: BorderRadius.circular(8)
                ),
                //add a let's builder
                child: ListView.builder(
                  itemCount: labs.length,
                    itemBuilder:(context,index){
                       return Padding(
                         padding: const EdgeInsets.all(16.0),
                         child: Row(
                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                           children: [
                             Text(
                               'Lab n° ${index +1}',style: TextStyle(
                               color: Colors.white,
                               fontSize: 16,
                             ),
                             ),
                             Text(
                               '${labs[index]}',style: TextStyle(
                               color: Colors.white,
                               fontSize: 16,
                             ),
                             ),
                           ],
                         ),
                       );
                    },
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(child:
                  RawMaterialButton(
                    onPressed: (){
                      (!started)?start():stop();
                    },
                    shape:const StadiumBorder(
                      side: BorderSide(
                        color: Colors.blue,
                      )
                    ),
                    child:Text(
                      (!started)?"Start":"Pause",style: TextStyle(
                      color: Colors.white,

                    ),
                    ) ,
                  )
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  IconButton(
                    color: Colors.white,
                      onPressed:(){
                      addLabs();
                      },
                      icon: Icon(Icons.flag),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Expanded(child:
                  RawMaterialButton(
                    onPressed: (){
                      reset();
                    },
                    fillColor:Colors.blue,
                    shape:const StadiumBorder(
                    ),
                    child:Text(
                      'Reset',style: TextStyle(
                      color: Colors.white,

                    ),
                    ) ,
                  )
                  ),
                ],
              )

            ],
          ),
        ) ,
      ),
    );
  }
}
