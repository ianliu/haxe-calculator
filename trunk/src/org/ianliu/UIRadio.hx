


package org.ianliu;

import org.ianliu.UILabel;
import flash.display.Shape;
import flash.display.Sprite;
import flash.events.MouseEvent;

class UIRadio extends UIComponent {
	
	/**
		TODO : Fix properties setters
	**/
	public var label    (default,null):String;
	public var value    (default,null):Dynamic;
	public var group    (default,null):RadioGroup;
	public var selected (default,null):Bool;
	
	private var lbl :UILabel;
	private var hit :Sprite;
	private var dot :Shape;
	private var circ:Shape;
	
	public function new(label:String, ?value:Dynamic) {
		super();
		this.label    = label;
		this.value    = value;
		this.selected = false;
		this.lbl      = new UILabel(label);
		this.hit      = new Sprite();
		this.dot      = new Shape();
		this.circ     = new Shape();
		
		/* Drawing the GUI */
		draw();
		alloc();
		
		dot.visible = false;
		hit.buttonMode = true;
		
		super.addChild(circ);
		super.addChild(dot);
		super.addChild(lbl);
		super.addChild(hit);
		
		hit.addEventListener(MouseEvent.CLICK, toggle);
	}
	
	/**
		Toggles the Radio Button
	**/
	public function toggle(?e:MouseEvent):Void {
		this.selected = !this.selected;
		this.dot.visible = this.selected;
	}
	
	/**
		Draw the graphical UI
	**/
	private function draw():Void {
		var g;
		
		// Drawing the radio button circle
		g = circ.graphics;
		g.lineStyle(1, 0xffffff);
		g.beginFill(0xeeeeee);
		g.drawCircle(1, 1, 5);
		g.endFill();
		g.lineStyle(1, 0x787878);
		g.drawCircle(0, 0, 5);
		
		// Drawing the dot
		g = dot.graphics;
		g.beginFill(0x00);
		g.drawCircle(0, 0, 2);
		
		// Drawing the hit area
		g = hit.graphics;
		g.beginFill(0x00, 0);
		g.drawRect(0, 0, circ.width + 5 + lbl.width, Math.max(circ.height, lbl.height));
	}
	
	/**
		Allocates the graphical UI
	**/
	private function alloc():Void {
		circ.x = dot.x = circ.width/2;
		lbl.x  = circ.width + 5;
		if(circ.height > lbl.height) {
			circ.y = circ.x;
			lbl.y  = (circ.height-lbl.height)/2;
		} else {
			circ.y = circ.x + (lbl.height-circ.height)/2;
			lbl.y = 0;
		}
		dot.y = circ.y;
	}
	
	/**
		Setters
	**/
	public function setLabel( label:String     ):String     { this.lbl.setLabel(label); return label; }
	public function setValue( value:Dynamic    ):Dynamic    { this.value = value;       return value; }
	//public function setGroup( group:RadioGroup ):RadioGroup { this.group = group;       return group; }
	
	/**
		Getters
	**/
	public function getLabel():String     { return this.label; }
	public function getValue():Dynamic    { return this.value; }
	public function getGroup():RadioGroup { return this.group; }
}
