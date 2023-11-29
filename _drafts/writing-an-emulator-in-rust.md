I've always been fascinated by emulators of old computers. The idea of reviving childhood memories
on a modern computer is one aspect of it. Diving deep into how the hardware works,
for a system that was still simple enough for a single person to fit into their head is
another.

When I grew up, many of my friends had PCs (386s and 486s) while I had no computer
at all, until my mom's cousin gave my his old Amstrad CPC 464. This system had 64k of
RAM, a color monitor, an built-in tape recorder (yes, in the 80's games usually came
on casette tapes that contained data) and an optional floppy drive.
This computer was how I got my start in programming. Because not only was its command
shell a BASIC interpreter, I also got tons of old magazines containing listings of
games and and other programs you could type in and run.

So naturally, when I was looking to start a new Rust project and decided on writing and
emulator, the Amstrad CPC 464 was the system I chose to implement. It is reasonably well
documented and most of its components were well known off the shelf chips. Figure 1 below
shows the chips the CPC consists of and among these only the Gate Array is a custom chip that
was designed specifically for the CPC.

Figure 1 -  simplified schematics

Road To The First Prompt
------------------------

The first component I implemented was the heart of the system - the Zilog Z80 8-bit microprocessor.
My implementation design for this CPU has two parts: An instruction decoder that parses machine
code into Rust representations of each supported instruction and the CPU itself which executes
the decoded instructions and keeps track of registers, interrupt requests, etc. This separation
allowed me to develop a simple disassembler first, feed it the system ROMs and compare its
output to some known good disassemblers. The disassembler would also be reused later to implement
a simple debugger.


