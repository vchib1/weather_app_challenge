extension TemperatureConversion on double {
  int toDegrees() {
    double temp = (this - 273.15);

    return temp.round();
  }

  String toWindSpeedKpm() => (this * 3.6).toStringAsFixed(2);
}
