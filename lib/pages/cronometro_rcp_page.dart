import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

import '../components/rounded_button.dart';

class CronoRCPPage extends StatefulWidget {
  static Future<void> navigatorPush(BuildContext context) async {
    return Navigator.push<void>(
      context,
      MaterialPageRoute(
        builder: (_) => CronoRCPPage(),
      ),
    );
  }

  @override
  _State createState() => _State();
}

class _State extends State<CronoRCPPage> {
  final _isHours = true;
  int _shockTimes = 0;
  int _EpinephrineTimes = 0;
  String _teste = '';
  DateTime now = DateTime.now();

  final StopWatchTimer _stopWatchTimerMain = StopWatchTimer(
    mode: StopWatchMode.countUp,
    onChange: (value) => print('onChange $value'),
    onChangeRawSecond: (value) => print('onChangeRawSecond $value'),
    onChangeRawMinute: (value) => print('onChangeRawMinute $value'),
    onStopped: () {
      print('onStop');
    },
    onEnded: () {
      print('onEnded');
    },
  );
  final StopWatchTimer _stopWatchTimerCPR = StopWatchTimer(
    mode: StopWatchMode.countUp,
  );
  final StopWatchTimer _stopWatchTimerShock = StopWatchTimer(
    mode: StopWatchMode.countUp,
  );
  final StopWatchTimer _stopWatchTimerEpinephrine = StopWatchTimer(
    mode: StopWatchMode.countUp,
  );

  final _scrollController = ScrollController();
  String _startTimeText = '';
  String _startTime = '';
  List<String> _clickedButton = [];
  List<String> _clickedTime = [];

  @override
  void initState() {
    super.initState();
    _stopWatchTimerMain.rawTime.listen((value) =>
        print('rawTime $value ${StopWatchTimer.getDisplayTime(value)}'));
    _stopWatchTimerMain.minuteTime
        .listen((value) => print('minuteTime $value'));
    _stopWatchTimerMain.secondTime
        .listen((value) => print('secondTime $value'));
    _stopWatchTimerMain.records.listen((value) => print('records $value'));
    _stopWatchTimerMain.fetchStopped
        .listen((value) => print('stopped from stream'));
    _stopWatchTimerMain.fetchEnded
        .listen((value) => print('ended from stream'));

    /// Can be set preset time. This case is "00:01.23".
    // _stopWatchTimerMain.setPresetTime(mSec: 1234);
  }

