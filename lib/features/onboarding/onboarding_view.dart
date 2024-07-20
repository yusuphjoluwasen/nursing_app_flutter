import 'package:flutter/material.dart';
import 'package:nursing_mother_medical_app/config/app_colors.dart';
import 'package:nursing_mother_medical_app/config/app_strings.dart';
import 'package:nursing_mother_medical_app/features/onboarding/onboarding_items.dart';
import 'package:nursing_mother_medical_app/features/onboarding/welcome.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingView extends StatefulWidget {
  const OnboardingView({super.key});

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {
  final controller = OnboardingItems();
  final pageController = PageController();

  bool isLastPage = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,

      bottomSheet: Container(
        color:AppColors.white,
        padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
        child: isLastPage? getStarted() : Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [

            //Skip Button
            TextButton(
                onPressed: ()=>pageController.jumpToPage(controller.items.length-1),
                child: Text(AppStrings.skip,
                  style:Theme.of(context).textTheme.bodySmall?.copyWith(color: AppColors.black))),

            //Indicator
            SmoothPageIndicator(
              controller: pageController,
              count: controller.items.length,
              onDotClicked: (index)=> pageController.animateToPage(index,
                  duration: const Duration(milliseconds: 600), curve: Curves.easeIn),
              effect: const WormEffect(
                dotHeight: 12,
                dotWidth: 12,
                activeDotColor: AppColors.primary,
              ),
            ),

            //Next Button
            TextButton(
                onPressed: ()=>pageController.nextPage(
                    duration: const Duration(milliseconds: 600), curve: Curves.easeIn),
                child:Text(AppStrings.next,
                    style:Theme.of(context).textTheme.labelSmall?.copyWith(color: AppColors.black))),


          ],
        ),
      ),
      body:  SafeArea(child:Container(
        color: Colors.white,
        margin: const EdgeInsets.symmetric(horizontal: 15),
        child: PageView.builder(
            onPageChanged: (index)=> setState(()=> isLastPage = controller.items.length-1 == index),
            itemCount: controller.items.length,
            controller: pageController,
            itemBuilder: (context,index){
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(child:
                  Row(mainAxisSize: MainAxisSize.min,children: [
                    Text(
                      controller.items[index].firstTitle,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(color: AppColors.black),
                    ),
                    const SizedBox(width: 5),
                    Text(controller.items[index].secondTitle,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(color: AppColors.primary),),
                  ])
                  ),
                  const SizedBox(height: 40),
                   Center(child: Image.asset(controller.items[index].image,width: 280,height: 280)),
                  const SizedBox(height: 40),
                  Text(controller.items[index].descriptions,
                    style:Theme.of(context).textTheme.bodySmall?.copyWith(color: AppColors.black),textAlign: TextAlign.center),
                ],
              );

            }),
      ),
    )
    );
  }

  //Now the problem is when press get started button
  // after re run the app we see again the onboarding screen
  // so lets do one time onboarding

  //Get started button

  Widget getStarted(){
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: AppColors.primary
      ),
      width: MediaQuery.of(context).size.width * .9,
      height: 45,
      child: TextButton(
          onPressed: ()async{
            final pres = await SharedPreferences.getInstance();
            pres.setBool("onboarding", true);

            //After we press get started button this onboarding value become true
            // same key
            if(!mounted)return;
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>WelcomePage()));
          },
          child: const Text("Get started",style: TextStyle(color: Colors.white),)),
    );
  }
}
