
package org.ianliu;

import flash.display.Shape;
import flash.display.Sprite;
import flash.display.Graphics;
import flash.display.GradientType;
import flash.display.SpreadMethod;
import flash.display.LineScaleMode;
import flash.text.TextField;
import flash.text.TextFormat;


class UIText extends UIComponent
{
	public var format:TextFormat;
	
	private var mainColor  :Int;
	private var borderColor:Int;
	private var txt :TextField;
	private var bg  :Shape;
	
	public function new(?width:Float, ?height:Float, ?format:TextFormat, ?faceColor:Int) {
		super();
		this.format = if(format == null) new TextFormat("Verdana", 14) else format;
		txt = new TextField();
		txt.type = "input";
		txt.width  = if(width  == null) 200-3 else width-3;
		txt.height = if(height == null) 22  else height;
		txt.defaultTextFormat = this.format;
		txt.y = 1;
		
		makeColor(faceColor);
		drawShape(txt.width, txt.height);
		addChild(bg);
		addChild(txt);
	}
	
	private function drawShape(w:Float, h:Float):Void {
		bg = new Shape();
		bg.graphics.lineStyle(1, borderColor);
		bg.graphics.beginFill(mainColor);
		bg.graphics.drawRect(0, 0, w, h);
		bg.graphics.endFill();
		bg.filters = [new flash.filters.GlowFilter(borderColor, 1, 5, 5, 2, 1, true)];
	}
	
	private function makeColor(c:Int):Void {
		mainColor = if(c == null) 0xfefefe else c;
		var r = (mainColor >> 16)-0x66;
		var g = (mainColor >> 8 & 0x00ff)-0x66;
		var b = (mainColor & 0x0000ff)-0x66;
		if(r < 0x00) r = 0x00;
		if(g < 0x00) g = 0x00;
		if(b < 0x00) b = 0x00;
		borderColor = r << 16 | g << 8 | b;
	}
	
	public function getTextField():TextField { return txt; }
	public function appendText(str:String):Void { txt.appendText(str); }
	
	public function getText  ():String { return txt.text;   }
	public function getWidth ():Float  { return txt.width;  }
	public function getHeight():Float  { return txt.height; }
	
	public function setText  (s:String):Void { txt.text   = s; }
	public function setWidth (w:Float) :Void { txt.width  = bg.width  = w-3; }
	public function setHeight(h:Float) :Void { txt.height = bg.height = h;   }
	public function setSize  (w:Float, h:Float):Void { setWidth(w); setHeight(h); }
}
