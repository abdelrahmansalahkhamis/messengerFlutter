import 'package:flutter/material.dart';
import 'package:messenger_app_flutter/modules/shop_app/login/shop_login_screen.dart';
import 'package:messenger_app_flutter/shared/components/components.dart';
import 'package:messenger_app_flutter/shared/network/local/cache_helper.dart';
import 'package:messenger_app_flutter/shared/styles/colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BoardingModel {
  String image;
  String title;
  String body;

  BoardingModel(this.image, this.title, this.body);
}

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  var boardController = PageController();

  bool isLast = false;

  List<BoardingModel> board = [
    BoardingModel(
        'assets/images/flowers.jpeg', 'On board 1 Title', 'On board 1 body'),
    BoardingModel(
        'assets/images/flowers.jpeg', 'On board 2 Title', 'On board 2 body'),
    BoardingModel(
        'assets/images/flowers.jpeg', 'On board 3 Title', 'On board 3 body')
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            defaultTextButton(() {
              submit();
              //navigateAndFinish(context, ShopLoginScreen());
            }, 'SKIP')
          ],
        ),
        body: Padding(
          padding: EdgeInsets.all(30.0),
          child: Column(
            children: [
              Expanded(
                child: PageView.builder(
                  physics: BouncingScrollPhysics(),
                  controller: boardController,
                  itemBuilder: (context, index) => buildBoardItem(board[index]),
                  itemCount: board.length,
                  onPageChanged: (int index) {
                    if (index == board.length - 1) {
                      setState(() {
                        isLast = true;
                      });
                    } else {
                      setState(() {
                        isLast = false;
                      });
                    }
                  },
                ),
              ),
              SizedBox(
                height: 40.0,
              ),
              Row(
                children: [
                  SmoothPageIndicator(
                    controller: boardController,
                    count: board.length,
                    effect: ExpandingDotsEffect(
                        dotColor: Colors.grey,
                        dotHeight: 10.0,
                        expansionFactor: 4,
                        dotWidth: 10.0,
                        spacing: 5.0,
                        activeDotColor: defaultColor),
                  ),
                  Spacer(),
                  FloatingActionButton(
                    onPressed: () {
                      if (isLast) {
                        //navigateTo(context, ShopLoginScreen());
                        submit();
                      } else {
                        boardController.nextPage(
                            duration: Duration(milliseconds: 750),
                            curve: Curves.bounceInOut);
                      }
                    },
                    child: Icon(Icons.arrow_forward_ios),
                  )
                ],
              )
            ],
          ),
        ));
  }

  void submit() {
    CacheHelper.saveData('onBoarding', true).then((value) {
      if (value) {
        navigateAndFinish(context, ShopLoginScreen());
      }
    });
    // CacheHelper.saveData('onBoarding', true).then((value) {
    //   if (value) {
    //     navigateAndFinish(context, ShopLoginScreen());
    //   }
    // });
  }

  Widget buildBoardItem(BoardingModel board) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: Image(image: AssetImage('${board.image}'))),
          SizedBox(
            height: 10.0,
          ),
          Text(
            '${board.title}',
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 15.0,
          ),
          Text(
            '${board.body}',
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      );
}