  @override
  void dispose() async {
    super.dispose();
    await _stopWatchTimerMain.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(178, 95, 189, 226),
        title: const Text('Cronômetro RCP'),
      ),
      body: Container(
        height: double.infinity,
        color: const Color.fromARGB(178, 95, 189, 226),
        child: Scrollbar(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 32,
                horizontal: 16,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(_startTimeText),
                        Text(_startTime),
                      ],
                    ),
                  ),

                  /// Display stop watch time
                  Row(
                    children: [
                      StreamBuilder<int>(
                        stream: _stopWatchTimerMain.rawTime,
                        initialData: _stopWatchTimerMain.rawTime.value,
                        builder: (context, snap) {
                          final value = snap.data!;
                          final displayTime = StopWatchTimer.getDisplayTime(
                              value,
                              milliSecond: false,
                              hours: _isHours);
                          return Padding(
                            padding: const EdgeInsets.all(8),
                            child: Text(
                              displayTime,
                              style: const TextStyle(
                                  fontSize: 25,
                                  fontFamily: 'Helvetica',
                                  fontWeight: FontWeight.bold),
                            ),
                          );
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: RoundedButton(
                            color: Colors.blue,
                            onTap: () {
                              if (_stopWatchTimerMain.isRunning) {
                                _clickedTime
                                    .add(DateFormat('kk:mm:ss').format(now));
                                _clickedButton.add('Pausa Geral');
                                _stopWatchTimerMain.onAddLap();
                                _stopWatchTimerMain.onStopTimer();

                                setState(() {});
                              } else {
                                _clickedButton.add('Início');
                                _clickedTime
                                    .add(DateFormat('kk:mm:ss').format(now));
                                _stopWatchTimerMain.onStartTimer();
                                _stopWatchTimerMain.onAddLap();
                                // _stopWatchTimerMain.rawTime.listen((value) =>
                                //     _teste =
                                //         'Start $value ${StopWatchTimer.getDisplayTime(value)}');
                                _startTimeText = 'RCP Iniciada às ';

                                setState(() {});
                              }
                            },
                            //_stopWatchTimerShock.onStartTimer,

                            label: _stopWatchTimerMain.isRunning
                                ? 'Parar'
                                : 'Começar'),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      StreamBuilder<int>(
                        stream: _stopWatchTimerCPR.rawTime,
                        initialData: _stopWatchTimerCPR.rawTime.value,
                        builder: (context, snap) {
                          final value = snap.data!;
                          final displayTime = StopWatchTimer.getDisplayTime(
                              value,
                              milliSecond: false,
                              hours: _isHours);
                          return Padding(
                            padding: const EdgeInsets.all(8),
                            child: Text(
                              displayTime,
                              style: const TextStyle(
                                  fontSize: 25,
                                  fontFamily: 'Helvetica',
                                  fontWeight: FontWeight.bold),
                            ),
                          );
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: RoundedButton(
                          color: Colors.redAccent,
                          onTap: () {
                            if (_stopWatchTimerCPR.isRunning) {
                              _clickedButton.add('Pausa na RCP');
                              _clickedTime
                                  .add(DateFormat('kk:mm:ss').format(now));
                              _stopWatchTimerMain.onAddLap();
                              _stopWatchTimerCPR.onStopTimer();
                              setState(() {});
                            } else {
                              _clickedButton.add('Início da RCP');
                              _clickedTime
                                  .add(DateFormat('kk:mm:ss').format(now));
                              _stopWatchTimerMain.onAddLap();
                              _stopWatchTimerCPR.onStartTimer();

                              setState(() {});
                            }
                          },
                          label: _stopWatchTimerCPR.isRunning
                              ? 'Pausar RCP'
                              : 'Iníciar RCP',
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      StreamBuilder<int>(
                        stream: _stopWatchTimerShock.rawTime,
                        initialData: _stopWatchTimerShock.rawTime.value,
                        builder: (context, snap) {
                          final value = snap.data!;
                          final displayTime = StopWatchTimer.getDisplayTime(
                              value,
                              milliSecond: false,
                              hours: _isHours);
                          return Padding(
                            padding: const EdgeInsets.all(8),
                            child: Text(
                              displayTime,
                              style: const TextStyle(
                                  fontSize: 25,
                                  fontFamily: 'Helvetica',
                                  fontWeight: FontWeight.bold),
                            ),
                          );
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: RoundedButton(
                          color: Colors.orange,
                          onTap: () {
                            _clickedButton.add('Choque');
                            _clickedTime
                                .add(DateFormat('kk:mm:ss').format(now));
                            _stopWatchTimerMain.onAddLap();
                            _stopWatchTimerShock.onResetTimer();
                            _stopWatchTimerCPR.onResetTimer();
                            _stopWatchTimerShock.onStartTimer();
                            _stopWatchTimerCPR.onStartTimer();
                            setState(() {
                              _shockTimes++;
                            });
                          },
                          label: 'Choque',
                        ),
                      ),
                      if (_shockTimes == 0)
                        const Text('')
                      else
                        RoundedButton(
                          label: _shockTimes.toString(),
                        )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      StreamBuilder<int>(
                        stream: _stopWatchTimerEpinephrine.rawTime,
                        initialData: _stopWatchTimerEpinephrine.rawTime.value,
                        builder: (context, snap) {
                          final value = snap.data!;
                          final displayTime = StopWatchTimer.getDisplayTime(
                              value,
                              milliSecond: false,
                              hours: _isHours);
                          return Padding(
                            padding: const EdgeInsets.all(8),
                            child: Text(
                              displayTime,
                              style: const TextStyle(
                                  fontSize: 25,
                                  fontFamily: 'Helvetica',
                                  fontWeight: FontWeight.bold),
                            ),
                          );
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: RoundedButton(
                            color: Colors.brown,
                            onTap: () {
                              _clickedButton.add('Epinefrina');
                              _clickedTime
                                  .add(DateFormat('kk:mm:ss').format(now));
                              _stopWatchTimerMain.onAddLap();
                              _stopWatchTimerEpinephrine.onResetTimer();
                              _stopWatchTimerEpinephrine.onStartTimer();
                              setState(() {
                                _EpinephrineTimes++;
                              });
                            },
                            label: 'Epinefrina'),
                      ),
                      if (_EpinephrineTimes == 0)
                        const Text('')
                      else
                        RoundedButton(
                          label: _EpinephrineTimes.toString(),
                        )
                    ],
                  ),

                  /// Lap time.
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: SizedBox(
                      height: 150,
                      child: StreamBuilder<List<StopWatchRecord>>(
                        stream: _stopWatchTimerMain.records,
                        initialData: _stopWatchTimerMain.records.value,
                        builder: (context, snap) {
                          final value = snap.data!;
                          if (value.isEmpty) {
                            return const SizedBox.shrink();
                          }
                          Future.delayed(const Duration(milliseconds: 100), () {
                            _scrollController.animateTo(
                                _scrollController.position.maxScrollExtent,
                                duration: const Duration(milliseconds: 200),
                                curve: Curves.easeOut);
                          });
                          print('Listen records. $value');
                          return ListView.builder(
                            controller: _scrollController,
                            scrollDirection: Axis.vertical,
                            itemBuilder: (BuildContext context, int index) {
                              final data = value[index];
                              final clicked = _clickedButton[index];
                              List<String> clickedTimeFinal = _clickedTime;
                              return Column(
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.all(8),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          '$clicked ',
                                          style: const TextStyle(
                                              fontSize: 17,
                                              fontFamily: 'Helvetica',
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          '${data.displayTime}',
                                          style: const TextStyle(
                                              fontSize: 17,
                                              fontFamily: 'Helvetica',
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          clickedTimeFinal[index],
                                          style: const TextStyle(
                                              fontSize: 17,
                                              fontFamily: 'Helvetica',
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const Divider(
                                    color: Colors.black38,
                                    height: 1,
                                  )
                                ],
                              );
                            },
                            itemCount: value.length,
                          );
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: RoundedButton(
                      color: Color.fromARGB(255, 117, 182, 201),
                      onTap: () {
                        _clickedButton.add('Medicação');
                        _clickedTime.add(DateFormat('kk:mm:ss').format(now));
                        _stopWatchTimerMain.onAddLap();
                      },
                      label: 'Outras Medicações',
                    ),
                  ),

                  // /// Button
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   children: <Widget>[
                  //     Padding(
                  //       padding: const EdgeInsets.symmetric(horizontal: 4),
                  //       child: RoundedButton(
                  //         color: Colors.red,
                  //         onTap: _stopWatchTimerMain.onResetTimer,
                  //         label: 'Reset',
                  //       ),
                  //     ),
                  //     Padding(
                  //       padding: const EdgeInsets.symmetric(horizontal: 4),
                  //       child: Row(
                  //         mainAxisAlignment: MainAxisAlignment.center,
                  //         children: <Widget>[
                  //           Padding(
                  //             padding:
                  //                 const EdgeInsets.all(0).copyWith(right: 8),
                  //             child: RoundedButton(
                  //               color: Colors.deepPurpleAccent,
                  //               onTap: _stopWatchTimerMain.onAddLap,
                  //               label: 'Lap',
                  //             ),
                  //           ),
                  //         ],
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  // Text(_teste),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
