//import 'dart:js_interop' as js;
import 'package:flutter/material.dart';

/// this was a desperate attempt to get the js interop working
/// with this exposed function, you can call it from js.
/// example: console window of Chrome: window.scroll(200, 0, 'smooth')
//@js.JS('scroll')
//external set _jsScroll(js.JSFunction f);

class MyScrollPage extends StatefulWidget {
  const MyScrollPage({super.key, required this.title});

  final String title;

  @override
  State<MyScrollPage> createState() => _MyScrollPageState();
}

class _MyScrollPageState extends State<MyScrollPage> {
  late final ScrollController _scrollController;

  // void _scrollTo(int top, int left, [String? behavior]) {
  //   if (_scrollController.hasClients) {
  //     if (behavior == 'smooth') {
  //       _scrollController.animateTo(
  //         top.toDouble(),
  //         duration: const Duration(milliseconds: 500),
  //         curve: Curves.ease,
  //       );
  //     } else {
  //       _scrollController.jumpTo(top.toDouble());
  //     }
  //   }
  // }

  // void exposeScrollToJs() {
  //   _jsScroll =
  //       (js.JSAny top, js.JSAny left, [js.JSAny? behavior]) {
  //         // Convert JSAny to Dart types using asDartInt and asDartString
  //         final int dartTop = top as int;
  //         // left is ignored for vertical scroll, but you could use it for horizontal
  //         final String? dartBehavior = behavior as String;
  //         _scrollTo(dartTop, 0, dartBehavior);
  //       }.toJS;
  // }

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    //exposeScrollToJs();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const minWidth = 300.0;
    const paddingTop = 30.0;
    const paddingLeft = 16.0;
    const paddingRight = 16.0;
    var maxWidth = double.infinity;
    if (MediaQuery.of(context).size.width > 480) {
      maxWidth = 992;
    }
    // wanted some long list of text to test the scroll bar
    final List<String> textItems = [
      'Text 1: This is the first item.',
      'Text 2: This is the second item.',
      'Text 3: This is the third item.',
      'Section 8: Powers of Congress',
      'The Congress shall have Power To lay and collect Taxes, Duties, Imposts and Excises, to pay the Debts and provide for the common Defence and general Welfare of the United States; but all Duties, Imposts and Excises shall be uniform throughout the United States;',
      'To borrow Money on the credit of the United States;',
      'To regulate Commerce with foreign Nations, and among the several States, and with the Indian Tribes;',
      'To establish a uniform Rule of Naturalization, and uniform Laws on the subject of Bankruptcies throughout the United States;',
      'To coin Money, regulate the Value thereof, and of foreign Coin, and fix the Standard of Weights and Measures;',
      'To provide for the Punishment of counterfeiting the Securities and current Coin of the United States;',
      'To establish Post Offices and post Roads;',
      'To promote the Progress of Science and useful Arts, by securing for limited Times to Authors and Inventors the exclusive Right to their respective Writings and Discoveries;',
      'To constitute Tribunals inferior to the supreme Court;',
      'To define and punish Piracies and Felonies committed on the high Seas, and Offences against the Law of Nations;',
      'To declare War, grant Letters of Marque and Reprisal, and make Rules concerning Captures on Land and Water;',
      'To raise and support Armies, but no Appropriation of Money to that Use shall be for a longer Term than two Years;',
      'To provide and maintain a Navy;',
      'To make Rules for the Government and Regulation of the land and naval Forces;',
      'To provide for calling forth the Militia to execute the Laws of the Union, suppress Insurrections and repel Invasions;',
      'To provide for organizing, arming, and disciplining, the Militia, and for governing such Part of them as may be employed in the Service of the United States, reserving to the States respectively, the Appointment of the Officers, and the Authority of training the Militia according to the discipline prescribed by Congress;',
      'To exercise exclusive Legislation in all Cases whatsoever, over such District (not exceeding ten Miles square) as may, by Cession of particular States, and the Acceptance of Congress, become the Seat of the Government of the United States, and to exercise like Authority over all Places purchased by the Consent of the Legislature of the State in which the Same shall be, for the Erection of Forts, Magazines, Arsenals, dock-Yards and other needful Buildings;-And',
      'To make all Laws which shall be necessary and proper for carrying into Execution the foregoing Powers, and all other Powers vested by this Constitution in the Government of the United States, or in any Department or Officer thereof.',
    ];

    return Semantics(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(widget.title),
        ),
        body: RepaintBoundary(
          child: Directionality(
            textDirection: TextDirection.ltr,
            child: Semantics(
              identifier: 'scroll_bar',
              child: Scrollbar(
                thumbVisibility: true,
                controller: _scrollController,
                child: Semantics(
                  identifier: 'my_scroll_page_scroll_view',
                  child: SingleChildScrollView(
                    controller: _scrollController,

                    child: Semantics(
                      child: Container(
                        alignment: Alignment.topCenter,
                        child: Padding(
                          padding: const EdgeInsets.only(
                            top: paddingTop,
                            left: paddingLeft,
                            right: paddingRight,
                          ),
                          child: ConstrainedBox(
                            constraints: BoxConstraints(
                              maxWidth: maxWidth,
                              minWidth: minWidth,
                            ),

                            child: Center(
                              // Center is a layout widget. It takes a single child and positions it
                              // in the middle of the parent.
                              child: Column(
                                children:
                                    textItems.map((text) {
                                      return GestureDetector(
                                        onTap: () {
                                          showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                title: Semantics(
                                                  child: Text(
                                                    'Text Selected',
                                                  ),
                                                ),
                                                content: Text(text),
                                                actions: [
                                                  TextButton(
                                                    onPressed: () {
                                                      Navigator.of(
                                                        context,
                                                      ).pop();
                                                    },
                                                    child: const Text('Close'),
                                                  ),
                                                ],
                                              );
                                            },
                                          );
                                        },
                                        child: Container(
                                          margin: const EdgeInsets.only(
                                            bottom: 12.0,
                                          ),
                                          padding: const EdgeInsets.all(16.0),
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                              color: Colors.black,
                                              width: 1.0,
                                            ),
                                            borderRadius: BorderRadius.circular(
                                              8.0,
                                            ),
                                          ),
                                          child: Semantics(
                                            identifier: 'text_item',
                                            child: Text(
                                              text,
                                              style: const TextStyle(
                                                fontSize: 18.0,
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    }).toList(),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
