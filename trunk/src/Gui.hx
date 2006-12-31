
/**
 * Importing UI components
 */
import org.ianliu.Grid;
import org.ianliu.Fog;
import org.ianliu.Text;
import org.ianliu.Label;
import org.ianliu.Button;
import org.ianliu.Container;

import flash.events.MouseEvent;

/**
	This class adds the keyboard numbers of the calculator
**/
class Teclado extends Container {
	public var igual:Button;
	public function new(f:MouseEvent->Void) {
		super(new Grid(3, FIXED_COL));
		var b;
		for(i in 0...9) {
			b = new Button(Std.string(i+1), 30, 30);
			b.addEventListener(MouseEvent.CLICK, f);
			super.add(b);
		}
		b = new Button(".", 30, 30); b.addEventListener(MouseEvent.CLICK, f); super.add(b);
		b = new Button("0", 30, 30); b.addEventListener(MouseEvent.CLICK, f); super.add(b);
		igual = new Button("=", 30, 30); super.add(igual);
	}
}

/**
	This class adds the operators buttons
**/
class Operadores extends Container {
	public function new(f:MouseEvent->Void) {
		super(new Grid(4, FIXED_ROW));
		var b;
		b = new Button("+", 30, 30); b.addEventListener(MouseEvent.CLICK, f); super.add(b);
		b = new Button("-", 30, 30); b.addEventListener(MouseEvent.CLICK, f); super.add(b);
		b = new Button("*", 30, 30); b.addEventListener(MouseEvent.CLICK, f); super.add(b);
		b = new Button("/", 30, 30); b.addEventListener(MouseEvent.CLICK, f); super.add(b);
		b = new Button("^", 30, 30); b.addEventListener(MouseEvent.CLICK, f); super.add(b);
		b = new Button("(", 30, 30); b.addEventListener(MouseEvent.CLICK, f); super.add(b);
		b = new Button(")", 30, 30); b.addEventListener(MouseEvent.CLICK, f); super.add(b);
	}
}

/**
	This class adds the bult-in functions buttons
**/
class Funcs extends Container {
	public function new(f:MouseEvent->Void) {
		super(new Grid(4, FIXED_ROW), true);
		var b;
		b = new Button("ln"  , 40, 30); b.addEventListener(MouseEvent.CLICK, f); super.add(b);
		b = new Button("sin" , 40, 30); b.addEventListener(MouseEvent.CLICK, f); super.add(b);
		b = new Button("cos" , 40, 30); b.addEventListener(MouseEvent.CLICK, f); super.add(b);
		b = new Button("tan" , 40, 30); b.addEventListener(MouseEvent.CLICK, f); super.add(b);
		b = new Button("exp" , 40, 30); b.addEventListener(MouseEvent.CLICK, f); super.add(b);
		b = new Button("asin", 40, 30); b.addEventListener(MouseEvent.CLICK, f); super.add(b);
		b = new Button("acos", 40, 30); b.addEventListener(MouseEvent.CLICK, f); super.add(b);
		b = new Button("atan", 40, 30); b.addEventListener(MouseEvent.CLICK, f); super.add(b);
	}
}

/**
	This class adds other buttons
**/
class Misc extends Container {
	
	public var add_function_btn:Button;
	
	public function new() {
		super(null, true);
		super.add(add_function_btn = new Button("Add function", 100, 30));
	}
}

class AddFuncPanel extends Container {
	
	public var _name   :Text;
	public var _exp    :Text;
	public var _ok     :Button;
	public var _cancel :Button;
	
	private var lbl_name:Label;
	private var lbl_exp :Label;
	
	public function new() {
		super();
		var c1 = new Container(new Grid(2, FIXED_ROW));
		var c2 = new Container(new Grid(1, FIXED_ROW), false);
		_name    = new Text();
		_exp     = new Text();
		lbl_name = new Label("Name:");
		lbl_exp  = new Label("Exp:");
		_ok      = new Button("Ok");
		_cancel  = new Button("Cancel");
		
		c1.add(lbl_name);
		c1.add(lbl_exp);
		c1.add(_name);
		c1.add(_exp);
		c2.add(_ok);
		c2.add(_cancel);
		
		add(c1);
		add(c2);
	}
}
