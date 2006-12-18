

package org.ianliu;

import flash.text.TextField;
import flash.text.TextFormat;

class UILabel extends UIComponent
{
	public var label (default,null):String;
	public var format(default,null):TextFormat;
	
	private var txt:TextField;
	
	public function new(?label:String, ?width:Float, ?format:TextFormat) {
		super();
		this.label  = label;
		this.txt    = new TextField();
		this.format = if(format == null) new TextFormat("Verdana", 14) else format;
		
		this.txt.defaultTextFormat = this.format;
		this.txt.text              = if(label == null) " " else label;
		this.txt.autoSize          = "left";
		
		if(width != null) {
			var h = txt.height;
			txt.autoSize = "none";
			txt.width = width;
			txt.height = h;
		}
		txt.selectable = false;
		super.addChild(txt);
	}
	
	/**
		Setters
	**/
	public function setLabel (label:String)     :Void { txt.text = label; this.label = label; }
	public function setFormat(format:TextFormat):Void { txt.defaultTextFormat = format; setLabel(getLabel()); }
	
	/**
		Getters
	**/
	public function getLabel () :String     { return label;  }
	public function getFormat() :TextFormat { return format; }
}
