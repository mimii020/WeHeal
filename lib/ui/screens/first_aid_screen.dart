import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:health_care_app/ui/screens/first_screen.dart';
import 'package:health_care_app/ui/widgets/first_aid_page.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class FirstAid extends StatefulWidget {

  const FirstAid({super.key});

  @override
  State<FirstAid> createState() => _FirstAidState();
}

class _FirstAidState extends State<FirstAid> {
  PageController controller=PageController();
  bool lastPage=false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: controller,
            onPageChanged: (index){
              setState(() {
                lastPage=(index==3)? true:false;
              });
              
            },
            children: [
              FirstAidPage(
               animation: "https://lottie.host/8500945e-7326-407f-a48a-f409ebca18f1/NGQzu0HsfB.json", 
               color: Color(0xffE1F2F8), 
               instruction: "If the person is unconscious, tilt their head back slightly and lift their chin to open the airway."
              ),
              FirstAidPage(
                animation: "https://lottie.host/786824fd-870c-477a-a952-893664832487/vt7r3WwPht.json", 
                color: Color(0xffABC3E6), 
                instruction: "If the person is not breathing, start CPR "
              ),
              FirstAidPage(
                animation: "https://lottie.host/786824fd-870c-477a-a952-893664832487/vt7r3WwPht.json", 
                color: Color.fromARGB(255, 122, 158, 212), 
                instruction: "if there's bleeding, apply pressure to the wound with a clean cloth and elevate the injured limb above the heart"
                ),
                FirstAidPage(
                  animation: "https://lottie.host/5a22c1d3-5184-49a5-bb49-54432e4641b0/sHeBcFZowF.json",
                  color: Color(0xffFFDDEE),
                  instruction: "If the persson is in shock, Lay them down on their back with their legs elevated slightly Keep them warm and covered",
                )
            ],
          ),
          
          Container(
            alignment: Alignment(0,0.8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                    TextButton(
                       onPressed: ()=>Navigator.pushReplacement(context, MaterialPageRoute(builder: (covariant)=>FirstScreen())), 
                       child: Text("skip")
                    ),
                    SmoothPageIndicator(controller: controller, count: 4),
                    
                   lastPage?
                    TextButton(
                      onPressed: (){
                       Navigator.pushReplacement(context, MaterialPageRoute(builder: (covariant)=>FirstScreen()));
                      }, 
                      child: Text("done")
                      ): TextButton(
                      onPressed: (){
                        controller.nextPage(
                          duration: Duration(milliseconds: 500), 
                          curve: Curves.easeIn
                          );
                      }, 
                      child: Text("next")
                      )

                 ],
            ) 
          ),
        ]
      ),
    );
  }
}