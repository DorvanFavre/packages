// Linear regression model is base on a line a + bx;
import 'package:ml/src/tool/result.dart';

class LinearRegression {
  double a = 0;
  double b = 0;

  Result<double> predict({required double vector}) {
    final prediction = a + b * vector;
    return Success(data: prediction);
  }

  Result<double> sSRFit(
      {required List<double> vectors, required List<double> labels}) {
    if (vectors.length != labels.length) {
      return Failure(message: "vectors and labels are not the same size");
    }

    double sSR = 0;
    for (int i = 0; i < vectors.length; i++) {
      final prediction = predict(vector: vectors[i]);
      if (prediction is Failure) {
        return Failure(message: "Prediction has failed");
      }
      sSR += ((prediction as Success).data - labels[i]) *
          ((prediction as Success).data - labels[i]);
    }
    return Success(data: sSR);
  }

  Result trainWithGradientZero(
      {required List<double> trainingVectors,
      required List<double> trainingLabels}) {
    if (trainingVectors.length != trainingLabels.length) {
      return Failure(message: "TrainingSet and TestSet are not the same size");
    }

    int numberOfSample = trainingVectors.length;
    double sumY = 0;
    double sumX = 0;
    double sumXSquared = 0;
    double sumXY = 0;

    for (int i = 0; i < numberOfSample; i++) {
      sumY += trainingLabels[i];
      sumX += trainingVectors[i];
      sumXSquared += trainingVectors[i] * trainingVectors[i];
      sumXY += trainingVectors[i] * trainingLabels[i];
    }

    a = (sumY * sumXSquared - sumX * sumXY) /
        (numberOfSample.toDouble() * sumXSquared - sumX * sumX);

    b = (numberOfSample * sumXY - sumX * sumY) /
        (numberOfSample * sumXSquared - sumX * sumX);

    return Success(data: null);
  }

  Result<double> mean({required List<double> labels}) {
    if (labels.isEmpty) {
      return Failure(message: "List is empty");
    }
    double sum = 0;
    labels.forEach((label) {
      sum += label;
    });
    return Success(data: sum / labels.length);
  }

  Result<double> sSRMean({required List<double> labels}) {
    double sSR = 0;
    final mean_ = mean(labels: labels);
    if (mean_ is Success) {
      for (int i = 0; i < labels.length; i++) {
        sSR += (a - labels[i]) * (a - labels[i]);
      }
      return Success(data: sSR);
    } else {
      return Failure(message: 'Cannot calulate the mean');
    }
  }

  Result<double> rSquared(
      {required List<double> vectors, required List<double> labels}) {
    final _sSRMean = sSRMean(labels: labels);
    final _sSRFit = sSRFit(vectors: vectors, labels: labels);
    if (_sSRMean is Success<double>) {
      if (_sSRFit is Success<double>) {
        return Success(data: (_sSRMean.data - _sSRFit.data) / _sSRMean.data);
      } else {
        return Failure(message: "Cannot calculate SSR around the fit");
      }
    } else {
      return Failure(message: "Cannot calculate SSR around the mean");
    }
  }

  Result trainWithGradientDescente(
      {required List<double> trainingVectors,
      required List<double> trainingLabels,
      int epoch = 100,
      double learningRate = 0.05,
      required void Function(int epoch) intermediateState}) {
    if (trainingVectors.length != trainingLabels.length) {
      return Failure(message: "TrainingSet and TestSet are not the same size");
    }

    int numberOfSample = trainingVectors.length;
    double sumY = 0;
    double sumX = 0;
    double sumXSquared = 0;
    double sumXY = 0;

    for (int i = 0; i < numberOfSample; i++) {
      sumY += trainingLabels[i];
      sumX += trainingVectors[i];
      sumXSquared += trainingVectors[i] * trainingVectors[i];
      sumXY += trainingVectors[i] * trainingLabels[i];
    }

    for (int i = 0; i < epoch; i++) {
      double da =
          (-2) * sumY + 2 * a * numberOfSample.toDouble() + 2 * b * sumX;
      double db = (-2) * sumXY + 2 * a * sumX + 2 * b * sumXSquared;
      print("XX da = $da");
      print("XX db = $db");
      da = learningRate * da * -1;
      db = learningRate * db * -1;
      a += da;
      b += db;
      intermediateState(i);
    }

    return Success(data: null);
  }
}
