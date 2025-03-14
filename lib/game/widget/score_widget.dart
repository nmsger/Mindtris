

import 'package:flutter/material.dart';
import 'package:mindtris/util/extensions.dart';

import '../model/score.dart';
import '../view_model/score_view_model.dart';

class ScoreWidget extends StatelessWidget {
    final ScoreViewModel viewModel;
    final bool dismissible;
    const ScoreWidget({super.key, required this.viewModel, required this.dismissible});

    @override
    Widget build(BuildContext context) {
      if (!dismissible) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _showScoreDialog(context, dismissible);
        });
      }
    return Card(
      clipBehavior: Clip.hardEdge,
      child: InkWell(
        splashColor: Colors.blue.withAlpha(30),
        onTap: () => _showScoreDialog(context, dismissible),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          child: Column(
            children: [
              const Text("SCORE", style: TextStyle(fontSize: 12),),
              ListenableBuilder(
                listenable: viewModel,
                builder: (BuildContext context, Widget? child) {
                  return Text("${viewModel.totalScore}", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold));
                },)
            ],
          ),
        ),
      )
    );
  }

  Future _showScoreDialog(BuildContext context, bool dismissible) async {
    return showDialog<String>(
      context: context,
      barrierDismissible: dismissible,
      builder: (BuildContext context) => _buildScoreDialog(context),
    );
  }

  AlertDialog _buildScoreDialog(BuildContext context) {
    return AlertDialog(
      title: const Text('Score Overview'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ...viewModel.scores.entries.map((entry) => _buildScoreRow(entry)),
          Divider(),
          _buildTotalScoreRow(),
        ],
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.pop(context, 'Close'),
          child: const Text('Close'),
        ),
      ],
    );
  }

  Widget _buildScoreRow(MapEntry<ScoreType, int> entry) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Text(entry.key.name.capitalize),
          Spacer(),
          Text("${entry.value}"),
        ],
      ),
    );
  }

  Widget _buildTotalScoreRow() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          const Text("Total", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          Spacer(),
          Text("${viewModel.totalScore}", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

}
