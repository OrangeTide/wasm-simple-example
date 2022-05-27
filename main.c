extern void print_int(int n);
extern void puts(const char *s, int len);

int start_app(int state)
{
	puts("Hello from WASM.", 16);
	print_int(5 * 2469);
	puts("Done!", 5);
	return 0;
}
