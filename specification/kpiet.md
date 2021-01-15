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



```k
configuration <T>    

    <input color="magenta" stream = "stdin"> .List </input>
    <output color="Orchid" stream = "stdout"> .List </output>
    <buf> .List </buf> //this exists to support stdin becuase we cant mutate stdin cells other than consuming the whole string

    <log> .List </log>

    //used when building up <program>
    <buildingx>-1</buildingx>
    <buildingy>-1</buildingy>
    <nextLines> . </nextLines>


    //used when building items in <block>
    <blockworkspace> .List </blockworkspace>
    <nextBlockID> 0 </nextBlockID>
```

### Codels

Piet code takes the form of graphics made up of the recognised colours.
Individual pixels of colour are significant in the language, so it is
common for programs to be enlarged for viewing so that the details are
easily visible. In such enlarged programs, the term \"codel\" is used to
mean a block of colour equivalent to a single pixel of code, to avoid
confusion with the actual pixels of the enlarged graphic, of which many
may make up one codel.

```k 
    <program> .Map </program> //maps position to colour of the pixel there        
    <k> $PGM:Program </k>
```

### Colour Blocks

The basic unit of Piet code is the colour block. A colour block is a
contiguous block of any number of codels of one colour, bounded by
blocks of other colours or by the edge of the program graphic. Blocks of
colour adjacent only diagonally are not considered contiguous. A colour
block may be any shape and may have \"holes\" of other colours inside
it, which are not considered part of the block.

```k
    <owner> .Map </owner> //maps position to the block that codel is in

        //stores all the blocks that have been constructed so far. 
    <blocks> 
        <block multiplicity = "*" type="Map">
            <id> -1 </id>
            <colour> color(black) </colour>
            <size> -1 </size>
            <transitions> .Map </transitions>
        </block>    
    </blocks> 
```


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

```k
    <stack> .List </stack> 
```


### Program Execution


The Piet language interpreter begins executing a program in the colour
block which includes the upper left codel of the program. The
interpreter maintains a *Direction Pointer* (DP), initially pointing to
the right. The DP may point either right, left, down or up. The
interpreter also maintains a *Codel Chooser* (CC), initially pointing
left. The CC may point either left or right. The directions of the DP
and CC will often change during program execution.

```k
    <DP>DP (>)</DP> 
    <CC>CC (<)</CC> 
    <PP> point(0,0) </PP> //program pointer, points to current pixel
    <exitedPP> point(0,0)</exitedPP>
    <timesToggled> 0 </timesToggled>
```

```k
</T>
```

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




