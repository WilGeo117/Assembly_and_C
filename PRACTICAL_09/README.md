# README #

Getting Started with NASM and i386 and x86_64 examples

### How do I get set up? ###

* Install [Visual Studio Code]("https://code.visualstudio.com/")
* Install [GNU Assembler Language Support]("https://marketplace.visualstudio.com/items?itemName=basdp.language-gas-x86")
![GNU ASM LANG](./images/GNUAssemberLanguage.png)  
* Install NASM Linux `sudo apt-get install nasm` or Windows [Version 2.15.05 Win x64](https://www.nasm.us/pub/nasm/releasebuilds/2.15.05/win64/)
* Navigate to *starterx32* folder
* On Linux compile using `nasm -f elf starterx32.asm`
* Object file starterx32.o will be created
![Compile and Execute](./images/compile_execute_starterx32.png)  
* Link the Object File using `ld -m elf_i386 -s -o StarterKitx32 starterx32.o`
* Execute program in therminal using `./StarterKitx32`
* Deployment instructions

### GDB Commands
* Run `make`<br/>
![Make](./images/make.png)<br/>
* Start GDB Debugger with `gdb ./EXECUTABLE_NAME -tui` e.g `gdb ./StarterKitx64 -tui`. Make sure to use make as it has `-g` gdb debugging turned on.<br/>
![Start GDB](./images/start_gdb.png)<br/>
* When GDB Loads you can start entering the following commands<br/>
![GDB Initial Screen](./images/1_GDB_Initial_Screen.png)<br/>
* `break _start` sets a breakpoint at _start <br/>
![GDB Load](./images/2_GDB_Load.png)<br/>
* `run` loads the machine code, stops at _start
* `info registers` show registers and their contents
* `layout asm` shows the assembly file<br/>
![GDB Run](./images/3_GDB_Run.png)<br/>
* If [TUI - Text User Interface](https://sourceware.org/gdb/onlinedocs/gdb/TUI-Commands.html#TUI-Commands) is started by makefile asm code can be displayed with `layout asm`
* Registers can be shown with `layout regs`
* `stepi` steps through the code and shows register changes / updates
* `print $rax` will print the contents of the `rax` register
* `focus cmd` switches focus to the command window to scroll through `tui` commands. See [TUI Commands](https://sourceware.org/gdb/onlinedocs/gdb/TUI-Commands.html for a full list of commands.
* `n` for next
* `c` for continue
* `si` for stepi
* Temporary breakpoints removed on reached. For example, to create a temporary breakpoint `tbreak gameloop` is removed after it is reached.
* `(gbd)show history size` shows filesize of history
* `(gbd)show history filename` shows location and file used for history
* `(gbd)set history filename ~/.gdb_history` sets history file in local directory
* `(gbd)set history save on` save history set on
* `(gbd)set history size 1000` sets history size 256 default
* `(gbd)set history expansion on` auto expansion

tbreak main
* History must be enabled in order to cycle through `gdb` commands issued to the terminal.
* To exit debugger use `CTRL+C CTRL+z`
* To try out C to ASM Integration example 
    * install 32 bit libraries using command `sudo apt-get install gcc-multilib`
    * Navigate to directory and type `make`
    ![GDB Load](./images/Integration.png)<br/>
    
## GDB Commands
| Command 	| Description 	|
|---	|---	|
| run or r 	| Executes the program from start to end. 	|
| break or b 	| Sets a breakpoint on a particular line. 	|
| disable 	| Disables a breakpoint 	|
| enable 	| Enables a disabled breakpoint. 	|
| next or n 	| Executes the next line of code without diving into functions. 	|
| step 	| Goes to the next instruction, diving into the function. 	|
| list or l 	| Displays the code. 	|
| print or p 	| Displays the value of a variable. 	|
| quit or q 	| Exits out of GDB. 	|
| clear 	| Clears all breakpoints. 	|
| continue 	| Continues normal execution 	|

### Who do I talk to? ###

* philip.bourke@itcarlow.ie

### Reading materials

* [Using 64-bit Windows Assembly Language from Microsoft Visual Studio](https://www.cs.uaf.edu/2017/fall/cs301/reference/nasm_vs/)
* [Makefile Example NASM](https://gist.github.com/hleonps/d2d1cb335ac8919991dc9a09954be7e8)
* [Running nasm and gdb](https://www.csee.umbc.edu/portal/help/nasm/nasm.shtml)
* [Assembly Programming](https://www.tutorialspoint.com/assembly_programming/)
* [Introduction to 80x80 Assembly Language and Computer Architecture](https://www.jblearning.com/catalog/productdetails/9781284036121)
* [Linux System Call Table](https://chromium.googlesource.com/chromiumos/docs/+/master/constants/syscalls.md)
* [List of System Calls](http://publicclu2.blogspot.com/2013/05/32-bit-linux-system-call-signal-errno.html)
* [Useful stackoverflow x86 Guide](https://stackoverflow.com/tags/x86/info)
* [GDB debugging with NASM](https://ncona.com/2019/12/debugging-assembly-with-gdb/)