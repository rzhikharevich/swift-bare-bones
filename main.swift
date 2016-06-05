public func kmain() {
	let vram = UnsafeMutablePointer<UInt16>(bitPattern: 0xB8000)
	let vramSize = 80 * 25

	var i = 0
	repeat {
		vram[i] = 0xA00
		i += 1
	} while i < vramSize

	let s: StaticString = "Hello, World!"

	i = 0
	while i < s.byteSize {
		vram[i] = UInt16(s.utf8Start[i]) | 0xA00
		i += 1
	}
}
