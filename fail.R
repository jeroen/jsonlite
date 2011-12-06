toJSON(list(NA))   # change to make NA represent JSON null

# now work:
  #roundtrip('["A","B","C"]')
  # roundtrip('["A",10,"C"]')

# now work
roundtrip('{"":10,"":13}')  
roundtrip('{"":10,"b":13}')  
