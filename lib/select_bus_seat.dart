import 'package:decor_ride/app/extensions/theme_extension.dart';
import 'package:flutter/material.dart';

class SelectSeatScreen extends StatefulWidget {
  const SelectSeatScreen({super.key});

  @override
  State<SelectSeatScreen> createState() => _SelectSeatScreenState();
}

class _SelectSeatScreenState extends State<SelectSeatScreen> {
  int setIndex = 5;
  int totalPrice = 0;
  List<int> bookedSeats = [
    0,
    3,
    4,
    5,
    6,
    18,
    20,
    21,
    22,
    23,
    24,
    25,
    26,
    27,
    28,
    29,
    53,
    54,
    60,
    79,
    72,
    73,
    75
  ];
  List<int> selectedSeats = [];
  Color setSeatColor(int index) {
    if (bookedSeats.contains(index)) {
      return Colors.red;
    } else if (selectedSeats.contains(index)) {
      return Colors.green;
    } else {
      return Colors.white.withOpacity(0.8);
    }
  }

  void selectSeat(int index) {
    if (bookedSeats.contains(index)) {
      // dismiss any active snackbar before showing a new one
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Seat $index is already booked"),
        backgroundColor: Colors.red,
      ));
      return;
    } else {
      if (selectedSeats.contains(index)) {
        selectedSeats.remove(index);
      } else {
        selectedSeats.add(index);
      }
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.only(left: 40.0),
              width: 240.0,
              child: ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 15,
                separatorBuilder: (context, index) {
                  return const SizedBox(height: 8.0);
                },
                itemBuilder: (context, mainIndex) {
                  if (mainIndex == 0) {
                    return SizedBox(
                      height: 30.0,
                      child: ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        itemCount: 5,
                        separatorBuilder: (context, index) {
                          if (index == 2) {
                            return const VisibilitySpacer();
                          }
                          return const SizedBox();
                        },
                        itemBuilder: (context, index) {
                          if (index == 1 || index == 2) {
                            return const VisibilitySpacer();
                          }
                          setIndex = 5;
                          int displayIndex = 0;
                          if (index > 2) {
                            displayIndex = index - 1;
                          }
                          return InkWell(
                            onTap: () {
                              selectSeat(displayIndex);
                            },
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: Container(
                                  height: 40,
                                  width: 30.0,
                                  color: setSeatColor(displayIndex),
                                  child: Center(
                                      child: Text(
                                    displayIndex == 0
                                        ? "CF"
                                        : displayIndex.toString(),
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w700,
                                        color: Colors.black),
                                  )),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  } else if (mainIndex == 14) {
                    return SizedBox(
                      height: 30.0,
                      child: ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        itemCount: 6,
                        separatorBuilder: (context, index) {
                          return const SizedBox();
                        },
                        itemBuilder: (context, index) {
                          // if (index >= 4) {
                          //   setIndex = mainIndex * 5;
                          // }
                          int displayValue = (setIndex + index + 1) - 2;
                          return InkWell(
                            onTap: () {
                              selectSeat(displayValue);
                            },
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: Container(
                                  height: 40,
                                  width: 30.0,
                                  color: setSeatColor(displayValue),
                                  child: Center(
                                      child: Text(
                                    displayValue.toString(),
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w700,
                                        color: Colors.black),
                                  )),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  }

                  /// ELSE BETWEEN SECOND AND LAST ROWS
                  return SizedBox(
                    height: 30.0,
                    child: ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemCount: 5,
                      separatorBuilder: (context, index) {
                        if (index == 2) {
                          return Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: Visibility(
                              visible: false,
                              maintainSize: true,
                              maintainAnimation: true,
                              maintainState: true,
                              child: Container(
                                width: 30.0,
                                color: Colors.white,
                              ),
                            ),
                          );
                        }
                        return const SizedBox();
                      },
                      itemBuilder: (context, index) {
                        if (index == 4) {
                          setIndex = (mainIndex + 1) * 5;
                        }
                        int displayValue = (setIndex + index) - 1;
                        displayValue =
                            index == 4 ? (displayValue - 5) : displayValue;
                        return InkWell(
                          onTap: () {
                            selectSeat(displayValue);
                            "Selected value is $displayValue".log();
                          },
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: Container(
                                height: 30,
                                width: 30.0,
                                color: setSeatColor(displayValue),
                                child: Center(
                                    child: Text(
                                  // mainIndex.toString(),
                                  displayValue.toString(),
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w700,
                                      color: Colors.black),
                                )),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
            Text("Seats: ${selectedSeats.length} "),
            Text("Total: ${selectedSeats.length * 5000} XAF"),
          ],
        ),
      ),
    );
  }
}

class VisibilitySpacer extends StatelessWidget {
  const VisibilitySpacer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: Visibility(
        visible: false,
        maintainSize: true,
        maintainAnimation: true,
        maintainState: true,
        child: Container(
          width: 30.0,
          color: Colors.white,
        ),
      ),
    );
  }
}
