

package org.ianliu;

enum GRID_TYPE {
	FixedRows;
	FixedCols;
}

class Grid
{
	public var value :Int;
	public var fixed (default,null):GRID_TYPE;
	public var hgap  (default,null):Int;
	public var vgap  (default,null):Int;
	public var margin(default,null):Int;
	public var count (default,null):Int;
	public var entry (default,null):Array<Array<UIComponent>>;
	
	public function new(value:Int, fixed:GRID_TYPE, ?hGap:Int, ?vGap:Int, ?margin:Int) {
		this.value = value;
		this.fixed = fixed;
		this.margin = if(margin == null) 0 else margin;
		hgap = if(hGap == null) 3 else hGap;
		vgap = if(vGap == null) 3 else vGap;
		entry = new Array();
		count = 0;
	}
	
	public function draw():Void {
		var k:Int = 0;
		var offx:Float;
		var offy:Float = margin;
		var aux :Float = 0;
		for(i in 0...entry.length) {
			offx = margin;
			aux = 0;
			for(j in 0...entry[i].length) {
				entry[i][j].x = offx;
				entry[i][j].y = offy;
				if(entry[i][j].height > aux) aux = entry[i][j].height;
				offx += entry[i][j].width + vgap;
				k ++;
				if(k == count) return;
			}
			offy += aux + hgap;
		}
	}
	
	public function add(element:UIComponent):Void {
		var i = Std.int(count/value);
		var j = count % value;
		switch( fixed ) {
			case FixedRows :
				if(entry[j] == null) {
					entry[j] = new Array();
				}
				entry[j][i] = element;
			case FixedCols :
				if(j == 0) entry[i] = new Array();
				entry[i][j] = element;
		}
		count ++;
		//trace(entry);
	}
	
	public function remove(element:UIComponent):Void {
		for(i in entry) {
			if(i.remove(element) == true) break;
		}
		draw();
	}
	public function removeAt(i:Int, j:Int):Void {
		//entry[i].splice(pos, 1);
		draw();
	}
	
	public function setValue   (value:Int      ) :Void { this.value  = value; draw(); }
	public function setHgap    (value:Int      ) :Void { this.hgap   = value; draw(); }
	public function setVgap    (value:Int      ) :Void { this.vgap   = value; draw(); }
	public function setMargin  (value:Int      ) :Void { this.margin = value; draw(); }
	public function toggleFixed(               ) :Void { ArrayTools.transpose(entry); draw();   }
	public function setFixed   (fixed:GRID_TYPE) :Void { if(this.fixed != fixed) toggleFixed(); }
}

