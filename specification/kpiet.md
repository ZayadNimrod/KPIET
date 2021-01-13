Piet
====
```k
require "helpers.k"

module KPIET
    imports DOMAINS-SYNTAX
    imports DOMAINS
    
    imports HELPERS
```

Language Concepts
-----------------

### Colours


Piet uses 20 distinct colours, as shown in the table underneath. The 18
colours in the first 3 rows of the table are related cyclically in the
following two ways:

-   **Hue Cycle:** red -\> yellow -\> green -\> cyan -\> blue -\>
    magenta -\> red
-   **Lightness Cycle:** light -\> normal -\> dark -\> light

Note that \"light\" is considered to be one step \"darker\" than
\"dark\", and vice versa. White and black do not fall into either cycle.


```k
    syntax Colour ::=  "color" "(" Lightness Hue ")" | "color" "(" "black" ")" | "color" "(" "white" ")" 
    syntax Hue ::= "red" | "yellow" | "green" | "cyan" | "blue" | "magenta"
    syntax Lightness ::= "light" | "normal" | "dark" 

    //The difference between two lightnesses of the same lightness is zero
    rule [lightness-difference-base-light]:         LightnessDifference L1:Lightness   L2:Lightness   => 0  requires L1 ==Lightness L2

    //if the colours are dissimlair, darken the second lightness one step, check the difference on this new lightness, and add 1 to it
    rule [lightness-difference-inductive-light]:    LightnessDifference L:Lightness       normal  => LightnessDifference L light +Int 1 requires notBool(L ==Lightness normal)
    rule [lightness-difference-inductive-normal]:   LightnessDifference L:Lightness       dark    => LightnessDifference L normal +Int 1 requires notBool(L ==Lightness dark)
    rule [lightness-difference-inductive-dark]:     LightnessDifference L:Lightness       light   => LightnessDifference L dark +Int 1 requires notBool(L ==Lightness light)

    //The difference in hues of the same hues is zero
    rule [hue-difference-base-red]:             HueDifference       H1:Hue      H2:Hue     => 0 requires H1 ==Hue H2 
    
    //If the colours are dissimiliar, then step the second hue down, then check the hue difference between those two colours, and add 1 to it
    rule [hue-difference-inductive-yellow]:     HueDifference       H:Hue       yellow  => HueDifference H red      +Int 1 requires notBool notBool(H ==Hue red)
    rule [hue-difference-inductive-green]:      HueDifference       H:Hue       green   => HueDifference H yellow   +Int 1 requires notBool notBool(H ==Hue yellow)
    rule [hue-difference-inductive-cyan]:       HueDifference       H:Hue       cyan    => HueDifference H green    +Int 1 requires notBool notBool(H ==Hue green)
    rule [hue-difference-inductive-blue]:       HueDifference       H:Hue       blue    => HueDifference H cyan     +Int 1 requires notBool notBool(H ==Hue cyan)
    rule [hue-difference-inductive-magenta]:    HueDifference       H:Hue       magenta => HueDifference H blue     +Int 1 requires notBool notBool(H ==Hue blue)
    rule [hue-difference-inductive-red]:        HueDifference       H:Hue       red     => HueDifference H magenta  +Int 1 requires notBool notBool(H ==Hue magenta)
```


|||||||
| -----------------------| ---------------------------| -------------------------|-------------------------|-------------------------|----------------------------|
| \#FFC0C0\ light red | \#FFFFC0\  light yellow | \#C0FFC0\ light green | \#C0FFFF\ light cyan | \#C0C0FF\ light blue | \#FFC0FF\ light magenta |
| \#FF0000\ red       | \#FFFF00\ yellow        | \#00FF00\ green       | \#00FFFF\ cyan       | \#0000FF\ blue       | \#FF00FF\ magenta       |
| \#C00000\ dark red  | \#C0C000\ dark yellow   | \#00C000\ dark green  | \#00C0C0\ dark cyan  | \#0000C0\ dark blue  | \#C000C0\ dark magenta  |

