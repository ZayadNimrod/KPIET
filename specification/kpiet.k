module KPIET
    imports DOMAINS-SYNTAX
    imports DOMAINS
    configuration <T>        
    
        <k> .K </k> //the current instruction we are working on

        <stack> .List </stack> //the stack of values the program works on

        <DP>0</DP> //direction pointer; 0 - right, 1 - down, 2 - left, 3- up
        <CC>0</CC> //"codel chooser"; 0-right,1-left
        <PP> point(0,0) </PP> //program pointer, points to current pixel


        <program> .Map </program> //maps position to colour of the pixel there
        <owner> .Map </owner> //maps position to the block that owns it
        <block> .Map </block> //stores a list of all the blocks that have been constructed so far. TODO: cache transitions

        <input color="magenta" stream = "stdin"> .List </input>
        <output color="Orchid" stream = "stdout"> .List </output>
    </T>


    syntax K ::= "point" "(" Int "," Int ")"

    //in our input, we can recieve hex, but we want to work on colour indices. Becuase of this, we want to translate one to the other    
    syntax Colour ::= ColorIndex | Hexcode | "TranslateHexcode" Colour 



    //this system is clearer (and conceptually closer to spec), if a lot more verbose than the clever int encoding that most implementations do
    syntax ColorIndex ::=  "[" Lightness Hue "]" | "[" "black" "]" | "[" "white" "]"
    syntax Hue ::= "red" | "yellow" | "green" | "cyan" | "blue" | "magenta"
    syntax Lightness ::= "light" | "normal" | "dark"
    
    syntax Hexcode ::=  "xffc0c0"   | "xff0000" | "xc00000" | 
                        "xffffc0"   | "xffff00" | "x00c000" | 
                        "xc0ffc0"   | "x00ff00" | "x00c000" | 
                        "xc0ffff"   | "x00ffff" | "x00c0c0" |
                        "xc0c0ff"   | "x0000ff" | "x0000c0" |
                        "xffc0ff"   | "xff00ff" | "xc000c0" |
                        "x000000"   | "xffffff" | Id  //matching Id exists so that if we pass a hexcode that is not matched to a spec colour we can handle it as white
                        

    rule [translate-hexcode-no-repeat]: TranslateHexcode TranslateHexcode  C:Colour => TranslateHexcode C
    rule [translate-hexcode-encountered-index]:   TranslateHexcode C:ColorIndex  => C

    rule [translate-hexcode-encountered-hexcode]: TranslateHexcode xffc0c0 => [ light red ]
    rule [translate-hexcode-encountered-hexcode]: TranslateHexcode xff0000 => [ normal red ]
    rule [translate-hexcode-encountered-hexcode]: TranslateHexcode xc00000 => [ dark red ]
    rule [translate-hexcode-encountered-hexcode]: TranslateHexcode xffffc0 => [ light yellow ]
    rule [translate-hexcode-encountered-hexcode]: TranslateHexcode xffff00 => [ normal yellow ]
    rule [translate-hexcode-encountered-hexcode]: TranslateHexcode x00c000 => [ dark yellow ]
    rule [translate-hexcode-encountered-hexcode]: TranslateHexcode xc0ffc0 => [ light green ]
    rule [translate-hexcode-encountered-hexcode]: TranslateHexcode x00ff00 => [ normal green ]
    rule [translate-hexcode-encountered-hexcode]: TranslateHexcode x00c000 => [ dark green ]
    rule [translate-hexcode-encountered-hexcode]: TranslateHexcode xc0ffff => [ light cyan ]
    rule [translate-hexcode-encountered-hexcode]: TranslateHexcode x00ffff => [ normal cyan ]
    rule [translate-hexcode-encountered-hexcode]: TranslateHexcode x00c0c0 => [ dark cyan ]
    rule [translate-hexcode-encountered-hexcode]: TranslateHexcode xc0c0ff => [ light blue ]
    rule [translate-hexcode-encountered-hexcode]: TranslateHexcode x0000ff => [ normal blue ]
    rule [translate-hexcode-encountered-hexcode]: TranslateHexcode x0000c0 => [ dark blue ]
    rule [translate-hexcode-encountered-hexcode]: TranslateHexcode xffc0ff => [ light magenta ]
    rule [translate-hexcode-encountered-hexcode]: TranslateHexcode xff00ff => [ normal magenta ]
    rule [translate-hexcode-encountered-hexcode]: TranslateHexcode xc000c0 => [ dark magenta ]
    
    rule [translate-hexcode-encountered-hexcode]: TranslateHexcode x000000 => [ black ] //[ light red ] if we use [black], then kompile treats this as an EOF?
    rule [translate-hexcode-encountered-hexcode]: TranslateHexcode xffffff => [ white ]    
    //cases of an unkown hex should be translated as white, according to spec
    rule [translate-hexcode-encountered-illegal]: TranslateHexcode X:Id => [ white ]  //TODO: need some test on this, i.e program w/non-spec pixel becomes white


    syntax Instruction ::=          "push"  |   "pop"   |
                        "add"   |   "sub"   |   "mult"  |
                        "div"   |   "mod"   |   "not"   |
                        "great" |   "ptr"   |   "switch"|
                        "dup"   |   "roll"  |   "innum" |
                        "inchar"|   "outnum"|   "outchar"

                        | "TranslateInstruction" Colour Colour [strict]
                        | "LookupInstruction" Int Int [strict]

    syntax Int ::=      LightnessDifferenceCall 
                    |   HueDifferenceCall
    syntax LightnessDifferenceCall ::= "LightnessDifference" Lightness Lightness
    syntax HueDifferenceCall ::= "HueDifference" Hue Hue


    rule [translate-instruction]: TranslateInstruction [L1 H1] [L2 H2] => LookupInstruction LightnessDifference L1 L2 HueDifference H1 H2

    rule [lightness-difference]: LightnessDifference light   light   => 0
    rule [lightness-difference]: LightnessDifference normal  normal  => 0
    rule [lightness-difference]: LightnessDifference dark    dark    => 0
    rule [lightness-difference]: LightnessDifference L       normal  => LightnessDifference L light +Int 1
    rule [lightness-difference]: LightnessDifference L       dark    => LightnessDifference L normal +Int 1
    rule [lightness-difference]: LightnessDifference L       light   => LightnessDifference L dark +Int 1


    rule [hue-difference]:       HueDifference       red     red     => 0
    rule [hue-difference]:       HueDifference       yellow  yellow  => 0
    rule [hue-difference]:       HueDifference       green   green   => 0
    rule [hue-difference]:       HueDifference       cyan    cyan    => 0
    rule [hue-difference]:       HueDifference       blue    blue    => 0
    rule [hue-difference]:       HueDifference       magenta magenta => 0
    rule [hue-difference]:       HueDifference       H       yellow  => HueDifference H red      +Int 1
    rule [hue-difference]:       HueDifference       H       green   => HueDifference H yellow   +Int 1
    rule [hue-difference]:       HueDifference       H       cyan    => HueDifference H green    +Int 1
    rule [hue-difference]:       HueDifference       H       blue    => HueDifference H cyan     +Int 1
    rule [hue-difference]:       HueDifference       H       magenta => HueDifference H blue     +Int 1
    rule [hue-difference]:       HueDifference       H       red     => HueDifference H magenta  +Int 1
    
    rule [instruction-resolution]:   LookupInstruction 0 0 => .
    rule [instruction-resolution]:   LookupInstruction 1 0 => push
    rule [instruction-resolution]:   LookupInstruction 2 0 => pop
    rule [instruction-resolution]:   LookupInstruction 0 1 => add
    rule [instruction-resolution]:   LookupInstruction 1 1 => sub
    rule [instruction-resolution]:   LookupInstruction 2 1 => mult
    rule [instruction-resolution]:   LookupInstruction 0 2 => div
    rule [instruction-resolution]:   LookupInstruction 1 2 => mod
    rule [instruction-resolution]:   LookupInstruction 2 2 => not
    rule [instruction-resolution]:   LookupInstruction 0 3 => great
    rule [instruction-resolution]:   LookupInstruction 1 3 => ptr
    rule [instruction-resolution]:   LookupInstruction 2 3 => switch
    rule [instruction-resolution]:   LookupInstruction 0 4 => dup
    rule [instruction-resolution]:   LookupInstruction 1 4 => roll
    rule [instruction-resolution]:   LookupInstruction 2 4 => innum
    rule [instruction-resolution]:   LookupInstruction 0 4 => inchar
    rule [instruction-resolution]:   LookupInstruction 1 4 => outnum
    rule [instruction-resolution]:   LookupInstruction 2 4 => outchar

    //push: Pushes the value (size) of the colour block just exited on to the stack. Note that values of colour blocks are not automatically pushed on to the stack - this push operation must be explicitly carried out.
    rule [instruction-push]: <k> push => . </k>  //TODO get the size of the current block
    
    //pop: Pops the top value off the stack and discards it.
    rule [instruction-pop]: <k> pop =>  .</k>
                            <stack> ListItem(I) => . ... </stack>

    //add: Pops the top two values off the stack, adds them, and pushes the result back on the stack.
    rule [instruction-add]: <k> add =>  .</k>
                            <stack> ListItem(I1:Int) ListItem(I2:Int) => ListItem(I2 +Int I2) ... </stack>

    //subtract: Pops the top two values off the stack, calculates the second top value minus the top value, and pushes the result back on the stack.
    rule [instruction-subtract]: <k> sub =>  .</k>
                            <stack> ListItem(I1:Int) ListItem(I2:Int) => ListItem(I2 -Int I1) ... </stack>

    //multiply: Pops the top two values off the stack, multiplies them, and pushes the result back on the stack.
    rule [instruction-multiply]: <k> mult =>  .</k>
                            <stack> ListItem(I1:Int) ListItem(I2:Int) => ListItem(I2 *Int I1) ... </stack>

    //divide: Pops the top two values off the stack, calculates the integer division of the second top value by the top value, and pushes the result back on the stack. If a divide by zero occurs, it is handled as an implementation-dependent error, though simply ignoring the command is recommended.
    rule [instruction-divide]: <k> div =>  .</k>
                            <stack> ListItem(I1:Int) ListItem(I2:Int) => ListItem(I2 /Int I1) ... </stack> //TODO: ignoring a div by zero rather than locking up
    
    //mod: Pops the top two values off the stack, calculates the second top value modulo the top value, and pushes the result back on the stack. The result has the same sign as the divisor (the top value). If the top value is zero, this is a divide by zero error, which is handled as an implementation-dependent error, though simply ignoring the command is recommended. (See note below.)
    rule [instruction-modulo]: <k> mod =>  .</k>
                            <stack> ListItem(I1:Int) ListItem(I2:Int) => ListItem(I2 %Int I1) ... </stack> //TODO: ignoring a div by zero rather than locking up
                            //TODO: make sure sign is the same as the divisor
    
    //not: Replaces the top value of the stack with 0 if it is non-zero, and 1 if it is zero.
    rule [instruction-not]: <k> not =>  .</k>
                            <stack> ListItem(I:Int) => ListItem(if (I ==Bool 0) then 1 else 0 fi) ... </stack> 

    //greater: Pops the top two values off the stack, and pushes 1 on to the stack if the second top value is greater than the top value, and pushes 0 if it is not greater.
    rule [instruction-greater]: <k> not =>  .</k>
                            <stack>ListItem(I1:Int) ListItem(I2:Int) => ListItem(if (I2 > I1) then 1 else 0 fi) ... </stack> 
    //pointer: Pops the top value off the stack and rotates the DP clockwise that many steps (anticlockwise if negative).
    rule [instruction-pointer]: <k> ptr =>  .</k>
                            <stack>ListItem(I:Int) => . ... </stack> 
                            <DP>D:Int => ((D +Int I)%Int 4)</DP>           
    //switch: Pops the top value off the stack and toggles the CC that many times (the absolute value of that many times if negative).
    rule [instruction-switch]: <k> switch =>  .</k>
        <stack>ListItem(I:Int) => . ... </stack> 
        <CC>C:Int => ((C +Int I)%Int 2)</DP> //TODO make sure we use absolute value of I
    //duplicate: Pushes a copy of the top value on the stack on to the stack.
    rule [instruction-duplicate]: <k> dup => .</k>
        <stack>ListItem(I:Int) => ListItem(I) ListItem(I) ...</stack>

    //roll: Pops the top two values off the stack and "rolls" the remaining stack entries to a depth equal to the second value popped, by a number of rolls equal to the first value popped. A single roll to depth n is defined as burying the top value on the stack n deep and bringing all values above it up by 1 place. A negative number of rolls rolls in the opposite direction. A negative depth is an error and the command is ignored. If a roll is greater than an implementation-dependent maximum stack depth, it is handled as an implementation-dependent error, though simply ignoring the command is recommended.
    rule [instruction-roll]: <k>roll => .</k>
        <stack></stack> ///TODO: AAAAAAA how to even begin


    //in: Reads a value from STDIN as either a number or character, depending on the particular incarnation of this command and pushes it on to the stack. If no input is waiting on STDIN, this is an error and the command is ignored. If an integer read does not receive an integer value, this is an error and the command is ignored.
    rule [instruction-in-number]: <k>innum => .</k>
        <stack> . => ListItem(I) ... </stack>
        <input> ListItem(I:Int) => .List ...</input> //TODO: ignore if not an int rather than locking up
    rule [instruction-incharacter]: <k>inchar => .</k>
        <stack> . => ListItem(S) ... </stack>
        <input> ListItem(S:String) => .List ...</input>  //TODO: specification is not too clear, but most implementations get one character and convert it to an integer


    //out: Pops the top value off the stack and prints it to STDOUT as either a number or character, depending on the particular incarnation of this command.
    rule [instruction-out-number]: <k> outnum => .</k>
        <stack>ListItem(I:Int) => . ...</stack>
        <output> ... . => ListItem(I)</output>
    rule [instruction-out-character]: <k> outnum => PrintChar(IntToChar(I))</k>
        <stack>ListItem(I:Int) => . ...</stack>
     


    syntax String ::= "IntToChar" "(" I:Int ")" [strict]
    rule IntToChar(I:Int) => charString(((I:Int %Int 256) +Int 256) %Int 256) [structural]

    syntax K ::= "PrintChar" "(" S:String ")" [strict]
    rule <k>PrintChar(S:String) => . ...</k> [structural]
    <output> ... . => S</output>





    syntax String ::= intToChar( K )
	rule intToChar(I:Int) => charString(((I:Int %Int 256) +Int 256) %Int 256) [structural]
	
endmodule