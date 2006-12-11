
/**
 * Importing UI components
 */

import org.ianliu.Grid;
import org.ianliu.UIText;
import org.ianliu.UILabel;
import org.ianliu.UIButton;
import org.ianliu.Container;
import org.ianliu.UIComponent;

/**
 * Import Events classes
 */
import flash.events.Event;
import flash.events.MouseEvent;
import flash.events.FocusEvent;
import flash.events.KeyboardEvent;
import flash.text.TextFormat;

import flash.ui.Keyboard;

/**
 * @class Teclado					- extends for Keyboard (portuguese)
 * @param f : MouseEvent -> Void	- function to be associated with the keyboards buttons
 * @usage new Teclado( function )
 */
class Teclado extends Container {
	public var igual:UIButton;
	public function new(f:MouseEvent->Void) {
		super(new Grid(3, FixedCols), true);
		var b;
		for(i in 0...9) {
			b = new UIButton(Std.string(i+1), 30, 30);
			b.addEventListener(MouseEvent.CLICK, f);
			super.add(b);
		}
		b = new UIButton(".", 30, 30); b.addEventListener(MouseEvent.CLICK, f); super.add(b);
		b = new UIButton("0", 30, 30); b.addEventListener(MouseEvent.CLICK, f); super.add(b);
		igual = new UIButton("=", 30, 30); super.add(igual);
	}
}

/**
 * @class Operadores				- extends for Operators (portuguese)
 * @param f : MouseEvent -> Void	- function to be associated with the operators buttons
 * @usage new Operadores( function )
 */
class Operadores extends Container {
	public function new(f:MouseEvent->Void) {
		super(new Grid(4, FixedRows), true);
		var b;
		b = new UIButton("+", 30, 30); b.addEventListener(MouseEvent.CLICK, f); super.add(b);
		b = new UIButton("-", 30, 30); b.addEventListener(MouseEvent.CLICK, f); super.add(b);
		b = new UIButton("*", 30, 30); b.addEventListener(MouseEvent.CLICK, f); super.add(b);
		b = new UIButton("/", 30, 30); b.addEventListener(MouseEvent.CLICK, f); super.add(b);
		b = new UIButton("^", 30, 30); b.addEventListener(MouseEvent.CLICK, f); super.add(b);
		b = new UIButton("(", 30, 30); b.addEventListener(MouseEvent.CLICK, f); super.add(b);
		b = new UIButton(")", 30, 30); b.addEventListener(MouseEvent.CLICK, f); super.add(b);
	}
}

/**
 * @class Funcs						- extends for functions
 * @param f : MouseEvent -> Void	- function to be associated with the function buttons
 * @usage new Funcs( function )
 */
class Funcs extends Container {
	public function new(f:MouseEvent->Void) {
		super(new Grid(4, FixedRows), true);
		var b;
		b = new UIButton("ln"  , 40, 30); b.addEventListener(MouseEvent.CLICK, f); super.add(b);
		b = new UIButton("foo" , 40, 30); b.addEventListener(MouseEvent.CLICK, f); super.add(b);
		b = new UIButton("exp" , 40, 30); b.addEventListener(MouseEvent.CLICK, f); super.add(b);
		b = new UIButton("sin" , 40, 30); b.addEventListener(MouseEvent.CLICK, f); super.add(b);
		b = new UIButton("cos" , 40, 30); b.addEventListener(MouseEvent.CLICK, f); super.add(b);
		b = new UIButton("tan" , 40, 30); b.addEventListener(MouseEvent.CLICK, f); super.add(b);
		b = new UIButton("asin", 40, 30); b.addEventListener(MouseEvent.CLICK, f); super.add(b);
		b = new UIButton("acos", 40, 30); b.addEventListener(MouseEvent.CLICK, f); super.add(b);
		b = new UIButton("atan", 40, 30); b.addEventListener(MouseEvent.CLICK, f); super.add(b);
	}
}

/**
 * Main Class
 */
class Flash
{
	// The stage
	public static var pane:flash.display.Stage = flash.Lib.current.stage;
	
	// The texts
	private var t1:UIText;
	private var t2:UIText;
	private var t3:UIText;
	private var t4:UIText;
	
	private var old:String; // Aux variable to fix the text when pressing O/P keys
	private var ind:Int;    // Aux variable to determine the caret position in the text field
	
	private var error_label:UILabel;
	
