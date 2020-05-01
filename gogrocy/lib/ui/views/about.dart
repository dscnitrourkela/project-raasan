import 'package:flutter/material.dart';
import 'package:gogrocy/ui/widgets/appbars/secondary_appbar.dart';
import 'package:url_launcher/url_launcher.dart';

final String aboutText =
    "GoGrocy is an online grocery and essentials providing service operating in cities of Odisha, India (began at Jeypore, Koraput). This idea was executed amidst the outrageous pandemic caused by COVID-19 that has forced lives and livelihood to a standstill. While India has taken to a state-enforced lockdown, it has increasingly become difficult for people to avail necessary daily supplements from home. In this backdrop, GoGrocy provides home delivery to customers.\n\nWe are built to scale up and if you are a vendor or someone who can help us scale up to your region, contact us.\nMobile: +91 7978877258\nEmail: gogrocy33@gmail.com\nGSTIN: 21AHHPC7274N1Z7\nLegal Name: KIRANKUMAR SUBUDHI CHINNAR\nAddress: BIDYADHAR MARKET, BIDYADHAR MARKET, M.G.ROAD, JEYPORE, Koraput, Odisha, 764001";

class AboutView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context).pop();
        return false;
      },
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: SecondaryAppBar('About'),
          body: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Image.asset(
                  'assets/dsc_logo.png',
                  fit: BoxFit.scaleDown,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 25, right: 25, top: 20, bottom: 30),
                  child: Text(
                    aboutText,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'PfDin',
                      color: Color.fromRGBO(25, 39, 45, 1),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 10),
                  child: Center(
                    child: Text(
                      "The Team",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    contactCard(context, "V Girish | Founder", ""),
                    contactCard(context, "Abel Mathew | App Developer",
                        "https://github.com/DesignrKnight"),
                    contactCard(context, "Chinmay Kabi | App Developer",
                        "https://github.com/Chinmay-KB"),
                    contactCard(context, "Smarak Das | App Developer",
                        "https://github.com/Thesmader"),
                    contactCard(context, "Reuben Abraham | Designer",
                        "http://reubenabraham.com/"),
                    contactCard(context, "Saumyaa Suneja | Designer",
                        "http://saumyaasuneja.com/"),
                    contactCard(context, "Harish | Web Developer",
                        "https://www.linkedin.com/in/harish-r-76272221/"),
                    contactCard(context, "Vishal Rana | Web Developer",
                        "https://www.linkedin.com/in/vishal36"),
                    contactCard(context, "Sanjay Sanapathi | Web Developer",
                        "https://www.linkedin.com/in/sanjay-kumar-sanapathi-a818a5151/")
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget contactCard(BuildContext context, String name, String contact) {
    //var queryWidth = MediaQuery.of(context).size.width;
    var textScaleFactor = MediaQuery.of(context).textScaleFactor;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          if (contact != "") {
            _launchURL(contact);
          } else {}
        },
        child: Card(
          elevation: 5.0,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Center(
                  child: Text(
                    name,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: textScaleFactor * 20,
                        fontFamily: 'PfDin',
                        fontWeight: FontWeight.w800),
                  ),
                ),
                Text(
                  contact,
                  style: TextStyle(
                    fontSize: textScaleFactor * 15,
                    fontFamily: 'PfDin',
                    fontWeight: FontWeight.w500,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