\#FFFFFF white

\#000000 black

```k
syntax Hexcode ::=  "xffc0c0"   | "xff0000" | "xc00000" | 
                        "xffffc0"   | "xffff00" | "xc0c000" | 
                        "xc0ffc0"   | "x00ff00" | "x00c000" | 
                        "xc0ffff"   | "x00ffff" | "x00c0c0" |
                        "xc0c0ff"   | "x0000ff" | "x0000c0" |
                        "xffc0ff"   | "xff00ff" | "xc000c0" |
                        "x000000"   | "xffffff"  | Id

    syntax Colour ::= "TranslateHexcode" Hexcode [function]

    //we always want to convert from hex whenever we can
    rule H:Hexcode => TranslateHexcode H      [structural]
                        
    rule [translate-hexcode-encountered-hexcode-light-red]:     TranslateHexcode xffc0c0 => color ( light red )
    rule [translate-hexcode-encountered-hexcode-normal-red]:    TranslateHexcode xff0000 => color ( normal red )
    rule [translate-hexcode-encountered-hexcode-dark-red]:      TranslateHexcode xc00000 => color ( dark red )
    rule [translate-hexcode-encountered-hexcode-light-yellow]:  TranslateHexcode xffffc0 => color ( light yellow )
    rule [translate-hexcode-encountered-hexcode-normal-yellow]: TranslateHexcode xffff00 => color ( normal yellow )
    rule [translate-hexcode-encountered-hexcode-dark-yellow]:   TranslateHexcode xc0c000 => color ( dark yellow )
    rule [translate-hexcode-encountered-hexcode-light-green]:   TranslateHexcode xc0ffc0 => color ( light green )
    rule [translate-hexcode-encountered-hexcode-normal-green]:  TranslateHexcode x00ff00 => color ( normal green )
    rule [translate-hexcode-encountered-hexcode-dark-green]:    TranslateHexcode x00c000 => color ( dark green )
    rule [translate-hexcode-encountered-hexcode-light-cyan]:    TranslateHexcode xc0ffff => color ( light cyan )
    rule [translate-hexcode-encountered-hexcode-normal-cyan]:   TranslateHexcode x00ffff => color ( normal cyan )
    rule [translate-hexcode-encountered-hexcode-dark-cyan]:     TranslateHexcode x00c0c0 => color ( dark cyan )
    rule [translate-hexcode-encountered-hexcode-light-blue]:    TranslateHexcode xc0c0ff => color ( light blue )
    rule [translate-hexcode-encountered-hexcode-normal-blue]:   TranslateHexcode x0000ff => color ( normal blue )
    rule [translate-hexcode-encountered-hexcode-dark-blue]:     TranslateHexcode x0000c0 => color ( dark blue )
    rule [translate-hexcode-encountered-hexcode-light-magenta]: TranslateHexcode xffc0ff => color ( light magenta )
    rule [translate-hexcode-encountered-hexcode-normal-magenta]:TranslateHexcode xff00ff => color ( normal magenta )
    rule [translate-hexcode-encountered-hexcode-dark-magenta]:  TranslateHexcode xc000c0 => color ( dark magenta )
    
    rule [translate-hexcode-encountered-hexcode-black]:         TranslateHexcode x000000 => color ( black )
    rule [translate-hexcode-encountered-hexcode-white]:         TranslateHexcode xffffff => color ( white )    
    
```



Additional colours (such as orange, brown) may be used, though their
effect is implementation-dependent. In the simplest case, non-standard
colours are treated by the language interpreter as the same as white, so
may be used freely wherever white is used. (Another possibility is that
they are treated the same as black.)

```k
    rule [translate-hexcode-encountered-illegal]:               TranslateHexcode _:Id => color ( white )  
    //TODO: need some test on this, i.e program w/non-spec pixel becomes white
```

### Codels

