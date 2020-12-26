module HELPERS
    imports DOMAINS-SYNTAX
    imports DOMAINS
    imports KPIET-SYNTAX

    syntax Bool ::= Colour "==Colour" Colour [function, functional] //refuses to be [strict] as well
    rule color(black) ==Colour color(white) => false
    rule color(white) ==Colour color(black) => false
    rule color(black) ==Colour color(black) => true
    rule color(white) ==Colour color(white) => true

    rule color(black) ==Colour color(_:Lightness _:Hue) => false
    rule color(white) ==Colour color(_:Lightness _:Hue) => false
    rule color(_:Lightness _:Hue) ==Colour color(black) => false
    rule color(_:Lightness _:Hue) ==Colour color(white) => false
    //rule color(L1:Lightness H1:Hue) ==Colour color(L2:Lightness H2:Hue) => LightnessDifference L1 L2 ==Int 0 andBool HueDifference H1 H2 ==Int 0
    rule color(L1:Lightness H1:Hue) ==Colour color(L2:Lightness H2:Hue) =>  L1 ==Lightness L2  andBool H1 ==Hue H2



    syntax Bool ::= Lightness "==Lightness" Lightness [function, functional] //refuses to be [strict]
    rule light ==Lightness light => true
    rule normal ==Lightness normal => true
    rule dark ==Lightness dark => true

    rule light ==Lightness normal => false
    rule light ==Lightness dark => false
    rule normal ==Lightness light => false
    rule normal ==Lightness dark => false
    rule dark ==Lightness normal => false
    rule dark ==Lightness light => false




    syntax Bool ::= Hue "==Hue" Hue [strict, function] 
    rule red ==Hue red => true
    rule yellow ==Hue yellow => true
    rule green ==Hue green => true
    rule cyan ==Hue cyan => true
    rule blue ==Hue blue => true
    rule magenta ==Hue magenta => true

    rule red ==Hue yellow => false
    rule red ==Hue green => false
    rule red ==Hue cyan => false
    rule red ==Hue blue => false
    rule red ==Hue magenta => false

    rule yellow ==Hue red => false
    rule yellow ==Hue green => false
    rule yellow ==Hue cyan => false
    rule yellow ==Hue blue => false
    rule yellow ==Hue magenta => false

    rule green ==Hue red => false
    rule green ==Hue yellow => false
    rule green ==Hue cyan => false
    rule green ==Hue blue => false
    rule green ==Hue magenta => false

    rule cyan ==Hue red => false
    rule cyan ==Hue yellow => false
    rule cyan ==Hue green => false
    rule cyan ==Hue blue => false
    rule cyan ==Hue magenta => false

    rule blue ==Hue red => false
    rule blue ==Hue yellow => false
    rule blue ==Hue green => false
    rule blue ==Hue cyan => false
    rule blue ==Hue magenta => false

    rule magenta ==Hue red => false
    rule magenta ==Hue yellow => false
    rule magenta ==Hue green => false
    rule magenta ==Hue cyan => false
    rule magenta ==Hue blue => false


    syntax Coord ::= Coord "+Coord" Coord [strict, function]
    rule point(X1:Int, Y1:Int) +Coord point(X2:Int, Y2:Int) => point(X1+Int X2, Y1 +Int Y2)


    syntax Coord ::= "DPToOffset" "(" DirectionPointer ")" [strict, function]
    rule DPToOffset (DP(>)) => point(1,0)
    rule DPToOffset (DP(v)) => point(0,1)
    rule DPToOffset (DP(<)) => point(-1,0)
    rule DPToOffset (DP(^)) => point(0,-1)

endmodule