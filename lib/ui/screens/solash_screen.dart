import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:health_care_app/ui/screens/first_screen.dart';
import 'package:health_care_app/ui/widgets/splash_animated_text.dart';
import 'package:lottie/lottie.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
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
                Container(
                  color: Color(0xff122965),
                  child: Center(child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      LottieBuilder.network("https://lottie.host/5a22c1d3-5184-49a5-bb49-54432e4641b0/sHeBcFZowF.json"),
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Center(
                          child:SplashText(
                            text:"Welcome to our community, where we heal each other..." ,
                            textStyle: TextStyle(color:Colors.white, fontSize: 17),
                          )
                          
                        ),
                      )
                    ],
                  ),)
                ),
                Container(
                  color: Color(0xff143965),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        LottieBuilder.network("https://lottie.host/6c685742-c9ab-4145-9705-617faf6737e8/XOhrq6D3TI.json"),
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Center(
                            child:SplashText(
                              text: "You can chat with doctors and patients from everwhere...", 
                              textStyle: TextStyle(color:Colors.white, fontSize: 17),
                              )
                            
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Container(
                color:Color(0xffABC3E6) ,
                child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        LottieBuilder.network("https://lottie.host/28368115-786f-4d44-b0a3-f29ddacf861c/Ofm9FvSnkw.json"),
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Center(
                            child: SplashText(
                              text:"You can schedule your medications" ,
                              textStyle: TextStyle(color:Colors.deepPurple, fontSize: 17),
                             )
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Container(
                  color: Color(0xffFFDDEE),
                  child:Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        LottieBuilder.network("https://lottie.host/4ce4d00b-e76f-46c4-9ad9-1b1b68b8c1e1/CzwWWSCh4K.json"),
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Center(
                            child: SplashText(
                              text: "And request volunteer services from other patients and doctors",
                              textStyle: TextStyle(color:Colors.deepPurple, fontSize: 17)
                              )
                             
                          ),
                        )
                      ],
                    ),
                  ),
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
          
        ],
      ),
    );
  }
}