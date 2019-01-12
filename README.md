## DetectHPlane
### 概要
水平面を認識し、球を配置する。
### 作成手順  

1. Xcodeで新規プロジェクトを作成し、「Augmented Reality App」を選択。  
<img src="images/detect_hplane_select_ar.png" width="480"/>   

2. 任意のプロジェクト名(ここでは「DetectHPlane」)、Languageは「Swift」、Content Technologyは「SceneKit」を選択。  
SceneKit：簡単に3Dゲームを作ることができるフレームワーク  
<img src="images/detect_hplane_select_swift_scene_kit.png" width="480"/>  

3. 一旦、実行してみる。iPhone/iPadを接続し、実行ボタンを押下。  
<img src="images/detect_hplane_initial_run.png" width="480"/>  
カメラスルーに飛行機が表示される。  
<img src="images/detect_hplane_initial_run_ship.png" width="200"/>  

4. 飛行機を削除し、水平面認識指定を追加。  
[変更内容](https://github.com/da351hon/DetectHPlane/commit/2a964fc8b8b52a165174da7134336c1e415335cf)

5. 水平面検出時に球を配置する処理を追加。  
[変更内容](https://github.com/da351hon/DetectHPlane/commit/4280be1f1c8aea9408daf1aa038f70411c12b231)

6. 実行。
