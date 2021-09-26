# UNICODE TRANSFORMATION FORMAT 16-BIT
# Encode a Unicode string to a string in which each 16-bit unit occupies only one byte
toBinary = (string) ->
  codeUnits = new Uint16Array string.length
  for i in [0..codeUnits.length-1]
    codeUnits[i] = string.charCodeAt i
  charCodes = new Uint8Array codeUnits.buffer
  result = ''
  for i in [0..charCodes.byteLength-1]
    result += String.fromCharCode charCodes[i]
  result

# Decode as well
fromBinary = (binary) ->
  bytes = new Uint8Array binary.length
  for i in [0..bytes.length-1]
    bytes[i] = binary.charCodeAt i
  charCodes = new Uint16Array bytes.buffer
  result = ''
  for i in [0..charCodes.length-1]
    result += String.fromCharCode charCodes[i]
  result

# New Unicode-16 to base-64
btoa_utf16 = (string) -> btoa toBinary string

# New base-64 to Unicode-16
atob_utf16 = (string) -> fromBinary atob string