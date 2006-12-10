

package org.ianliu;

class ArrayTools {
	public static function transpose(a:Array<Array<Dynamic>>):Array<Array<Dynamic>> {
		var tmp:Array<Array<Dynamic>> = new Array();
		for(i in 0...a[0].length) {
			tmp[i] = new Array();
			for(j in 0...a.length) {
				tmp[i][j] = a[j][i];
			}
		}
		return tmp;
	}
}
