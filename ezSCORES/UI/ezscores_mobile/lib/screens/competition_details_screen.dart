import 'package:ezscores_mobile/models/competitions.dart';
import 'package:ezscores_mobile/models/competitionsReferees.dart';
import 'package:ezscores_mobile/models/competitionsSponsors.dart';
import 'package:ezscores_mobile/models/enums/competitionStatus.dart';
import 'package:ezscores_mobile/models/enums/competitionType.dart';
import 'package:ezscores_mobile/providers/CompetitionsProvider.dart';
import 'package:ezscores_mobile/providers/utils.dart';
import 'package:ezscores_mobile/screens/scores_screen.dart';
import 'package:ezscores_mobile/screens/standings_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CompetitionsDetailsScreen extends StatefulWidget {
  final int? competitionId;

  const CompetitionsDetailsScreen(this.competitionId, {super.key});

  @override
  State<CompetitionsDetailsScreen> createState() =>
      _CompetitionsDetailsScreenState();
}

class _CompetitionsDetailsScreenState
    extends State<CompetitionsDetailsScreen> {
  late CompetitionProvider competitionProvider;
  Competitions? competition;

  @override
  void initState() {
    super.initState();
    competitionProvider = context.read<CompetitionProvider>();
    initForm();
  }

  Future<void> initForm() async {
    if (widget.competitionId != null) {
      var competitionData =
          await competitionProvider.getById(widget.competitionId!);
      setState(() {
        competition = competitionData;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (competition == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(competition!.name ?? "Detalji takmičenja", style: TextStyle(fontSize: 15),),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header section
            _buildHeader(),
            const SizedBox(height: 5),
            Divider(
              height: 5,
              thickness: 0.5,
              color: Colors.grey.withOpacity(0.5),
            ),
            // General Info
            if (competition!.status == CompetitionStatus.underway) ...[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () {
                          Navigator.of(context).push(
                            PageRouteBuilder(
                              pageBuilder: (context, animation, secondaryAnimation) => ResultsScreen(competition: competition!,),
                              transitionsBuilder: (context, animation, secondaryAnimation, child) {
                                return FadeTransition(opacity: animation, child: child);
                              },
                            ),
                          );
                        },
                        icon: const Icon(Icons.sports_soccer),
                        label: const Text('Rezultati'),
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () {
                          Navigator.of(context).push(
                            PageRouteBuilder(
                              pageBuilder: (context, animation, secondaryAnimation) => StandingsScreen(competition: competition!,),
                              transitionsBuilder: (context, animation, secondaryAnimation, child) {
                                return FadeTransition(opacity: animation, child: child);
                              },
                            ),
                          );
                        },
                        icon: const Icon(Icons.leaderboard),
                        label: const Text('Poredak'),
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
            const SizedBox(height: 10),
            _buildSectionTitle("Opšte informacije"),
            const SizedBox(height: 8),
            _buildInfoRow(
              icon: Icons.calendar_today,
              label: "Prijave do",
              value: formatDateOnly(competition!.applicationEndDate),
            ),
            _buildInfoRow(
              icon: Icons.calendar_today,
              label: "Datum početka",
              value: formatDateOnly(competition!.startDate),
            ),
            _buildInfoRow(
              icon: Icons.sports,
              label: "Tip takmičenja",
              value: competition!.competitionType!.displayName,
            ),
            _buildInfoRow(
              icon: Icons.numbers,
              label: "Broj timova",
              value: competition!.maxTeamCount.toString(),
            ),
            _buildInfoRow(
              icon: Icons.numbers,
              label: "Max igrača po timu",
              value: competition!.maxPlayersPerTeam.toString(),
            ),
            _buildInfoRow(
              icon: Icons.monetization_on,
              label: "Kotizacija",
              value: "${competition!.fee.toString()} KM"
            ),
            _buildInfoRow(
              icon: Icons.group_add,
              label: "Selekcija",
              value: competition!.selection!.name!
            ),
            _buildInfoRow(
              icon: Icons.location_city,
              label: "Grad",
              value: competition!.city!.name!
            ),
            const SizedBox(height: 24),

            // Contact Info
            _buildSectionTitle("Kontakt informacije"),
            const SizedBox(height: 8),
            _buildInfoRow(
              icon: Icons.email,
              label: "Email",
              value: "N/A",
            ),
            _buildInfoRow(
              icon: Icons.phone,
              label: "Telefon",
              value: "N/A",
            ),

            const SizedBox(height: 24),
            
            buildSponsorsSection(competition!.competitionsSponsors!),

            const SizedBox(height: 24),

            buildRefereesSection(competition!.competitionsReferees!)
          ],
        ),
      ),
      bottomNavigationBar: competition!.status == CompetitionStatus.applicationsOpen ? SizedBox(
      width: double.infinity,
      height: 44,
      child: ElevatedButton(
        onPressed: () {
          // Handle apply logic
        },
        style: ElevatedButton.styleFrom(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.zero,
          ),
          backgroundColor: Colors.green,
          padding: EdgeInsets.zero,
        ),
        child: const Text(
          "Prijavi ekipu",
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
        ),
      ),) : null
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: Theme.of(context)
          .textTheme
          .titleMedium
          ?.copyWith(fontWeight: FontWeight.bold),
    );
  }

  Widget _buildInfoRow(
      {required IconData icon, required String label, required String value}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Icon(icon, size: 18, color: Colors.blueGrey),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              label,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(fontWeight: FontWeight.w500),
            ),
          ),
          Text(
            value,
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(color: Colors.grey[700]),
          ),
        ],
      ),
    );
  }
  Widget buildSponsorsSection(List<CompetitionsSponsors> competitionSponsors) {
    if (competitionSponsors.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('Sponzori'),
        const SizedBox(height: 15),
        SizedBox(
          height: 100,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            itemCount: competitionSponsors.length,
            separatorBuilder: (_, __) => const SizedBox(width: 12),
            itemBuilder: (context, index) {
              final competitionSponsor = competitionSponsors[index];
              return Container(
                width: 90,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.grey[300],
                        image: competitionSponsor.sponsor?.picture == null || competitionSponsor.sponsor!.picture!.isEmpty
                            ? null
                            : DecorationImage(
                                image: imageFromString(competitionSponsor.sponsor!.picture!).image,
                                fit: BoxFit.cover,
                              ),
                      ),
                      child: (competitionSponsor.sponsor?.picture == null || competitionSponsor.sponsor!.picture!.isEmpty)
                          ? const Icon(Icons.emoji_events, size: 30, color: Colors.grey)
                          : null,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: Text(
                        competitionSponsor.sponsor!.name!,
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
  Widget buildRefereesSection(List<CompetitionsReferees> competitionReferees) {
    if (competitionReferees.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('Sudski arbitar'),
        const SizedBox(height: 15),
        SizedBox(
          height: 100,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            itemCount: competitionReferees.length,
            separatorBuilder: (_, __) => const SizedBox(width: 12),
            itemBuilder: (context, index) {
              final competitionReferee = competitionReferees[index];
              return Container(
                width: 90,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.grey[300],
                        image: competitionReferee.referee?.picture == null || competitionReferee.referee!.picture!.isEmpty
                            ? null
                            : DecorationImage(
                                image: imageFromString(competitionReferee.referee!.picture!).image,
                                fit: BoxFit.cover,
                              ),
                      ),
                      child: (competitionReferee.referee?.picture == null || competitionReferee.referee!.picture!.isEmpty)
                          ? const Icon(Icons.person, size: 30, color: Colors.grey)
                          : null,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: Text(
                        "${competitionReferee.referee?.firstName} ${competitionReferee.referee?.lastName}",
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
  
  _buildHeader() {
    final textTheme = Theme.of(context).textTheme;
    return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                borderRadius: BorderRadius.circular(30), 
                child: Container(
                            width: 60,
                            height: 60,
                            color: Colors.grey[300],
                            child: competition!.picture == null || competition!.picture!.isEmpty ?
                             const Icon(Icons.emoji_events, size: 30, color: Colors.grey) :
                             imageFromString(competition!.picture!)
                          )
                  ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        competition!.name ?? '',
                        style: textTheme.titleLarge
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "Organizator: ${competition!.city?.name ?? 'Nepoznato'}",
                        style: textTheme.bodyMedium
                            ?.copyWith(color: Colors.grey[700]),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "Status: ${competition?.status?.displayName}",
                        style: textTheme.bodySmall
                            ?.copyWith(color: Colors.blueGrey),
                      ),
                    ],
                  ),
                )
              ],
            );
  }
}
