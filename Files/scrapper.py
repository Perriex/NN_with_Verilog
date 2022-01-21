import math
from turtle import up


spec = open("./file_spec.txt", "r")

for line in spec:
    filename, bulksize, count = line.split()
    bulksize = int(bulksize)
    count = int(count)
    upperbound = 2**math.ceil(math.log2(bulksize))
    file = open(filename, "r")
    name, ext = filename.split('.')
    outfiles = [open("%s_%d.%s"%(name, i, ext), "w") for i in range(count)];
    
    writeData = ''
    index = 0
    for data in file:
        writeData += data[:-1]
        if index % upperbound == bulksize - 1:
            for i in range(upperbound - bulksize):
                writeData+='00'
            outfiles[(index//upperbound)%count].write(writeData+'\n')
            writeData = ''
            index += upperbound - bulksize + 1
            continue

        if index % 8 == 7:
            outfiles[(index//upperbound)%count].write(writeData +'\n')
            writeData = ''
        index+=1
    
    for i in range(index, count*upperbound*math.ceil(index/upperbound/count)):
        outfiles[(i//upperbound)%count].write('00')
        if i % 8 == 7:
            outfiles[(i//upperbound)%count].write('\n')