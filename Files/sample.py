from email.mime import base


weight = open("./w1_sm.dat")
data = open("./te_data_sm.dat")
bias = open("./b1_sm.dat")

res = []
indata = []
for j in range(62):
    indata.append(int(data.readline(), base=16))

for i in range(30):
    ws = 0
    for j in range(62):
        
        w = int(weight.readline(), base=16)
        ws = w * indata[j]
    res.append(ws + int(bias.readline(), base=16))

print(res)