from cryptography.fernet import Fernet

key = b'pRmgMa8T0INjEAfksaq2aafzoZXEuwKI7wDe4c1F8AY='
cipher_suite = Fernet(key)
with open('mssqltip_bytes.bin', 'rb') as file_object:
    for line in file_object:
        encryptedpwd = line

uncipher_text = (cipher_suite.decrypt(encryptedpwd))
plain_text_unencryptedpassword = bytes(uncipher_text).decode("utf-8") #convert to string