```k
syntax Direction ::= "direction" "(" DirectionPointer "," CodelChooser ")"
syntax State ::= "step" | "build" "(" Int ")" | "makeBlock" "(" Coord "," Int ")"

// Summary of a step
// We begin: PP at location, <currentColour> holds colour of the current block, DP/CC in some configuration
// Find item in <block> mapped to <PP>. Look up with DP/CC where the PP is next. Update <PP> to this position., and <exitedPP> to the old <PP>
//      If this mapping does not exist in <block>, create the block!
// Take the colour at the new <PP>, run TranslateInstruction on it and <currentColour>, 
// if <k> is step, do again

rule [next-step-mapping-exists]:
    <k> step => TranslateInstruction OldColour NewColour ... </k>
    <PP> OldPP:Coord => NewPP +Coord DPToOffset(D) </PP> 
    <exitedPP> _ => OldPP </exitedPP>
    <program> ... (NewPP +Coord DPToOffset(D)) |-> NewColour:Colour ...</program>       
    <owner> ... OldPP |-> OldBlockID:Int ... </owner>
    <blocks> ... <block> <id>OldBlockID</id> <colour>OldColour:Colour</colour> <size>_Size:Int </size> <transitions> ... direction(D,C)|-> NewPP:Coord ... </transitions> </block>...</blocks>
    <DP>D:DirectionPointer</DP>
    <CC>C:CodelChooser</CC>
    <blockworkspace> .List </blockworkspace>

    rule [next-step-out-of-bounds]:
    <k> step => TranslateInstruction OldColour color(black) ... </k> //going out of bounds is treated like walking into a black pixel
    <PP> OldPP:Coord => NewPP +Coord DPToOffset(D) </PP> 
    <exitedPP> _ => OldPP </exitedPP>
    <program> Program:Map </program>  //out of bounds, so it is unmapped  
    <owner> ... OldPP |-> OldBlockID:Int ... </owner>
    <blocks> ... <block> <id>OldBlockID</id> <colour>OldColour:Colour</colour> <size>_Size:Int </size> <transitions> ... direction(D,C)|-> NewPP:Coord ... </transitions> </block>...</blocks>
    <DP>D:DirectionPointer</DP>
    <CC>C:CodelChooser</CC>
    <blockworkspace> .List </blockworkspace>
        requires notBool ((NewPP +Coord DPToOffset(D)) in_keys (Program))

rule [next-step-no-mapping]:
    <k> step => makeBlock(OldPP , BlockID) ~> build(BlockID)  ~> step... </k>
    <PP> OldPP:Coord </PP>
    <program> ... OldPP |-> OldColour:Colour ...</program>  //this pixel is in bounds
    <owner> M:Map </owner>
    //create a new block
    <blocks> ... (.Bag => <block> 
    //<blocks> .Set => <block>
            <id>BlockID</id>
            <colour>OldColour</colour> 
            <size>0</size>
            <transitions> 
                direction(DP(>), CC(>)) |-> OldPP 
                direction(DP(>), CC(<)) |-> OldPP 
                direction(DP(v), CC(>)) |-> OldPP 
                direction(DP(v), CC(<)) |-> OldPP
                direction(DP(<), CC(>)) |-> OldPP 
                direction(DP(<), CC(<)) |-> OldPP
                direction(DP(^), CC(>)) |-> OldPP 
                direction(DP(^), CC(<)) |-> OldPP
            </transitions>  
        </block>) ...
    </blocks> 
    <nextBlockID> BlockID:Int => BlockID +Int 1 </nextBlockID>
    //<blockworkspace> .List -> ListItem(oldPP) ...</blockworkspace>
    requires notBool(OldPP in_keys (M))

rule [build-block]:
    <k> makeBlock (point(X:Int, Y:Int ), BlockID :Int) =>
            makeBlock (point(X +Int 1, Y),BlockID) ~>
            makeBlock (point(X, Y +Int 1),BlockID) ~>             
            makeBlock (point(X, Y -Int 1),BlockID) ~>
            makeBlock (point(X -Int 1, Y),BlockID)    
        ...</k>
    <program> ... point(X,Y) |-> OtherColour:Colour ... </program>// The current position is in bounds
    <owner> Owner:Map </owner>
    <blocks> 
        ... 
        <block> <id>BlockID</id> <colour>MainColour:Colour</colour>...</block>
        ...
    </blocks>
    <blockworkspace> ... .List => ListItem(point(X,Y)) </blockworkspace>
    requires (MainColour ==Colour OtherColour) //This is part of the same block that we started from
        andBool notBool (point(X,Y) in_keys(Owner)) // the current position is not already mapped
        andBool notBool(MainColour ==Colour color(white)) //white blocks follow different rules



rule [build-block-white]:
    <k> makeBlock (point(X:Int, Y:Int ), BlockID :Int) => . ...</k>
    <program> ... point(X,Y) |-> OtherColour:Colour ... </program>// The current position is in bounds
    <owner> Owner:Map </owner>
    <blocks> 
        ... 
        <block> <id>BlockID</id> <colour>MainColour:Colour</colour>...</block>
        ...
    </blocks>
    <blockworkspace> ... .List => ListItem(point(X,Y)) </blockworkspace>
    requires (MainColour ==Colour color(white) ) //white pixels make single-pixel blocks
        andBool notBool (point(X,Y) in_keys(Owner)) // the current position is not already mapped


//do not add the pixel into the current block, for some reason; i.e out of bounds, wrong colour, already in block
rule [build-block-wrong-pixel-wrong-colour]: 
    <k> makeBlock (Position:Coord, BlockID:Int) => . ...</k>
    <program> ... Position |-> OtherColour:Colour ... </program>
    <blocks> 
        ... 
        <block> <id>BlockID</id> <colour>MainColour:Colour</colour>...</block>
        ...
    </blocks>
    requires notBool (MainColour ==Colour OtherColour) //This is not part of the block that we started from
        


rule [build-block-wrong-pixel-out-bounds]:
    <k> makeBlock (Position:Coord, _BlockID:Int) => . ...</k>
    <program> Program:Map </program>
    <owner> Owner:Map </owner>
    //<PP> CenterPosition:Coord </PP>
    <blockworkspace> B:List</blockworkspace>
    requires Position in_keys(Owner) // the current position is already mapped
        orBool notBool (Position in_keys(Program))// The current position is out of bounds
        orBool Position in(B) // the current position is already mapped



//TODO:the following rules are all very similair, can we fold them together somehow?
//<blockworkspace> contains all the pixels in the current block we are building. 
//So we should deplete thet cell until it is empty, to create the block
rule [build-block-rightright]: 
    <k> build (BlockID:Int)  ...</k>
    <blocks> 
        ... 
        <block> 
            <id>BlockID</id> 
            <colour>_ </colour>
            <size> _ </size>
            <transitions> ... direction(DP(>), CC(>)) |-> (point(X2:Int,Y2:Int) => point(X1,Y1))  ... </transitions>
        </block>
        ...
    </blocks>
    <blockworkspace>ListItem(point(X1:Int,Y1:Int)) ... </blockworkspace>
    requires (X1 >Int X2) 
        orBool (X1 ==Int X2 andBool Y1 >Int Y2)  //The new point is the new right-bottom pixel in the block

rule [build-block-rightleft]: 
    <k> build (BlockID:Int)  ...</k>
    <blocks> 
        ...
        <block> 
            <id>BlockID</id> 
            <colour> _ </colour>
            <size> _ </size>
            <transitions> ... direction(DP(>), CC(<)) |-> (point(X2:Int,Y2:Int) =>  point(X1,Y1) ) ... </transitions>
        </block>
        ...
    </blocks>
    <blockworkspace>ListItem(point(X1:Int,Y1:Int)) ... </blockworkspace>
    requires (X1 >Int X2) 
        orBool (X1 ==Int X2 andBool  Y2 >Int Y1 )  //The new point is the new right-top pixel in the block

rule [build-block-downright]: 
    <k> build (BlockID:Int)  ...</k>
    <blocks> 
        ... 
        <block>
            <id>BlockID</id>
            <colour> _ </colour>
            <size> _ </size>
            <transitions> ... direction(DP(v), CC(>)) |-> (point(X2:Int,Y2:Int) => point(X1,Y1) ) ... </transitions>
        </block>
        ...
    </blocks>
    <blockworkspace>ListItem(point(X1:Int,Y1:Int)) ... </blockworkspace>
    requires (Y1 >Int Y2) 
        orBool (Y1 ==Int Y2 andBool X2 >Int X1 )  //The new point is the new bottom-left pixel in the block

rule [build-block-downleft]: 
    <k> build (BlockID:Int)  ...</k>
    <blocks> 
        ... 
        <block> 
            <id>BlockID</id>
            <colour> _ </colour>
            <size> _ </size>
            <transitions> ... direction(DP(v), CC(<)) |-> (point(X2:Int,Y2:Int)  => point(X1,Y1) ) ... </transitions>
        </block>
        ...
    </blocks>
    <blockworkspace>ListItem(point(X1:Int,Y1:Int)) ... </blockworkspace>
    requires (Y1 >Int Y2) 
        orBool (Y1 ==Int Y2 andBool X1 >Int X2 )  //The new point is the new bottom-right pixel in the block

rule [build-block-leftleft]: 
    <k> build (BlockID:Int)  ...</k>
    <blocks> 
        ... 
        <block>
            <id>BlockID</id>
            <colour> _ </colour>
            <size> _ </size>
            <transitions> ... direction(DP(<), CC(<)) |-> (point(X2:Int,Y2:Int) => point(X1,Y1) ) ... </transitions>
        </block>
        ...
    </blocks>
    <blockworkspace>ListItem(point(X1:Int,Y1:Int)) ... </blockworkspace>
    requires (X2 >Int X1) 
        orBool (X1 ==Int X2 andBool Y1 >Int Y2 )  //The new point is the new left-bottom pixel in the block

rule [build-block-leftright]: 
    <k> build (BlockID:Int)  ...</k>
    <blocks> 
        ... 
        <block> 
            <id>BlockID</id>
            <colour> _ </colour>
            <size> _ </size>
            <transitions> ... direction(DP(<), CC(>)) |-> (point(X2:Int,Y2:Int) => point(X1,Y1) ) ... </transitions>
        </block>
        ...
    </blocks>
    <blockworkspace>ListItem(point(X1:Int,Y1:Int)) ... </blockworkspace>
    requires (X2 >Int X1) 
        orBool (X1 ==Int X2 andBool Y2 >Int Y1 )  //The new point is the new left-top pixel in the block

rule [build-block-upleft]: 
    <k> build (BlockID:Int)  ...</k>
    <blocks> 
        ... 
        <block>
            <id>BlockID</id>
            <colour> _ </colour>
            <size> _ </size>
            <transitions> ... direction(DP(^), CC(<)) |-> (point(X2:Int,Y2:Int) =>  point(X1,Y1) ) ... </transitions>
        </block>
    </blocks>
    <blockworkspace>ListItem(point(X1:Int,Y1:Int)) ... </blockworkspace>
    requires (Y2 >Int Y1) 
        orBool (Y1 ==Int Y2 andBool X2 >Int X1 )  //The new point is the new top-left pixel in the block

rule [build-block-upright]: 
    <k> build (BlockID:Int)  ...</k>
    <blocks> 
        ... 
        <block>
            <id>BlockID</id>
            <colour> _ </colour>
            <size> _ </size>
            <transitions> ... direction(DP(^), CC(>)) |-> (point(X2:Int,Y2:Int)  =>  point(X1,Y1) ) ...</transitions>
        </block>
        ...
    </blocks>
    <blockworkspace>ListItem(point(X1:Int,Y1:Int)) ... </blockworkspace>
    requires (Y2 >Int Y1) 
        orBool (Y1 ==Int Y2 andBool X1 >Int X2 )  //The new point is the new top-right pixel in the block


//this pixel does not /no longer updates the block edges, so just add it to the block mapping,and increment block size
rule [build-block-finish-up]: 
    <k> build (BlockID:Int) ...</k>
    <owner> ... .Map => point(X,Y) |-> BlockID</owner>
    <blocks> 
        ... 
        <block>
            <id>BlockID</id>
            <colour>_</colour> 
            <size>Size:Int => Size+Int 1</size>
            <transitions> 
                direction(DP(>), CC(>)) |-> point(RRX:Int, RRY:Int) 
                direction(DP(>), CC(<)) |-> point(RLX:Int, RLY:Int)  
                direction(DP(v), CC(>)) |-> point(DRX:Int, DRY:Int)  
                direction(DP(v), CC(<)) |-> point(DLX:Int, DLY:Int) 
                direction(DP(<), CC(>)) |-> point(LRX:Int, LRY:Int) 
                direction(DP(<), CC(<)) |-> point(LLX:Int, LLY:Int) 
                direction(DP(^), CC(>)) |-> point(URX:Int, URY:Int)  
                direction(DP(^), CC(<)) |-> point(ULX:Int, ULY:Int) 
            </transitions>
        </block>
        ...
    </blocks>
    <blockworkspace> ListItem(point(X:Int,Y:Int))=> .List ... </blockworkspace>
    requires    notBool ((X >Int RRX)  orBool (X ==Int RRX andBool Y >Int RRY)) //not the right-bottom
        andBool notBool ((X >Int RLX)  orBool (X ==Int RLX andBool RLY >Int Y)) //not the right-top
        andBool notBool ((Y >Int DRY)  orBool (Y ==Int DRY andBool DRX >Int X)) //not the bottom-left
        andBool notBool ((Y >Int DLY)  orBool (Y ==Int DLY andBool X >Int DLX)) //not the bottom-right
        andBool notBool ((LRX >Int X)  orBool (X ==Int LRX andBool LRY >Int Y)) //not the left-top
        andBool notBool ((LLX >Int X)  orBool (X ==Int LLX andBool Y >Int LLY)) //not the left-bottom
        andBool notBool ((URY >Int Y)  orBool (Y ==Int URY andBool X >Int URX)) //not the top-right
        andBool notBool ((ULY >Int Y)  orBool (Y ==Int ULY andBool ULX >Int X)) //not the top-left

rule [build-block-finished]: //we have finished constructing the block
    <k> build(_) => . ...</k>
    <blockworkspace>.List</blockworkspace> 

```

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


