require "helpers.k"

module KPIET
    imports DOMAINS-SYNTAX
    imports DOMAINS
    
    imports HELPERS

//The difference between two lightnesses of the same lightness is zero
rule [lightness-difference-base-light]:         LightnessDifference L1:Lightness   L2:Lightness   => 0  requires L1 ==Lightness L2

//if the colours are dissimlair, darken the second lightness one step, check the difference on this new lightness, and add 1 to it
rule [lightness-difference-inductive-light]:    LightnessDifference L:Lightness       normal  => LightnessDifference L light +Int 1 requires notBool(L ==Lightness normal)
rule [lightness-difference-inductive-normal]:   LightnessDifference L:Lightness       dark    => LightnessDifference L normal +Int 1 requires notBool(L ==Lightness dark)
rule [lightness-difference-inductive-dark]:     LightnessDifference L:Lightness       light   => LightnessDifference L dark +Int 1 requires notBool(L ==Lightness light)

//The difference in hues of the same hues is zero
rule [hue-difference-base-red]:             HueDifference       H1:Hue      H2:Hue     => 0 requires H1 ==Hue H2 

//If the colours are dissimiliar, then step the second hue down, then check the hue difference between those two colours, and add 1 to it
rule [hue-difference-inductive-yellow]:     HueDifference       H:Hue       yellow  => HueDifference H red      +Int 1 requires notBool(H ==Hue yellow)
rule [hue-difference-inductive-green]:      HueDifference       H:Hue       green   => HueDifference H yellow   +Int 1 requires notBool(H ==Hue green)
rule [hue-difference-inductive-cyan]:       HueDifference       H:Hue       cyan    => HueDifference H green    +Int 1 requires notBool(H ==Hue cyan)
rule [hue-difference-inductive-blue]:       HueDifference       H:Hue       blue    => HueDifference H cyan     +Int 1 requires notBool(H ==Hue blue)
rule [hue-difference-inductive-magenta]:    HueDifference       H:Hue       magenta => HueDifference H blue     +Int 1 requires notBool(H ==Hue magenta)
rule [hue-difference-inductive-red]:        HueDifference       H:Hue       red     => HueDifference H magenta  +Int 1 requires notBool(H ==Hue red)

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
    


rule [translate-hexcode-encountered-illegal]:               TranslateHexcode _:Id => color ( white )  
//TODO: need some test on this, i.e program w/non-spec pixel becomes white





configuration <T>    
    <program> .Map </program> //maps position to colour of the pixel there  

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
    <path> .List</path>

       
    <k> $PGM:Program </k>

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





    <stack> .List </stack> 


    <DP>DP (>)</DP> 
    <CC>CC (<)</CC> 
    <PP> point(0,0) </PP> //program pointer, points to current pixel
    <exitedPP> point(0,0)</exitedPP>
    <timesToggled> 0 </timesToggled>



</T>



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
    <blocks>
    ... 
        <block>
            <id> OldBlockID </id> 
            <colour> OldColour:Colour </colour> 
            <size> _Size:Int </size> 
            <transitions> ... direction(D,C)|-> NewPP:Coord ... </transitions> 
        </block>
    ...
    </blocks>
    <DP>D:DirectionPointer</DP>
    <CC>C:CodelChooser</CC>
    <blockworkspace> .List </blockworkspace>

    rule [next-step-out-of-bounds]:
    <k> step => TranslateInstruction OldColour color(black) ... </k> //going out of bounds is treated like walking into a black pixel
    <PP> OldPP:Coord => NewPP +Coord DPToOffset(D) </PP> 
    <exitedPP> _ => OldPP </exitedPP>
    <program> Program:Map </program>  //out of bounds, so it is unmapped  
    <owner> ... OldPP |-> OldBlockID:Int ... </owner>
    <blocks> 
    ... 
        <block> 
            <id> OldBlockID </id> 
            <colour> OldColour:Colour </colour> 
            <size> _Size:Int </size> 
            <transitions> ... direction(D,C)|-> NewPP:Coord ... </transitions> 
        </block>
    ...
    </blocks>
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



