class Assets {
  /// WEATHER TYPE ICONS
  static String weatherClearSkyDay = "assets/icons/01d@4x.png";
  static String weatherClearSkyNight = "assets/icons/01n@4x.png";
  static String weatherFewClouds = "assets/icons/02d@4x.png";
  static String weatherFewCloudsNight = "assets/icons/02n@4x.png";
  static String weatherScatteredDay = "assets/icons/03d@4x.png";
  static String weatherScatteredNight = "assets/icons/03n@4x.png";
  static String weatherBrokenCloudsDay = "assets/icons/03d@4x.png";
  static String weatherBrokenCloudsNight = "assets/icons/03n@4x.png";
  static String weatherShowerRainDay = "assets/icons/09d@4x.png";
  static String weatherShowerRainNight = "assets/icons/09n@4x.png";
  static String weatherRainDay = "assets/icons/10d@4x.png";
  static String weatherRainNight = "assets/icons/10n@4x.png";
  static String weatherThunderstormDay = "assets/icons/11d@4x.png";
  static String weatherThunderstormNight = "assets/icons/11n@4x.png";
  static String weatherSnowDay = "assets/icons/13d@4x.png";
  static String weatherSnowNight = "assets/icons/13n@4x.png";
  static String weatherMistDay = "assets/icons/50d@4x.png";
  static String weatherMistNight = "assets/icons/50n@4x.png";

  static String getWeatherIcon({String code = "01d"}) =>
      "assets/icons/$code@4x.png";

  /// SVGs
  static String feelsLikeSvg = "assets/svg/feels_like.svg";
  static String humiditySvg = "assets/svg/humidity.svg";
  static String windSvg = "assets/svg/wind.svg";
  static String locationIconSvg = "assets/svg/location_icon.svg";

  /// WEATHER TYPE BACKGROUND
  static String bgClearSkyDay = "assets/background/01d.jpg";
  static String bgClearSkyNight = "assets/background/01n.jpg";
  static String bgFewClouds = "assets/background/02d.jpg";
  static String bgFewCloudsNight = "assets/background/02n.jpg";
  static String bgScatteredDay = "assets/background/03d.jpg";
  static String bgScatteredNight = "assets/background/03n.jpg";
  static String bgBrokenCloudsDay = "assets/background/03d.jpg";
  static String bgBrokenCloudsNight = "assets/background/03n.jpg";
  static String bgShowerRainDay = "assets/background/09d.jpg";
  static String bgShowerRainNight = "assets/background/09n.jpg";
  static String bgRainDay = "assets/background/10d.jpg";
  static String bgRainNight = "assets/background/10n.jpg";
  static String bgThunderstormDay = "assets/background/11d.jpg";
  static String bgThunderstormNight = "assets/background/11n.jpg";
  static String bgSnowDay = "assets/background/13d.jpg";
  static String bgSnowNight = "assets/background/13n.jpg";
  static String bgMistDay = "assets/background/50d.jpg";
  static String bgMistNight = "assets/background/50n.jpg";

  static String getWeatherBackground({String? code = "01d"}) =>
      "assets/background/$code.jpg";

  /// Lottie Animations Json
  static String clearDayJson = "assets/animations/01d.json";
  static String clearNightJson = "assets/animations/01n.json";
  static String cloudyDayJson = "assets/animations/02d.json";
  static String cloudyNightJson = "assets/animations/02n.json";
  static String cloudsJson = "assets/animations/03d.json";
  static String rainDayJson = "assets/animations/09d.json";
  static String rainNightJson = "assets/animations/09n.json";
  static String thunderJson = "assets/animations/11d.json";
  static String snowJson = "assets/animations/13d.json";
  static String mistJson = "assets/animations/50d.json";
  static String loadingAnimationJson =
      "assets/animations/loading_animation.json";

  static String getAnimation({String? code = "01d"}) {
    switch (code!) {
      case "01d":
        return clearDayJson;
      case "01n":
        return clearNightJson;
      case "02d":
        return cloudyDayJson;
      case "02n":
        return cloudyNightJson;
      case "03d":
      case "03n":
      case "04d":
      case "04n":
        return cloudsJson;
      case "09d":
      case "10d":
        return rainDayJson;
      case "09n":
      case "10n":
        return rainNightJson;
      case "11d":
      case "11n":
        return thunderJson;
      case "13d":
      case "13n":
        return snowJson;
      case "50d":
      case "50n":
        return mistJson;
      default:
        return clearDayJson;
    }
  }
}
