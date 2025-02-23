--[[
Representation Limits
Most programming languages represent numbers with some fixed number of bits. Therefore,
those representations have limits, both in range and in precision

Standard lua uses 64bit integers. Integers have 64 bits (8 bytes) and can represent values
up to 2^63-1, roughly 10^19. (Small lua uses 32-bit which can count up to 2 billion, approx)
The math library defines constants with the max (math.maxinteger) and the min (math.mininteger)
values for an integer

This max value for 64-bit inte is aa large number. it is thousands times the total wealth on
earth counted in cents of dollars and one billion times the world population. But despite the
large value, overflow still occur. When we compute an integer operation that would result in
a value smaller than mininteger or larger than maxinteger, the result wraps around.

In math terms, to wrap around means that the computed result is the only number between 
mininteger and maxinteger that is equal module 2^64 to the mathematical result. In computational
terms, it means that we throw away the last carry bit. (This last carry bit would increment a
hypothetical 65th bit, with represents 2^64. Thus to ignore this bit does not change the modulo 2^64
of this value) The behavior is consistent and predictable in all arithmetic operations with integers
in lua:]]
print('Representation Limits - Wrap-around:')
print(math.maxinteger + 1 == math.mininteger)
print(math.mininteger - 1 == math.maxinteger)
print(-math.mininteger == math.mininteger)
print(math.mininteger // -1 == math.mininteger)
print()print()

print(math.maxinteger)
print(0x7fffffffffffffff)
print(math.mininteger)
print(0x8000000000000000)
print()print()

--[[
For floating-point numbers, standard lua uses double precision. It represents each number with 64bits
11 of which are used for the exponent. Double precision floating point numbers can represent numbers
with roughtly 16 significant decimal digits, in a range from -10^308 to 10^308. 

The range of double-precision floats is large enough for most practical applciations, but we must always
acknowledge the limied precision. The situation here is not different from what happens with pen and
paper. if we use ten digits to represent a number, 1/7 becomes rounded to 0.142857142. If we compute 
1/7 * 7 using ten digits, the result will be 0.999999994, which is different from 1. Moreover numbers
that have a finite representation in decimal can have an infinte representation in binary. For instance
12.7 - 20 + 7.3 is not exactly zero  even when computed with double precision, because both 12.7 and 7.3
do not have an exact finite representation in binary.

Because integers and floats have different limits, we can expect that arithmetic operations will give
different results for integers and floats when the results reach these limits
]]
print(math.maxinteger + 2)
print(math.maxinteger + 2.0)

--[[
In this example, both results are mathematically incorrect, but in quite different ways. The first 
line makes an integer addition, so the result wraps around. The second line makes a float addition
so the result is rounded to an approximate value, as we can see in the following equality:
]]
print(math.maxinteger + 2.0 == math.maxinteger + 1.0)

-- each representation has its own strengths. Of course, only floats can represent fractional numbers
-- Flaots have a much larger range, but the range where they can represent integers exactly is 
-- restricted to -2^53, 2^53. These are quite large numbers nevertheless. Up to these limits we can 
-- mostly ignore the differences between integers and floats. Outside these limits, we should think more 
-- carefully about the representations we are using.