```k
rule [translate-instruction-to-black]:      
    <k>TranslateInstruction _ color(black)   => blk(TT) ...</k>
    <timesToggled> TT:Int => TT +Int 1 </timesToggled>

rule [hit-black-pixel-dp]:
    <k>blk(I:Int) => rotdp(1) ~> step ...</k>
    <PP> _ => ExitedPP </PP> //roll back the program pointer
    <exitedPP> ExitedPP:Coord </exitedPP>
    <log> ... .List => ListItem("bounced dp") </log>
    requires notBool (I ==Int 7) andBool (I %Int 2 ==Int 1)
rule [hit-black-pixel-c]:
    <k>blk(I:Int) => rotcc(1) ~> step ...</k>
    <PP> _ => ExitedPP </PP> //roll back the program pointer
    <exitedPP> ExitedPP:Coord </exitedPP>
    <log> ... .List => ListItem("bounced cc") </log>
    requires notBool (I ==Int 7) andBool (I %Int 2 ==Int 0)
rule [hit-black-pixel-too-many]:
    <k>blk(7) => stop ...</k>
    <log> ... .List => ListItem("stuck") </log>
```

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

```k
rule [translate-instruction-from-white]:    TranslateInstruction color(white) color(L H)  => nop
rule [translate-instruction-to-white]:      TranslateInstruction color(L H) color(white)   => nop 
rule [translate-instruction-between-white]: TranslateInstruction color(white) color(white)   => nop //TODO: how do we know whne we're retracing our steps...?
```

