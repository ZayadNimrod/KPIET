module KPIET
    imports DOMAINS-SYNTAX
    configuration <T>        
    
        <k> .K </k> //the current command we are working on

        <stack> .List </stack> //the stack of values the program works on

        <DP>0</DP> //0 - right, 1 - down, 2 - left, 3- up
        <CC>0</CC> //0-right,1-left
        <PP> point(0,0) </PP> //program pointer, points to current pixel


        <program> .Map </program> //maps position to colour of the pixel there
        <owner> .Map </owner> //maps position to the block that wons it
        <block> .Map </block> //stores a list of all the blocks that have been constructed so far. TODO: cache transitions


        <input color="magenta" stream = "stdin"> .List </input>
        <output color="Orchid" stream = "stdout"> .List </output>
    </T>

    //in our input, we can recieve hex, but we want to work on colour indices. Becuase of this, we want to translate one to the other    
    syntax Colour ::= ColorIndex | Hexcode | "TranslateHexcode" Colour 



    //this system is clearer (and conceptually closer to spec), if a lot more verbose than the clever int encoding that most implementations do
    syntax ColorIndex ::=  "[" Lightness Hue "]" | "[" "black" "]" | "[" "white" "]"
    syntax Hue = "red" | "yellow" | "green" | "cyan" | "blue" | "magenta"
    syntax Lightness = "light" | "normal" | "dark"
    
    syntax Hexcode ::= //TODO

    rule [translate_hexcode_no_repeat] TranslateHexcode TranslateHexcode  => TranslateHexcode
    rule [translate_hexcode_encountered_index] TranslateHexcode C:ColourIndex  => C

    rule [translate_hexcode_encountered_hexcode] TranslateHexcode  ffc0c0 => [ light red ]
    rule [translate_hexcode_encountered_hexcode] TranslateHexcode  ff0000 => [ normal red ]
    rule [translate_hexcode_encountered_hexcode] TranslateHexcode  c00000 => [ dark red ]
    rule [translate_hexcode_encountered_hexcode] TranslateHexcode  ffffc0 => [ light yellow ]
    rule [translate_hexcode_encountered_hexcode] TranslateHexcode  ffff00 => [ normal yellow ]
    rule [translate_hexcode_encountered_hexcode] TranslateHexcode  00c000 => [ dark yellow ]
    rule [translate_hexcode_encountered_hexcode] TranslateHexcode  c0ffc0 => [ light green ]
    rule [translate_hexcode_encountered_hexcode] TranslateHexcode  00ff00 => [ normal green ]
    rule [translate_hexcode_encountered_hexcode] TranslateHexcode  00c000 => [ dark green ]
    rule [translate_hexcode_encountered_hexcode] TranslateHexcode  c0ffff => [ light cyan ]
    rule [translate_hexcode_encountered_hexcode] TranslateHexcode  00ffff => [ normal cyan ]
    rule [translate_hexcode_encountered_hexcode] TranslateHexcode  00c0c0 => [ dark cyan ]
    rule [translate_hexcode_encountered_hexcode] TranslateHexcode  c0c0ff => [ light blue ]
    rule [translate_hexcode_encountered_hexcode] TranslateHexcode  0000ff => [ normal blue ]
    rule [translate_hexcode_encountered_hexcode] TranslateHexcode  0000c0 => [ dark blue ]
    rule [translate_hexcode_encountered_hexcode] TranslateHexcode  ffc0ff => [ light magenta ]
    rule [translate_hexcode_encountered_hexcode] TranslateHexcode  ff00ff => [ normal magenta ]
    rule [translate_hexcode_encountered_hexcode] TranslateHexcode  c000c0 => [ dark magenta ]

    //ah.... it'll interpret 000000 as 0, won't it....
    //I guess we need to append something in the bitmapper to each hexcode to make this identify is as a hex
    rule [translate_hexcode_encountered_hexcode] TranslateHexcode  000000 => [ black ]
    rule [translate_hexcode_encountered_hexcode] TranslateHexcode  ffffff => [ white ]      
    //TODO: cases of an unkown hex should be translated as white, according to spec


    syntax Command ::=              "push"  |   "pop"   |
                        "add"   |   "sub"   |   "mult"  |
                        "div"   |   "mod"   |   "not"   |
                        "great" |   "ptr"   |   "switch"|
                        "dup"   |   "roll"  |   "innum" |
                        "inchar"|   "outnum"|   "outchar"

                        | "TranslateCommand" Colour Colour [strict]
                        | "LookupCommand" LightnessDifferenceCall HueDifferenceCall [strict]

    syntax LightnessDifferenceCall := "LightnessDifference" Lightness Lightness | Int
    syntax HueDifferenceCall := "HueDifference" Hue Hue | Int


    rule [translate_command] TranslateCommand [L1 H1] [L2 H2] => LookupCommand LightnessDifference L1 L2 HueDifference H1 H2


    rule [lightness_difference] LightnessDifference normal  normal  => 0
    rule [lightness_difference] LightnessDifference dark    dark    => 0
    rule [lightness_difference] LightnessDifference light   normal  => 1
    rule [lightness_difference] LightnessDifference normal  dark    => 1
    rule [lightness_difference] LightnessDifference dark    light   => 1
    rule [lightness_difference] LightnessDifference light   dark    => 2
    rule [lightness_difference] LightnessDifference normal  light   => 2
    rule [lightness_difference] LightnessDifference dark    normal  => 2

    rule [hue_difference]       HueDifference       red     red     => 0
    rule [hue_difference]       HueDifference       yellow  yellow  => 0
    rule [hue_difference]       HueDifference       green   green   => 0
    rule [hue_difference]       HueDifference       cyan    cyan    => 0
    rule [hue_difference]       HueDifference       blue    blue    => 0
    rule [hue_difference]       HueDifference       magenta magenta => 0
    rule [hue_difference]       HueDifference       red     yellow  => 1
    rule [hue_difference]       HueDifference       yellow  green   => 1
    rule [hue_difference]       HueDifference       green   cyan    => 1
    rule [hue_difference]       HueDifference       cyan    blue    => 1
    rule [hue_difference]       HueDifference       blue    magenta => 1
    rule [hue_difference]       HueDifference       magenta red     => 1
    rule [hue_difference]       HueDifference       red     green   => 2
    rule [hue_difference]       HueDifference       yellow  cyan    => 2
    rule [hue_difference]       HueDifference       green   blue    => 2
    rule [hue_difference]       HueDifference       cyan    magenta => 2
    rule [hue_difference]       HueDifference       blue    red     => 2
    rule [hue_difference]       HueDifference       magenta yellow  => 2
    rule [hue_difference]       HueDifference       red     cyan    => 3
    rule [hue_difference]       HueDifference       yellow  blue    => 3
    rule [hue_difference]       HueDifference       green   magenta => 3
    rule [hue_difference]       HueDifference       cyan    red     => 3
    rule [hue_difference]       HueDifference       blue    yellow  => 3
    rule [hue_difference]       HueDifference       magenta green   => 3
    rule [hue_difference]       HueDifference       red     blue    => 4
    rule [hue_difference]       HueDifference       yellow  magenta => 4
    rule [hue_difference]       HueDifference       green   red     => 4
    rule [hue_difference]       HueDifference       cyan    yellow  => 4
    rule [hue_difference]       HueDifference       blue    green   => 4
    rule [hue_difference]       HueDifference       magenta cyan    => 4
    rule [hue_difference]       HueDifference       red     magenta => 5
    rule [hue_difference]       HueDifference       yellow  red     => 5
    rule [hue_difference]       HueDifference       green   yellow  => 5
    rule [hue_difference]       HueDifference       cyan    green   => 5
    rule [hue_difference]       HueDifference       blue    cyan    => 5
    rule [hue_difference]       HueDifference       magenta blue    => 5
    
    rule [command_resolution]   LookupCommand 0 0 => .
    rule [command_resolution]   LookupCommand 1 0 => push
    rule [command_resolution]   LookupCommand 2 0 => pop
    rule [command_resolution]   LookupCommand 0 1 => add
    rule [command_resolution]   LookupCommand 1 1 => sub
    rule [command_resolution]   LookupCommand 2 1 => mult
    rule [command_resolution]   LookupCommand 0 2 => div
    rule [command_resolution]   LookupCommand 1 2 => mod
    rule [command_resolution]   LookupCommand 2 2 => not
    rule [command_resolution]   LookupCommand 0 3 => great
    rule [command_resolution]   LookupCommand 1 3 => ptr
    rule [command_resolution]   LookupCommand 2 3 => switch
    rule [command_resolution]   LookupCommand 0 4 => dup
    rule [command_resolution]   LookupCommand 1 4 => roll
    rule [command_resolution]   LookupCommand 2 4 => innum
    rule [command_resolution]   LookupCommand 0 4 => inchar
    rule [command_resolution]   LookupCommand 1 4 => outnum
    rule [command_resolution]   LookupCommand 2 4 => outchar



endmodule