class Iro_ninshiki {
  //要素宣言------------------------------------------------
  PFont font;//漢字のフォント
  PImage img;//画像
  //色
char[] t= {
  '赤', '橙', '黄', '緑', '翠', '水', '藍', '青', '紫', '桃', '白', '黒', '誤'
};
  char sc;
  int interval=1;//文字間隔
  int ofset;//ひとつ前までの文字列の長さ
  //キャプチャースイッチ
  private boolean switch_Capture=false;
  //------------------------------------------------------
  //コンストラクタ----------------------------------------
  Iro_ninshiki(String sFont, String sImg) {
    font=loadFont(sFont);
    textFont(font);
    img=loadImage(sImg);
    ofset=0;
  }
  //-----------------------------------------------------
  //クラスの初期化---------------------------------------
//  void setIro_ninshiki() {
//  }
//  //ここは改善できるかも
  //-------------------------------------------------------
  void setImage(String sImg) throws NullPointerException{
    img=loadImage(sImg);
  }
  //アクセッサー--------------------------------
  boolean get_Status() {
    return switch_Capture;
  }
  void set_Status(boolean s) {
    switch_Capture=s;
  }
  //--------------------------------------------

  //描画---------------------------------------------------
  void draw() {
    image(img, 0, 0);
    if (switch_Capture) {
      loadPixels();//ピクセル読み込み
      background(0);//imgを黒で上書き
      //文字描画-------------------------------------------
      textSize(12);//モザイクの荒さ
      int y=0;
      int x=0;
      int space=10;
      while (y +space<= height) {
        while (x+ofset<=width) {  
          fill(pixels[(y)*width+ofset]); //ピクセルごとの色を抽出
          sc=select_Char(pixels[(y)*width+ofset]);//文字選択
          text(sc, ofset, y+space);//文字描画
          ofset+=textWidth(sc)-interval;//描画した文字分足す
        }
        y+=textAscent()-interval;//描画した文字分足す
        ofset=0;//初期化
      }
    }
  }
  ///文字選択------------------------------------------
  public char select_Char(color c) {
  float h=hue(c);//色相
  float s=saturation(c);//彩度
  float b=brightness(c);//明度
  char sc;
  if ((0<=h&&h<=29)||(329<h&&h<=360)) {
    sc=t[0];//red
  }
  else if (29<h&&h<=45) {
    sc=t[1];//orange
  }
  else if (45<h&&h<=70) {
    sc=t[2];//yellow
  }
  else if (70<h&&h<=159) {
    sc=t[3];//green
  }
  else if (159<h&&h<=180) {
    sc=t[4];//emerald
  }
  else if (180<h&&h<=210) {
    sc=t[5];//cyan
  }
  else if (210<h&&h<=225) {
    sc=t[6];//azure
  }
  else if (225<h&&h<=270) {
    sc=t[7];//blue
  }
  else if (270<h&&h<=299) {
    sc=t[8];//violet
  }
  else if (299<h&&h<=329) {
    sc=t[9];//pink
  }
  else {
    sc=t[12];//error
  }
  if (s<=0.10) {
    sc=t[10];//white
  }
  if (b<=0.3) {
    sc=t[11];//black
  }
  if (21<=h&&h<=45) {
    if (0.25<=s&&s<=0.55) {
      if (0.90<=b&&b<=1.0) {
        sc='肌';
      }
    }
  }
  return sc;
}
  //--------------------------------------------
}

