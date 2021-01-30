module HELPERS
    //everything here is [structural], it's all just helper functions rather than actual execution steps
    imports DOMAINS-SYNTAX
    imports DOMAINS
    imports KPIET-SYNTAX

    syntax Bool ::= Colour "==Colour" Colour [strict, function] 
    rule color(black) ==Colour color(white) => false [structural]
    rule color(white) ==Colour color(black) => false [structural]
    rule color(black) ==Colour color(black) => true [structural]
    rule color(white) ==Colour color(white) => true [structural]

    rule color(black) ==Colour color(_:Lightness _:Hue) => false [structural]
    rule color(white) ==Colour color(_:Lightness _:Hue) => false [structural]
    rule color(_:Lightness _:Hue) ==Colour color(black) => false [structural]
    rule color(_:Lightness _:Hue) ==Colour color(white) => false [structural]
    //rule color(L1:Lightness H1:Hue) ==Colour color(L2:Lightness H2:Hue) => LightnessDifference L1 L2 ==Int 0 andBool HueDifference H1 H2 ==Int 0
    rule color(L1:Lightness H1:Hue) ==Colour color(L2:Lightness H2:Hue) =>  L1 ==Lightness L2  andBool H1 ==Hue H2 [structural]



    syntax Bool ::= Lightness "==Lightness" Lightness [strict, function] 
    rule light ==Lightness light => true    [structural]
    rule normal ==Lightness normal => true  [structural]
    rule dark ==Lightness dark => true      [structural]

    rule light ==Lightness normal => false  [structural]
    rule light ==Lightness dark => false    [structural]
    rule normal ==Lightness light => false  [structural]
    rule normal ==Lightness dark => false   [structural]
    rule dark ==Lightness normal => false   [structural]
    rule dark ==Lightness light => false    [structural]




    syntax Bool ::= Hue "==Hue" Hue [strict, function] 
    rule red ==Hue red => true          [structural]
    rule yellow ==Hue yellow => true    [structural]
    rule green ==Hue green => true      [structural]
    rule cyan ==Hue cyan => true        [structural]
    rule blue ==Hue blue => true        [structural]
    rule magenta ==Hue magenta => true  [structural]

    rule red ==Hue yellow => false      [structural]
    rule red ==Hue green => false       [structural]
    rule red ==Hue cyan => false        [structural]
    rule red ==Hue blue => false        [structural]
    rule red ==Hue magenta => false     [structural]

    rule yellow ==Hue red => false      [structural]
    rule yellow ==Hue green => false    [structural]
    rule yellow ==Hue cyan => false     [structural]
    rule yellow ==Hue blue => false     [structural]
    rule yellow ==Hue magenta => false  [structural]

    rule green ==Hue red => false       [structural]
    rule green ==Hue yellow => false    [structural]
    rule green ==Hue cyan => false      [structural]
    rule green ==Hue blue => false      [structural]
    rule green ==Hue magenta => false   [structural]

    rule cyan ==Hue red => false        [structural]
    rule cyan ==Hue yellow => false     [structural]
    rule cyan ==Hue green => false      [structural]
    rule cyan ==Hue blue => false       [structural]
    rule cyan ==Hue magenta => false    [structural]

    rule blue ==Hue red => false        [structural]
    rule blue ==Hue yellow => false     [structural]
    rule blue ==Hue green => false      [structural]
    rule blue ==Hue cyan => false       [structural]
    rule blue ==Hue magenta => false    [structural]

    rule magenta ==Hue red => false     [structural]
    rule magenta ==Hue yellow => false  [structural]
    rule magenta ==Hue green => false   [structural]
    rule magenta ==Hue cyan => false    [structural]
    rule magenta ==Hue blue => false    [structural]


    syntax Coord ::= Coord "+Coord" Coord [strict, function]
    rule point(X1:Int, Y1:Int) +Coord point(X2:Int, Y2:Int) => point(X1+Int X2, Y1 +Int Y2) [structural]


    syntax Coord ::= "DPToOffset" "(" DirectionPointer ")" [strict, function]
    rule DPToOffset (DP(>)) => point(1,0)   [structural]
    rule DPToOffset (DP(v)) => point(0,1)   [structural]
    rule DPToOffset (DP(<)) => point(-1,0)  [structural]
    rule DPToOffset (DP(^)) => point(0,-1)  [structural]





    syntax Int ::= "abs" "("Int")" [strict, function]
    rule abs(X:Int) => X:Int requires X >Int 0                  [structural]
    rule abs(X:Int) => 0 -Int X requires notBool (X >Int 0)     [structural]

    syntax Bool ::= "stringIsInt" "(" String ")" [strict, function]
    
    //findChar(S ,"-",0) ==Int 0 is the same as "S begins with "-""
    rule stringIsInt (S:String) => (cleanFromChars(S) ==String "-." andBool findChar(S ,"-",0) ==Int 0) orBool (cleanFromChars(S) ==String "-" andBool findChar(S ,"-",0) ==Int 0) orBool (cleanFromChars(S) ==String ".") orBool (cleanFromChars(S) ==String "")
  
    syntax String ::= "cleanFromChars" "(" String ")" [strict, function]

    rule cleanFromChars (S) => replaceAll (replaceAll (replaceAll (replaceAll (replaceAll (replaceAll (replaceAll (replaceAll (replaceAll (replaceAll (S,"9", ""),"8", ""),"7", ""),"6", ""),"5", ""),"4", ""),"3", ""),"2", ""),"1", ""),"0", "")


    syntax List ::= "getLastN" "(" List "," Int ")" [strict, function]
    rule getLastN (L:List , I:Int) => range(L, size(L) -Int I, 0) requires size(L) >=Int I


    syntax Bool ::= List "==List" List [strict, function]
    rule L:List ==List L => true
    rule ListItem(I1) L1:List ==List ListItem(I2) L2:List => #if I1 ==Waypoint I2  #then range(L1,1,0) ==List range(L2,1,0) #else false #fi //AAAA THIS IS NOT GENERIC IT WORKS ONLY FOR THAT ONE TYPE
    rule L2:List ==List L1:List => false requires notBool (size(L1) ==Int size(L2))


    syntax Bool ::= Waypoint "==Waypoint" Waypoint [strict, function]
    rule WP(point(X1:Int, Y1:Int), C1:Colour) ==Waypoint WP(point(X2:Int, Y2:Int), C2:Colour) => X1 ==Int X2 andBool Y1 ==Int Y2 andBool C1 ==Colour C2 
endmodule