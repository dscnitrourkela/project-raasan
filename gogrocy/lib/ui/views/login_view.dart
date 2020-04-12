import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gogrocy/core/viewModels/login_model.dart';
import 'package:gogrocy/service_locator.dart';
import 'package:gogrocy/ui/widgets/login_text_field_widget.dart';
import 'package:gogrocy/ui/widgets/onboarding_widget.dart';
import 'package:gogrocy/ui/widgets/text_widgets.dart';
import 'package:provider/provider.dart';
import 'package:gogrocy/ui/shared/constants.dart' as constants;
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class LoginView extends StatelessWidget {
  final controller = PageController();

  @override
  Widget build(BuildContext context) {
    constants.mediaQueryData = MediaQuery.of(context);
    return ChangeNotifierProvider<LoginModel>(
        create: (_) => locator<LoginModel>(),
        child: Consumer<LoginModel>(
          builder: (context, model, child) {
            return SafeArea(
              child: Scaffold(
                resizeToAvoidBottomInset: false,
//                resizeToAvoidBottomPadding: false,
                backgroundColor: Colors.white,
                body: Stack(
                  children: <Widget>[
                    Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        TitleText(),
                        OnBoardingWidget(controller),
                        SmoothPageIndicator(
                          controller: controller,
                          count: 3,
                          effect: WormEffect(
                            activeDotColor: Colors.green,
                            dotColor: Colors.lightGreen,
                            radius: 8.0,
                            strokeWidth: 2.0,
                            dotHeight: 10.0,
                            dotWidth: 10.0,
                            spacing: 10.0,
                          ),
                        ),
                        SizedBox(
                          height: 250.0,
                        ),
                      ],
                    ),
                    IgnorePointer(
                      child: AnimatedOpacity(
                        duration: Duration(milliseconds: 180),
                        opacity: (MediaQuery.of(context).viewInsets.bottom>0)?0.5:0.0,
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 0, sigmaY: 0),
                          child: Container(
                            color: Colors.black,
                            height: constants.screenHeight,
                            width: constants.screenWidth,
                          ),
                        ),
                      ),
                    ),
                    LoginTextFieldWidget(),
                  ],
                ),
              ),
            );
          },
        ));
  }
}
