## VGA controller in VHDL

- `sync.vhd` generates the `hsync` and `vsync` signals
- `shader.vhd` colors the pixels
- `text_tb.vhd` logs VGA signals to a `vga.txt` file that can be viewed by following javascript: http://ericeastwood.com/lab/vga-simulator/
- `bitmap_tb.vhd` outputs a PPM bitmap (`vga.ppm`) for the first VGA frame with a few caveats:
    - Ridiculously ineffecient format (a nibble in every byte is a 0x0, because we can't pack) and of course no compression either
    - PPM uses a non-linear color space, so the colors aren't  what you'd see on a RGB VGA screen
    -  Support for multiple VGA frames yet to follow
