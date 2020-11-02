stack = []
def psh(*X): stack.extend(X)
def pop(): return stack.pop() if stack else None
def pop2(): return (None, None) if len(stack) < 2 else (stack.pop(), stack.pop())
def rll(x, y):
 x %= y
 if y <= 0 or x == 0: return
 z = -abs(x) + y * (x < 0)
 stack[-y:] = stack[z:] + stack[-y:z]
def x0y0():
 a = pop()
 return [x1y0, y0x1][1 if a is None else a&1]

def x1y0():
 stack.append(1)
 return x2y0

def y0x1():
 stack.append(1)
 return y0x2

def y0x2():
 stack.append(1)
 return y0x3

def y0x3():
 a,b = pop2()
 a is not None and psh(b+a)
 return y0x4

def y0x4():
 a = pop()
 a is not None and psh(a,a)
 return y0x5

def y0x5():
 a = pop()
 a is not None and psh(a,a)
 return y0x6

def y0x6():
 a,b = pop2()
 a is not None and psh(b+a)
 return y0x7

def y0x7():
 a,b = pop2()
 a is not None and psh(b*a)
 return y0x8

def y0x8():
 a = pop()
 a is not None and psh(a,a)
 return y0x9

def y0x9():
 a = pop()
 a is not None and psh(a,a)
 return y0x10

def y0x10():
 stack.append(1)
 return y0x11

def y0x11():
 a = pop()
 return [y0x12, y0X12, Y0x12, Y0X12][0 if a is None else (a%4+4)%4]

def y0x12():
 a = pop()
 a is not None and psh(a,a)
 return X12y1

def y0X12():
 a = pop()
 a is not None and psh(a,a)
 return y1X12

def Y0x12():
 a = pop()
 return [Y0x11, x11Y0][1 if a is None else a&1]

def Y0X12():
 a = pop()
 a is not None and psh(a,a)
 return y1X12

def y1X12():
 a,b = pop2()
 a is not None and psh(b*a)
 return y2X12

def y2X12():
 a,b = pop2()
 a is not None and psh(b+a)
 return y3X12

def y3X12():
 a = pop()
 a is not None and print(chr(a&255), sep='', end='', flush=1)
 return y4X12

def y4X12():
 stack.append(1)
 return y5X12

def y5X12():
 stack.append(1)
 return y6X12

def y6X12():
 a,b = pop2()
 a is not None and psh(b+a)
 return y7X12

def y7X12():
 a,b = pop2()
 a is not None and psh(b+a)
 return y8X12

def y8X12():
 a = pop()
 a is not None and psh(a,a)
 return y9X12

def y9X12():
 a = pop()
 a is not None and psh(a,a)
 return y10X12

def y10X12():
 stack.append(1)
 return y11X12

def y11X12():
 a = pop()
 return [y12X12, Y12x12, Y12X12, y12x12][0 if a is None else (a%4+4)%4]

def y12X12():
 a,b = pop2()
 a is not None and psh(b*a)
 return x11Y12

def Y12x12():
 a,b = pop2()
 a is not None and psh(b*a)
 return Y12x11

def Y12X12():
 a = pop()
 return [Y11X12, X12Y11][1 if a is None else a&1]

def y12x12():
 a,b = pop2()
 a is not None and psh(b*a)
 return Y12x11

def Y12x11():
 a = pop()
 a is not None and psh(a,a)
 return Y12x10

def Y12x10():
 stack.append(1)
 return Y12x9

def Y12x9():
 a,b = pop2()
 a is not None and psh(b+a)
 return Y12x8

def Y12x8():
 a = pop()
 a is not None and print(chr(a&255), sep='', end='', flush=1)
 return Y12x7

def Y12x7():
 a = pop()
 a is not None and psh(a,a)
 return Y12x6

def Y12x6():
 stack.append(1)
 return Y12x5

def Y12x5():
 stack.append(1)
 return Y12x4

def Y12x4():
 a,b = pop2()
 a is not None and psh(b+a)
 return Y12x3

def Y12x3():
 stack.append(1)
 return Y12x2

def Y12x2():
 a = pop()
 return [Y12x1, Y12X1, y12x1, y12X1][0 if a is None else (a%4+4)%4]

def Y12x1():
 pop()
 return Y12x0

def Y12X1():
 a = pop()
 a is not None and psh(a,a)
 return Y11X1

def y12x1():
 a = pop()
 return [y12x2, x2y12][1 if a is None else a&1]

def y12X1():
 pop()
 return x0Y12

def x0Y12():
 a = pop()
 a is not None and psh(a,a)
 return Y11X0

def Y11X0():
 a = pop()
 return [Y10X0, X0Y10][1 if a is None else a&1]

def Y10X0():
 a = pop()
 a is not None and print(a, sep='', end='', flush=1)
 return Y9X0

def X0Y10():
 a = pop()
 a is not None and print(a, sep='', end='', flush=1)
 return X0Y9

def X0Y9():
 pop()
 return X0Y8

