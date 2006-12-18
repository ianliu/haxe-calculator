

package org.ianliu;

import flash.events.Event;
import flash.display.Stage;
import flash.display.Shape;
import flash.display.Sprite;

import org.ianliu.Container;

class UIFog extends Sprite {
	
	public static var init:UIFog;
	
	private var fog:Shape;
	private var pane:Stage;
	
	public function new(parent:Stage, over:Container) {
		if(init != null) throw "Can't add 2 or more UIFogs instances";
		super();
		init = this;
		pane = parent;
		fog = new Shape();
		drawFog();
		
		super.addChild(fog);
		super.addChild(over);
		
		over.x = (pane.stageWidth-over.width)/2;
		over.y = (pane.stageHeight-over.height)/2;
	}
	public function show():Void {
		pane.addChild(this);
		pane.addEventListener(Event.ADDED, moveFog);
	}
	public function remove():Void {
		pane.removeChild(this);
		pane.removeEventListener(Event.ADDED, moveFog);
	}
	private function drawFog():Void {
		fog.graphics.beginFill(0x00, .3);
		fog.graphics.drawRect(0, 0, pane.stageWidth, pane.stageHeight);
		fog.graphics.endFill();
	}
	private function moveFog(e:Event):Void {
		try {
			if(pane.getChildIndex(e.target) > pane.getChildIndex(this))
				pane.swapChildren(e.target, this);
		}
	}
}