rule [translate-instruction-from-white]:    TranslateInstruction color(white) color(_ _)  => nop
rule [translate-instruction-to-white]:      TranslateInstruction color(_ _) color(white)   => nop 
rule [translate-instruction-between-white]: TranslateInstruction color(white) color(white)   => nopW 



rule [translate-instruction-colours]:       TranslateInstruction color(L1 H1) color(L2 H2)  => LookupInstruction LightnessDifference L1 L2 HueDifference H1 H2


    
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
    

    
        rule [instruction-pop]: 
            <k> pop =>  nop</k>
            <stack>  ListItem(_) => .List ...  </stack>
            <log> ... .List => ListItem ("POP,") </log>
 
    
        rule [instruction-add]: 
            <k> add =>  nop</k>
            <stack> ListItem(I1:Int) ListItem(I2:Int) => ListItem(I1 +Int I2) ... </stack>
            <log> ... .List => ListItem ("ADD,") </log>
    


        rule [instruction-subtract]: 
            <k> sub =>  nop</k>
            <stack> ListItem(I1:Int) ListItem(I2:Int) => ListItem(I2 -Int I1) ... </stack>
            <log> ... .List => ListItem ("SUB,") </log>
    

  
    
        rule [instruction-multiply]: 
            <k> mult =>  nop</k>
            <stack> ListItem(I1:Int) ListItem(I2:Int) => ListItem(I2 *Int I1) ... </stack>
            <log> ... .List => ListItem ("MULT,") </log>
    

    
        rule [instruction-divide]: 
            <k> div =>  nop</k>
            <stack> ListItem(I1:Int) ListItem(I2:Int) => ListItem(I2 /Int I1) ... </stack> 
            <log> ... .List => ListItem ("DIV,") </log>
                requires notBool (I1 ==Int 0)

        rule [instruction-divide-by-zero]: 
            <k> div =>  nop</k>
            <stack> ListItem(0) ListItem(_:Int) ... </stack> 
            <log> ... .List => ListItem ("DIV,") </log>
    

    
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
            <log> ... .List => ListItem ("MOD,") </log>
    

    
        rule [instruction-not-nonzero]: 
            <k> not => nop</k>
            <stack> ListItem(I1:Int) => ListItem(0) ... </stack> 
            <log> ... .List => ListItem ("NOT,") </log>
                when notBool(I1 ==Int 0)
        rule [instruction-not-zero]: 
            <k> not => nop</k>
            <stack> ListItem(0) => ListItem(1) ... </stack> 
            <log> ... .List => ListItem ("NOT,") </log>
 
    
        rule [instruction-greater-bot-greater]: 
            <k> great =>  nop</k>
            <stack>ListItem(Top:Int) ListItem(Bottom:Int) => ListItem(1) ... </stack> 
            <log> ... .List => ListItem ("GR") </log>
                requires Bottom >Int Top

        rule [instruction-greater-bot-not-greater]: 
            <k> great =>  nop</k>
            <stack>ListItem(Top:Int) ListItem(Bottom:Int) => ListItem(0) ... </stack> 
            <log> ... .List => ListItem ("LT") </log>
                requires notBool(Bottom >Int Top)
    

    
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
    

    
        rule [instruction-duplicate]: 
            <k> dup => nop</k>
            <stack>ListItem(Value:Int) => ListItem(Value) ListItem(Value) ...</stack>
            <log> ... .List => ListItem ("DUP") </log>
 
    
    rule [instruction-roll]: 
        <k>roll => rollby(Depth, NumRolls)</k>
        <stack> ListItem(NumRolls:Int) ListItem(Depth:Int) => .List ... </stack>
        <log> ... .List => ListItem ("ROLL,") </log>
            requires Depth >=Int 0  

    rule [instruction-roll-negative-depth]:
        <k>roll => nop</k>
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
 

    rule [instruction-in-number-int]: 
        <k>innum => nop </k>
        <stack> .List => ListItem(I) ... </stack>                       
        <log> ... .List => ListItem ("INNUM,") </log>
        <input> ListItem(I:Int) => .List ...</input> 

    //TODO: doesn't work
    //rule [instruction-in-number-ignore]: 
    //    <k>innum => nop </k>                     
    //    <log> ... .List => ListItem ("INNUMIGNORE,") ListItem(#getc(#stdin)) </log> //use <log> as a "black hole" cell for the character we ignore from STDIN
    //    <input> ListItem(S:String) </input>
    //        requires notBool (stringIsInt(S))


    rule [instruction-in-char]: 
        <k>inchar => nop</k>
        <stack> .List => ListItem(#getc(#stdin)) ... </stack> //yes, we're using FFI, I'm very sorry for this, I managed to avoid it until now.      
        <log> ... .List => ListItem ("INCHAR,") </log>

    


    
    rule [instruction-out-number]: 
        <k> outnum => nop</k>
        <stack>ListItem(Value:Int) => .List ...</stack>
        <output> ... .List => ListItem(Value)</output>
        <log> ... .List => ListItem ("OUTNUM") </log>

    rule [instruction-out-character]: 
        <k> outchar => nop</k>
        <stack>ListItem(Value:Int) => .List ...</stack>
        <output> ... .List => ListItem(chrChar(Value))</output>     //TODO: use #putc instead?
        <log> ... .List => ListItem ("OUTCHAR") </log>     
    


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




//a NOP occurs after every instruction. Thus, we can reset the timesToggled counter, becuase we did not hit a black pixel
rule [process-nop]: 
    <k> nop => step ...</k> 
    <PP> P:Coord </PP>
    <program> ... P |-> C:Colour ... </program>
    <path> ... .List => ListItem (WP(P,C)) </path>
    <timesToggled> _ => 0 </timesToggled> //[structural]

//check that we are not in a white loop. If we are, halt the program
rule [process-nop-loop]: 
    <k> nopW => #if repeats(L , 1) #then stop #else nop #fi </k> 
    <path> L </path> 

syntax Bool ::= "repeats" "(" List "," Int ")" [strict, function]

rule repeats(L:List , I:Int) => false requires I >=Int size(L) /Int 2


rule repeats (L:List, I:Int) => ((getLastN(L, I) getLastN(L, I)) ==List getLastN(L, I*Int 2) andBool (notBool (hasNonWhite ( getLastN(L, I*Int 2))))) orBool repeats(L, I +Int 1) requires size(L) /Int 2 >Int I

syntax Bool ::= "hasNonWhite" "("  List ")" [strict, function]

rule hasNonWhite (ListItem(WP(_:Coord, color(_:Lightness  _:Hue) )) _:List )=> true //this will also not match black but that shouldn't be in the path anyway
rule hasNonWhite ((ListItem(WP(_:Coord, color(white))) L:List) )=>  hasNonWhite (L)
rule hasNonWhite ( .List ) => false


rule [ignore-one-arg-instruction]:
                        <k> _:Instruction1Arg => nop </k>
                        <stack> S:List </stack>
                        <log> ... .List => ListItem ("IGNORE,") </log>
                        requires 1 >Int size(S)

rule [ignore-two-arg-instruction]:
                        <k> _:Instruction2Arg => nop </k>
                        <stack> S:List </stack>
                        <log> ... .List => ListItem ("IGNORE,") </log>
                        requires 2 >Int size(S)





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



endmodule



module KPIET-SYNTAX
    imports DOMAINS

    //TODO: would prefer to place this up with the lightness rules but `kompile` shouts at me if I do that
    syntax Colour ::=  "color" "(" Lightness Hue ")" | "color" "(" "black" ")" | "color" "(" "white" ")" 
    syntax Hue ::= "red" | "yellow" | "green" | "cyan" | "blue" | "magenta"
    syntax Lightness ::= "light" | "normal" | "dark" 

    syntax KResult ::= Int | Colour | Coord | Instruction | Bool | Waypoint

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
                        | "nop" | "nopW"
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
                        "x000000"   | "xffffff" | Id
    //TODO: maybe break this syntax module back into the main module, then I can place syntax next to the appropriate rules

    syntax Waypoint ::= "WP" "(" Coord "," Colour ")"
endmodule


