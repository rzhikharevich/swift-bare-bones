public func kmain() {
	let vram = UnsafeMutablePointer<UInt16>(bitPattern: 0xB8000)
	let vramSize = 80 * 25

	var i = 0
	repeat {
		vram[i] = 0xA00
		i += 1
	} while i < vramSize

	vram[0] = 0xA48
	vram[1] = 0xA65
	vram[2] = 0xA6C
	vram[3] = 0xA6C
	vram[4] = 0xA6F
	vram[5] = 0xA21
}
