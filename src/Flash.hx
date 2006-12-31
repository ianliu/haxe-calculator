


import org.ianliu.Fog;
import org.ianliu.Css;
import org.ianliu.Grid;
import org.ianliu.Text;
import org.ianliu.Label;
import org.ianliu.Button;
import org.ianliu.Container;
import org.ianliu.util.MyStringTools;

import flash.events.Event;
import flash.events.MouseEvent;
import flash.events.FocusEvent;
import flash.events.KeyboardEvent;

import flash.text.TextFormat;
import flash.ui.Keyboard;
import Gui;

/**
	Main Class
**/
class Flash
{
	// The stage
	public static var pane:flash.display.Stage = flash.Lib.current.stage;
	
	// The texts
	private var t1:Text;
	private var t2:Text;
	private var t3:Text;
	private var t4:Text;
	
	private var old:String; // Aux variable to fix the text when pressing O/P keys
	private var ind:Int;    // Aux variable to determine the caret position in the text field
	
	private var error_label:Label;
	
	// Constructor
	public function new()
	{
		pane.scaleMode = flash.display.StageScaleMode.NO_SCALE;
		pane.align = flash.display.StageAlign.TOP_LEFT;
		
		var raiz       = new Container();
		var cont       = new Container(new Grid(1, FIXED_ROW), false, new Css(0, 0));
		var teclado    = new Teclado(labelBtnHandle);
		var operadores = new Operadores(labelBtnHandle);
		var funcs      = new Funcs(funcBtnHandle);
		var error_log  = new Container();
		var misc       = new Misc();
		var funcPanel  = new AddFuncPanel();
		var fog        = new Fog("Adding a new Function", funcPanel);
		
		cont.add(teclado);
		cont.add(operadores);
		cont.add(funcs);
		cont.add(misc);
		
		error_label = new Label(null, cont.innerWidth-2*error_log.css.padding-error_log.css.border_size);
		error_log.add(error_label);
		
		var textos = new Container(new Grid(2, FIXED_COL));
		var tf     = new TextFormat("Verdana", 14); tf.align = "center";
		var tmpw = cont.innerWidth - textos.layout.vgap - 2*textos.css.padding - 1 - textos.css.border_size;
		var tmp = 
		textos.add(new Label("C=")); textos.add( t4 = new Text( tmpw - tmp.width, null, tf) );
		textos.add(new Label("B=")); textos.add( t3 = new Text( tmpw - tmp.width, null, tf) );
		textos.add(new Label("A=")); textos.add( t2 = new Text( tmpw - tmp.width, null, tf) );
		textos.add(new Label("R=")); textos.add( t1 = new Text( tmpw - tmp.width, null, tf) );
		
		raiz.add(textos);
		raiz.add(error_log);
		raiz.add(cont);
		pane.addChild(raiz);
		
		teclado.igual.addEventListener(MouseEvent.CLICK, parse);
		pane.addEventListener(KeyboardEvent.KEY_DOWN, handleKeyboard);
		misc.add_function_btn.addEventListener(MouseEvent.CLICK,
			function(e:MouseEvent):Void {
				fog.show();
			}
		);
		funcPanel._cancel.addEventListener(MouseEvent.CLICK,
			function(e:MouseEvent):Void {
				fog.hide();
			}
		);
		
		pane.focus = t1.textField;
	}
	
	/**
	 * Calculates the t1.text expression and pull all
	 * other expressions to the upper text field
	 */
	public function parse(e:MouseEvent):Void {
		var p, a;
		try {
			a = [t2.text, t3.text, t4.text];
			p = new Parse( MyStringTools.trimAll(t1.text), a );
			t4.text = t3.text;
			t3.text = t2.text;
			t2.text = t1.text;
			t1.text = Std.string(p.result);
			var i = t1.text.length;
			pane.focus = t1.textField;
			t1.textField.setSelection(i, i);
		} catch( e:ParseError ) {
			error_label.label = "Error: " + e.message + " at [" + e.interval.toString() + "]";
			t1.format.color = 0xff0000;
			t1.format.bold  = true;
			t1.textField.setTextFormat(t1.format, e.interval[0], e.interval[1]);
			if(pane.focus == t1.textField) pane.focus = pane;
			var me = this;
			t1.textField.addEventListener(FocusEvent.FOCUS_IN,
				function(e:FocusEvent):Void {
					me.t1.format.color = 0x00;
					me.t1.format.bold  = false;
					me.t1.textField.setTextFormat(me.t1.format);
				});
		}
	}
	/**
	 * Add the button label to the text field
	 */
	public function addLabel(label:String):Void {
		var t = t1.textField;
		var i = t.selectionBeginIndex;
		var j = t.selectionEndIndex;
		if(i != j) t.replaceSelectedText(label);
		else       t.text = t.text.substr(0, i) + label + t.text.substr(i);
		ind = i+label.length;
		old = t.text;
	}
	
	public function addFunc(func:String, ?code:Int):Void {
		var t = t1.textField;
		var i = t.selectionBeginIndex;
		var j = t.selectionEndIndex;
		if(code == null) code = 40;
		if( i != j ) {
			old = t.text.substr(0, i) + func + "(" + t.text.substr(i, j-i) + ")" + t.text.substr(j);
			ind = i + func.length + 2 + j-i;
		} else {
			old = t.text.substr(0, i) + func + Std.chr(code) + t.text.substr(i);
			ind = i + func.length + 1;
		}
	}
	public function handleKeyboard(e:KeyboardEvent):Void {
		var c = e.keyCode;
		if( c == Keyboard.ENTER ) {
			parse(null);
		} else
		if( (c >= 48 && c <= 90) || ( c >= 96 && c <= 105 ) ||
			cmpAll(c, [32, 106, 107, 109, 110, 111, 187, 188, 189, 194]) ) { // Keys [0, 9], [a, z], {-=/*-+.,}
			var t = t1.textField;
			if( pane.focus != t ) pane.focus = t;
			if( c == 79 || c == 80 ) {    // f( O ) = '('   f( P ) = ')'
				addFunc("", c-39); fix(); // Keys 40 and 41 are parentheses
			} else
			if( c == 73 ) {               // f( i ) = ^
				addLabel("^"); fix();
			} else
			if( c == 110 || c == 188 ) {  // f( , ) = .
				addLabel("."); fix();
			} else
			if( c == 187 ) {              // f( = ) = +
				addLabel("+"); fix();
			} else
			if( c == 32 ) {               // espaço
				addLabel(""); fix();
			}
		}
	}
	public function fix():Void { t1.addEventListener(Event.CHANGE, fixText); }
	public function fixText(e:Event):Void {
		t1.text = old;
		t1.textField.setSelection(ind, ind);
		t1.removeEventListener(Event.CHANGE, fixText);
	}
	public function funcBtnHandle(e:MouseEvent):Void {
		pane.focus = t1.textField;
		addFunc(e.currentTarget.getLabel());
		t1.text = old;
		t1.textField.setSelection(ind, ind);
	}
	public function labelBtnHandle(e:MouseEvent):Void {
		pane.focus = t1.textField;
		addLabel(cast(e.currentTarget, Button).label);
		t1.textField.setSelection(ind, ind);
	}
	public function cmpAll( c:Int, a:Array<Int> ):Bool {
		for(i in 0...a.length)
			if(a[i] == c)
				return true;
		return false;
	}
	public function say(x:Dynamic):Void {
		trace("\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t"+x);
	}
	public static function main() {
		new Flash();
	}
}
