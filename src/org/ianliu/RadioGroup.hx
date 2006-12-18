


package org.ianliu;

import org.ianliu.Container;
import org.ianliu.events.RadioEvent;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.events.EventDispatcher;

class RadioGroup extends EventDispatcher {
	
	private var radios       :Array<UIRadio>;
	private var container    :Container;
	private var lastSelected :UIRadio;
	
	public function new(?container:Container) {
		super();
		radios         = new Array();
		this.container = container;
		lastSelected   = null;
	}
	
	public function add(rb:UIRadio):UIRadio {
		if(container != null)
			container.add(rb);
		radios.push(rb);
		//rb.setGroup(this);
		rb.addEventListener(MouseEvent.CLICK, dispatchChange);
		return rb;
	}
	
	private function dispatchChange(e:MouseEvent):Void {
		if(lastSelected != null) {
			lastSelected.toggle();
		}
		lastSelected = e.currentTarget;
		super.dispatchEvent(new RadioEvent(this, e.currentTarget));
	}
	
	public function getContainer():Container      { return this.container; }
	public function getRadios()   :Array<UIRadio> { return this.radios;    }
	public function getSelected() :UIRadio        { return lastSelected;   }
}
