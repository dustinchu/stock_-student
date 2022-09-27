import 'dart:async';

import 'package:flapp/ui/hooks/use_l10n.dart';
import 'package:flapp/ui/theme/app_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graphic/graphic.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../common/util/data.dart';
import '../stock_detail_view_model.dart';

class RealtimeChart extends HookConsumerWidget {
  RealtimeChart({
    Key? key,
  }) : super(key: key);
  final priceVolumeChannel = StreamController<GestureSignal>.broadcast();

  List<String> labels = ["09:00", "10:00", "11:00", "12:00", "13:00"];
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(appThemeProvider);
    final state = ref.watch(stockDetailViewModelProvider);
    final l10n = useL10n();

    return SafeArea(
      child: SingleChildScrollView(
        child: Center(
          child: Column(
            children: <Widget>[
              Container(
                margin: const EdgeInsets.only(top: 10),
                height: 150,
                child: Chart(
                  padding: (_) => const EdgeInsets.fromLTRB(40, 5, 10, 0),
                  rebuild: false,
                  data: priceVolumeData,
                  variables: {
                    '時間': Variable(
                      accessor: (Map map) => map['time'] as String,
                      scale: OrdinalScale(tickCount: 3),
                    ),
                    '價格': Variable(
                      accessor: (Map map) => map['end'] as num,
                      scale: LinearScale(min: 5, tickCount: 5),
                    ),
                    '量': Variable(
                      accessor: (Map map) => map['volume'] as num,
                    ),
                  },
                  tooltip: TooltipGuide(
                    layer: 1,
                    followPointer: [true, true],
                    align: Alignment.topRight,
                    offset: const Offset(-20, -20),
                  ),
                  elements: [
                    LineElement(
                      size: SizeAttr(value: 1),
                    )
                  ],
                  axes: [
                    Defaults.horizontalAxis
                      ..label = null
                      ..line = null,

                    Defaults.verticalAxis
                      ..grid = StrokeStyle(
                          color: Colors.white.withOpacity(0.5), width: 1)
                    // Defaults.verticalAxis
                    //   ..gridMapper = (_, index, __) =>
                    //       index == 0 ? null : Defaults.strokeStyle
                    // ,
                  ],
                  selections: {
                    'touchMove': PointSelection(
                      on: {
                        GestureType.scaleUpdate,
                        GestureType.tapDown,
                        GestureType.longPressMoveUpdate
                      },
                      dim: Dim.x,
                    )
                  },
                  crosshair: CrosshairGuide(
                    followPointer: [true, false],
                    styles: [
                      StrokeStyle(color: const Color(0xffbfbfbf), dash: [4, 0]),
                      StrokeStyle(color: const Color(0xffbfbfbf), dash: [4, 0]),
                    ],
                  ),
                  gestureChannel: priceVolumeChannel,
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 0),
                height: 80,
                child: Chart(
                  padding: (_) => const EdgeInsets.fromLTRB(40, 0, 10, 20),
                  rebuild: false,
                  data: priceVolumeData,
                  variables: {
                    'time': Variable(
                      accessor: (Map map) => map['time'] as String,
                      scale: OrdinalScale(
                          inflate: true,
                          ticks: ["09:00", "10:00", "11:00"],
                          formatter: (text) {
                            if (text.substring(0, 1) == "1") {
                              return text.substring(0, 2);
                            }
                            return text.substring(1, 2);
                          }),
                    ),
                    'volume': Variable(
                      accessor: (Map map) {
                        if (map['volume'] == 0) {
                          return double.nan;
                        }
                        return map['volume'] as num;
                      },
                      scale: LinearScale(min: 0),
                    ),
                  },
                  elements: [
                    IntervalElement(
                      size: SizeAttr(value: 1),
                    )
                  ],
                  axes: [Defaults.horizontalAxis..tickLine = TickLine()],
                  selections: {
                    'touchMove': PointSelection(
                      on: {
                        GestureType.scaleUpdate,
                        GestureType.tapDown,
                        GestureType.longPressMoveUpdate
                      },
                      dim: Dim.x,
                    )
                  },
                  crosshair: CrosshairGuide(
                    followPointer: [false, false],
                    styles: [
                      StrokeStyle(color: const Color(0xffbfbfbf), dash: [4, 0]),
                      StrokeStyle(color: const Color(0xffbfbfbf), dash: [0, 2]),
                    ],
                  ),
                  gestureChannel: priceVolumeChannel,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
