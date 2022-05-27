CC = clang --target=wasm32
LD = wasm-ld --no-entry --export-all
compile.c = $(CC) -c -o $@ $(CFLAGS) $(CPPFLAGS) $<
compile.c += -O3 -flto
link.o = $(CC) -o $@ -nostdlib -Wl,--no-entry -Wl,--export-all -Wl,--allow-undefined $(LDFLAGS) $^ $(LDLIBS)
link.o += -Wl,--lto-O3
link.c = $(CC) -o $@ -nostdlib -Wl,--no-entry -Wl,--export-all -Wl,--allow-undefined $(CFLAGS) $(CPPFLAGS) $(LDFLAGS) $^ $(LDLIBS)
link.c += -Wl,--lto-O3
EXT = .wasm
EXT2 = .html
%.html: %.wasm
	@echo "Creating $@ to wrap $< ..."
	@echo "<!DOCTYPE html>" > $@
	@echo "<body onload=\"start_app(document.getElementById('container'))\">" >> $@
	@echo " <div id='container'></div>" >> $@
	@echo "</body>" >> $@
	@echo "<script>" >> $@
	@echo " function start_app(ele) {" >> $@
	@echo "  function ele_puts(arg) {" >> $@
	@echo "   ele.innerHTML += arg + \"\n<br>\";" >> $@
	@echo "  }" >> $@
	@echo "  let importObject = { " >> $@
	@echo "   env: { " >> $@
	@echo "    print_int: function(arg) { ele_puts(arg); }," >> $@
	@echo "    puts: function(arg, len) { " >> $@
	@echo "     var m = new Uint8Array(instance.exports.memory.buffer, arg, len);" >> $@
	@echo "     var s = new TextDecoder(\"utf-8\").decode(m);" >> $@
	@echo "     ele_puts(s);" >> $@
	@echo "    }" >> $@
	@echo "   }" >> $@
	@echo "  };" >> $@
	@echo "  WebAssembly.instantiateStreaming(fetch(\"./$<\"), importObject)" >> $@
	@echo "   .then( wasm => {" >> $@
	@echo "    window.instance = wasm.instance;" >> $@
	@echo "    console.log(\"result is \" + wasm.instance.exports.start_app(1));" >> $@
	@echo "   });" >> $@
	@echo " }" >> $@
	@echo "</script>" >> $@
