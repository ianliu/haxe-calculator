


package org.ianliu.events;

import org.ianliu.UIRadio;
import org.ianliu.RadioGroup;
import flash.events.Event;

class RadioEvent extends Event {
	
	public var radioGroup (default,null):RadioGroup;
	public var targetRadio(default,null):UIRadio;
	
	public function new(radioGroup:RadioGroup, targetRadio:UIRadio) {
		super(Event.CHANGE);
		this.radioGroup  = radioGroup;
		this.targetRadio = targetRadio;
	}
}
