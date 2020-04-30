import 'package:flutter/material.dart';
import 'package:gogrocy/core/enums/viewstate.dart';
import 'package:gogrocy/core/viewModels/search_view_model.dart';
import 'package:gogrocy/ui/views/base_view.dart';
import 'package:gogrocy/ui/views/category/product_list.dart';
import 'package:gogrocy/ui/shared/colors.dart' as colors;
import 'package:gogrocy/ui/shared/constants.dart' as constants;

class SearchView extends StatelessWidget {
  final focusNode = FocusNode();
  final TextEditingController _textEditingController =
      new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BaseView<SearchViewModel>(
      onModelReady: (model) {
        model.getAllProducts("");
      },
      builder: (context, model, child) {
        return SafeArea(
            child: Scaffold(
                resizeToAvoidBottomPadding: false,
                body: Stack(
                  children: <Widget>[
                    (model.state == ViewState.Idle)
                        ? ((!model.isSearchNull)
                            ? (!model.searchResults.empty)
                                ? (Center(
                                    child: Column(
                                      children: <Widget>[
                                        Container(
                                          height: constants.screenHeight * 0.13,
                                        ),
                                        CategoryProductList(
                                            model.searchResults.result),
                                      ],
                                    ),
                                  ))
                                : Center(
                                    child: (Column(
                                      children: <Widget>[
                                        Container(
                                            height: 80,
                                            child: Image(
                                              image: AssetImage(
                                                  'assets/images/no_products.png'),
                                            )),
                                        Text(
                                          "We don't have that product right now",
                                          style: TextStyle(
                                              fontSize: 18.0,
                                              fontFamily: 'Gilroy',
                                              fontWeight: FontWeight.bold),
                                        )
                                      ],
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      mainAxisSize: MainAxisSize.min,
                                    )),
                                  )
                            : Center(
                                child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Icon(
                                    Icons.search,
                                    size: 60,
                                    color: Colors.black12,
                                  ),
                                  Text(
                                    "Search for your favourite products",
                                    style: TextStyle(
                                        fontSize: 18.0,
                                        fontFamily: 'Gilroy',
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              )))
                        : Center(child: CircularProgressIndicator()),
                    Align(
                      alignment: Alignment(0, -0.95),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          color: Colors.transparent,
                          child: Material(
                            elevation: 5,
                            child: Theme(
                              data: ThemeData(
                                  primaryColor: Colors.white,
                                  primaryColorDark: Colors.white),
                              child: TextField(
                                autofocus: true,
                                textInputAction: TextInputAction.search,
                                focusNode: focusNode,
                                controller: _textEditingController,
                                cursorColor: colors.PRIMARY_COLOR,
                                decoration: new InputDecoration(
                                    border: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                    enabledBorder: InputBorder.none,
                                    errorBorder: InputBorder.none,
                                    disabledBorder: InputBorder.none,
                                    suffixIcon: (_textEditingController
                                                .text.length !=
                                            0)
                                        ? GestureDetector(
                                            onTap: () {
                                              _textEditingController.clear();
                                              FocusScope.of(context)
                                                  .requestFocus(focusNode);
                                            },
                                            child: Icon(Icons.cancel))
                                        : Container(
                                            width: 0,
                                            height: 0,
                                          ),
                                    prefixIcon: GestureDetector(
                                      onTap: () => Navigator.pop(context),
                                      child: Icon(
                                        Icons.arrow_back,
                                        color: Colors.black38,
                                      ),
                                    ),
                                    contentPadding: EdgeInsets.all(15),
                                    hintText: "Search"),
                                onSubmitted: (value) {
                                  model.getAllProducts(value);
                                },
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                )));
      },
    );
  }
}