### Commands

 



Commands are defined by the transition of colour from one colour block
to the next as the interpreter travels through the program. The number
of steps along the Hue Cycle and Lightness Cycle in each transition
determine the command executed, as shown in the table at right. If the
transition between colour blocks occurs via a slide across a white
block, no command is executed. The individual commands are explained
below.
```k
rule [translate-instruction-colours]:       TranslateInstruction color(L1 H1) color(L2 H2)  => LookupInstruction LightnessDifference L1 L2 HueDifference H1 H2
```

-   **push:** Pushes the value of the colour block just exited on to the
    stack. Note that values of colour blocks are not automatically
    pushed on to the stack - this push operation must be explicitly
    carried out.

    ```k
    rule [instruction-push]:
                            <k> push => nop </k>  
                            <exitedPP>PP:Coord </exitedPP>
                            <owner> ... PP |-> ID:Int ...</owner>
                            <blocks> 
                            ...
                                <block> <id> ID </id><colour>_</colour><size> I:Int</size><transitions>_</transitions></block>
                            ...
                            </blocks>
                            <stack> .List => ListItem(I) ... </stack>
                            <log> ... .List => ListItem ("PUSH,") ListItem(I)</log>
    ```

-   **pop:** Pops the top value off the stack and discards it.

    ```k
        rule [instruction-pop]: 
                            <k> pop =>  nop</k>
                            <stack>  ListItem(_) => .List ...  </stack>
                            <log> ... .List => ListItem ("POP,") </log>
    ```

