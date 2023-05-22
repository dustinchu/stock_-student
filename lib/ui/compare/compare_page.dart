import 'package:auto_route/auto_route.dart';
import 'package:flapp/ui/hooks/use_l10n.dart';
import 'package:flapp/ui/theme/app_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../routes/app_route.gr.dart';
import 'compare_view_model.dart';
import 'components/search_field.dart';

class ComparePage extends StatefulHookConsumerWidget {
  const ComparePage({Key? key}) : super(key: key);

  @override
  ComparePageState createState() => ComparePageState();
}

class ComparePageState extends ConsumerState<ComparePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      ref.read(compareViewModelProvider).init();
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = ref.watch(appThemeProvider);
    final state = ref.watch(compareViewModelProvider);
    final l10n = useL10n();

    Widget fieldWidget({required TextEditingController controller}) {
      return SizedBox(
        height: 40,
        child: SearchField(typeAheadController: controller, hitText: "請輸入公司代號"),
      );
    }

    Widget radioTitle(int value) {
      return Radio(
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        value: value,
        onChanged: state.changeTitleType,
        groupValue: state.titleType,
      );
    }

    Widget radio1(String text, int value, IconData iconData) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Radio(
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            value: value,
            onChanged: state.changeBodyType1,
            groupValue: state.bodyType1,
          ),
          Text(text), Icon(iconData)
          // Column(
          //   crossAxisAlignment: CrossAxisAlignment.start,
          //   children: [Text(text), Icon(iconData)],
          // ),
        ],
      );
    }

    Widget radio2(String text, int value, IconData iconData) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Radio(
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            value: value,
            onChanged: state.changeBodyType2,
            groupValue: state.bodyType2,
          ),
          Text(text),
          Icon(iconData)
        ],
      );
    }

    Widget radio3(String text, int value, IconData iconData) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Radio(
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            value: value,
            onChanged: state.changeBodyType3,
            groupValue: state.bodyType3,
          ),
          Text(text),
          Icon(iconData)
        ],
      );
    }

    Widget bodyRadio1() {
      return Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              radio1("營業收入", 1, Icons.currency_exchange),
              radio1("營業毛利", 2, Icons.inventory),
              radio1("營業利益", 3, Icons.stacked_bar_chart),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              radio1("稅後純益", 4, Icons.assured_workload),
              radio1("每股盈餘", 5, Icons.insights),
            ],
          ),
        ],
      );
    }

    Widget bodyRadio2() {
      return Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              radio2("流動比率", 1, Icons.alarm_on),
              radio2("速動比率", 2, Icons.history_toggle_off),
              radio2("利息保障倍數", 3, Icons.settings_ethernet),
            ],
          ),
        ],
      );
    }

    Widget bodyRadio3() {
      return Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              radio3("毛利率", 1, Icons.blur_circular),
              radio3("營業利益率", 2, Icons.looks),
              radio3("稅後純益率", 3, Icons.app_registration),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              radio3("資產報酬率", 4, Icons.import_contacts),
              radio3("權益報酬率", 5, Icons.voicemail),
            ],
          ),
        ],
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("多股比較"),
        centerTitle: true,
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 2.w),
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            const Text(
              '請選擇比較類型',
              style: TextStyle(fontSize: 15),
            ),
            Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Row(
                      children: [
                        radioTitle(1),
                        const Text("綜合損益項目"),
                      ],
                    ),
                    Row(
                      children: [
                        radioTitle(2),
                        const Text("償債能力"),
                      ],
                    ),
                    Row(
                      children: [
                        radioTitle(3),
                        const Text("獲利能力"),
                      ],
                    ),
                    // radioTitle(4),
                    // const Text("股利"),
                  ],
                ),
                const Divider(
                  thickness: 1.5,
                ),
                state.titleType == 1
                    ? bodyRadio1()
                    : state.titleType == 2
                        ? bodyRadio2()
                        : state.titleType == 3
                            ? bodyRadio3()
                            : Container()
              ],
            ),
            (state.titleType != 999)
                ? Expanded(
                    child: ListView(
                      // mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(
                          height: 100,
                        ),
                        fieldWidget(controller: state.textController1),
                        const SizedBox(
                          height: 20,
                        ),
                        fieldWidget(controller: state.textController2),
                        const SizedBox(
                          height: 20,
                        ),
                        fieldWidget(controller: state.textController3),
                        const SizedBox(
                          height: 80,
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: OutlinedButton(
                            onPressed: () async {
                              if (state.textController1.text != "" ||
                                  state.textController2.text != "" ||
                                  state.textController3.text != "") {
                                await state.selectCompareResult();
                                AutoRouter.of(context)
                                    .push(const CompareDetailRoute());
                              }
                              // print(
                              //     "table ===${state.sqlTableName} titleName  ==${state.sqlTitleName}");
                              // AutoRouter.of(context).push(const CompareDetailRoute());
                            },
                            child: const Text(
                              '開始比較',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                : Container()
          ],
        ),
      ),
    );
  }
}
