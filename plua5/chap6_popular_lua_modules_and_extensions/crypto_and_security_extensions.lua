--[[
How Cryptography Secures Data?

Crypto is essential for protecting sensitive data, ensuring that information remains confidential
during storage and transmission. Crypto modules secure data by transforming it from a readable
format (plaintext) into an unreadable format (ciphertext) using a secret key and an IV (what's that? 🤔)
The encryption algorithm uses the key to scramble the data and the IV ensures that identical plaintext
blocks are encrypted into different ciphertext blocks, enhancing security. This process makes it
nearly impossible for an attacker to derive the original data without access to the actual secret key.

Once the data is encrypted, even if it is intercepted during transmission or accessed without authorization
it remains protected because the decryption key is not known. Only someone with the correct key and IV
can reverse the process and access the original information. This principle is critical for securing
communication, such as when transmitting personal information over the internet or storing confidential
data in a database.

Several cryptography modules are avaialable for lua, such as luaCrypto, luaossl, and others. While
LuaCrypto was popular in earlier versions, luaossl is a more mordern library that leverages OpenSSLs
extensive capabilities. luaossl supports various cryptographic operations including hasing, encryption
and decryption. And for my practicial in this book, I'll focus on luaossl as it provides a robust 
interface to OpenSSL 

I'll start by using luaossl to demonstrate how symmetric encryption works, as the symmetric encryption
uses the same key for both encrypting and decrypting data.

Luaossl for aES Encryption:
So first I need to get luaossl installed on my system with luarocks. (its luaossl not openssl) 
Here i'll use the AES-256-CBC cipher, which is a widely recognized standard for secure encryption
]]

local openssl = require 'openssl'
local cipher = openssl.cipher.get('aes-256-cbc')
-- first I need to set up the cipher, defining a secret key and an initialization vector (IV)
-- the key should be 32 bytes long for AES-256
-- For CBC mode the IV should be 16 bytes long

-- in a real application I would get use a password generator to get this
local key = '0123456789abcdef0123456789abcdef'

-- define a 16-byte IV (also should be generated securely with a password manager)
local iv = 'abcdef9876543210'

-- Here the plaintext that I'll secure
local plaintext = 'Sensitive information: Do not share this data with unauthorized parties.'

-- Encrypting the message
-- I then use the cipher's encrypt method which takes the message, key, and IV and returns ciphertext
local encrypted = cipher:encrypt(plaintext,key,iv)
print()
print('Plaintext Message:')
print(plaintext)
print()
print('Encrypted Data:')
print(encrypted)
print()

-- Decrypting Ciphertext
-- then to validate that the encryption was successful and reversible, I'll need to decrypt the ciphertext
-- using the same cipher, key, and IV. 
local decrypted = cipher:decrypt(encrypted,key,iv)
print('Decrypted Data:')
print(decrypted)

-- If done correctly the output will match the original plaintext messsage. This confirms that the
-- cryptographic hash functions (sha-256) can help ensure that the ciphertext has not been tampered
-- with during the transmission