-   **add:** Pops the top two values off the stack, adds them, and
    pushes the result back on the stack.

    ```k
        rule [instruction-add]: 
                            <k> add =>  nop</k>
                            <stack> ListItem(I1:Int) ListItem(I2:Int) => ListItem(I1 +Int I2) ... </stack>
                            <log> ... .List => ListItem ("ADD,") </log>
    ```

-   **subtract:** Pops the top two values off the stack, calculates the
    second top value minus the top value, and pushes the result back on
    the stack.

    ```k
        rule [instruction-subtract]: 
                            <k> sub =>  nop</k>
                            <stack> ListItem(I1:Int) ListItem(I2:Int) => ListItem(I2 -Int I1) ... </stack>
                            <log> ... .List => ListItem ("SUB,") </log>
    ```

-   **multiply:** Pops the top two values off the stack, multiplies
    them, and pushes the result back on the stack.

    ```k
        rule [instruction-multiply]: 
                            <k> mult =>  nop</k>
                            <stack> ListItem(I1:Int) ListItem(I2:Int) => ListItem(I2 *Int I1) ... </stack>
                            <log> ... .List => ListItem ("MULT,") </log>
    ```

-   **divide:** Pops the top two values off the stack, calculates the
    integer division of the second top value by the top value, and
    pushes the result back on the stack. If a divide by zero occurs, it
    is handled as an implementation-dependent error, though simply
    ignoring the command is recommended.

    ```k
        rule [instruction-divide]: 
                            <k> div =>  nop</k>
                            <stack> ListItem(I1:Int) ListItem(I2:Int) => ListItem(I2 /Int I1) ... </stack> 
                             <log> ... .List => ListItem ("DIV,") </log>
                            requires notBool (I1 ==Int 0)

        rule [instruction-divide-by-zero]: 
                            <k> div =>  nop</k>
                            <stack> ListItem(0) ListItem(_:Int) ... </stack>
    ```

