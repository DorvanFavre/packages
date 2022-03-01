import 'package:ml/src/tool/result.dart';

class Scaler {
  //late final List<List<double>> normalizedDataset;
  int numberOfFeatures = 0;
  final List<double> featureMinValue = List.empty(growable: true);
  final List<double> featureMaxValue = List.empty(growable: true);

  /// # Scaler
  ///
  /// Scale each features to be between 0.0 and 1.0 with 0.0 as the min value and 1.0 the max value.
  ///
  /// Each feature is rescaled individualy.
  ///
  /// If the scaler transform value of a different dataset than the one used to fit the scaler. Values may be inferior than 0.0 or superior than 1.0
  ///
  Scaler();

  /// Calcul the scaler parameters for each features
  Result fit({required List<List<double>> vectors}) {
    if (vectors.isEmpty) {
      return Failure(message: 'vectors is empty');
    }
    featureMinValue.clear();
    featureMaxValue.clear();
    numberOfFeatures = vectors[0].length;
    for (int index = 0; index < numberOfFeatures; index++) {
      featureMinValue.add(vectors.first[index]);
      featureMaxValue.add(vectors.first[index]);
      vectors.forEach((vector) {
        /*if (vector.length != numberOfFeatures) {
          return Failure(
              message: 'One of the vector has not the same amount of features'); 
        }*/
        if (vector[index] < featureMinValue[index])
          featureMinValue[index] = vector[index];
        if (vector[index] > featureMaxValue[index])
          featureMaxValue[index] = vector[index];
      });
    }
    return Success(data: null);
  }

  /// Scale each features of each vectors according the the scaler parameters
  ///
  /// Copy: if true, create a nea list and do not affect in input vectors list
  Result<List<List<double>>> transform(
      {required List<List<double>> vectors, copy = false}) {
    if (vectors.isEmpty) {
      return Failure(message: 'vectors is empty');
    }
    final int numberOfFeaturesInput = vectors[0].length;
    if (numberOfFeaturesInput != numberOfFeatures) {
      return Failure(message: 'Do not expect this number of features');
    }

    final List<List<double>> scaledVectors = List.empty(growable: true);

    for (int vectorIndex = 0; vectorIndex < vectors.length; vectorIndex++) {
      final List<double> scaledVector = List.empty(growable: true);
      for (int featureIndex = 0;
          featureIndex < numberOfFeatures;
          featureIndex++) {
        final value = vectors[vectorIndex][featureIndex];
        final scaledValue = (value - featureMinValue[featureIndex]) /
            (featureMaxValue[featureIndex] - featureMinValue[featureIndex]);

        if (copy) {
          scaledVector.add(scaledValue);
        } else {
          vectors[vectorIndex][featureIndex] = scaledValue;
        }
      }
      if (copy) {
        scaledVectors.add(scaledVector);
      }
    }

    if (copy) {
      return Result.success(data: scaledVectors);
    } else {
      return Result.success(data: vectors);
    }
  }

  /// Fit the Scaler and transform directly the data
  Result<List<List<double>>> fitTransform(
      {required List<List<double>> vectors, copy = false}) {
    final fitResult = fit(vectors: vectors);
    if (fitResult is Failure) {
      return Failure(message: fitResult.message);
    }
    return transform(vectors: vectors, copy: copy);
  }
}
