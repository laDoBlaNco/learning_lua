-- to force a number to be a float we can simply add 0.0
print(-3 + 0.0)
print(0x7fffffffffffffff + 0.0)
print()

print(2 ^ 53)
print(2 ^ 53 | 0)
print()

-- lua only does this conversion when the number has an exact representation. In other words
-- it has no fractional part. If so, it returns an error
-- print(3.2|0)

-- another way to force a number into an int is to use math.tointeger, which returns nil when
-- a number can't be converted.
print(math.tointeger(-258.0))
print(math.tointeger(2^30))
print(math.tointeger(5.01))
print(math.tointeger(2^64))
print()