-   **mod:** Pops the top two values off the stack, calculates the
    second top value
    [modulo](https://en.wikipedia.org/wiki/Modulo_operation) the top
    value, and pushes the result back on the stack. The result has the
    same sign as the divisor (the top value). If the top value is zero,
    this is a divide by zero error, which is handled as an
    implementation-dependent error, though simply ignoring the command
    is recommended. (*See note below.*)

    ```k
        //note: This assumes that the inbuilt %Int is modulus that has same sign as the *dividend* rather than divisor, there's the possibility I've misunderstood the docs
        rule [instruction-modulo-positive]: 
                            //divisor is positive, so output must be positive
                            <k> mod => nop</k>
                            <stack> ListItem(I1:Int) ListItem(I2:Int) => ListItem(I2 %Int I1) ... </stack> 
                            <log> ... .List => ListItem ("MOD,") </log>
                            requires notBool (I1 ==Int 0) andBool (I1 >Int 0)
        rule [instruction-modulo-negative]: 
                            //divisor is negative, so so it output
                            <k> mod => nop</k>
                            <stack> ListItem(I1:Int) ListItem(I2:Int) => ListItem(0 -Int ((0 -Int I2) %Int (0 -Int I1))) ... </stack> 
                            <log> ... .List => ListItem ("MOD,") </log>
                            requires notBool (I1 ==Int 0) andBool (0 >Int I1)

        rule [instruction-modulo-zero]: // ignoring a mod by zero 
                            <k> mod =>  nop</k>
                            <stack> ListItem(0) ListItem(_Int)... </stack>
    ```

-   **not:** Replaces the top value of the stack with 0 if it is
    non-zero, and 1 if it is zero.

    ```k
        rule [instruction-not-nonzero]: 
                            <k> not => nop</k>
                            <stack> ListItem(I1:Int) => ListItem(0) ... </stack> 
                            <log> ... .List => ListItem ("NOT,") </log>
                            when notBool(I1 ==Int 0)
        rule [instruction-not-zero]: 
                            <k> not => nop</k>
                            <stack> ListItem(0) => ListItem(1) ... </stack> 
                            <log> ... .List => ListItem ("NOT,") </log>
    ```
-   **greater:** Pops the top two values off the stack, and pushes 1 on
    to the stack if the second top value is greater than the top value,
    and pushes 0 if it is not greater.

    ```k
        rule [instruction-greater-bot-greater]: 
                            <k> great =>  nop</k>
                            <stack>ListItem(Top:Int) ListItem(Bottom:Int) => ListItem(1) ... </stack> 
                            <log> ... .List => ListItem ("GR") </log>
                            when Bottom >Int Top

        rule [instruction-greater-bot-not-greater]: 
                            <k> great =>  nop</k>
                            <stack>ListItem(Top:Int) ListItem(Bottom:Int) => ListItem(0) ... </stack> 
                            <log> ... .List => ListItem ("LT") </log>
                            when notBool(Bottom >Int Top)
    ```

-   **pointer:** Pops the top value off the stack and rotates the DP
    clockwise that many steps (anticlockwise if negative).

    ```k
        rule [instruction-pointer]:
                            <k> ptr =>  rotdp(abs(Steps)) ~> nop ...</k>
                            <stack>ListItem(Steps:Int) => .List ... </stack> 
                            <log> ... .List => ListItem ("PTR") </log>


        syntax State ::= "rotdp" "(" Int ")" [strict]

        rule    <k>rotdp(0) => . ...</k>
        rule    <k>rotdp(X:Int) => rotdp(X -Int 1) ...</k>
                <DP>DP(>) => DP(v)</DP>
                requires notBool (X ==Int 0)
        rule    <k>rotdp(X:Int) => rotdp(X -Int 1) ...</k>
                <DP>DP(v) => DP(<)</DP>
                requires notBool (X ==Int 0)
        rule    <k>rotdp(X:Int) => rotdp(X -Int 1) ...</k>
                <DP>DP(<) => DP(^)</DP>
                requires notBool (X ==Int 0)
        rule    <k>rotdp(X:Int) => rotdp(X -Int 1) ...</k>
                <DP>DP(^) => DP(>)</DP>
                requires notBool (X ==Int 0)
    ```

-   **switch:** Pops the top value off the stack and toggles the CC that
    many times (the absolute value of that many times if negative).

    ```k
        rule [instruction-switch]: 
                            <k> switch =>  rotcc(abs(C)) ~> nop ...</k>
                            <stack>ListItem(C:Int) => .List ... </stack> 
                            <log> ... .List => ListItem ("SWITCH") </log>



        syntax State ::= "rotcc" "(" Int ")" [strict]
        rule    <k>rotcc(0) => . ...</k>
        rule    <k>rotcc(X:Int) => rotcc(X -Int 1) ...</k>
                <CC>CC(>) => CC(<)</CC>
                requires notBool (X ==Int 0)
        rule    <k>rotcc(X:Int) => rotcc(X -Int 1) ...</k>
                <CC>CC(<) => CC(>)</CC>
                requires notBool (X ==Int 0)
    ```

-   **duplicate:** Pushes a copy of the top value on the stack on to the
    stack.

    ```k
        rule [instruction-duplicate]: 
                            <k> dup => nop</k>
                            <stack>ListItem(Value:Int) => ListItem(Value) ListItem(Value) ...</stack>
                            <log> ... .List => ListItem ("DUP") </log>
    ```
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

    ```k
        rule [instruction-roll]: 
                            <k>roll => rollby(Depth, NumRolls)</k>
                            <stack> ListItem(NumRolls:Int) ListItem(Depth:Int) => .List ... </stack>
                            <log> ... .List => ListItem ("ROLL,") </log>
                                requires Depth >=Int 0
    
    
    
        rule                <k>roll => nop</k>
                            <stack> ListItem(_:Int) ListItem(Depth:Int) => .List ... </stack>
                                requires 0 >Int Depth //negative depth is an error and ignored

        
            syntax State ::= "rollby" "(" Int "," Int ")" [strict]
            rule    <k>rollby(_:Int, 0) => nop</k>

            rule    <k> rollby (Depth:Int, _:Int)=> nop ... </k> //ignore if depth too large
                    <stack> S:List </stack>
                        requires (Depth >Int size(S))

            rule    <k>rollby(Depth:Int, NumRolls:Int)=> rollby(Depth, NumRolls -Int 1)</k> 
                    <stack> S:List => (range(S, 1, size(S) -Int Depth ) range(S, 0, size(S) -Int 1) range(S, Depth,0) ) </stack>
                        requires NumRolls >Int 0

            // other (presumably correct) implementations take the value at [depth] and move it to the top of the stack, so that's what I'll do.
            // I originall thought it meant taking the value at the top and moving it to [depth] from the *bottom* of the stack
            rule    <k>rollby(Depth:Int, NumRolls:Int)=> rollby(Depth, NumRolls +Int 1)</k> 
                    <stack> S:List => (range(S, Depth, size(S) -Int Depth -Int 1  )  range(S, 0, size(S) -Int Depth )  range(S, Depth +Int 1,0) ) </stack>
                        requires 0 >Int NumRolls
    ```
-   **in:** Reads a value from STDIN as either a number or character,
    depending on the particular incarnation of this command and pushes
    it on to the stack. If no input is waiting on STDIN, this is an
    error and the command is ignored. If an integer read does not
    receive an integer value, this is an error and the command is
    ignored.
-   **out:** Pops the top value off the stack and prints it to STDOUT as
    either a number or character, depending on the particular
    incarnation of this command.


|                |           | **Lightness Change** |              |
|----------------|-----------|:--------------------:|--------------|
| **Hue change** | **None**  | **1 Darker**         | **2 Darker** |
| **None**       |           | push                 | pop          |
| **1 Step**     | add       | subtract             | multiply     |
| **2 Step**     | divide    | mod                  | not          |
| **3 Step**     | greater   | pointer              | switch       |
| **4 Step**     | duplicate | roll                 | in (number)  |
| **5 Step**     | in (char) | out (number)         | out (char)   |

```k
    rule [instruction-resolution-none]:     LookupInstruction 0 0 => nop
    rule [instruction-resolution-push]:     LookupInstruction 1 0 => push
    rule [instruction-resolution-pop]:      LookupInstruction 2 0 => pop
    rule [instruction-resolution-add]:      LookupInstruction 0 1 => add
    rule [instruction-resolution-subtract]: LookupInstruction 1 1 => sub
    rule [instruction-resolution-multiply]: LookupInstruction 2 1 => mult
    rule [instruction-resolution-divide]:   LookupInstruction 0 2 => div
    rule [instruction-resolution-modulo]:   LookupInstruction 1 2 => mod
    rule [instruction-resolution-not]:      LookupInstruction 2 2 => not
    rule [instruction-resolution-greater]:  LookupInstruction 0 3 => great
    rule [instruction-resolution-pointer]:  LookupInstruction 1 3 => ptr
    rule [instruction-resolution-switch]:   LookupInstruction 2 3 => switch
    rule [instruction-resolution-duplicate]:LookupInstruction 0 4 => dup
    rule [instruction-resolution-roll]:     LookupInstruction 1 4 => roll
    rule [instruction-resolution-in(num)]:  LookupInstruction 2 4 => innum
    rule [instruction-resolution-in(char)]: LookupInstruction 0 5 => inchar
    rule [instruction-resolution-out(num)]: LookupInstruction 1 5 => outnum
    rule [instruction-resolution-out(char)]:LookupInstruction 2 5 => outchar
```


```k
//a NOP occurs after every instruction. Thus, we can reset the timesToggled counter, becuase we did not hit a black pixel
rule [process-nop]: 
    <k> nop => step ...</k> 
    <PP> P:Coord </PP>
    <log> ... .List => ListItem (P) </log>
    <timesToggled> _ => 0 </timesToggled> //[structural]
```

Any operations which cannot be performed (such as popping values when
not enough are on the stack) are simply ignored, and processing
continues with the next command.
```k
rule [ignore-one-arg-instruction]:
                        <k> _:Instruction1Arg => nop </k>
                        <stack> S:List </stack>
                        requires 1 >Int size(S)

rule [ignore-two-arg-instruction]:
                        <k> _:Instruction2Arg => nop </k>
                        <stack> S:List </stack>
                        requires 2 >Int size(S)

```


```k
//####
// RELATED TO PARSING PROGRAM INTO <program> CELL
//####

rule [finished-parsing]:
    <k>.Lines => step </k>              

rule [parse-next-line]: 
    <k>L:Line ; Ls:Lines => L </k>   
    <nextLines> . => Ls </nextLines>              
    <buildingx> _X:Int => -1 </buildingx>
    <buildingy> Y:Int => Y +Int 1 </buildingy>  [structural]

rule [parse-next-line-restore]:
    <k> .Line => Ls </k> 
    <nextLines> Ls:Lines => .</nextLines>  [structural]

rule [parse-next-pixel]:      
    <k>P:Pixel  L:Line => P ~> L</k>
    <buildingx> X:Int => X +Int 1 </buildingx> [structural]

//place the colour index into the program cell, mapped from its position. This means we will be able to look up colours from positions later
rule [place-pixel-in-map]:
    <k> C:Colour => . ...</k>
    <buildingx> X:Int </buildingx>
    <buildingy> Y:Int </buildingy>
    <program> ... .Map => point(X,Y) |->  C ...</program> [structural]
```

```k
endmodule
```

```k
module KPIET-SYNTAX
    imports DOMAINS

    //TODO: would prefer to place this up with the lightness rules but `kompile` shouts at me if I do that
    syntax Colour ::=  "color" "(" Lightness Hue ")" | "color" "(" "black" ")" | "color" "(" "white" ")" 
    syntax Hue ::= "red" | "yellow" | "green" | "cyan" | "blue" | "magenta"
    syntax Lightness ::= "light" | "normal" | "dark" 

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

    //TODO: would prefer to place this up with the hexcode rules but `kompile` shouts at me if I do that
    syntax Hexcode ::=  "xffc0c0"   | "xff0000" | "xc00000" | 
                        "xffffc0"   | "xffff00" | "xc0c000" | 
                        "xc0ffc0"   | "x00ff00" | "x00c000" | 
                        "xc0ffff"   | "x00ffff" | "x00c0c0" |
                        "xc0c0ff"   | "x0000ff" | "x0000c0" |
                        "xffc0ff"   | "xff00ff" | "xc000c0" |
                        "x000000"   | "xffffff"  | Id
    //TODO: maybe break this syntax module back into the main module, then I can place syntax next to the appropriate rules
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