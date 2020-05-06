import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gogrocy/core/viewModels/login_model.dart';
import 'package:gogrocy/ui/views/base_view.dart';
import 'package:gogrocy/ui/widgets/login_text_field_widget.dart';
import 'package:gogrocy/ui/widgets/onboarding_widget.dart';
import 'package:gogrocy/ui/widgets/text_widgets.dart';
import 'package:gogrocy/ui/widgets/vertical_spaces.dart';
import 'package:gogrocy/ui/shared/constants.dart' as constants;

class LoginView extends StatelessWidget {
  final controller = PageController();

  @override
  Widget build(BuildContext context) {
    return BaseView<LoginModel>(
      builder: (context, model, child) => SafeArea(
        child: Scaffold(
          key: model.loginScaffoldKey,
          resizeToAvoidBottomInset: false,
//                resizeToAvoidBottomPadding: false,
          backgroundColor: Colors.white,
          body: Stack(
            children: <Widget>[
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Hero(tag: 'GoGrocy', child: TitleText()),
                  OnBoardingWidget(controller),
                  VerticalSpaces.extraLarge,
                  /*SmoothPageIndicator(
                    controller: controller,
                    count: 3,
                    effect: WormEffect(
                      activeDotColor: Colors.green,
                      dotColor: Colors.lightGreen,
                      radius: 0.019 * constants.screenWidth,
                      strokeWidth: 0.005 * constants.screenWidth,
                      dotHeight: 0.024 * constants.screenWidth,
                      dotWidth: 0.024 * constants.screenWidth,
                      spacing: 0.024 * constants.screenWidth,
                    ),
                  ),*/
                  //VerticalSpaces.extraLarge,
                ],
              ),
              IgnorePointer(
                child: AnimatedOpacity(
                  duration: Duration(milliseconds: 180),
                  opacity: (MediaQuery.of(context).viewInsets.bottom > 0)
                      ? 0.5
                      : 0.0,
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
      ),
    );
  }
}
