import 'package:e_rose/assets/colors.dart';
import 'package:e_rose/assets/spacing.dart';
import 'package:e_rose/controllers/accident_controller.dart';
import 'package:e_rose/presentation/widgets/page_template.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AccidentsListViewWeb extends ConsumerWidget {
  const AccidentsListViewWeb({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final accidentController = ref.read(accidentControllerProvider.notifier);
    final data = ref.watch(accidentControllerProvider);
    return PageTemplateWidget(
      child: data.when(
        data: (accidentState) => accidentState.accidents.isEmpty
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
                              for (var accident in accidentState.accidents) ...[
                                Material(
                                  color:
                                      accident == accidentState.selectedAccident
                                          ? lighGrey.withOpacity(0.1)
                                          : Colors.transparent,
                                  child: InkWell(
                                    onTap: () =>
                                        accidentController.select(accident),
                                    hoverColor: lighGrey.withOpacity(0.1),
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
                                                        accident.iconCode!),
                                                    fontFamily:
                                                        accident.iconFontFamily,
                                                    fontPackage: accident
                                                        .iconFontPackage,
                                                  ),
                                                  color: white,
                                                  size: constraints.maxHeight /
                                                      18,
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 5,
                                              child: Text(
                                                accident.name!,
                                                textScaleFactor:
                                                    textScaleFactor(context),
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 12,
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
                  const VerticalDivider(
                    color: white,
                    thickness: 3,
                    width: 3,
                  ),
                  Flexible(
                    flex: 3,
                    child: LayoutBuilder(
                      builder: (context, constraints) => Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: constraints.maxWidth / 10,
                        ),
                        child: Center(
                          child: Text(
                            accidentState.selectedAccident.description!,
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
