x = "Open Bar $300 \u5564\u9152\u3001\u6C23\u9152 \u4EFB\u98F2"
print(x)
Encoding(x)
library(RJSONIO)
fromJSON(paste('{"tweet":"', x, '"}', sep = ''))