def X0Y8():
 a,b = pop2()
 a is not None and a!=0 and psh(b//a)
 return X0Y7

def X0Y7():
 a,b = pop2()
 a is not None and a!=0 and psh(b//a)
 return X0Y6

def X0Y6():
 a,b = pop2()
 a is not None and psh(int(b>a))
 return X0Y5

def X0Y5():
 a = psh(int(input()))
 return X0Y4

def X0Y4():
 a,b = pop2()
 a is not None and psh(b-a)
 return X0Y3

def X0Y3():
 pop()
 return X0Y2

def X0Y2():
 a = pop()
 return [X0Y1, x0y1, X0y1, x0Y1][0 if a is None else (a%4+4)%4]

def X0Y1():
 a,b = pop2()
 a is not None and psh(b-a)
 return X0Y0

def x0y1():
 a = psh(int(input()))
 return x1y1

def X0y1():
 a = pop()
 return [X0y2, y2X0][1 if a is None else a&1]

def x0Y1():
 a,b = pop2()
 a is not None and psh(b-a)
 return Y0X0

def Y0X0():
 a = pop()
 return [x1y0, y0x1][1 if a is None else a&1]

def X0y2():
 stack.append(1)
 return X0y3

def y2X0():
 stack.append(1)
 return y3X0

def y3X0():
 a = pop()
 a is not None and print(chr(a&255), sep='', end='', flush=1)
 return y4X0

def y4X0():
 a,b = pop2()
 a is not None and a!=0 and psh(b%a)
 return y5X0

def y5X0():
 a,b = pop2()
 a is not None and psh(int(b>a))
 return y6X0

def y6X0():
 a = pop()
 a is not None and psh(a,a)
 return y7X0

def y7X0():
 a = pop()
 a is not None and psh(a,a)
 return y8X0

def y8X0():
 stack.append(1)
 return y9X0

def y9X0():
 a,b = pop2()
 a is not None and psh(b*a)
 return y10X0

def y10X0():
 a = pop()
 return [y11X0, Y11x0, Y11X0, y11x0][0 if a is None else (a%4+4)%4]

def y11X0():
 a,b = pop2()
 a is not None and a!=0 and psh(b//a)
 return y12X0

def Y11x0():
 a = pop()
 return [X0Y10, Y10X0][1 if a is None else a&1]

def y11x0():
 stack.append(1)
 return y11x1

def y11x1():
 a,b = pop2()
 a is not None and a!=0 and psh(b//a)
 return y11x2

def y11x2():
 a = pop()
 return [y11x3, x3y11][1 if a is None else a&1]

def y11x3():
 pop()
 return y11x4

def x3y11():
 pop()
 return x4y11

def x4y11():
 stack.append(1)
 return x5y11

def x5y11():
 pop()
 return x6y11

def x6y11():
 pop()
 return x7y11

def x7y11():
 pop()
 return x8y11

def x8y11():
 a,b = pop2()
 a is not None and a!=0 and psh(b//a)
 return x9y11

def x9y11():
 a,b = pop2()
 a is not None and psh(b-a)
 return x10y11

def x10y11():
 a,b = pop2()
 a is not None and a!=0 and psh(b//a)
 return x11y11

def x11y11():
 pop()
 return x12y11

def x12y11():
 a = pop()
 return [y12X12, Y12x12, Y12X12, y12x12][0 if a is None else (a%4+4)%4]

def y11x4():
 stack.append(1)
 return y11x5

def y11x5():
 pop()
 return y11x6

def y11x6():
 pop()
 return y11x7

def y11x7():
 pop()
 return y11x8

def y11x8():
 a,b = pop2()
 a is not None and a!=0 and psh(b//a)
 return y11x9

def y11x9():
 a,b = pop2()
 a is not None and psh(b-a)
 return y11x10

def y11x10():
 a,b = pop2()
 a is not None and a!=0 and psh(b//a)
 return y11x11

def y11x11():
 pop()
 return y11x12

def y11x12():
 a = pop()
 return [X12y12, x12Y12, X12Y12, x12y12][0 if a is None else (a%4+4)%4]

def X12y12():
 a,b = pop2()
 a is not None and psh(b*a)
 return Y12x11

def x12Y12():
 a,b = pop2()
 a is not None and psh(b*a)
 return x11Y12

def X12Y12():
 a = pop()
 return [X12Y11, Y11X12][1 if a is None else a&1]

def x12y12():
 a,b = pop2()
 a is not None and psh(b*a)
 return x11Y12

def x11Y12():
 a = pop()
 a is not None and psh(a,a)
 return x10Y12

def x10Y12():
 stack.append(1)
 return x9Y12

def x9Y12():
 a,b = pop2()
 a is not None and psh(b+a)
 return x8Y12

def x8Y12():
 a = pop()
 a is not None and print(chr(a&255), sep='', end='', flush=1)
 return x7Y12

def x7Y12():
 a = pop()
 a is not None and psh(a,a)
 return x6Y12

def x6Y12():
 stack.append(1)
 return x5Y12

def x5Y12():
 stack.append(1)
 return x4Y12

def x4Y12():
 a,b = pop2()
 a is not None and psh(b+a)
 return x3Y12

def x3Y12():
 stack.append(1)
 return x2Y12

def x2Y12():
 a = pop()
 return [x1Y12, X1Y12, x1y12, X1y12][0 if a is None else (a%4+4)%4]

def x1Y12():
 pop()
 return x0Y12

def X1Y12():
 a = pop()
 a is not None and psh(a,a)
 return X1Y11

def x1y12():
 a = pop()
 return [x2y12, y12x2][1 if a is None else a&1]

def X1y12():
 pop()
 return Y12x0

def Y12x0():
 a = pop()
 a is not None and psh(a,a)
 return X0Y11

def X0Y11():
 a = pop()
 return [X0Y10, Y10X0][1 if a is None else a&1]

def x2y12():
 pop()
 return x3y12

def y12x2():
 pop()
 return y12x3

def y12x3():
 a = input()
 psh(ord(a))
 return y12x4

def y12x4():
 pop()
 return y12x5

def y12x5():
 pop()
 return y12x6

def y12x6():
 a,b = pop2()
 a is not None and a!=0 and psh(b//a)
 return y12x7

def y12x7():
 a,b = pop2()
 a is not None and psh(b-a)
 return y12x8

def y12x8():
 a = input()
 psh(ord(a))
 return y12x9

def y12x9():
 pop()
 return y12x10

def y12x10():
 a,b = pop2()
 a is not None and a!=0 and psh(b//a)
 return y12x11

def y12x11():
 a = pop()
 a is not None and print(a, sep='', end='', flush=1)
 return y12x12

def x3y12():
 a = input()
 psh(ord(a))
 return x4y12

def x4y12():
 pop()
 return x5y12

def x5y12():
 pop()
 return x6y12

def x6y12():
 a,b = pop2()
 a is not None and a!=0 and psh(b//a)
 return x7y12

def x7y12():
 a,b = pop2()
 a is not None and psh(b-a)
 return x8y12

def x8y12():
 a = input()
 psh(ord(a))
 return x9y12

def x9y12():
 pop()
 return x10y12

def x10y12():
 a,b = pop2()
 a is not None and a!=0 and psh(b//a)
 return x11y12

def x11y12():
 a = pop()
 a is not None and print(a, sep='', end='', flush=1)
 return x12y12

def X1Y11():
 a = pop()
 a is not None and psh(a,a)
 return X1Y10

def X1Y10():
 a,b = pop2()
 a is not None and psh(b+a)
 return X1Y9

def X1Y9():
 a,b = pop2()
 a is not None and psh(b*a)
 return X1Y8

def X1Y8():
 a,b = pop2()
 a is not None and psh(b+a)
 return X1Y7

def X1Y7():
 a = pop()
 a is not None and psh(a,a)
 return X1Y6

def X1Y6():
 a = pop()
 a is not None and psh(a,a)
 return X1Y5

def X1Y5():
 a = pop()
 a is not None and psh(a,a)
 return X1Y4

def X1Y4():
 a = pop()
 a is not None and print(chr(a&255), sep='', end='', flush=1)
 return X1Y3

def X1Y3():
 stack.append(1)
 return X1Y2

def X1Y2():
 a = pop()
 return [X1Y1, x1y1, X1y1, x1Y1][0 if a is None else (a%4+4)%4]

def X1Y1():
 stack.append(1)
 return X1Y0

def x1y1():
 a = pop()
 a is not None and print(chr(a&255), sep='', end='', flush=1)
 return x2y1

def X1y1():
 a = pop()
 return [X1y2, y2X1][1 if a is None else a&1]

def x1Y1():
 a,b = pop2()
 a is not None and a!=0 and psh(b%a)
 return x0Y1

def X1y2():
 pop()
 return X1y3

def y2X1():
 pop()
 return y3X1

def y3X1():
 a,b = pop2()
 a is not None and psh(b-a)
 return y4X1

def y4X1():
 a,b = pop2()
 a is not None and a!=0 and psh(b//a)
 return y5X1

def y5X1():
 a,b = pop2()
 a is not None and a!=0 and psh(b//a)
 return y6X1

def y6X1():
 a,b = pop2()
 a is not None and a!=0 and psh(b//a)
 return y7X1

def y7X1():
 a = input()
 psh(ord(a))
 return y8X1

def y8X1():
 a = pop()
 a is not None and print(a, sep='', end='', flush=1)
 return y9X1

def y9X1():
 a = input()
 psh(ord(a))
 return y10X1

def y10X1():
 a,b = pop2()
 a is not None and a!=0 and psh(b//a)
 return y11X1

def y11X1():
 a,b = pop2()
 a is not None and a!=0 and psh(b//a)
 return y12X1

def X1y3():
 a,b = pop2()
 a is not None and psh(b-a)
 return X1y4

def X1y4():
 a,b = pop2()
 a is not None and a!=0 and psh(b//a)
 return X1y5

def X1y5():
 a,b = pop2()
 a is not None and a!=0 and psh(b//a)
 return X1y6

def X1y6():
 a,b = pop2()
 a is not None and a!=0 and psh(b//a)
 return X1y7

def X1y7():
 a = input()
 psh(ord(a))
 return X1y8

def X1y8():
 a = pop()
 a is not None and print(a, sep='', end='', flush=1)
 return X1y9

def X1y9():
 a = input()
 psh(ord(a))
 return X1y10

def X1y10():
 a,b = pop2()
 a is not None and a!=0 and psh(b//a)
 return X1y11

def X1y11():
 a,b = pop2()
 a is not None and a!=0 and psh(b//a)
 return X1y12

def x2y1():
 stack.append(1)
 return x3y1

def x3y1():
 stack.append(1)
 return x4y1

def x4y1():
 a,b = pop2()
 a is not None and psh(b+a)
 return x5y1

def x5y1():
 stack.append(1)
 return x6y1

def x6y1():
 a,b = pop2()
 a is not None and psh(b+a)
 return x7y1

def x7y1():
 stack.append(1)
 return x8y1

def x8y1():
 pop()
 return x9y1

def x9y1():
 stack.append(1)
 return x10y1

def x10y1():
 a = pop()
 return [x11y1, X11y1, x11Y1, X11Y1][0 if a is None else (a%4+4)%4]

def x11y1():
 a = pop()
 a is not None and psh(a,a)
 return x12y1

def X11y1():
 a = pop()
 a is not None and psh(a,a)
 return X11y2

def x11Y1():
 a = pop()
 return [x10Y1, Y1x10][1 if a is None else a&1]

def X11Y1():
 a = pop()
 return [X11Y0, Y0X11][1 if a is None else a&1]

def X11Y0():
 a = pop()
 return [y0x12, y0X12, Y0x12, Y0X12][0 if a is None else (a%4+4)%4]

def Y0X11():
 a = pop()
 return [x12y0, X12y0, x12Y0, X12Y0][0 if a is None else (a%4+4)%4]

def x12y0():
 a = pop()
 a is not None and psh(a,a)
 return y1X12

def X12y0():
 a = pop()
 a is not None and psh(a,a)
 return X12y1

def x12Y0():
 a = pop()
 return [x11Y0, Y0x11][1 if a is None else a&1]

def X12Y0():
 a = pop()
 a is not None and psh(a,a)
 return X12y1

def X12y1():
 a,b = pop2()
 a is not None and psh(b*a)
 return X12y2

def X12y2():
 a,b = pop2()
 a is not None and psh(b+a)
 return X12y3

def X12y3():
 a = pop()
 a is not None and print(chr(a&255), sep='', end='', flush=1)
 return X12y4

def X12y4():
 stack.append(1)
 return X12y5

def X12y5():
 stack.append(1)
 return X12y6

def X12y6():
 a,b = pop2()
 a is not None and psh(b+a)
 return X12y7

def X12y7():
 a,b = pop2()
 a is not None and psh(b+a)
 return X12y8

def X12y8():
 a = pop()
 a is not None and psh(a,a)
 return X12y9

def X12y9():
 a = pop()
 a is not None and psh(a,a)
 return X12y10

def X12y10():
 stack.append(1)
 return X12y11

def X12y11():
 a = pop()
 return [X12y12, x12Y12, X12Y12, x12y12][0 if a is None else (a%4+4)%4]

def x11Y0():
 pop()
 return x10Y0

def Y0x11():
 pop()
 return Y0x10

def Y0x10():
 a,b = pop2()
 a is not None and a!=0 and psh(b//a)
 return Y0x9

def Y0x9():
 a,b = pop2()
 a is not None and a!=0 and psh(b//a)
 return Y0x8

def Y0x8():
 a = pop()
 a is not None and print(a, sep='', end='', flush=1)
 return Y0x7

def Y0x7():
 a = input()
 psh(ord(a))
 return Y0x6

def Y0x6():
 a,b = pop2()
 a is not None and a!=0 and psh(b//a)
 return Y0x5

def Y0x5():
 a,b = pop2()
 a is not None and a!=0 and psh(b//a)
 return Y0x4

def Y0x4():
 a = input()
 psh(ord(a))
 return Y0x3

def Y0x3():
 pop()
 return Y0x2

def Y0x2():
 pop()
 return Y0x1

def Y0x1():
 a = pop()
 return [Y0x0, Y0X0, y0x0, y0X0][0 if a is None else (a%4+4)%4]

def Y0x0():
 a = pop()
 return [y0x1, x1y0][1 if a is None else a&1]

def y0x0():
 a = pop()
 return [y0x1, x1y0][1 if a is None else a&1]

def y0X0():
 a = pop()
 a is not None and print(chr(a&255), sep='', end='', flush=1)
 return y1X0

def y1X0():
 a = pop()
 return [y2X0, X0y2][1 if a is None else a&1]

def x10Y0():
 a,b = pop2()
 a is not None and a!=0 and psh(b//a)
 return x9Y0

def x9Y0():
 a,b = pop2()
 a is not None and a!=0 and psh(b//a)
 return x8Y0

def x8Y0():
 a = pop()
 a is not None and print(a, sep='', end='', flush=1)
 return x7Y0

def x7Y0():
 a = input()
 psh(ord(a))
 return x6Y0

def x6Y0():
 a,b = pop2()
 a is not None and a!=0 and psh(b//a)
 return x5Y0

def x5Y0():
 a,b = pop2()
 a is not None and a!=0 and psh(b//a)
 return x4Y0

def x4Y0():
 a = input()
 psh(ord(a))
 return x3Y0

def x3Y0():
 pop()
 return x2Y0

def x2Y0():
 pop()
 return x1Y0

def x1Y0():
 a = pop()
 return [x0Y0, X0Y0, x0y0, X0y0][0 if a is None else (a%4+4)%4]

def x0Y0():
 a = pop()
 return [x1y0, y0x1][1 if a is None else a&1]

def X0Y0():
 a = pop()
 return [y0x1, x1y0][1 if a is None else a&1]

def X0y0():
 a = pop()
 a is not None and print(chr(a&255), sep='', end='', flush=1)
 return X0y1

def x10Y1():
 pop()
 return x9Y1

def Y1x10():
 pop()
 return Y1x9

def Y1x9():
 stack.append(1)
 return Y1x8

def Y1x8():
 pop()
 return Y1x7

def Y1x7():
 a = input()
 psh(ord(a))
 return Y1x6

def Y1x6():
 pop()
 return Y1x5

def Y1x5():
 a = input()
 psh(ord(a))
 return Y1x4

def Y1x4():
 pop()
 return Y1x3

def Y1x3():
 pop()
 return Y1x2

def Y1x2():
 a,b = pop2()
 a is not None and psh(b-a)
 return Y1x1

def Y1x1():
 a,b = pop2()
 a is not None and a!=0 and psh(b%a)
 return Y1x0

def Y1x0():
 a,b = pop2()
 a is not None and psh(b-a)
 return X0Y0

def x9Y1():
 stack.append(1)
 return x8Y1

def x8Y1():
 pop()
 return x7Y1

def x7Y1():
 a = input()
 psh(ord(a))
 return x6Y1

def x6Y1():
 pop()
 return x5Y1

def x5Y1():
 a = input()
 psh(ord(a))
 return x4Y1

def x4Y1():
 pop()
 return x3Y1

def x3Y1():
 pop()
 return x2Y1

def x2Y1():
 a,b = pop2()
 a is not None and psh(b-a)
 return x1Y1

def X11y2():
 a = pop()
 a is not None and psh(a,a)
 return X11y3

def X11y3():
 stack.append(1)
 return X11y4

def X11y4():
 stack.append(1)
 return X11y5

def X11y5():
 a,b = pop2()
 a is not None and psh(b+a)
 return X11y6

def X11y6():
 a,b = pop2()
 a is not None and rll(a,b)
 return X11y7

def X11y7():
 a,b = pop2()
 a is not None and psh(b+a)
 return X11y8

def X11y8():
 a = pop()
 a is not None and psh(a,a)
 return X11y9

def X11y9():
 stack.append(1)
 return X11y10

def X11y10():
 a = pop()
 return [X11y11, x11Y11, X11Y11, x11y11][0 if a is None else (a%4+4)%4]

def X11y11():
 a = psh(int(input()))
 return X11y12

def x11Y11():
 a = pop()
 a is not None and psh(a,a)
 return x10Y11

def X11Y11():
 a = pop()
 return [X11Y10, Y10X11][1 if a is None else a&1]

def X11Y10():
 pop()
 return X11Y9

def Y10X11():
 pop()
 return Y9X11

def Y9X11():
 a,b = pop2()
 a is not None and a!=0 and psh(b//a)
 return Y8X11

def Y8X11():
 a = input()
 psh(ord(a))
 return Y7X11

def Y7X11():
 a = pop()
 a is not None and psh(int(not a))
 return Y6X11

def Y6X11():
 a = input()
 psh(ord(a))
 return Y5X11

def Y5X11():
 pop()
 return Y4X11

def Y4X11():
 pop()
 return Y3X11

def Y3X11():
 a,b = pop2()
 a is not None and a!=0 and psh(b//a)
 return Y2X11

def Y2X11():
 a,b = pop2()
 a is not None and a!=0 and psh(b//a)
 return Y1X11

def Y1X11():
 a = pop()
 return [Y0X11, X11Y0][1 if a is None else a&1]

def X11Y9():
 a,b = pop2()
 a is not None and a!=0 and psh(b//a)
 return X11Y8

def X11Y8():
 a = input()
 psh(ord(a))
 return X11Y7

def X11Y7():
 a = pop()
 a is not None and psh(int(not a))
 return X11Y6

def X11Y6():
 a = input()
 psh(ord(a))
 return X11Y5

def X11Y5():
 pop()
 return X11Y4

def X11Y4():
 pop()
 return X11Y3

def X11Y3():
 a,b = pop2()
 a is not None and a!=0 and psh(b//a)
 return X11Y2

def X11Y2():
 a,b = pop2()
 a is not None and a!=0 and psh(b//a)
 return X11Y1

def x10Y11():
 a = pop()
 a is not None and print(chr(a&255), sep='', end='', flush=1)
 return x9Y11

def x9Y11():
 a = pop()
 a is not None and psh(a,a)
 return x8Y11

def x8Y11():
 stack.append(1)
 return x7Y11

def x7Y11():
 stack.append(1)
 return x6Y11

def x6Y11():
 stack.append(1)
 return x5Y11

def x5Y11():
 pop()
 return x4Y11

def x4Y11():
 stack.append(1)
 return x3Y11

def x3Y11():
 a = pop()
 return [x2Y11, X2Y11, x2y11, X2y11][0 if a is None else (a%4+4)%4]

def x2Y11():
 a = pop()
 a is not None and psh(a,a)
 return x1Y11

def X2Y11():
 stack.append(1)
 return X2Y10

def x2y11():
 a = pop()
 return [x3y11, y11x3][1 if a is None else a&1]

def X2y11():
 a = pop()
 return [X2y12, y12X2][1 if a is None else a&1]

def X2y12():
 a = pop()
 return [Y12x1, Y12X1, y12x1, y12X1][0 if a is None else (a%4+4)%4]

def y12X2():
 a = pop()
 return [x1Y12, X1Y12, x1y12, X1y12][0 if a is None else (a%4+4)%4]

def X2Y10():
 pop()
 return X2Y9

def X2Y9():
 a,b = pop2()
 a is not None and psh(b+a)
 return X2Y8

def X2Y8():
 a = pop()
 a is not None and psh(a,a)
 return X2Y7

def X2Y7():
 a = pop()
 a is not None and psh(a,a)
 return X2Y6

def X2Y6():
 a,b = pop2()
 a is not None and psh(b+a)
 return X2Y5

def X2Y5():
 a = pop()
 a is not None and psh(a,a)
 return X2Y4

def X2Y4():
 stack.append(1)
 return X2Y3

def X2Y3():
 a = pop()
 return [X2Y2, x2y2, X2y2, x2Y2][0 if a is None else (a%4+4)%4]

def X2Y2():
 a,b = pop2()
 a is not None and psh(b+a)
 return X2Y1

def x2y2():
 a = pop()
 a is not None and psh(a,a)
 return x3y2

def X2y2():
 a = pop()
 return [X2y3, y3X2][1 if a is None else a&1]

def x2Y2():
 a = input()
 psh(ord(a))
 return x1Y2

def x1Y2():
 a,b = pop2()
 a is not None and a!=0 and psh(b%a)
 return x0Y2

def x0Y2():
 a = pop()
 return [Y1X0, y1x0, y1X0, Y1x0][0 if a is None else (a%4+4)%4]

def Y1X0():
 a,b = pop2()
 a is not None and psh(b-a)
 return Y0X0

def y1x0():
 a = psh(int(input()))
 return y1x1

def y1x1():
 a = pop()
 a is not None and print(chr(a&255), sep='', end='', flush=1)
 return y1x2

def y1x2():
 stack.append(1)
 return y1x3

def y1x3():
 stack.append(1)
 return y1x4

def y1x4():
 a,b = pop2()
 a is not None and psh(b+a)
 return y1x5

def y1x5():
 stack.append(1)
 return y1x6

def y1x6():
 a,b = pop2()
 a is not None and psh(b+a)
 return y1x7

def y1x7():
 stack.append(1)
 return y1x8

def y1x8():
 pop()
 return y1x9

def y1x9():
 stack.append(1)
 return y1x10

def y1x10():
 a = pop()
 return [y1x11, y1X11, Y1x11, Y1X11][0 if a is None else (a%4+4)%4]

def y1x11():
 a = pop()
 a is not None and psh(a,a)
 return y1x12

def y1X11():
 a = pop()
 a is not None and psh(a,a)
 return y2X11

def Y1x11():
 a = pop()
 return [Y1x10, x10Y1][1 if a is None else a&1]

def y2X11():
 a = pop()
 a is not None and psh(a,a)
 return y3X11

def y3X11():
 stack.append(1)
 return y4X11

def y4X11():
 stack.append(1)
 return y5X11

def y5X11():
 a,b = pop2()
 a is not None and psh(b+a)
 return y6X11

def y6X11():
 a,b = pop2()
 a is not None and rll(a,b)
 return y7X11

def y7X11():
 a,b = pop2()
 a is not None and psh(b+a)
 return y8X11

def y8X11():
 a = pop()
 a is not None and psh(a,a)
 return y9X11

def y9X11():
 stack.append(1)
 return y10X11

def y10X11():
 a = pop()
 return [y11X11, Y11x11, Y11X11, y11x11][0 if a is None else (a%4+4)%4]

def y11X11():
 a = psh(int(input()))
 return y12X11

def Y11x11():
 a = pop()
 a is not None and psh(a,a)
 return Y11x10

def Y11X11():
 a = pop()
 return [Y10X11, X11Y10][1 if a is None else a&1]

def Y11x10():
 a = pop()
 a is not None and print(chr(a&255), sep='', end='', flush=1)
 return Y11x9

def Y11x9():
 a = pop()
 a is not None and psh(a,a)
 return Y11x8

def Y11x8():
 stack.append(1)
 return Y11x7

def Y11x7():
 stack.append(1)
 return Y11x6

def Y11x6():
 stack.append(1)
 return Y11x5

def Y11x5():
 pop()
 return Y11x4

def Y11x4():
 stack.append(1)
 return Y11x3

def Y11x3():
 a = pop()
 return [Y11x2, Y11X2, y11x2, y11X2][0 if a is None else (a%4+4)%4]

def Y11x2():
 a = pop()
 a is not None and psh(a,a)
 return Y11x1

def Y11X2():
 stack.append(1)
 return Y10X2

def y11X2():
 a = pop()
 return [y12X2, X2y12][1 if a is None else a&1]

def Y10X2():
 pop()
 return Y9X2

def Y9X2():
 a,b = pop2()
 a is not None and psh(b+a)
 return Y8X2

def Y8X2():
 a = pop()
 a is not None and psh(a,a)
 return Y7X2

def Y7X2():
 a = pop()
 a is not None and psh(a,a)
 return Y6X2

def Y6X2():
 a,b = pop2()
 a is not None and psh(b+a)
 return Y5X2

def Y5X2():
 a = pop()
 a is not None and psh(a,a)
 return Y4X2

def Y4X2():
 stack.append(1)
 return Y3X2

def Y3X2():
 a = pop()
 return [Y2X2, y2x2, y2X2, Y2x2][0 if a is None else (a%4+4)%4]

def Y2X2():
 a,b = pop2()
 a is not None and psh(b+a)
 return Y1X2

def y2x2():
 a = pop()
 a is not None and psh(a,a)
 return y2x3

def y2X2():
 a = pop()
 return [y3X2, X2y3][1 if a is None else a&1]

def Y2x2():
 a = input()
 psh(ord(a))
 return Y2x1

def Y2x1():
 a,b = pop2()
 a is not None and a!=0 and psh(b%a)
 return Y2x0

def Y2x0():
 a = pop()
 return [X0Y1, x0y1, X0y1, x0Y1][0 if a is None else (a%4+4)%4]

def y3X2():
 pop()
 return y4X2

def X2y3():
 pop()
 return X2y4

def X2y4():
 a,b = pop2()
 a is not None and a!=0 and psh(b//a)
 return X2y5

def X2y5():
 a = input()
 psh(ord(a))
 return X2y6

def X2y6():
 a,b = pop2()
 a is not None and a!=0 and psh(b//a)
 return X2y7

def X2y7():
 a,b = pop2()
 a is not None and a!=0 and psh(b//a)
 return X2y8

def X2y8():
 a = input()
 psh(ord(a))
 return X2y9

def X2y9():
 stack.append(1)
 return X2y10

def X2y10():
 pop()
 return X2y11

def y4X2():
 a,b = pop2()
 a is not None and a!=0 and psh(b//a)
 return y5X2

def y5X2():
 a = input()
 psh(ord(a))
 return y6X2

def y6X2():
 a,b = pop2()
 a is not None and a!=0 and psh(b//a)
 return y7X2

def y7X2():
 a,b = pop2()
 a is not None and a!=0 and psh(b//a)
 return y8X2

def y8X2():
 a = input()
 psh(ord(a))
 return y9X2

def y9X2():
 stack.append(1)
 return y10X2

def y10X2():
 pop()
 return y11X2

def y2x3():
 a,b = pop2()
 a is not None and psh(b*a)
 return y2x4

def y2x4():
 a = pop()
 a is not None and psh(a,a)
 return y2x5

def y2x5():
 a,b = pop2()
 a is not None and psh(b+a)
 return y2x6

def y2x6():
 a = pop()
 a is not None and psh(a,a)
 return y2x7

def y2x7():
 stack.append(1)
 return y2x8

def y2x8():
 stack.append(1)
 return y2x9

def y2x9():
 a = pop()
 return [y2x10, y2X10, Y2x10, Y2X10][0 if a is None else (a%4+4)%4]

def y2x10():
 a = input()
 psh(ord(a))
 return y2x11

def y2X10():
 stack.append(1)
 return y3X10

def Y2x10():
 a = pop()
 return [Y2x9, x9Y2][1 if a is None else a&1]

def Y2X10():
 a = psh(int(input()))
 return Y1X10

def Y1X10():
 pop()
 return Y0X10

def Y0X10():
 stack.append(1)
 return x11y0

def x11y0():
 a = pop()
 return [x12y0, X12y0, x12Y0, X12Y0][0 if a is None else (a%4+4)%4]

def Y2x9():
 pop()
 return Y2x8

def x9Y2():
 pop()
 return x8Y2

def x8Y2():
 pop()
 return x7Y2

def x7Y2():
 a,b = pop2()
 a is not None and a!=0 and psh(b//a)
 return x6Y2

def x6Y2():
 a = input()
 psh(ord(a))
 return x5Y2

def x5Y2():
 a,b = pop2()
 a is not None and a!=0 and psh(b//a)
 return x4Y2

def x4Y2():
 a = pop()
 a is not None and print(a, sep='', end='', flush=1)
 return x3Y2

def x3Y2():
 a,b = pop2()
 a is not None and a!=0 and psh(b//a)
 return x2Y2

def Y2x8():
 pop()
 return Y2x7

def Y2x7():
 a,b = pop2()
 a is not None and a!=0 and psh(b//a)
 return Y2x6

def Y2x6():
 a = input()
 psh(ord(a))
 return Y2x5

def Y2x5():
 a,b = pop2()
 a is not None and a!=0 and psh(b//a)
 return Y2x4

def Y2x4():
 a = pop()
 a is not None and print(a, sep='', end='', flush=1)
 return Y2x3

def Y2x3():
 a,b = pop2()
 a is not None and a!=0 and psh(b//a)
 return Y2x2

def y3X10():
 a,b = pop2()
 a is not None and psh(b+a)
 return y4X10

def y4X10():
 a = pop()
 a is not None and psh(a,a)
 return y5X10

def y5X10():
 a,b = pop2()
 a is not None and psh(b+a)
 return y6X10

def y6X10():
 a = pop()
 a is not None and psh(a,a)
 return y7X10

def y7X10():
 a = pop()
 a is not None and psh(a,a)
 return y8X10

def y8X10():
 stack.append(1)
 return y9X10

def y9X10():
 a = pop()
 return [y10X10, Y10x10, Y10X10, y10x10][0 if a is None else (a%4+4)%4]

def y10X10():
 a = pop()
 return [y11X10, X10y11][1 if a is None else a&1]

def Y10x10():
 a,b = pop2()
 a is not None and psh(b+a)
 return Y10x9

def Y10X10():
 a = pop()
 return [Y9X10, X10Y9][1 if a is None else a&1]

def y10x10():
 a,b = pop2()
 a is not None and a!=0 and psh(b%a)
 return y10x11

def y10x11():
 a = pop()
 return [y10x12, x12y10][1 if a is None else a&1]

def y10x12():
 stack.append(1)
 return X12y11

def x12y10():
 stack.append(1)
 return y11X12

def Y9X10():
 pop()
 return Y8X10

def X10Y9():
 pop()
 return X10Y8

def X10Y8():
 a,b = pop2()
 a is not None and a!=0 and psh(b//a)
 return X10Y7

def X10Y7():
 a,b = pop2()
 a is not None and a!=0 and psh(b//a)
 return X10Y6

def X10Y6():
 a = input()
 psh(ord(a))
 return X10Y5

def X10Y5():
 a,b = pop2()
 a is not None and a!=0 and psh(b//a)
 return X10Y4

def X10Y4():
 a = input()
 psh(ord(a))
 return X10Y3

def X10Y3():
 pop()
 return X10Y2

def X10Y2():
 a = psh(int(input()))
 return X10Y1

def X10Y1():
 pop()
 return X10Y0

def X10Y0():
 stack.append(1)
 return y0x11

def Y8X10():
 a,b = pop2()
 a is not None and a!=0 and psh(b//a)
 return Y7X10

def Y7X10():
 a,b = pop2()
 a is not None and a!=0 and psh(b//a)
 return Y6X10

def Y6X10():
 a = input()
 psh(ord(a))
 return Y5X10

def Y5X10():
 a,b = pop2()
 a is not None and a!=0 and psh(b//a)
 return Y4X10

def Y4X10():
 a = input()
 psh(ord(a))
 return Y3X10

def Y3X10():
 pop()
 return Y2X10

def Y10x9():
 a,b = pop2()
 a is not None and psh(b+a)
 return Y10x8

def Y10x8():
 a,b = pop2()
 a is not None and psh(b+a)
 return Y10x7

def Y10x7():
 a = pop()
 a is not None and print(chr(a&255), sep='', end='', flush=1)
 return Y10x6

def Y10x6():
 a = pop()
 return [Y9x5, x5Y9][1 if a is None else a&1]

def Y9x5():
 pop()
 return Y9x4

def x5Y9():
 pop()
 return x4Y9

def x4Y9():
 pop()
 return x3Y9

def x3Y9():
 a = pop()
 a is not None and psh(a,a)
 return x2Y9

def x2Y9():
 a,b = pop2()
 a is not None and psh(int(b>a))
 return x1Y9

def x1Y9():
 a = pop()
 return [x0Y9, Y9x0][1 if a is None else a&1]

def x0Y9():
 pop()
 return Y8X0

def Y9x0():
 pop()
 return X0Y8

def Y8X0():
 a,b = pop2()
 a is not None and a!=0 and psh(b//a)
 return Y7X0

def Y7X0():
 a,b = pop2()
 a is not None and a!=0 and psh(b//a)
 return Y6X0

def Y6X0():
 a,b = pop2()
 a is not None and psh(int(b>a))
 return Y5X0

def Y5X0():
 a = psh(int(input()))
 return Y4X0

def Y4X0():
 a,b = pop2()
 a is not None and psh(b-a)
 return Y3X0

def Y3X0():
 pop()
 return Y2X0

def Y2X0():
 a = pop()
 return [Y1X0, y1x0, y1X0, Y1x0][0 if a is None else (a%4+4)%4]

def Y9x4():
 pop()
 return Y9x3

def Y9x3():
 a = pop()
 a is not None and psh(a,a)
 return Y9x2

def Y9x2():
 a,b = pop2()
 a is not None and psh(int(b>a))
 return Y9x1

def Y9x1():
 a = pop()
 return [Y9x0, x0Y9][1 if a is None else a&1]

def y11X10():
 a = psh(int(input()))
 return y12X10

def X10y11():
 a = psh(int(input()))
 return X10y12

def X10y12():
 stack.append(1)
 return Y12x9

def y12X10():
 stack.append(1)
 return x9Y12

def y2x11():
 a,b = pop2()
 a is not None and psh(b*a)
 return y2x12

def y2x12():
 a,b = pop2()
 a is not None and psh(b+a)
 return X12y3

def Y1X2():
 a,b = pop2()
 a is not None and psh(b+a)
 return Y0X2

def Y0X2():
 stack.append(1)
 return x3y0

def x3y0():
 a,b = pop2()
 a is not None and psh(b+a)
 return x4y0

def x4y0():
 a = pop()
 a is not None and psh(a,a)
 return x5y0

def x5y0():
 a = pop()
 a is not None and psh(a,a)
 return x6y0

def x6y0():
 a,b = pop2()
 a is not None and psh(b+a)
 return x7y0

def x7y0():
 a,b = pop2()
 a is not None and psh(b*a)
 return x8y0

def x8y0():
 a = pop()
 a is not None and psh(a,a)
 return x9y0

def x9y0():
 a = pop()
 a is not None and psh(a,a)
 return x10y0

def x10y0():
 stack.append(1)
 return x11y0

def Y11x1():
 pop()
 return Y11x0

def y12X11():
 a = pop()
 a is not None and psh(a,a)
 return x10Y12

def y1x12():
 a,b = pop2()
 a is not None and psh(b*a)
 return X12y2

def x3y2():
 a,b = pop2()
 a is not None and psh(b*a)
 return x4y2

def x4y2():
 a = pop()
 a is not None and psh(a,a)
 return x5y2

def x5y2():
 a,b = pop2()
 a is not None and psh(b+a)
 return x6y2

def x6y2():
 a = pop()
 a is not None and psh(a,a)
 return x7y2

def x7y2():
 stack.append(1)
 return x8y2

def x8y2():
 stack.append(1)
 return x9y2

def x9y2():
 a = pop()
 return [x10y2, X10y2, x10Y2, X10Y2][0 if a is None else (a%4+4)%4]

def x10y2():
 a = input()
 psh(ord(a))
 return x11y2

def X10y2():
 stack.append(1)
 return X10y3

def x10Y2():
 a = pop()
 return [x9Y2, Y2x9][1 if a is None else a&1]

def X10y3():
 a,b = pop2()
 a is not None and psh(b+a)
 return X10y4

def X10y4():
 a = pop()
 a is not None and psh(a,a)
 return X10y5

def X10y5():
 a,b = pop2()
 a is not None and psh(b+a)
 return X10y6

def X10y6():
 a = pop()
 a is not None and psh(a,a)
 return X10y7

def X10y7():
 a = pop()
 a is not None and psh(a,a)
 return X10y8

def X10y8():
 stack.append(1)
 return X10y9

def X10y9():
 a = pop()
 return [X10y10, x10Y10, X10Y10, x10y10][0 if a is None else (a%4+4)%4]

def X10y10():
 a = pop()
 return [X10y11, y11X10][1 if a is None else a&1]

def x10Y10():
 a,b = pop2()
 a is not None and psh(b+a)
 return x9Y10

def X10Y10():
 a = pop()
 return [X10Y9, Y9X10][1 if a is None else a&1]

def x10y10():
 a,b = pop2()
 a is not None and a!=0 and psh(b%a)
 return x11y10

def x11y10():
 a = pop()
 return [x12y10, y10x12][1 if a is None else a&1]

def x9Y10():
 a,b = pop2()
 a is not None and psh(b+a)
 return x8Y10

def x8Y10():
 a,b = pop2()
 a is not None and psh(b+a)
 return x7Y10

def x7Y10():
 a = pop()
 a is not None and print(chr(a&255), sep='', end='', flush=1)
 return x6Y10

def x6Y10():
 a = pop()
 a is not None and print(chr(a&255), sep='', end='', flush=1)
 return x5Y10

def x5Y10():
 stack.append(1)
 return x4Y10

def x4Y10():
 a = pop()
 return [x3Y10, X3Y10, x3y10, X3y10][0 if a is None else (a%4+4)%4]

def x3Y10():
 a = input()
 psh(ord(a))
 return x2Y10

def X3Y10():
 a,b = pop2()
 a is not None and psh(b*a)
 return X3Y9

def x3y10():
 a = pop()
 return [x4y10, y10x4][1 if a is None else a&1]

def X3y10():
 a,b = pop2()
 a is not None and a!=0 and psh(b%a)
 return X3y11

def X3y11():
 pop()
 return X3y12

def X3y12():
 stack.append(1)
 return Y12x2

def x4y10():
 pop()
 return x5y10

def y10x4():
 pop()
 return y10x5

def y10x5():
 a,b = pop2()
 a is not None and psh(b-a)
 return y10x6

def y10x6():
 a,b = pop2()
 a is not None and psh(b-a)
 return y10x7

def y10x7():
 a = input()
 psh(ord(a))
 return y10x8

def y10x8():
 a = input()
 psh(ord(a))
 return y10x9

def y10x9():
 a = input()
 psh(ord(a))
 return y10x10

def x5y10():
 a,b = pop2()
 a is not None and psh(b-a)
 return x6y10

def x6y10():
 a = pop()
 return [x7y9, y9x7][1 if a is None else a&1]

def x7y9():
 pop()
 return x8y9

def y9x7():
 pop()
 return y9x8

def y9x8():
 a = input()
 psh(ord(a))
 return y9x9

def y9x9():
 a = pop()
 a is not None and print(chr(a&255), sep='', end='', flush=1)
 return y9x10

def y9x10():
 a = pop()
 a is not None and print(a, sep='', end='', flush=1)
 return y9x11

def y9x11():
 a = input()
 psh(ord(a))
 return y9x12

def y9x12():
 a = pop()
 a is not None and psh(a,a)
 return X12y10

def x8y9():
 a = input()
 psh(ord(a))
 return x9y9

def x9y9():
 a = pop()
 a is not None and print(chr(a&255), sep='', end='', flush=1)
 return x10y9

def x10y9():
 a = pop()
 a is not None and print(a, sep='', end='', flush=1)
 return x11y9

def x11y9():
 a = input()
 psh(ord(a))
 return x12y9

def x12y9():
 a = pop()
 a is not None and psh(a,a)
 return y10X12

def X3Y9():
 a,b = pop2()
 a is not None and psh(b+a)
 return X3Y8

def X3Y8():
 a = pop()
 a is not None and print(chr(a&255), sep='', end='', flush=1)
 return X3Y7

def X3Y7():
 a = pop()
 a is not None and print(chr(a&255), sep='', end='', flush=1)
 return X3Y6

def X3Y6():
 a,b = pop2()
 a is not None and psh(b+a)
 return X3Y5

def X3Y5():
 stack.append(1)
 return X3Y4

def X3Y4():
 a = pop()
 return [X3Y3, x3y3, X3y3, x3Y3][0 if a is None else (a%4+4)%4]

def X3Y3():
 a = psh(int(input()))
 return X3Y2

def x3y3():
 a = pop()
 a is not None and print(chr(a&255), sep='', end='', flush=1)
 return x4y3

def X3y3():
 a = pop()
 return [X3y4, y4X3][1 if a is None else a&1]

def x3Y3():
 a = pop()
 return [x2Y3, X2Y3, x2y3, X2y3][0 if a is None else (a%4+4)%4]

def x2Y3():
 a,b = pop2()
 a is not None and a!=0 and psh(b//a)
 return x1Y3

def x2y3():
 a = pop()
 return [x3y3, y3x3][1 if a is None else a&1]

def y3x3():
 a = pop()
 a is not None and print(chr(a&255), sep='', end='', flush=1)
 return y3x4

def y3x4():
 a = pop()
 a is not None and print(chr(a&255), sep='', end='', flush=1)
 return y3x5

def y3x5():
 a = pop()
 a is not None and psh(a,a)
 return y3x6

def y3x6():
 a = pop()
 a is not None and print(chr(a&255), sep='', end='', flush=1)
 return y3x7

def y3x7():
 stack.append(1)
 return y3x8

def y3x8():
 a = pop()
 return [y3x9, y3X9, Y3x9, Y3X9][0 if a is None else (a%4+4)%4]

def y3x9():
 a,b = pop2()
 a is not None and psh(b+a)
 return y3x10

def y3X9():
 stack.append(1)
 return y4X9

def Y3x9():
 a = pop()
 return [Y3x8, x8Y3][1 if a is None else a&1]

def Y3X9():
 a,b = pop2()
 a is not None and rll(a,b)
 return Y2X9

def Y2X9():
 a,b = pop2()
 a is not None and psh(b*a)
 return Y1X9

def Y1X9():
 a,b = pop2()
 a is not None and a!=0 and psh(b//a)
 return Y0X9

def Y0X9():
 a = pop()
 a is not None and psh(a,a)
 return x10y0

def Y3x8():
 pop()
 return Y3x7

def x8Y3():
 pop()
 return x7Y3

def x7Y3():
 a,b = pop2()
 a is not None and psh(b-a)
 return x6Y3

def x6Y3():
 a,b = pop2()
 a is not None and a!=0 and psh(b//a)
 return x5Y3

def x5Y3():
 a,b = pop2()
 a is not None and psh(b-a)
 return x4Y3

def x4Y3():
 a,b = pop2()
 a is not None and psh(b-a)
 return x3Y3

def Y3x7():
 a,b = pop2()
 a is not None and psh(b-a)
 return Y3x6

def Y3x6():
 a,b = pop2()
 a is not None and a!=0 and psh(b//a)
 return Y3x5

def Y3x5():
 a,b = pop2()
 a is not None and psh(b-a)
 return Y3x4

def Y3x4():
 a,b = pop2()
 a is not None and psh(b-a)
 return Y3x3

def Y3x3():
 a = pop()
 return [Y3x2, Y3X2, y3x2, y3X2][0 if a is None else (a%4+4)%4]

def Y3x2():
 a,b = pop2()
 a is not None and a!=0 and psh(b//a)
 return Y3x1

def y3x2():
 a = pop()
 return [y3x3, x3y3][1 if a is None else a&1]

def Y3x1():
 a,b = pop2()
 a is not None and a!=0 and psh(b//a)
 return Y3x0

def Y3x0():
 pop()
 return X0Y2

def y4X9():
 stack.append(1)
 return y5X9

def y5X9():
 a,b = pop2()
 a is not None and psh(b+a)
 return y6X9

def y6X9():
 stack.append(1)
 return y7X9

def y7X9():
 stack.append(1)
 return y8X9

def y8X9():
 a = pop()
 return [y9X9, Y9x9, Y9X9, y9x9][0 if a is None else (a%4+4)%4]

def y9X9():
 a,b = pop2()
 a is not None and psh(int(b>a))
 return y10X9

def Y9x9():
 a,b = pop2()
 a is not None and psh(b+a)
 return Y9x8

def Y9X9():
 a = pop()
 return [Y8X9, X9Y8][1 if a is None else a&1]

def Y8X9():
 pop()
 return Y7X9

def X9Y8():
 pop()
 return X9Y7

def X9Y7():
 pop()
 return X9Y6

def X9Y6():
 a = input()
 psh(ord(a))
 return X9Y5

def X9Y5():
 pop()
 return X9Y4

def X9Y4():
 pop()
 return X9Y3

def X9Y3():
 a,b = pop2()
 a is not None and rll(a,b)
 return X9Y2

def X9Y2():
 a,b = pop2()
 a is not None and psh(b*a)
 return X9Y1

def X9Y1():
 a,b = pop2()
 a is not None and a!=0 and psh(b//a)
 return X9Y0

def X9Y0():
 a = pop()
 a is not None and psh(a,a)
 return y0x10

def Y7X9():
 pop()
 return Y6X9

def Y6X9():
 a = input()
 psh(ord(a))
 return Y5X9

def Y5X9():
 pop()
 return Y4X9

def Y4X9():
 pop()
 return Y3X9

def Y9x8():
 stack.append(1)
 return Y9x7

def Y9x7():
 a = pop()
 return [Y9x6, Y9X6, y9x6, y9X6][0 if a is None else (a%4+4)%4]

def Y9x6():
 a = pop()
 return [Y9x5, x5Y9][1 if a is None else a&1]

def Y9X6():
 a,b = pop2()
 a is not None and a!=0 and psh(b//a)
 return Y8X6

def y9x6():
 a,b = pop2()
 a is not None and psh(b-a)
 return y10x7

def y9X6():
 a,b = pop2()
 a is not None and rll(a,b)
 return y11X6

def y11X6():
 a = pop()
 a is not None and print(a, sep='', end='', flush=1)
 return y12X6

def y12X6():
 stack.append(1)
 return x5Y12

def Y8X6():
 a = pop()
 a is not None and print(chr(a&255), sep='', end='', flush=1)
 return Y7X6

def Y7X6():
 a = pop()
 a is not None and print(chr(a&255), sep='', end='', flush=1)
 return Y6X6

def Y6X6():
 return
def y10X9():
 a,b = pop2()
 a is not None and psh(b-a)
 return y11X9

def y11X9():
 a = pop()
 a is not None and print(a, sep='', end='', flush=1)
 return y12X9

def y12X9():
 a,b = pop2()
 a is not None and psh(b+a)
 return x8Y12

def y3x10():
 a = pop()
 return [y3x11, x11y3][1 if a is None else a&1]

def y3x11():
 a = psh(int(input()))
 return y3x12

def x11y3():
 a = psh(int(input()))
 return x12y3

def x12y3():
 a = pop()
 a is not None and print(chr(a&255), sep='', end='', flush=1)
 return y4X12

def y3x12():
 a = pop()
 a is not None and print(chr(a&255), sep='', end='', flush=1)
 return X12y4

def x1Y3():
 a,b = pop2()
 a is not None and a!=0 and psh(b//a)
 return x0Y3

def x0Y3():
 pop()
 return Y2X0

def X3y4():
 pop()
 return X3y5

def y4X3():
 pop()
 return y5X3

def y5X3():
 a = input()
 psh(ord(a))
 return y6X3

def y6X3():
 a,b = pop2()
 a is not None and psh(b-a)
 return y7X3

def y7X3():
 a,b = pop2()
 a is not None and psh(b-a)
 return y8X3

def y8X3():
 a = input()
 psh(ord(a))
 return y9X3

def y9X3():
 a = pop()
 a is not None and print(a, sep='', end='', flush=1)
 return y10X3

def y10X3():
 a,b = pop2()
 a is not None and a!=0 and psh(b%a)
 return y11X3

def y11X3():
 pop()
 return y12X3

def y12X3():
 stack.append(1)
 return x2Y12

def X3y5():
 a = input()
 psh(ord(a))
 return X3y6

def X3y6():
 a,b = pop2()
 a is not None and psh(b-a)
 return X3y7

def X3y7():
 a,b = pop2()
 a is not None and psh(b-a)
 return X3y8

def X3y8():
 a = input()
 psh(ord(a))
 return X3y9

def X3y9():
 a = pop()
 a is not None and print(a, sep='', end='', flush=1)
 return X3y10

def x4y3():
 a = pop()
 a is not None and print(chr(a&255), sep='', end='', flush=1)
 return x5y3

def x5y3():
 a = pop()
 a is not None and psh(a,a)
 return x6y3

def x6y3():
 a = pop()
 a is not None and print(chr(a&255), sep='', end='', flush=1)
 return x7y3

def x7y3():
 stack.append(1)
 return x8y3

def x8y3():
 a = pop()
 return [x9y3, X9y3, x9Y3, X9Y3][0 if a is None else (a%4+4)%4]

def x9y3():
 a,b = pop2()
 a is not None and psh(b+a)
 return x10y3

def X9y3():
 stack.append(1)
 return X9y4

def x9Y3():
 a = pop()
 return [x8Y3, Y3x8][1 if a is None else a&1]

def X9y4():
 stack.append(1)
 return X9y5

def X9y5():
 a,b = pop2()
 a is not None and psh(b+a)
 return X9y6

def X9y6():
 stack.append(1)
 return X9y7

def X9y7():
 stack.append(1)
 return X9y8

def X9y8():
 a = pop()
 return [X9y9, x9Y9, X9Y9, x9y9][0 if a is None else (a%4+4)%4]

def X9y9():
 a,b = pop2()
 a is not None and psh(int(b>a))
 return X9y10

def x9Y9():
 a,b = pop2()
 a is not None and psh(b+a)
 return x8Y9

def X9Y9():
 a = pop()
 return [X9Y8, Y8X9][1 if a is None else a&1]

def x8Y9():
 stack.append(1)
 return x7Y9

def x7Y9():
 a = pop()
 return [x6Y9, X6Y9, x6y9, X6y9][0 if a is None else (a%4+4)%4]

def x6Y9():
 a = pop()
 a is not None and print(chr(a&255), sep='', end='', flush=1)
 return x5Y10

def X6Y9():
 a,b = pop2()
 a is not None and a!=0 and psh(b//a)
 return X6Y8

def x6y9():
 a = pop()
 return [x7y9, y9x7][1 if a is None else a&1]

def X6y9():
 a,b = pop2()
 a is not None and rll(a,b)
 return X6y11

def X6y11():
 a = pop()
 a is not None and print(a, sep='', end='', flush=1)
 return X6y12

def X6y12():
 stack.append(1)
 return Y12x5

def X6Y8():
 a = pop()
 a is not None and print(chr(a&255), sep='', end='', flush=1)
 return X6Y7

def X6Y7():
 a = pop()
 a is not None and print(chr(a&255), sep='', end='', flush=1)
 return X6Y6

def X6Y6():
 return
def X9y10():
 a,b = pop2()
 a is not None and psh(b-a)
 return X9y11

def X9y11():
 a = pop()
 a is not None and print(a, sep='', end='', flush=1)
 return X9y12

def X9y12():
 a,b = pop2()
 a is not None and psh(b+a)
 return Y12x8

def x10y3():
 a = pop()
 return [x11y3, y3x11][1 if a is None else a&1]

def X3Y2():
 a = pop()
 return [X3Y1, x3y1, X3y1, x3Y1][0 if a is None else (a%4+4)%4]

def X3Y1():
 a,b = pop2()
 a is not None and psh(b+a)
 return X3Y0

def X3y1():
 a = pop()
 return [X3y2, y2X3][1 if a is None else a&1]

def X3y2():
 a,b = pop2()
 a is not None and a!=0 and psh(b%a)
 return X3y3

def y2X3():
 a,b = pop2()
 a is not None and a!=0 and psh(b%a)
 return y3X3

def y3X3():
 a = pop()
 return [y4X3, X3y4][1 if a is None else a&1]

def X3Y0():
 a,b = pop2()
 a is not None and psh(b+a)
 return y0x4

def x2Y10():
 a = pop()
 a is not None and psh(int(not a))
 return x1Y10

def x1Y10():
 a = pop()
 a is not None and print(a, sep='', end='', flush=1)
 return x0Y10

def x0Y10():
 a = pop()
 a is not None and print(a, sep='', end='', flush=1)
 return Y9X0

def Y9X0():
 pop()
 return Y8X0

def x11y2():
 a,b = pop2()
 a is not None and psh(b*a)
 return x12y2

def x12y2():
 a,b = pop2()
 a is not None and psh(b+a)
 return y3X12

def X2Y1():
 a,b = pop2()
 a is not None and psh(b+a)
 return X2Y0

def X2Y0():
 stack.append(1)
 return y0x3

def x1Y11():
 pop()
 return x0Y11

def x0Y11():
 a = pop()
 return [Y10X0, X0Y10][1 if a is None else a&1]

def X11y12():
 a = pop()
 a is not None and psh(a,a)
 return Y12x10

def x12y1():
 a,b = pop2()
 a is not None and psh(b*a)
 return y2X12

def X1Y0():
 stack.append(1)
 return y0x2

def X12Y11():
 pop()
 return X12Y10

def Y11X12():
 pop()
 return Y10X12

def Y10X12():
 a,b = pop2()
 a is not None and a!=0 and psh(b//a)
 return Y9X12

def Y9X12():
 a,b = pop2()
 a is not None and a!=0 and psh(b//a)
 return Y8X12

def Y8X12():
 a = input()
 psh(ord(a))
 return Y7X12

def Y7X12():
 a = input()
 psh(ord(a))
 return Y6X12

def Y6X12():
 pop()
 return Y5X12

def Y5X12():
 pop()
 return Y4X12

def Y4X12():
 a,b = pop2()
 a is not None and psh(b-a)
 return Y3X12

def Y3X12():
 a = input()
 psh(ord(a))
 return Y2X12

def Y2X12():
 a = pop()
 a is not None and print(a, sep='', end='', flush=1)
 return Y1X12

def Y1X12():
 a,b = pop2()
 a is not None and a!=0 and psh(b//a)
 return Y0X12

def X12Y10():
 a,b = pop2()
 a is not None and a!=0 and psh(b//a)
 return X12Y9

def X12Y9():
 a,b = pop2()
 a is not None and a!=0 and psh(b//a)
 return X12Y8

def X12Y8():
 a = input()
 psh(ord(a))
 return X12Y7

def X12Y7():
 a = input()
 psh(ord(a))
 return X12Y6

def X12Y6():
 pop()
 return X12Y5

def X12Y5():
 pop()
 return X12Y4

def X12Y4():
 a,b = pop2()
 a is not None and psh(b-a)
 return X12Y3

def X12Y3():
 a = input()
 psh(ord(a))
 return X12Y2

def X12Y2():
 a = pop()
 a is not None and print(a, sep='', end='', flush=1)
 return X12Y1

def X12Y1():
 a,b = pop2()
 a is not None and a!=0 and psh(b//a)
 return X12Y0

def y12X0():
 a = pop()
 a is not None and psh(a,a)
 return Y11X0

def X0y3():
 a = pop()
 a is not None and print(chr(a&255), sep='', end='', flush=1)
 return X0y4

def X0y4():
 a,b = pop2()
 a is not None and a!=0 and psh(b%a)
 return X0y5

def X0y5():
 a,b = pop2()
 a is not None and psh(int(b>a))
 return X0y6

def X0y6():
 a = pop()
 a is not None and psh(a,a)
 return X0y7

def X0y7():
 a = pop()
 a is not None and psh(a,a)
 return X0y8

def X0y8():
 stack.append(1)
 return X0y9

def X0y9():
 a,b = pop2()
 a is not None and psh(b*a)
 return X0y10

def X0y10():
 a = pop()
 return [X0y11, x0Y11, X0Y11, x0y11][0 if a is None else (a%4+4)%4]

def X0y11():
 a,b = pop2()
 a is not None and a!=0 and psh(b//a)
 return X0y12

def x0y11():
 stack.append(1)
 return x1y11

def x1y11():
 a,b = pop2()
 a is not None and a!=0 and psh(b//a)
 return x2y11

def X0y12():
 a = pop()
 a is not None and psh(a,a)
 return X0Y11

def Y11X1():
 a = pop()
 a is not None and psh(a,a)
 return Y10X1

def Y10X1():
 a,b = pop2()
 a is not None and psh(b+a)
 return Y9X1

def Y9X1():
 a,b = pop2()
 a is not None and psh(b*a)
 return Y8X1

def Y8X1():
 a,b = pop2()
 a is not None and psh(b+a)
 return Y7X1

def Y7X1():
 a = pop()
 a is not None and psh(a,a)
 return Y6X1

def Y6X1():
 a = pop()
 a is not None and psh(a,a)
 return Y5X1

def Y5X1():
 a = pop()
 a is not None and psh(a,a)
 return Y4X1

def Y4X1():
 a = pop()
 a is not None and print(chr(a&255), sep='', end='', flush=1)
 return Y3X1

def Y3X1():
 stack.append(1)
 return Y2X1

def Y2X1():
 a = pop()
 return [Y1X1, y1x1, y1X1, Y1x1][0 if a is None else (a%4+4)%4]

def Y1X1():
 stack.append(1)
 return Y0X1

def y1X1():
 a = pop()
 return [y2X1, X1y2][1 if a is None else a&1]

def Y0X1():
 stack.append(1)
 return x2y0

def x2y0():
 stack.append(1)
 return x3y0

if __name__ == "__main__":
    bounce = x0y0
    while bounce is not None:
        bounce = bounce()
