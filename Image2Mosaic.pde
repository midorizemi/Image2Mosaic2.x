//Capture!!ボタンを押すことで、モザイク画面を表示し
//同時にキャプチャします。
//ボタンはウィンドウ上部に隠れるようになっていてカーソルを
//上部に移動するとツールバーが降りてきます。
//テキストボックスにはデフォルトで「temp.jpg」が入力されています。
//ここに任意のファイル名と（tiff, tga, gif, jpg, png)の
//フォーマットで保存できます。
//ファイルは実行データのディレクトリに格納されます。
///////////////////////////////////////////////////////////////
import java.awt.TextField;
//ツールバーの要素宣言---------------------------------------
PFont font;
Button button;//キャプチャボタン
int x;//ボタン座標ｘ
int y;//ボタン座標ｙ
String s="Capture!!";//ボタンテキスト
Button mosaic;
int mX;
int mY;
String  mS="2mosaic";
Button change;
int cX, cY;
String cS="ChangeData";
//------------------------------------------------------------
final int sheet_x=0;//ツールバー座標ｘ
final int sheet_Height=34;//ツールバーの高さ
int sheet_y;//ツールバー座標ｙ
int sheet_Width;//ツールバーの幅
color sheet_color=color(255, 0, 0);////ツールバーの色（赤）
//テキストボックス---------------------------------------------
int tX, tY;
String file_Name="temp.jpg";
TextField imput=new TextField(file_Name);
//------------------------------------------------------------
//モザイク加工した画像表示------------------------------------
String sImg="hoge.jpg";//加工元画像名
Iro_ninshiki ninshiki;//モザイク加工クラス
//------------------------------------------------------------
//////////////////////////////////////////////////////////////
void setup() {
  size(640, 480);//画面サイズ
  //フォント読み込み------------------------------------------
  font=loadFont("MS-Gothic-15.vlw");
  textFont(font,15);
  sheet_Width=width; //画面いっぱいに表示
  mX=sheet_Width/60;
  mY=sheet_Height/10;
  mosaic=new Button(mX, mY, mS);
  mosaic.setButton();
  x=13*sheet_Width/40-10;
  y=sheet_Height/10;
  button=new Button(x, y, s);//インスタンス化
  button.setButton();//初期化
  cX=3*sheet_Width/20-5;
  cY=y;
  change=new Button(cX, cY, cS);
  change.setButton();
  //-----------------------------------------------------------
  ninshiki=new Iro_ninshiki("MS-Gothic-15.vlw", sImg);//インスタンス化
  //-----------------------------------------------------------

  //-----------------------------------------------------------
  //------------------------------------------------------------
  tX=19*sheet_Width/40-10;
  tY=y;
  setLayout(null);
  imput.setBounds(tX, tY, 160, 20);
  add(imput);
  //-----------------------------------------------------------
  frameRate(30);
  colorMode(HSB, 360, 1.0, 1.0);//HSV表現
}
//////////////////////////////////////////////////////////////////
void draw() {
  background(0, 0, 1);//背景(白）
  //マウスが画面上にあるときのツールバー------------------------
  if (onY(mouseY, 0, sheet_Height)&&sheet_y<=0) {
    //上から出てくる
    sheet_y+=1;
    y+=1;
    tY+=1;
    mY+=1;
    cY+=1;
    //ボタンの座標更新
    button.setY(y);
    mosaic.setY(mY);
    change.setY(cY);
    imput.setBounds(tX, tY, 160, 20);
  }
  if (!onY(mouseY, 0, sheet_Height) && sheet_y>=-sheet_Height) {
    //ツールバーが閉じていく
    sheet_y-=1;
    y-=1;
    tY-=1;
    mY-=1;
    cY-=1;
    //ボタンの座標更新
    button.setY(y);
    mosaic.setY(mY);
    change.setY(cY);
    imput.setBounds(tX, tY, 160, 20);
  }
  //イメージの変更------------------------------------------------
//  if(change.getStatus()){
//    ninshiki.setImage(file_Name);
//    change.switched();
//  }
  if(change.getStatus()){
     try {
    ninshiki.setImage(file_Name);
     } catch(NullPointerException e) {
             println(sImg);  //(3)
             ninshiki.setImage(sImg);
    }
    change.switched();
  }
 
     
   

  //--------------------------------------------------------------
  ninshiki.draw();//描画
  //モザイク描画--------------------------------------------------
  if (mosaic.getStatus()) {
    //on/offでスイッチ
    if (button.getStatus()) {
     //trueならキャプチャ。file_Nameとして保存
     save("mosaic_"+file_Name);//保存
     button.switched();
    }
  }

  fill(sheet_color);//ツールバー色設定
  rect(sheet_x, sheet_y, sheet_Width, sheet_Height);//ツールバー描画
  textFont(font, 15);
  fill(0, 0, 1);//ボタン色
  mosaic.draw();
  fill(0, 0, 1);//ボタン色
  change.draw();
  fill(0, 0, 1);//ボタン色
  button.draw();//描画
  text(imput.getText()+"で保存します", 29*sheet_Width/40-10, y+17);//ファイルの案内画面
} 
///////////////////////////////////////////////////////////////////////
//キャプチャーボタンのクリックイベント---------------------------------
void mousePressed() {
  //キャプチャーする
  if (onX( mouseX, button.getX(), (button.getX() + button.getW()) ) && onY( mouseY, button.getY(), (button.getY() + button.getL()) ) ) {
    button.switched();
    if (button.getStatus()) {
      if (file_Name.length()!=0) {
        file_Name=imput.getText();
      }
    }
  }
  if (onX( mouseX, mosaic.getX(), (mosaic.getX() + mosaic.getW()) ) && onY( mouseY, mosaic.getY(), (mosaic.getY() + mosaic.getL()) ) ) {
    mosaic.switched();
    ninshiki.set_Status(mosaic.getStatus());
  }
  if (onX( mouseX, change.getX(), (change.getX() + change.getW()) ) && onY( mouseY, change.getY(), (change.getY() + change.getL()) ) ) {
    change.switched();
    file_Name=imput.getText();
  }
}
//----------------------------------------------------------------
//領域判定（マウスの座標「評価対象」、最小値、最大値)--------------
boolean onX(int mx, int min, int max) {
  //領域内であればtrueを返す
  if (min<=mx&&mx<=max) {
    return true;
  }
  return false;
}
//Yの場合
boolean onY(int my, int min, int max) {
  if (min<=my&&my<=max) {
    return true;
  }
  return false;
}
//-------------------------------------------------------------------

