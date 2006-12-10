
package org.ianliu;

import flash.display.Shape;
import flash.display.Sprite;
import flash.display.Graphics;
import flash.display.GradientType;
import flash.display.SpreadMethod;
import flash.display.LineScaleMode;
import flash.events.MouseEvent;
import flash.text.TextFormat;
import flash.text.TextFieldAutoSize;
import flash.geom.Matrix;
import org.ianliu.FTextField;

class UIButton extends org.ianliu.UIComponent
{
	private var gface  :Shape;
	private var gpress :Shape;
	private var ghit   :Sprite;
	private var ftxt   :FTextField;
	
	private var mainColor:Int;
	private var lightColor:Int;
	private var borderColor:Int;
	
	public function new(label:String, ?width:Float, ?height:Float, ?faceColor:Int, ?textFormat:TextFormat)
	{
		super();
		makeText(label, textFormat);
		if(width  == null) width  = Std.int(ftxt.width) + 5;
		if(height == null) height = Std.int(ftxt.height) + 5;
		locateText(width, height);
		
		makeColor(faceColor);
		makeHit  (width, height);
		makeFace (width, height);
		makePress(width, height);
		
		gpress.visible = false;
		
		addEvents();
		this.addChild(gpress);
		this.addChild(gface);
		this.addChild(ftxt);
		this.addChild(ghit);
	}
	
	public function resize(width:Int, height:Int):Void {
		gface.width = ghit.width = gpress.width = width;
		gface.height = ghit.height = gpress.height = height;
		locateText(width, height);
	}
	
	private function addEvents():Void {
		ghit.addEventListener(MouseEvent.MOUSE_UP  , mouseUp  );
		ghit.addEventListener(MouseEvent.MOUSE_DOWN, mouseDown);
	}
	
	private function mouseDown(e:MouseEvent):Void {
		gpress.visible = true;
		gface.visible = false;
	}
	
	private function mouseUp(e:MouseEvent):Void {
		gpress.visible = false;
		gface.visible = true;
	}
	
	private function makeColor(c:Int):Void {
		mainColor = if(c == null) 0xDEDEDE else c;
		var r = (mainColor >> 16)+0x15;
		var g = (mainColor >> 8 & 0x00ff)+0x15;
		var b = (mainColor & 0x0000ff)+0x15;
		if(r > 0xff) r = 0xff;
		if(g > 0xff) g = 0xff;
		if(b > 0xff) b = 0xff;
		lightColor = r << 16 | g << 8 | b;
		r -= 0x51;
		g -= 0x51;
		b -= 0x51;
		if(r < 0x00) r = 0x00;
		if(g < 0x00) g = 0x00;
		if(b < 0x00) b = 0x00;
		borderColor = r << 16 | g << 8 | b;
	}
	
	private function makeText(lbl:String, tf:TextFormat):Void {
		ftxt = new FTextField(lbl);
		ftxt.autoSize = TextFieldAutoSize.LEFT;
		ftxt.selectable = false;
		
		if(tf != null) {
			ftxt.format = tf;
		} else {
			var f:TextFormat = ftxt.format;
			f.font = "Verdana";
			f.size = 12;
			f.color = 0x333333;
		}
		ftxt.setFormat();
	}
	
	private function makeFace(w:Float, h:Float):Void {
		gface = new Shape();
		
		var g:Graphics = gface.graphics;
		var mtr:Matrix = new Matrix();
		var fillType = GradientType.LINEAR;
		var colors   = [lightColor, mainColor];
		var alphas   = [1, 1];
		var ratios   = [0x00, 0xAA];
		mtr.createGradientBox(w, h, Math.PI/2);
		
		g.lineStyle(1, borderColor);
		g.beginGradientFill(fillType, colors, alphas, ratios, mtr, SpreadMethod.PAD);
		g.drawRect(0, 0, w, h);
		g.endFill();
	}
	
	private function makePress(w:Float, h:Float):Void {
		gpress = new Shape();
		
		var g:Graphics = gpress.graphics;
		
		g.lineStyle(1, borderColor, 1.0, false, LineScaleMode.NONE);
		g.beginFill(mainColor);
		g.drawRect(0, 0, w, h);
		g.endFill();
	}
	
	private function makeHit(w:Float, h:Float):Void {
		ghit = new Sprite();
		
		var g:Graphics = ghit.graphics;
		
		g.lineStyle(1, 0, 0.0, false, LineScaleMode.NONE);
		g.beginFill(0, 0.0);
		g.drawRect(0, 0, w, h);
		g.endFill();
		ghit.buttonMode = true;
	}
	
	private function locateText(w:Float, h:Float):Void {
		ftxt.x = (w - ftxt.width)/2;
		ftxt.y = (h - ftxt.height)/2;
	}
	
	public function getLabel()  :String {return ftxt.text;    }
}






