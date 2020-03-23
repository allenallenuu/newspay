import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:wpay_app/view/widgets/notificationCenter.dart';
import 'package:wpay_app/view_model/state_lib.dart';

class HomeNoticeView extends StatefulWidget {
  @override
  _HomeNoticeView createState() => _HomeNoticeView();
}

class _HomeNoticeView extends State<HomeNoticeView> {
  List _noticeStringList = [
    "恭喜1**2赚取 120元！",
    "恭喜1**2赚取 119元！",
    "恭喜1**2赚取 118元！",
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
            width: MediaQuery.of(context).size.width,
            height: (MediaQuery.of(context).size.width-30)/3.375,
            margin: EdgeInsets.only(left: 15, right: 15, top: 5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              image: DecorationImage(
                image: AssetImage(Tools.imagePath('home_notice')),
                fit: kIsWeb ? BoxFit.fitHeight : BoxFit.fitWidth,
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: Container(
                    height: 30,
                    alignment: Alignment.center,
                    child: Swiper(
                      itemCount: _noticeStringList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ClipRRect(
                          borderRadius:
                              new BorderRadius.all(new Radius.circular(10.0)),
                          child: Container(
                            height: 30,
                            alignment: Alignment.center,
                            child: Text(
                              '${_noticeStringList[index]}',
                              style:
                                  TextStyle(fontSize: 16, color: Colors.white),
                            ),
                          ),
                        );
                      },
                      scrollDirection: Axis.vertical,
                      autoplay: true,
                      autoplayDelay: 3000,
                      autoplayDisableOnInteraction: true,
                      duration: 600,
                      itemHeight: 28,
                      pagination: null,
                      onTap: (int index) {
//                  print("index-----" + _noticeStringList[index]);
                        NotificationCenter.instance
                            .postNotification(NotificationCenter.eventJumpToPage, 1);
                      },
                    ),
                  ),
                ),
              ],
            ),
          );
  }
}
