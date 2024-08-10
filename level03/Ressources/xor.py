def xor_string(input_string, key):
	return ''.join(chr(ord(char) ^ key) for char in input_string)
input_string = "Q}|u`fsg~sf{}|a3"
for key in range(1, 22):
	result = xor_string(input_string, key)
	print(f"Key {key}: {result}")
