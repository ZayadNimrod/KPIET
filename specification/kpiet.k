module KPIET
    imports DOMAINS-SYNTAX
    imports DOMAINS
    
    //TODO: Hold on, what if we don't place black pixels in the <program> cell. Thus, if we look them up, we fail, and instead return blac. this laos means out of bounds pixels will be considred black, which will mimc the functionality edges have.
    configuration <T>        
    
        <k> $PGM:Program</k> //the current instruction we are working on

        <stack> .List </stack> //the stack of values the program works on

        <DP>0</DP> //direction pointer; 0 - right, 1 - down, 2 - left, 3- up
        <CC>0</CC> //"codel chooser"; 0-right,1-left
        <PP> point(0,0) </PP> //program pointer, points to current pixel


        <program> .Map </program> //maps position to colour of the pixel there
        <owner> .Map </owner> //maps position to the block that owns it
        <block> .Map </block> //stores a list of all the blocks that have been constructed so far. TODO: cache transitions

        //TODO:K doesn't like streams anymore
        //<input color="magenta" stream = "stdin"> .List </input>
        //<output color="Orchid" stream = "stdout"> .List </output>

        <input color="magenta"> .List </input>
        <output color="Orchid"> .List </output>

        //used when building up <program>
        <buildingx>0</buildingx>
        <buildingy>0</buildingy>
        <nextLines> . </nextLines>
    </T>

    //####
    // RELATED TO PARSING PROGRAM INTO <program> CELL
    //####

    
    syntax Coord ::= "point" "(" Int "," Int ")"
    syntax KResult ::= Int | ColorIndex | Coord
    syntax Program ::= Lines

    syntax Lines ::= List{Line, ";"}
    syntax Line ::= List{Pixel, ""} 

    syntax Pixel ::= Colour

    //get next pixel, convert to colour, map to its location, go to next pixel
    rule H:Hexcode => TranslateHexcode H 

 
    rule .Lines => .
    rule [parse-next-line]: 
        
        //<k>L:Line EOL Ls:Lines => L ~> Ls</k>     
        //<buildingx> _X:Int => 0 </buildingx>
        //<buildingy> Y:Int => Y +Int 1 </buildingy>  


        <k>L:Line ; Ls:Lines => L </k>   
        <nextLines> . => Ls </nextLines>              
        <buildingx> _X:Int => 0 </buildingx>
        <buildingy> Y:Int => Y +Int 1 </buildingy>  



    rule [parse-next-line-restore]:
        <k> . => Ls </k> 
        <nextLines> Ls:Lines => .</nextLines>   



    rule .Line => .
    rule [parse-next-pixel]: 
        //<k>"," => . ...</k>        
        <k>P:Colour  L:Line => P ~> L</k>
        <buildingx> X:Int => X +Int 1 </buildingx> 



    //place the colour index into the program cell, mapped from its position. This means we will be able to look up colours from positions later
    rule [place-pixel-in-map]:
        <k> C:ColorIndex => . ...</k>
        <buildingx> X:Int </buildingx>
        <buildingy> Y:Int </buildingy>
         <program> ... .Map => point(X,Y) |->  C ...</program>

    //in our input, we can recieve hex, but we want to work on colour indices. Becuase of this, we want to translate one to the other    
    syntax Colour ::= ColorIndex | Hexcode | "TranslateHexcode" Colour 



    //this system is clearer (and conceptually closer to spec), if a lot more verbose than the clever int encoding that most implementations do
    syntax ColorIndex ::=  "color" "(" Lightness Hue ")" | "color" "(" "black" ")" | "color" "(" "white" ")"
    syntax Hue ::= "red" | "yellow" | "green" | "cyan" | "blue" | "magenta"
    syntax Lightness ::= "light" | "normal" | "dark" 

    syntax Hexcode ::=  "xffc0c0"   | "xff0000" | "xc00000" | 
                        "xffffc0"   | "xffff00" | "x00c000" | 
                        "xc0ffc0"   | "x00ff00" | "x00c000" | 
                        "xc0ffff"   | "x00ffff" | "x00c0c0" |
                        "xc0c0ff"   | "x0000ff" | "x0000c0" |
                        "xffc0ff"   | "xff00ff" | "xc000c0" |
                        "x000000"   | "xffffff" | "x0000000" | Id  //matching Id exists so that if we pass a hexcode that is not matched to a spec colour we can handle it as white


                        
    //####
    // RELATED TO VIRTUAL MACHINE
    //####
    rule [translate-hexcode-no-repeat]: TranslateHexcode TranslateHexcode  C:Colour => TranslateHexcode C
    rule [translate-hexcode-encountered-index]:   TranslateHexcode C:ColorIndex  => C

    rule [translate-hexcode-encountered-hexcode-light-red]:     TranslateHexcode xffc0c0 => color ( light red )
    rule [translate-hexcode-encountered-hexcode-normal-red]:    TranslateHexcode xff0000 => color ( normal red )
    rule [translate-hexcode-encountered-hexcode-dark-red]:      TranslateHexcode xc00000 => color ( dark red )
    rule [translate-hexcode-encountered-hexcode-light-yellow]:  TranslateHexcode xffffc0 => color ( light yellow )
    rule [translate-hexcode-encountered-hexcode-normal-yellow]: TranslateHexcode xffff00 => color ( normal yellow )
    rule [translate-hexcode-encountered-hexcode-dark-yellow]:   TranslateHexcode x00c000 => color ( dark yellow )
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
    //cases of an unkown hex should be translated as white, according to spec
    rule [translate-hexcode-encountered-illegal]:               TranslateHexcode _:Id => color ( white )  
    //TODO: need some test on this, i.e program w/non-spec pixel becomes white

    syntax KResult::= Int | ColorIndex
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



    /*

    // Get the instruction that a transition between two colours maps to
    // Get the difference between two colours hues and lightnesses, then look that up on the table of instructions
    rule [translate-instruction-colours]:       TranslateInstruction color(L1 H1) color(L2 H2)  => LookupInstruction LightnessDifference L1 L2 HueDifference H1 H2
    //When a white pixel is involved in the transition, no instruction is exectuted
    rule [translate-instruction-from-white]:    TranslateInstruction color(white) _   => . //moving from white to another pixel results in NOP
    rule [translate-instruction-to-white]:      TranslateInstruction _ color(white)   => . //moving to  white from another pixel results in NOP
    //TODO: transitions involving black pixels

    //The difference between two lightnesses of the same lightness is zero
    rule [lightness-difference-base-light]:         LightnessDifference light   light   => 0
    rule [lightness-difference-base-normal]:        LightnessDifference normal  normal  => 0
    rule [lightness-difference-base-dark]:          LightnessDifference dark    dark    => 0
    //if the colours are dissimlair, darken the second lightness one step, check the difference on this new lightness, and add 1 to it
    rule [lightness-difference-inductive-light]:    LightnessDifference L       normal  => LightnessDifference L light +Int 1
    rule [lightness-difference-inductive-normal]:   LightnessDifference L       dark    => LightnessDifference L normal +Int 1
    rule [lightness-difference-inductive-dark]:     LightnessDifference L       light   => LightnessDifference L dark +Int 1

    //The difference in hues of the same hues is zero
    rule [hue-difference-base-red]:             HueDifference       red     red     => 0
    rule [hue-difference-base-yellow]:          HueDifference       yellow  yellow  => 0
    rule [hue-difference-base-green]:           HueDifference       green   green   => 0
    rule [hue-difference-base-cyan]:            HueDifference       cyan    cyan    => 0
    rule [hue-difference-base-blue]:            HueDifference       blue    blue    => 0
    rule [hue-difference-base-magenta]:         HueDifference       magenta magenta => 0
    //If the colours are dissimiliar, then step the second hue down, then check the hue difference between those two colours, and add 1 to it
    rule [hue-difference-inductive-yellow]:     HueDifference       H       yellow  => HueDifference H red      +Int 1
    rule [hue-difference-inductive-green]:      HueDifference       H       green   => HueDifference H yellow   +Int 1
    rule [hue-difference-inductive-cyan]:       HueDifference       H       cyan    => HueDifference H green    +Int 1
    rule [hue-difference-inductive-blue]:       HueDifference       H       blue    => HueDifference H cyan     +Int 1
    rule [hue-difference-inductive-magenta]:    HueDifference       H       magenta => HueDifference H blue     +Int 1
    rule [hue-difference-inductive-red]:        HueDifference       H       red     => HueDifference H magenta  +Int 1


    
    rule [instruction-resolution-none]:     LookupInstruction 0 0 => .
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
    rule [instruction-resolution-in(char)]: LookupInstruction 0 4 => inchar
    rule [instruction-resolution-out(num)]: LookupInstruction 1 4 => outnum
    rule [instruction-resolution-out(char)]:LookupInstruction 2 4 => outchar

    //push: Pushes the value (size) of the colour block just exited on to the stack. Note that values of colour blocks are not automatically pushed on to the stack - this push operation must be explicitly carried out.
    rule [instruction-push]: <k> push => . </k>  //TODO get the size of the current block
    
    //pop: Pops the top value off the stack and discards it.
    rule [instruction-pop]: 
                            <k> pop =>  .</k>
                            <stack> ... ListItem(_) => .List  </stack>

    //add: Pops the top two values off the stack, adds them, and pushes the result back on the stack.
    rule [instruction-add]: 
                            <k> add =>  .</k>
                            <stack> ListItem(I1:Int) ListItem(I2:Int) => ListItem(I1 +Int I2) ... </stack>

    //subtract: Pops the top two values off the stack, calculates the second top value minus the top value, and pushes the result back on the stack.
    rule [instruction-subtract]: 
                            <k> sub =>  .</k>
                            <stack> ListItem(I1:Int) ListItem(I2:Int) => ListItem(I2 -Int I1) ... </stack>

    //multiply: Pops the top two values off the stack, multiplies them, and pushes the result back on the stack.
    rule [instruction-multiply]: 
                            <k> mult =>  .</k>
                            <stack> ListItem(I1:Int) ListItem(I2:Int) => ListItem(I2 *Int I1) ... </stack>

    //divide: Pops the top two values off the stack, calculates the integer division of the second top value by the top value, and pushes the result back on the stack. If a divide by zero occurs, it is handled as an implementation-dependent error, though simply ignoring the command is recommended.
    rule [instruction-divide]: 
                            <k> div =>  .</k>
                            <stack> ListItem(I1:Int) ListItem(I2:Int) => ListItem(I2 /Int I1) ... </stack> //TODO: ignoring a div by zero rather than locking up
    
    //mod: Pops the top two values off the stack, calculates the second top value modulo the top value, and pushes the result back on the stack. The result has the same sign as the divisor (the top value). If the top value is zero, this is a divide by zero error, which is handled as an implementation-dependent error, though simply ignoring the command is recommended. (See note below.)
    rule [instruction-modulo]: 
                            <k> mod =>  .</k>
                            <stack> ListItem(I1:Int) ListItem(I2:Int) => ListItem(I2 %Int I1) ... </stack> //TODO: ignoring a div by zero  -i.e use "when"-rather than locking up
                            //TODO: make sure sign is the same as the divisor
    
    //not: Replaces the top value of the stack with 0 if it is non-zero, and 1 if it is zero.
    rule [instruction-not-nonzero]: 
                            <k> not => .</k>
                            <stack> ListItem(I1:Int) => ListItem(0) ... </stack> 
                            when notBool(I1 ==Int 0)
    rule [instruction-not-zero]: 
                            <k> not => .</k>
                            <stack> ListItem(0) => ListItem(1) ... </stack> 

    //greater: Pops the top two values off the stack, and pushes 1 on to the stack if the second top value is greater than the top value, and pushes 0 if it is not greater.
    rule [instruction-greater-top-greater]: 
                            <k> great =>  .</k>
                            <stack>ListItem(Top:Int) ListItem(Bottom:Int) => ListItem(1) ... </stack> 
                            when Top >Int Bottom
    rule [instruction-greater-to-not-greater]: 
                            <k> great =>  .</k>
                            <stack>ListItem(Top:Int) ListItem(Bottom:Int) => ListItem(0) ... </stack> 
                            when notBool(Top >Int Bottom)

    //pointer: Pops the top value off the stack and rotates the DP clockwise that many steps (anticlockwise if negative).
    rule [instruction-pointer]: 
                            <k> ptr =>  .</k>
                            <stack>ListItem(Steps:Int) => .List ... </stack> 
                            <DP>D:Int => ((D +Int Steps)%Int 4)</DP>           
    //switch: Pops the top value off the stack and toggles the CC that many times (the absolute value of that many times if negative).
    rule [instruction-switch]: 
                            <k> switch =>  .</k>
                            <stack>ListItem(Step:Int) => .List ... </stack> 
                            <CC>C:Int => ((C +Int Step)%Int 2)</CC> //TODO make sure we use absolute value of I
    //duplicate: Pushes a copy of the top value on the stack on to the stack.
    rule [instruction-duplicate]: 
                            <k> dup => .</k>
                            <stack>ListItem(Value:Int) => ListItem(Value) ListItem(Value) ...</stack>

    //roll: Pops the top two values off the stack and "rolls" the remaining stack entries to a depth equal to the second value popped, by a number of rolls equal to the first value popped. A single roll to depth n is defined as burying the top value on the stack n deep and bringing all values above it up by 1 place. A negative number of rolls rolls in the opposite direction. A negative depth is an error and the command is ignored. If a roll is greater than an implementation-dependent maximum stack depth, it is handled as an implementation-dependent error, though simply ignoring the command is recommended.
    rule [instruction-roll]: 
                            <k>roll => .</k>
        //<stack> </stack> ///TODO: AAAAAAA how to even begin


    //in: Reads a value from STDIN as either a number or character, depending on the particular incarnation of this command and pushes it on to the stack. If no input is waiting on STDIN, this is an error and the command is ignored. If an integer read does not receive an integer value, this is an error and the command is ignored.
    rule [instruction-in-number]: 
                            <k>innum => .</k>
                            <stack> .List => ListItem(I) ... </stack>
                            <input> ListItem(I:Int) => .List ...</input> //TODO: ignore if not an int rather than locking up
    rule [instruction-incharacter]: 
                            <k>inchar => .</k>
                            <stack> .List => ListItem(S) ... </stack>
                            <input> ListItem(S:String) => .List ...</input>  //TODO: specification is not too clear, but most implementations get one character and convert it to an integer


    //out: Pops the top value off the stack and prints it to STDOUT as either a number or character, depending on the particular incarnation of this command.
    rule [instruction-out-number]: 
                            <k> outnum => .</k>
                            <stack>ListItem(Value:Int) => .List ...</stack>
                            <output> ... .List => ListItem(Value)</output>
    rule [instruction-out-character]: 
                            <k> outnum => PrintChar(IntToChar(Value))</k>
                            <stack>ListItem(Value:Int) => .List ...</stack>
                        


    syntax String ::= "IntToChar" "(" Int ")" [strict]
    //rule IntToChar(Input:Int) => Id2String(((Input %Int 256) +Int 256) %Int 256) [structural]
    //TODO return to the above
    syntax K ::= "PrintChar" "(" String ")" [strict]
    rule 
                            <k>PrintChar (S:String) => . ...</k> 
                            <output> ... .List => ListItem(S)</output> [structural]


	 */
endmodule