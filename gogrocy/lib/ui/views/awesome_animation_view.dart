import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gogrocy/core/viewModels/animations_model.dart';
import 'package:gogrocy/service_locator.dart';
import 'package:gogrocy/ui/shared/constants.dart' as constants;
import 'package:gogrocy/ui/widgets/details_form.dart';
import 'package:provider/provider.dart';

class AwesomeAnimationView extends StatefulWidget {
  @override
  _AwesomeAnimationViewState createState() => _AwesomeAnimationViewState();
}

class _AwesomeAnimationViewState extends State<AwesomeAnimationView>
    with SingleTickerProviderStateMixin {
  AnimationController _womanScaleController;
  Animation<double> womanScaleAnimation;
  AwesomeAnimationView awesomeAnimationView = locator<AwesomeAnimationView>();

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
    return Provider<AnimationsModel>(
      create: (context) => AnimationsModel(controller: _womanScaleController),
      child: Consumer<AnimationsModel>(
        builder: (context, model, child) => Scaffold(
          backgroundColor: Colors.white,
          body: Stack(
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
                left: first ? 40.0 : 20.0,
                top: first ? 80.0 : 40.0,
                child: SizedBox(
                  height: constants.screenHeight,
                  width: constants.screenWidth,
                  child: ScaleTransition(
                    scale: model.awesomeTextScaleAnimation,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        RichText(
                          text: TextSpan(
                            text: '',
                            children: <TextSpan>[
                              TextSpan(
                                text: 'Awesome',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 48.0,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Gilroy',
                                ),
                              ),
                              TextSpan(
                                text: '!',
                                style: TextStyle(
                                    color: Colors.green,
                                    fontSize: 48.0,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Gilroy'),
                              )
                            ],
                          ),
                        ),
                        AnimatedCrossFade(
                          crossFadeState: first
                              ? CrossFadeState.showFirst
                              : CrossFadeState.showSecond,
                          duration: Duration(milliseconds: 400),
                          firstChild: Text(
                            'Welcome on board',
                            style: TextStyle(
                                color: Colors.green,
                                fontSize: 18.0,
                                fontFamily: 'Gilroy',
                                fontWeight: FontWeight.bold),
                          ),
                          secondChild: SizedBox(
                            width: 230.0,
                            child: Text(
                              'A couple more things before we get you started',
                              style: TextStyle(
                                  color: Colors.green,
                                  fontSize: 18.0,
                                  fontFamily: 'Gilroy',
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        SizedBox(height: 50.0),
                        DetailsForm(_womanScaleController),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
