class WeatherState {
  String location;
  int degree;
  int degreeMin;
  int degreeMax;
  String weather;
  int airQuality;
  String airQualityText;
  int ultraviolet;
  int humidity;
  int sensory;
  int wind;
  String sunriseTime;
  int airPressure;
  String windDirection;
  int windScale;

  WeatherState({
    this.location = '......',
    this.degree = 0,
    this.degreeMin = 0,
    this.degreeMax = 0,
    this.weather = '..',
    this.airQuality = 0,
    this.airQualityText = "...",
    this.ultraviolet = 0,
    this.humidity = 0,
    this.sensory = 0,
    this.wind = 0,
    this.sunriseTime = '....',
    this.airPressure = 0,
    this.windDirection = '...',
    this.windScale = 0,
  });
}
