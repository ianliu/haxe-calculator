
/**
 * Importing UI components
 */
import org.ianliu.Util;
import org.ianliu.Grid;
import org.ianliu.UIFog;
import org.ianliu.UIText;
import org.ianliu.UILabel;
import org.ianliu.UIButton;
import org.ianliu.Container;

import flash.events.MouseEvent;

/**
	This class adds the keyboard numbers of the calculator
**/
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
	This class adds the operators buttons
**/
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
	This class adds the bult-in functions buttons
**/
class Funcs extends Container {
	public function new(f:MouseEvent->Void) {
		super(new Grid(4, FixedRows), true);
		var b;
		b = new UIButton("ln"  , 40, 30); b.addEventListener(MouseEvent.CLICK, f); super.add(b);
		b = new UIButton("sin" , 40, 30); b.addEventListener(MouseEvent.CLICK, f); super.add(b);
		b = new UIButton("cos" , 40, 30); b.addEventListener(MouseEvent.CLICK, f); super.add(b);
		b = new UIButton("tan" , 40, 30); b.addEventListener(MouseEvent.CLICK, f); super.add(b);
		b = new UIButton("exp" , 40, 30); b.addEventListener(MouseEvent.CLICK, f); super.add(b);
		b = new UIButton("asin", 40, 30); b.addEventListener(MouseEvent.CLICK, f); super.add(b);
		b = new UIButton("acos", 40, 30); b.addEventListener(MouseEvent.CLICK, f); super.add(b);
		b = new UIButton("atan", 40, 30); b.addEventListener(MouseEvent.CLICK, f); super.add(b);
	}
}

/**
	This class adds other buttons
**/
class Misc extends Container {
	
	public var add_function_btn:UIButton;
	
	public function new() {
		super(null, true);
		super.add(add_function_btn = new UIButton("Add function", 100, 30));
	}
}

class AddFuncPanel extends Container {
	
	public var _name   :UIText;
	public var _exp    :UIText;
	public var _ok     :UIButton;
	public var _cancel :UIButton;
	
	private var lbl_name:UILabel;
	private var lbl_exp :UILabel;
	
	public function new() {
		super(new Grid(2, FixedCols), true);
		var c1 = new Container(null, true);
		var c2 = new Container(null, true);
		var c3 = new Container(new Grid(1, FixedRows));
		_name    = new UIText();
		_exp     = new UIText();
		lbl_name = new UILabel("Name:");
		lbl_exp  = new UILabel("Exp:");
		_ok      = new UIButton("Ok");
		_cancel  = new UIButton("Cancel");
		
		c1.add(lbl_name);
		c1.add(lbl_exp);
		c2.add(_name);
		c2.add(_exp);
		c3.add(_ok);
		c3.add(_cancel);
		
		add(c1);
		add(c2);
		add(c3);
	}
}
