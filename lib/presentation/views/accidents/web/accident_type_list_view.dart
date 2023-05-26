import 'package:e_rose/assets/spacing.dart';
import 'package:e_rose/controllers/accident_type_list_controller.dart';
import 'package:e_rose/presentation/common/colors.dart';
import 'package:e_rose/presentation/widgets/common/vertical_divider.dart';
import 'package:e_rose/presentation/widgets/common/page_template.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AccidentTypeListViewWeb extends ConsumerWidget {
  const AccidentTypeListViewWeb({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final accidentTypeListController =
        ref.read(accidentTypeListControllerProvider.notifier);
    final data = ref.watch(accidentTypeListControllerProvider);
    return PageTemplateWidget(
      child: data.when(
        data: (accidentTypeListState) => accidentTypeListState
                .accidentTypes.isEmpty
            ? Center(
                child: Text(
                  "Il n'y a aucun accidents pour l'instant !",
                  textScaleFactor: textScaleFactor(context),
                  style: const TextStyle(fontSize: 15),
                ),
              )
            : Row(
                children: [
                  Flexible(
                    flex: 2,
                    child: LayoutBuilder(
                      builder: (context, constraints) => Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: constraints.maxHeight / 15,
                        ),
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              for (var accidentType
                                  in accidentTypeListState.accidentTypes) ...[
                                Material(
                                  color: accidentType ==
                                          accidentTypeListState
                                              .selectedAccidentType
                                      ? CustomColors.lighGrey.withOpacity(0.1)
                                      : Colors.transparent,
                                  child: InkWell(
                                    onTap: () => accidentTypeListController
                                        .select(accidentType),
                                    hoverColor:
                                        CustomColors.lighGrey.withOpacity(0.1),
                                    child: SizedBox(
                                      height: constraints.maxHeight / 12,
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                          left: constraints.maxWidth / 10,
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Expanded(
                                              flex: 1,
                                              child: Center(
                                                child: FaIcon(
                                                  IconData(
                                                    int.parse(
                                                        accidentType.iconCode!),
                                                    fontFamily: accidentType
                                                        .iconFontFamily,
                                                    fontPackage: accidentType
                                                        .iconFontPackage,
                                                  ),
                                                  color: CustomColors.white,
                                                  size: constraints.maxHeight /
                                                      18,
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 5,
                                              child: Text(
                                                accidentType.name!,
                                                textScaleFactor:
                                                    textScaleFactor(context),
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  const CustomVerticalDivider(),
                  Flexible(
                    flex: 3,
                    child: LayoutBuilder(
                      builder: (context, constraints) => Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: constraints.maxWidth / 10,
                        ),
                        child: Center(
                          child: Text(
                            accidentTypeListState
                                .selectedAccidentType.description!,
                            textScaleFactor: textScaleFactor(context),
                            maxLines: 10,
                            textAlign: TextAlign.center,
                            style: const TextStyle(fontSize: 12),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
        loading: () => const CircularProgressIndicator(),
        error: (error, stackTrace) => const SizedBox(),
      ),
    );
  }
}
