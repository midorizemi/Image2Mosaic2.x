public class Button {
  //要素宣言
  private int x, y;//座標（ｘ,ｙ）
  private int w, l;//幅　と　高さ
  private String s;//ボタンに書く文字列
  private int setting=6;//調節
  private boolean status=false;
  private double rate=1.25;
  //コンストラクタ
  Button(int x_, int y_, String s_) {
    x=x_;
    y=y_;
    s=s_;
  }
  //ボタンオブジェクトの初期化-----------
  void setButton() {
    for (int i=0;i<s.length(); i++) {
      w+=(int)(textWidth(s.charAt(i))*rate);
    }
    l=(int)(textAscent()*rate);
  }
  //ゲッター---------------------------
  int getX() { 
    return x;
  }
  int getY() { 
    return y;
  }
  int getW() { 
    return w;
  }
  int getL() { 
    return l;
  }
  //セッター-------------------------
  void setXY(int x_, int y_) {
    x=x_;
    y=y_;
  }
  void setY(int y_) {
    y=y_;
  }
  //スイッチ---------------------------
  void switched(){
    if(status){
      status=false;
    }else{
      status=true;
    }
  }
  boolean getStatus(){
    return status;
  }
  //-----------------------------------
  //描画-------------------------------
  void draw() {
    rect(x, y, w, l);
    fill(0);
    text(s, x+5, l+y-setting/2);
  }
}

