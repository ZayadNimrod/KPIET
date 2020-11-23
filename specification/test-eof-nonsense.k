module TEST-EOF-NONSENSE
    imports DOMAINS-SYNTAX
    imports DOMAINS
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
                        "x000000"   | "xffffff" | Id  //matching Id exists so that if we pass a hexcode that is not matched to a spec colour we can handle it as white
                        

    rule [translate-hexcode-no-repeat]: TranslateHexcode TranslateHexcode  C:Colour => TranslateHexcode C
    rule [translate-hexcode-encountered-index]:   TranslateHexcode C:ColorIndex  => C

    rule [translate-hexcode-encountered-hexcode]: TranslateHexcode xffc0c0 => color ( light red )
    rule [translate-hexcode-encountered-hexcode]: TranslateHexcode xff0000 => color ( normal red )
    rule [translate-hexcode-encountered-hexcode]: TranslateHexcode xc00000 => color ( dark red )
    rule [translate-hexcode-encountered-hexcode]: TranslateHexcode xffffc0 => color ( light yellow )
    rule [translate-hexcode-encountered-hexcode]: TranslateHexcode xffff00 => color ( normal yellow )
    rule [translate-hexcode-encountered-hexcode]: TranslateHexcode x00c000 => color ( dark yellow )
    rule [translate-hexcode-encountered-hexcode]: TranslateHexcode xc0ffc0 => color ( light green )
    rule [translate-hexcode-encountered-hexcode]: TranslateHexcode x00ff00 => color ( normal green )
    rule [translate-hexcode-encountered-hexcode]: TranslateHexcode x00c000 => color ( dark green )
    rule [translate-hexcode-encountered-hexcode]: TranslateHexcode xc0ffff => color ( light cyan )
    rule [translate-hexcode-encountered-hexcode]: TranslateHexcode x00ffff => color ( normal cyan )
    rule [translate-hexcode-encountered-hexcode]: TranslateHexcode x00c0c0 => color ( dark cyan )
    rule [translate-hexcode-encountered-hexcode]: TranslateHexcode xc0c0ff => color ( light blue )
    rule [translate-hexcode-encountered-hexcode]: TranslateHexcode x0000ff => color ( normal blue )
    rule [translate-hexcode-encountered-hexcode]: TranslateHexcode x0000c0 => color ( dark blue )
    rule [translate-hexcode-encountered-hexcode]: TranslateHexcode xffc0ff => color ( light magenta )
    rule [translate-hexcode-encountered-hexcode]: TranslateHexcode xff00ff => color ( normal magenta )
    rule [translate-hexcode-encountered-hexcode]: TranslateHexcode xc000c0 => color ( dark magenta )
    
    rule [translate-hexcode-encountered-hexcode]: TranslateHexcode x000000 => color ( black )
    rule [translate-hexcode-encountered-hexcode]: TranslateHexcode xffffff => color ( white )    
    //cases of an unkown hex should be translated as white, according to spec
    rule [translate-hexcode-encountered-illegal]: TranslateHexcode X:Id => color ( white )  

   

    syntax Int ::=      LightnessDifferenceCall 
                    |   HueDifferenceCall
    syntax LightnessDifferenceCall ::= "LightnessDifference" Lightness Lightness
    syntax HueDifferenceCall ::= "HueDifference" Hue Hue





    syntax Instruction ::= "TranslateInstruction" Colour Colour [strict]
                        | "LookupInstruction" Int Int [strict]

    // Get the instruction that a transition between two colours maps to
    // get the diff
    rule [translate-instruction]: TranslateInstruction color (L1 H1) color (L2 H2)  => LookupInstruction LightnessDifference L1 L2 HueDifference H1 H2
    rule [translate-instruction]: TranslateInstruction color (white) C:ColorIndex   => . //moving from white to another pixel results in NOP
    rule [translate-instruction]: TranslateInstruction C:ColorIndex color (white)   => . //moving to  white from another pixel results in NOP
    //TODO: transitions involving black pixels

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


endmodule