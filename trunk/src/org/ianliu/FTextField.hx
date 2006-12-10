package org.ianliu;

class FTextField extends flash.text.TextField {
	public var format:flash.text.TextFormat;
	public function new(?label:String, ?format:flash.text.TextFormat, ?beginIndex:Int, ?endIndex:Int) {
		super();
		if(format == null) {
			this.format = new flash.text.TextFormat();
		} else {
			this.format = format;
			setFormat(beginIndex, endIndex);
		}
		if(label != null) this.text = label;
	}
	public function setFormat(?beginIndex : Int, ?endIndex : Int):Void {
		if(beginIndex == null)	beginIndex = -1;
		if(endIndex == null)	endIndex = -1;
		setTextFormat(this.format, beginIndex, endIndex);
		defaultTextFormat = this.format;
	}
}
