import 'dart:math';

class TrainTestSplit {
  late final List<List<double>> trainingVectors;
  late final List<List<double>> testingVectors;
  late final List<List<double>> trainingLabels;
  late final List<List<double>> testingLabels;
  TrainTestSplit(
      {required List<List> vectors,
      required List<List> labels,
      double testFraction = 0.2,
      int? seed}) {
    final List<List<double>> trainingVectors = List.from(vectors);
    final List<List<double>> testVectors = List.empty(growable: true);
    final List<List<double>> trainingLabels = List.from(labels);
    final List<List<double>> testLabels = List.empty(growable: true);
    int testingLabelsLength = (labels.length.toDouble() * testFraction).toInt();
    for (int i = 0; i < testingLabelsLength; i++) {
      final index = Random(seed).nextInt(trainingVectors.length);
      testVectors.add(trainingVectors[index]);
      trainingVectors.remove(trainingVectors[index]);
      testLabels.add(trainingLabels[index]);
      trainingLabels.remove(trainingLabels[index]);
    }
    this.trainingVectors = trainingVectors;
    this.testingVectors = testVectors;
    this.trainingLabels = trainingLabels;
    this.testingLabels = testLabels;
    // Labels
  }
}
