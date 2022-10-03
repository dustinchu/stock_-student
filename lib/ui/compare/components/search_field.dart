import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../ui/theme/app_theme.dart';
import '../compare_view_model.dart';
import 'search_field/cupertino_flutter_typeahead.dart';

class SearchField extends HookConsumerWidget {
  SearchField({
    Key? key,
    required this.typeAheadController,
    this.suggestionsBoxController,
    required this.hitText,
    this.onTap,
  }) : super(key: key);
  String hitText;
  final TextEditingController typeAheadController;
  CupertinoSuggestionsBoxController? suggestionsBoxController;
  VoidCallback? onTap;
  List<String> n = [];
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(appThemeProvider);
    final state = ref.watch(compareViewModelProvider);
    return CupertinoTypeAheadFormField(
      placeholderStyle: theme.textTheme.h40.copyWith(color: Colors.white38),
      getImmediateSuggestions: true,
      suggestionsBoxController: suggestionsBoxController,
      textFieldConfiguration: CupertinoTextFieldConfiguration(
          keyboardType: TextInputType.text,
          onTap: onTap,
          obscuringCharacter: "*",
          padding: EdgeInsets.fromLTRB(15.sp, 0.h, 5.sp, 0.h),
          placeholder: hitText,
          controller: typeAheadController,
          decoration: BoxDecoration(
            // border: Border.all(color: borderColor, width: 1),
            border: Border.all(
              width: 1,
              color: theme.appColors.primary,
            ),
            // color: Colors.white,
            borderRadius: BorderRadius.circular(17.sp),
          ),
          style: theme.textTheme.h40.copyWith(color: Colors.white)),
      suggestionsCallback: (pattern) async => await state.selectCompny(pattern),
      itemBuilder: (context, String suggestion) {
        return Material(
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Text(
              suggestion,
              // style: theme.textTheme.h40.copyWith(color: Colors.white),
            ),
          ),
        );
      },
      onSuggestionSelected: (String suggestion) {
        typeAheadController.text = suggestion;
      },
    );
  }
}
