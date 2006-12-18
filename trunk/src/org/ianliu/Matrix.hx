

package org.ianliu;

class Matrix<F> {
	public var m:Array<Array<F>>;
	public function new(A : Array<Array<F>>) {
		m = A;
	}
	public function transpose():Matrix<F> {
		var tmp:Matrix<F> = new Matrix();
		for(i in 0...a[0].length) {
			tmp[i] = new Array();
			for(j in 0...a.length) {
				tmp[i][j] = a[j][i];
			}
		}
		return tmp;
	}
}
