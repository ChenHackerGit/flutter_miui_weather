# flutter_miui_weather

一个使用 flutter 仿照 miui 天气写的简易天气软件，支持 windows 和 android

## 如何运行

1. 创建一个[心知天气](https://www.seniverse.com/)账号.
2. 获取 API key 在 https://www.seniverse.com/dashboard.
3. 拉取仓库
   ```sh
   git clone https://github.com/ChenHackerGit/flutter_miui_weather.git
   ```
4. 安装所有依赖
   ```sh
   flutter pub get
   ```
5. 在 **lib\utils\fetch_json.dart** 用你的 api key 替换
   ```dart
   https://api.seniverse.com/v3/weather/now.json?key=YouKey
   ```
6. 启动 app