	// Constructor
	public function new()
	{
		pane.scaleMode = flash.display.StageScaleMode.NO_SCALE;
		pane.align = flash.display.StageAlign.TOP_LEFT;
		
		var raiz       = new Container(null, true);
		var cont       = new Container(new Grid(3, FixedCols), false, 0);
		var teclado    = new Teclado(labelBtnHandle);
		var operadores = new Operadores(labelBtnHandle);
		var funcs      = new Funcs(funcBtnHandle);
		var error_log  = new Container(null, true);
		
		cont.add(teclado);
		cont.add(operadores);
		cont.add(funcs);
		
		error_label = new UILabel(null, cont.width-raiz.padding-operadores.padding - 2);
		error_log.add(error_label);
		
		var textos = new Container(new Grid(2, FixedCols), true);
		var tf     = new TextFormat("Verdana", 14); tf.align = "center";
		
		var tmp = new UILabel("A");
		var tmp_w = cont.width - raiz.padding - operadores.padding - tmp.width - textos.padding;
		textos.add(t4 = new UIText( tmp_w, null, tf)); textos.add(tmp);
		textos.add(t3 = new UIText( tmp_w, null, tf)); textos.add(new UILabel("B"));
		textos.add(t2 = new UIText( tmp_w, null, tf)); textos.add(new UILabel("C"));
		textos.add(t1 = new UIText( tmp_w, null, tf)); textos.add(new UILabel("D"));
		
		raiz.add(textos);
		raiz.add(error_log);
		raiz.add(cont);
		pane.addChild(raiz);
		
		teclado.igual.addEventListener(MouseEvent.CLICK, parse);
		pane.addEventListener(KeyboardEvent.KEY_DOWN, handleKeyboard);
		
		pane.focus = t1.getTextField();
	}
	/**
	 * Calculates the t1.text expression and pull all
	 * other expressions to the upper text field
	 */
	public function parse(e:MouseEvent):Void {
		var p;
		try {
			p = new Parse(t1.getText());
			t4.setText(t3.getText());
			t3.setText(t2.getText());
			t2.setText(t1.getText());
			t1.setText(Std.string(p.result));
			var i = t1.getText().length;
			pane.focus = t1.getTextField();
			t1.getTextField().setSelection(i, i);
		} catch( e:ParseError ) {
			error_label.setLabel("Error: " + e.message + " at [" + e.interval.toString() + "]");
			t1.format.color = 0xff0000;
			t1.format.bold  = true;
			t1.getTextField().setTextFormat(t1.format, e.interval[0], e.interval[1]);
			if(pane.focus == t1.getTextField()) pane.focus = pane;
			var me = this;
			t1.getTextField().addEventListener(FocusEvent.FOCUS_IN,
				function(e:FocusEvent):Void {
					me.t1.format.color = 0x00;
					me.t1.format.bold  = false;
					me.t1.getTextField().setTextFormat(me.t1.format);
				});
		}
	}
	/**
	 * Add the button label to the text field
	 */
	public function addLabel(label:String):Void {
		var t = t1.getTextField();
		var i = t.selectionBeginIndex;
		var j = t.selectionEndIndex;
		if(i != j) t.replaceSelectedText(label);
		else t.text = t.text.substr(0, i) + label + t.text.substr(i);
		old = t.text;
		ind = j+1;
	}
	
	public function addFunc(func:String, ?code:Int):Void {
		var t = t1.getTextField();
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
			cmpAll(c, [106, 107, 109, 110, 111, 187, 188, 189, 194]) ) { // Keys [0, 9], [a, z], {-=/*-+.,}
			var t = t1.getTextField();
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
			}
		}
	}
	public function fix():Void { t1.addEventListener(Event.CHANGE, fixText); }
	public function fixText(e:Event):Void {
		t1.setText(old);
		t1.getTextField().setSelection(ind, ind);
		t1.removeEventListener(Event.CHANGE, fixText);
	}
	public function funcBtnHandle(e:MouseEvent):Void {
		pane.focus = t1.getTextField();
		addFunc(e.currentTarget.getLabel());
		t1.setText(old);
		t1.getTextField().setSelection(ind, ind);
	}
	public function labelBtnHandle(e:MouseEvent):Void {
		pane.focus = t1.getTextField();
		addLabel(e.currentTarget.getLabel());
	}
	public function cmpAll( c:Int, a:Array<Int> ):Bool {
		for(i in 0...a.length)
			if(a[i] == c)
				return true;
		return false;
	}
	
	public static function main() {
		new Flash();
	}
}
