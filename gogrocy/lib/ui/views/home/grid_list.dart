import 'package:flutter/material.dart';
import 'package:gogrocy/core/models/ProductsByCity.dart';
import 'package:gogrocy/core/services/navigation_service.dart';
import 'package:gogrocy/service_locator.dart';
import 'package:gogrocy/ui/shared/constants.dart' as constants;

class GridList extends StatefulWidget {
  final List<Result> resultList;

  GridList(this.resultList);

  @override
  _GridListState createState() => _GridListState();
}

class _GridListState extends State<GridList>
    with AutomaticKeepAliveClientMixin {
  final ScrollController _scrollController = ScrollController();
  final String baseImgUrl = constants.imageBaseUrl;

  final NavigationService _navigationService = locator<NavigationService>();

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    if (widget.resultList.length != 0)
      return GridView.builder(
          itemCount: (widget.resultList.length>=8)?8:widget.resultList.length,
          shrinkWrap: true,
          controller: _scrollController,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, childAspectRatio: 1, crossAxisSpacing: 8.0),
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                _navigationService.navigateTo('product',
                    arguments: widget.resultList[index]);
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black26),
                      borderRadius: BorderRadius.all(Radius.circular(10.0))),
                  child: Column(
                    children: <Widget>[
                      Flexible(
                          flex: 4,
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 8, right: 8, top: 8),
                            child: ClipRRect(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8)),
                              child: Container(
                                color: Colors.black12,
                                height:
                                    constants.HomePageConfig.productGridHeight *
                                        4 /
                                        6,
                                width: double.maxFinite,
                                child: Image(
                                  image: NetworkImage(
                                      'https://res.cloudinary.com/gogrocy/image/upload/v1/' +
                                          widget.resultList[index].image),
                                  fit: BoxFit.fitWidth,
                                ),
                              ),
                            ),
                          )),
                      Flexible(
                        flex: 2,
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: <Widget>[
                              Flexible(
                                  flex: 8,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 8, top: 4, bottom: 4),
                                    child: Text(
                                      widget.resultList[index].name,
                                      style: TextStyle(
                                          fontSize: 14.0,
                                          fontWeight: FontWeight.w500),
                                      maxLines: 2,
                                    ),
                                  )),
                              Flexible(
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      right: 8, top: 4, bottom: 4),
                                  child: Text(
                                    '₹' + widget.resultList[index].price,
                                    style: TextStyle(
                                        fontSize: 18.0,
                                        color: Color(0xff5FD900),
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                                flex: 7,
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          });
    else {
      return emptyProducts();
    }
  }

  Widget emptyProducts() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(
              width: 60.0 * constants.scaleRatio,
              height: 60.0 * constants.scaleRatio,
              child: Image(
                image: AssetImage("assets/images/no_products.png"),
              )),
          Text(
            "You don't have any orders",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 18.0,
                fontFamily: 'Gilroy',
                fontWeight: FontWeight.bold),
          ),
          Container(
            height: 80,
          )
        ],
      ),
    );
  }
}
