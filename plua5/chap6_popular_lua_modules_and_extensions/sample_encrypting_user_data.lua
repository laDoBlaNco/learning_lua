--[[
Sample Program: Encrypting User Data for Transmission

The following example integrates JSON serliazation with AES encryption, preparing for
secure data transmission:
]]

local openssl = require 'openssl'
local cjson = require 'cjson'
local cipher = openssl.cipher.get('aes-256-cbc')

-- secure key and IV (in practice, generate these securely with a password generator/manager)
local key = '0123456789abcdef0123456789abcdef'
local iv = 'abcdef9876543210'

-- example lua table with user data
local userData = {
  username = 'ladoblanco',
  email = 'whitesidekevin@gmail.com',
  role = 'lua_hacker',
}

-- convert the lua table to a json string
local jsonData = cjson.encode(userData)
print('JSON Data to Encrypt:')
print(jsonData) print()

-- encrypt the json data now
local encryptedData = cipher:encrypt(jsonData,key,iv)
print('Encrypted Data:')
print(encryptedData) print()

-- simulate transmission here (e.g., send encryptedData over network)

-- then we would decrypt the received data
local decryptedJson = cipher:decrypt(encryptedData,key,iv)
print('Decrypted JSON Data:')
print(decryptedJson) print()

-- Convert JSON back to lua table
local decodedData = cjson.decode(decryptedJson)
print('Decoded Lua Table:')
for k,v in pairs(decodedData) do
  print(k .. ':',v)
end

-- pretty self explanatory here. A quick coding, encrypting, decrypting and decoding of data
-- data --> json --> encrypted --> decrypted --> json --> decoded --> data

--[[
Summary:

By adding different lua modules that made my application more useful, I broadened my lua hacking
skills. I learned to make web requests, talk to remote APIs, and quickly process responses using
HTTP modules. By using luasocket, I tried out the GET and POST operations, which are the building
blocks of network communication. I also looked into json parsing and serialization, which let me
change lua tables into JSON strings and back again.

On top of that, I used special moduels to connect my lua program to databases and run queries, 
handle transactions, and process results on the fly. I gained skills to work with relational
databases and manage persistent data because of this experience. I also tried more advanced file
system operations by using utility modules. Last but not least, I added security and cryptography
features by including modules such as luaossl and openssl. I practiced using AES algorithms to
encrypt and decrypt sensitive data, which kept the data safe while it was being sent. Overall,
I came up with strong ways to handle errors and manage resources.
]]

