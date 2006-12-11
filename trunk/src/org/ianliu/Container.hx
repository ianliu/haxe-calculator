

package org.ianliu;

import flash.display.Sprite;
import flash.events.Event;
import flash.events.EventDispatcher;
import org.ianliu.Grid;

class Container extends org.ianliu.UIComponent {
	
	public var layout:Grid;
	public var padding:Int;
	public var background:Int;
	
	private var innerWidth :Float;
	private var innerHeight:Float;
	private var bdr:Sprite;
	
	public function new(?layout:Grid, ?has_border:Bool, ?padding:Int, ?background:Int) {
		super();
		addEventListener(UIComponent.REFRESH, refresh);
		this.layout  = if(layout == null) new Grid(1, FixedCols) else layout;
		this.padding = if(padding == null) 5 else padding;
		this.layout.setMargin(this.padding);
		this.background = if(background == null) 0xDDDDDD else background;
		if(has_border) {
			bdr = new Sprite();
			super.addChild(bdr);
		}
	}
	
	private function refresh(e:Event):Void {
		layout.draw();
		if(bdr != null) {
			bdr.graphics.clear();
			var w = innerWidth  = this.width;
			var h = innerHeight = this.height;
			bdr.graphics.lineStyle(1, 0xffffff, 1, true);
			bdr.graphics.beginFill(background);
			bdr.graphics.drawRoundRect(1, 1, w+2*padding, h+2*padding, 10, 10);
			bdr.graphics.endFill();
			bdr.graphics.lineStyle(1, 0x787878, 1, true);
			bdr.graphics.drawRoundRect(0, 0, w+2*padding, h+2*padding, 10, 10);
		}
	}
	public function add(c:UIComponent):Void {
		addChild(c);
		layout.add(c);
		dispatchEvent(new Event(UIComponent.REFRESH, true));
	}
	public function remove(c:UIComponent):Void {
		super.removeChild(c);
		layout.remove(c);
		dispatchEvent(new Event(UIComponent.REFRESH, true));
	}
	public function removeAt(pos:Int):Void {
		super.removeChildAt(pos);
		//layout.removeAt(pos);
		dispatchEvent(new Event(UIComponent.REFRESH, true));
	}
	
	public function getInnerWidth() :Float { return if(bdr == null) this.width  else innerWidth;  }
	public function getInnerHeight():Float { return if(bdr == null) this.height else innerHeight; }
}
