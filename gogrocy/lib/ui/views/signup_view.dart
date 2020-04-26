import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gogrocy/core/viewModels/signup_view_model.dart';
import 'package:gogrocy/service_locator.dart';
import 'package:gogrocy/ui/shared/constants.dart' as constants;
import 'package:gogrocy/ui/widgets/details_form.dart';
import 'package:provider/provider.dart';

class SignUpView extends StatefulWidget {
  final String mobile;
  final String countryCode;

  SignUpView({this.mobile, this.countryCode});

  @override
  _SignUpViewState createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView>
    with SingleTickerProviderStateMixin {
  AnimationController _womanScaleController;
  Animation<double> womanScaleAnimation;
  SignUpView awesomeAnimationView = locator<SignUpView>();

  //Animations animations;
  bool first = true;

  AnimationController get womanScaleController => AnimationController(
        duration: Duration(seconds: 2),
        vsync: this,
      )..addListener(() {
          if (_womanScaleController.value > 0.5)
            setState(() {
              first = false;
            });
        });

//  AnimationController get womanScaleController => _womanScaleController;

  @override
  void initState() {
    super.initState();
    //Animation curve = CurvedAnimation(parent: womanScaleController, curve: Curves.easeOut);
    _womanScaleController = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
    )..addListener(() {
        if (_womanScaleController.value > 0.5)
          setState(() {
            first = false;
          });
      });

    //animations = Animations(controller: _womanScaleController);
    _womanScaleController.forward();
  }

  @override
  void dispose() {
    super.dispose();
    _womanScaleController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SignUpViewModel>(
      create: (context) => SignUpViewModel(
          controller: _womanScaleController, mobile: widget.mobile, countryCode: widget.countryCode),
      child: Consumer<SignUpViewModel>(
        builder: (context, model, child) => Scaffold(
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: SizedBox(
              height: constants.screenHeight + 60.0,
              width: constants.screenWidth,
              child: Stack(
                children: <Widget>[
                  Positioned(
                    right: 0.0,
                    child: SlideTransition(
                      position: Tween<Offset>(
                        begin: Offset.zero,
                        end: Offset(1.0, 0.5),
                      ).animate(CurvedAnimation(
                        parent: _womanScaleController,
                        curve: Interval(0.5, 1.0, curve: Curves.easeOut),
                      )),
                      child: ScaleTransition(
                        scale: model.womanScaleAnimation,
                        child: Image.asset(
                          'assets/images/awesome_woman.png',
                          height: constants.screenHeight,
                          width: constants.screenWidth,
                        ),
                      ),
                    ),
                  ),
                  AnimatedPositioned(
                    duration: Duration(milliseconds: 500),
                    curve: Curves.easeOut,
                    left: first ? 40.0 : 0.0,
                    top: first ? 80.0 : 40.0,
                    child: ScaleTransition(
                      scale: model.awesomeTextScaleAnimation,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        verticalDirection: VerticalDirection.down,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(
                                left: 0.047 * constants.screenWidth),
                            child: RichText(
                              text: TextSpan(
                                text: '',
                                children: <TextSpan>[
                                  TextSpan(
                                    text: 'Awesome',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 0.113 * constants.screenWidth,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Gilroy',
                                    ),
                                  ),
                                  TextSpan(
                                    text: '!',
                                    style: TextStyle(
                                      color: Colors.green,
                                      fontSize: 0.113 * constants.screenWidth,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Gilroy',
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                left: 0.047 * constants.screenWidth),
                            child: AnimatedCrossFade(
                              crossFadeState: first
                                  ? CrossFadeState.showFirst
                                  : CrossFadeState.showSecond,
                              duration: Duration(milliseconds: 400),
                              firstChild: Text(
                                'Welcome on board',
                                style: TextStyle(
                                  color: Colors.green,
                                  fontSize: 0.042 * constants.screenWidth,
                                  fontFamily: 'Gilroy',
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              secondChild: SizedBox(
                                width: 0.543 * constants.screenWidth,
                                child: Text(
                                  'A couple more things before we get you started',
                                  style: TextStyle(
                                    color: Colors.green,
                                    fontSize: 0.042 * constants.screenWidth,
                                    fontFamily: 'Gilroy',
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 0.035 * constants.screenHeight),
                          Padding(
                            padding: EdgeInsets.only(
                                left: 0.047 * constants.screenWidth),
                            child: DetailsForm(
                                _womanScaleController, widget.mobile, widget.countryCode),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
