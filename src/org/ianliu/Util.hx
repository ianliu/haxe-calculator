

package org.ianliu;

class Util {
	public static function trimAll(s:String):String {
		var r = "";
		for(i in 0...s.length)
			if(!StringTools.isSpace(s, i))
				r += s.charAt(i);
		return r;
	}
}