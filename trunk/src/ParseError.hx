
enum ErrorType {
	Syntax;
	DivByZero;
	WrongParentheses;
}

class ParseError
{
	public var message  :String;
	public var intervals:Array<Int>;
	
	public function new(errorType:ErrorType, intervals:Array<Int>) {
		this.intervals = intervals;
		message = switch( errorType ) {
			case Syntax : "Syntax error";
			case DivByZero : "Division by zero";
			case WrongParentheses : "Unmatched parentheses";
		}
	}
}
