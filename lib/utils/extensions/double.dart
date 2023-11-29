extension TemperatureConversion on double {
  String toWindSpeedKpm() => (this * 3.6).toStringAsFixed(2);
}
