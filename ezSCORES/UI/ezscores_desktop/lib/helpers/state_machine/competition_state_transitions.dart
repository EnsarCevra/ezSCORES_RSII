import 'package:ezscores_desktop/models/enums/competitionStatus.dart';
import 'package:ezscores_desktop/providers/CompetitionsProvider.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

typedef TransitionCallback = Future<void> Function(int competitionId, BuildContext context);

final Map<CompetitionStatus, Map<CompetitionStatus, TransitionCallback>> transitionActions = {
  CompetitionStatus.preparation: {
    CompetitionStatus.applicationsOpen: (id, context) => context.read<CompetitionProvider>().openApplications(id),
  },
  CompetitionStatus.applicationsOpen: {
    CompetitionStatus.preparation: (id, context) => context.read<CompetitionProvider>().preparation(id),
    CompetitionStatus.applicationsClosed: (id, context) => context.read<CompetitionProvider>().closeApplications(id),
  },
  CompetitionStatus.applicationsClosed: {
    CompetitionStatus.applicationsOpen: (id, context) => context.read<CompetitionProvider>().openApplications(id),
    CompetitionStatus.underway: (id, context) => context.read<CompetitionProvider>().startCompetition(id),
  },
  CompetitionStatus.underway: {
    CompetitionStatus.finished: (id, context) => context.read<CompetitionProvider>().finishCompetition(id),
  },
  // No transitions from `finished`
};
