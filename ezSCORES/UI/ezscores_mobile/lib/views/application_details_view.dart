import 'dart:ui';
import 'package:ezscores_mobile/models/applications.dart';
import 'package:flutter/material.dart';
import 'package:ezscores_mobile/models/competitions.dart';
import 'package:ezscores_mobile/models/players.dart';
import 'package:ezscores_mobile/models/teams.dart';
import 'package:ezscores_mobile/providers/utils.dart';

class ApplicationDetailsView extends StatefulWidget {
  final Applications? application;
  final Competitions competition;
  final Teams team;
  final Set<Players> players;
  final String? message;
  final ValueChanged<String>? onMessageChanged;

  const ApplicationDetailsView({
    super.key,
    this.application,
    required this.competition,
    required this.team,
    required this.players,
    this.message,
    this.onMessageChanged,
  });

  @override
  State<ApplicationDetailsView> createState() => _ApplicationDetailsViewState();
}

class _ApplicationDetailsViewState extends State<ApplicationDetailsView> {
  late TextEditingController _messageController;

  @override
  void initState() {
    super.initState();
    _messageController = TextEditingController(
      text: widget.message ?? widget.application?.message ?? "",
    );
  }

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildGeneralDetails(context),
          const SizedBox(height: 20),
          _buildPaymentStatusView(),
          const SizedBox(height: 20),
          const Text(
            "Odabrani igrači",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
          ),
          const SizedBox(height: 2),
          _buildTeamPlayersView(),
          if(widget.application == null || widget.application?.message != null)_buildMessageInput(),
        ],
      ),
    );
  }

  Widget _buildGeneralDetails(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
      height: 160,
      width: double.infinity,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            "assets/images/match_bg_2.jpeg",
            fit: BoxFit.cover,
          ),
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
            child: Container(
              color: Colors.black.withOpacity(0.4),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Takmičenje:",
                  style: textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                Text(
                  '${widget.competition.name} - ${widget.competition.selection?.name}',
                  style: textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  "Tim:",
                  style: textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Container(
                        width: 40,
                        height: 40,
                        color: Colors.grey[300],
                        child: widget.team.picture == null ||
                                widget.team.picture!.isEmpty
                            ? const Icon(Icons.groups,
                                size: 20, color: Colors.white70)
                            : imageFromString(widget.team.picture!),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        widget.team.name ?? "Nepoznat tim",
                        style: textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    if (widget.application != null) ...[
                      const SizedBox(width: 8),
                      Flexible(
                        flex: 0,
                        child: Container(
                          constraints: const BoxConstraints(maxWidth: 100),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: _statusColor(widget.application!.isAccepted),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            textAlign: TextAlign.center,
                            softWrap: true,
                            overflow: TextOverflow.visible,
                            widget.application!.isAccepted == null
                                ? 'Na obradi'
                                : widget.application!.isAccepted == true
                                    ? 'Prijava prihvaćena'
                                    : 'Prijava odbijena',
                            style: textTheme.bodySmall?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Color _statusColor(bool? status) {
    return status == null
        ? Colors.grey
        : status == true
            ? Colors.green
            : Colors.red;
  }

  Widget _buildTeamPlayersView() {
    if (widget.players.isEmpty) {
      return const Text("Nema odabranih igrača.");
    }

    return Expanded(
      child: LayoutBuilder(
        builder: (context, constraints) {
          const cardMinWidth = 100.0;
          final crossAxisCount = (constraints.maxWidth ~/ cardMinWidth).clamp(1, 3);

          return GridView.builder(
            physics: const AlwaysScrollableScrollPhysics(),
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
              childAspectRatio: 0.8,
            ),
            itemCount: widget.players.length,
            itemBuilder: (context, index) {
              final player = widget.players.elementAt(index);
              return _buildMiniPlayerCard(context, player);
            },
          );
        },
      ),
    );
  }

  Widget _buildMiniPlayerCard(BuildContext context, Players player) {
    final textTheme = Theme.of(context).textTheme;

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipOval(
              child: Container(
                width: 50,
                height: 50,
                color: Colors.grey[300],
                child: player.picture == null || player.picture!.isEmpty
                    ? const Icon(Icons.person, size: 30, color: Colors.grey)
                    : imageFromString(player.picture!),
              ),
            ),
            const SizedBox(height: 6),
            Text(
              "${player.firstName ?? ''} ${player.lastName ?? ''}",
              maxLines: 2, // allow wrapping into 2 rows
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: textTheme.bodySmall?.copyWith(
                fontWeight: FontWeight.w600,
                fontSize: 12,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              player.birthDate != null
                  ? formatDateOnly(player.birthDate!)
                  : "Nepoznat datum",
              style: textTheme.labelSmall?.copyWith(color: Colors.grey[700]),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }


  Widget _buildMessageInput() {
    return TextField(
      controller: _messageController,
      enabled: widget.application == null,
      maxLines: 4,
      minLines: 2,
      style: const TextStyle(fontSize: 12),
      decoration: InputDecoration(
        labelText: "Poruka / napomena za organizatora",
        labelStyle: TextStyle(
          color: Colors.grey[600],
          fontSize: 12,
        ),
        alignLabelWithHint: true,
        filled: true,
        fillColor: Colors.grey.shade100,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.blue.shade400, width: 1.6),
        ),
        hintText: "Dodajte poruku / napomenu za organizatora...",
        hintStyle: TextStyle(
          color: Colors.grey[600],
          fontSize: 12,
        ),
      ),
      onChanged: widget.onMessageChanged,
    );
  }
  
  _buildPaymentStatusView() {
    final textTheme = Theme.of(context).textTheme;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
            "Status uplate",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
          ),
        Flexible(
          flex: 0,
          child: Container(
            padding: const EdgeInsets.symmetric(
                horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: _paymentStatusColor(widget.application!.isAccepted),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                textAlign: TextAlign.center,
                overflow: TextOverflow.visible,
                widget.application!.isPaId == true
                        ? 'Uplaćeno'
                        : 'Nije uplaćeno',
                style: textTheme.bodySmall?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
  
  _paymentStatusColor(bool? isPaid) {
    return isPaid == true
        ? Colors.green
        : Colors.red;
  }
}
