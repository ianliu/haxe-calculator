

package org.ianliu;

typedef Matrix<F> = Array<Array<F>>

class MathTools
{
	public static function transpose(a:Matrix<Dynamic>):Matrix<F> {
		var tmp:Matrix<F> = new Array();
		for(i in 0...a[0].length) {
			tmp[i] = new Array();
			for(j in 0...a.length) {
				tmp[i][j] = a[j][i];
			}
		}
		return tmp;
	}
	
	public static function equal(A : Matrix<Dynamic>, B : Matrix<Dynamic>):Bool {
		for(i in 0...A.length)
			for(j in 0...A[0].length)
				if(A[i][j] != B[i][j])
					return false;
		return true;
	}
}
