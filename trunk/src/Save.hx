


class Save {
	public function new(name:String, exp:String) {
		//var f = neko.io.File.write("C:\\arq\\Ian\\foo.txt", false);
		//f.append("haha " + name + " " + exp);
		//f.close();
		var s = neko.io.File.getContent("C:\\arq\\Ian\\foo.txt");
		trace(neko.io.File);
		trace(s);
	}
	public static function main() {
		new Save("1", "looooop!");
	}
}