Piet code takes the form of graphics made up of the recognised colours.
Individual pixels of colour are significant in the language, so it is
common for programs to be enlarged for viewing so that the details are
easily visible. In such enlarged programs, the term \"codel\" is used to
mean a block of colour equivalent to a single pixel of code, to avoid
confusion with the actual pixels of the enlarged graphic, of which many
may make up one codel.

### Colour Blocks

The basic unit of Piet code is the colour block. A colour block is a
contiguous block of any number of codels of one colour, bounded by
blocks of other colours or by the edge of the program graphic. Blocks of
colour adjacent only diagonally are not considered contiguous. A colour
block may be any shape and may have \"holes\" of other colours inside
it, which are not considered part of the block.

### Stack

Piet uses a
*[stack](https://en.wikipedia.org/wiki/Stack_(abstract_data_type))* for
storage of all data values. Data values exist only as integers, though
they may be read in or printed as
[Unicode](https://en.wikipedia.org/wiki/Unicode) character values with
appropriate commands.

The stack is notionally infinitely deep, but implementations may elect
to provide a finite maximum stack size. If a finite stack overflows, it
should be treated as a runtime error, and handling this will be
implementation dependent.

### Program Execution

| **DP**    | **CC**    | **Codel chosen** |
|-------|-------|--------------|
| right | left  | uppermost    |
|       | right | lowermost    |
| down  | left  | rightmost    |
|       | right | leftmost     |
| left  | left  | lowermost    |
|       | right | uppermost    |
| up    | left  | leftmost     |
|       | right | rightmost    |

The Piet language interpreter begins executing a program in the colour
block which includes the upper left codel of the program. The
interpreter maintains a *Direction Pointer* (DP), initially pointing to
the right. The DP may point either right, left, down or up. The
interpreter also maintains a *Codel Chooser* (CC), initially pointing
left. The CC may point either left or right. The directions of the DP
and CC will often change during program execution.

As it executes the program, the interpreter traverses the colour blocks
of the program under the following rules:

1.  The interpreter finds the edge of the current colour block which is
    furthest in the direction of the DP. (This edge may be disjoint if
    the block is of a complex shape.)
2.  The interpreter finds the codel of the current colour block on that
    edge which is furthest to the CC\'s direction of the DP\'s direction
    of travel. (Visualise this as standing on the program and walking in
    the direction of the DP; see table at right.)
3.  The interpreter travels from that codel into the colour block
    containing the codel immediately in the direction of the DP.

The interpreter continues doing this until the program terminates.

Syntax Elements
---------------

### Numbers

Each non-black, non-white colour block in a Piet program represents an
integer equal to the number of codels in that block. Note that
non-positive integers cannot be represented, although they can be
constructed with operators. When the interpreter encounters a number, it
does not necessarily do anything with it. In particular, it is not
automatically pushed on to the stack - there is an explicit command for
that (see below).

The maximum size of integers is notionally infinite, though
implementations may implement a finite maximum integer size. An integer
overflow is a runtime error, and handling this will be implementation
dependent.

### Black Blocks and Edges

Black colour blocks and the edges of the program restrict program flow.
If the Piet interpreter attempts to move into a black block or off an
edge, it is stopped and the CC is toggled. The interpreter then attempts
to move from its current block again. If it fails a second time, the DP
is moved clockwise one step. These attempts are repeated, with the CC
and DP being changed between alternate attempts. If after eight attempts
the interpreter cannot leave its current colour block, there is no way
out and the program terminates.

### White Blocks

White colour blocks are \"free\" zones through which the interpreter
passes unhindered. If it moves from a colour block into a white area,
the interpreter \"slides\" through the white codels in the direction of
the DP until it reaches a non-white colour block. If the interpreter
slides into a black block or an edge, it is considered restricted (see
above), otherwise it moves into the colour block so encountered. Sliding
across white blocks into a new colour does not cause a command to be
executed (see below). In this way, white blocks can be used to change
the current colour without executing a command, which is very useful for
coding loops.

Sliding across white blocks takes the interpreter in a *straight line*
until it hits a coloured pixel or edge. It does not use the procedure
described above for determining where the interpreter emerges from
non-white coloured blocks.

*Precisely what happens when the interpeter slides across a white block
and hits a black block or an edge was not clear in the original
specification. My interpretation follows from a literal reading of the
above text:*

-   The interpreter \"slides\" across the white block in a straight
    line.
-   If it hits a restriction, the CC is toggled. Since this results in
    no difference in where the interpreter is trying to go, the DP is
    immediately stepped clockwise.
-   The interpreter now begins sliding from its current white codel, in
    the new direction of the DP, until it either enters a coloured block
    or encounters another restriction.
-   Each time the interpreter hits a restriction while within the white
    block, it toggles the CC and steps the DP clockwise, then tries to
    slide again. This process repeats until the interpreter either
    enters a coloured block (where execution then continues); or until
    the interpreter begins retracing its route. If it retraces its route
    entirely within a white block, there is no way out of the white
    block and execution should terminate.

### Commands

 

|                |           | **Lightness Change** |              |
|----------------|-----------|:--------------------:|--------------|
| **Hue change** | **None**  | **1 Darker**         | **2 Darker** |
| **None**       |           | push                 | pop          |
| **1 Step**     | add       | subtract             | multiply     |
| **2 Step**     | divide    | mod                  | not          |
| **3 Step**     | greater   | pointer              | switch       |
| **4 Step**     | duplicate | roll                 | in (number)  |
| **5 Step**     | in (char) | out (number)         | out (char)   |

Commands are defined by the transition of colour from one colour block
to the next as the interpreter travels through the program. The number
of steps along the Hue Cycle and Lightness Cycle in each transition
determine the command executed, as shown in the table at right. If the
transition between colour blocks occurs via a slide across a white
block, no command is executed. The individual commands are explained
below.

-   **push:** Pushes the value of the colour block just exited on to the
    stack. Note that values of colour blocks are not automatically
    pushed on to the stack - this push operation must be explicitly
    carried out.
-   **pop:** Pops the top value off the stack and discards it.
-   **add:** Pops the top two values off the stack, adds them, and
    pushes the result back on the stack.
-   **subtract:** Pops the top two values off the stack, calculates the
    second top value minus the top value, and pushes the result back on
    the stack.
-   **multiply:** Pops the top two values off the stack, multiplies
    them, and pushes the result back on the stack.
-   **divide:** Pops the top two values off the stack, calculates the
    integer division of the second top value by the top value, and
    pushes the result back on the stack. If a divide by zero occurs, it
    is handled as an implementation-dependent error, though simply
    ignoring the command is recommended.
-   **mod:** Pops the top two values off the stack, calculates the
    second top value
    [modulo](https://en.wikipedia.org/wiki/Modulo_operation) the top
    value, and pushes the result back on the stack. The result has the
    same sign as the divisor (the top value). If the top value is zero,
    this is a divide by zero error, which is handled as an
    implementation-dependent error, though simply ignoring the command
    is recommended. (*See note below.*)
-   **not:** Replaces the top value of the stack with 0 if it is
    non-zero, and 1 if it is zero.
-   **greater:** Pops the top two values off the stack, and pushes 1 on
    to the stack if the second top value is greater than the top value,
    and pushes 0 if it is not greater.
-   **pointer:** Pops the top value off the stack and rotates the DP
    clockwise that many steps (anticlockwise if negative).
-   **switch:** Pops the top value off the stack and toggles the CC that
    many times (the absolute value of that many times if negative).
-   **duplicate:** Pushes a copy of the top value on the stack on to the
    stack.
-   **roll:** Pops the top two values off the stack and \"rolls\" the
    remaining stack entries to a depth equal to the second value popped,
    by a number of rolls equal to the first value popped. A single roll
    to depth *n* is defined as burying the top value on the stack *n*
    deep and bringing all values above it up by 1 place. A negative
    number of rolls rolls in the opposite direction. A negative depth is
    an error and the command is ignored. If a roll is greater than an
    implementation-dependent maximum stack depth, it is handled as an
    implementation-dependent error, though simply ignoring the command
    is recommended.
-   **in:** Reads a value from STDIN as either a number or character,
    depending on the particular incarnation of this command and pushes
    it on to the stack. If no input is waiting on STDIN, this is an
    error and the command is ignored. If an integer read does not
    receive an integer value, this is an error and the command is
    ignored.
-   **out:** Pops the top value off the stack and prints it to STDOUT as
    either a number or character, depending on the particular
    incarnation of this command.

Any operations which cannot be performed (such as popping values when
not enough are on the stack) are simply ignored, and processing
continues with the next command.

```k
endmodule
```

```k
module KPIET-SYNTAX
    imports DOMAINS

    syntax KResult ::= Int | Colour | Coord | Instruction | Bool

    syntax Coord ::= "point" "(" Int "," Int ")"

    syntax Program ::= Lines

    syntax Lines ::= List{Line, ";"}
    syntax Line ::= List{Pixel, ""} 

    syntax Pixel ::= Colour | Hexcode


    syntax DirectionPointer ::= "DP" "(" "^" ")" |"DP" "(" "v" ")" |"DP" "(" "<" ")"|"DP" "(" ">" ")"
    syntax CodelChooser ::= "CC" "(" "<"  ")"|"CC" "(" ">" ")"


    syntax Instruction ::=  VMInstruction
                        | "TranslateInstruction" Colour Colour [strict]
                        | "LookupInstruction" Int Int [strict, function]
                        | "nop"
                        | "stop"
                        | "blk" "(" Int ")"


    syntax VMInstruction ::=  Instruction1Arg | Instruction2Arg  | "push" | "innum" | "inchar"
    
    syntax Instruction1Arg ::=   "pop"   | 
                                 "not"   |   
                                 "ptr"   |   
                                 "switch"|
                                 "dup"   |  
                                 "outnum"|   
                                 "outchar"


    syntax Instruction2Arg ::= "add"   |   "sub"   |   "mult"  |
                    "div"   |   "mod"   |  "great" | "roll"  


    syntax Int ::=      "LightnessDifference" Lightness Lightness [function, functional] 
                    |   "HueDifference" Hue Hue [function, functional]


endmodule
```




*Note on the mod command:* In the original specification of Piet the
result of a modulo operation with a negative dividend (the second top
value popped off the stack) was not explicitly defined. I assumed that
everyone would assume that the result of (*p* mod *q*) would always be
equal to ((*p* + *Nq*) mod *q*) for any integer *N*. So:

-   5 mod 3 = 2
-   2 mod 3 = 2
-   -1 mod 3 = 2
-   -4 mod 3 = 2

The mod command is thus identical to *floored division* in Wikipedia\'s
page on the [modulus
operation](https://en.wikipedia.org/wiki/Modulo_operation).

Sample Programs and Resources
-----------------------------

-   [Sample
    programs](https://www.dangermouse.net/esoteric/piet/samples.html)
-   [Third-party Piet interpreters and development
    tools](https://www.dangermouse.net/esoteric/piet/tools.html)

------------------------------------------------------------------------

[Home](https://www.dangermouse.net/) \| [Esoteric Programming
Languages](https://www.dangermouse.net/esoteric/)\
*Last updated: Thursday, 27 September, 2018; 04:00:52 PDT.*\
Copyright © 1990-2020, David Morgan-Mar. *dmm\@dangermouse.net*\
*Hosted by: [DreamHost](http://www.dreamhost.com/rewards.cgi?dmmaus)*


Adapted from [David Morgan-Mar's original specification](https://www.dangermouse.net/esoteric/piet.html)