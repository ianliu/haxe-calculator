

package org.ianliu;

import flash.text.TextField;
import flash.text.TextFormat;

class UILabel extends UIComponent
{
	private var format:TextFormat;
	private var txt:TextField;
	
	public function new(?label:String, ?width:Float, ?format:TextFormat) {
		super();
		this.format = if(format == null) new TextFormat("Verdana", 14) else format;
		txt = new TextField();
		txt.defaultTextFormat = this.format;
		txt.text = if(label == null) " " else label;
		txt.autoSize = "left";
		if(width != null) {
			var h = txt.height;
			txt.autoSize = "none";
			txt.width = width;
			txt.height = h;
		}
		txt.selectable = false;
		super.addChild(txt);
	}
	public function getLabel():String { return txt.text; }
	public function setLabel(label:String):Void { txt.text = label; }
	
	public function getFormat():TextFormat { return format; }
	public function setFormat(format:TextFormat):Void { txt.defaultTextFormat = format; setLabel(getLabel()); }
}
