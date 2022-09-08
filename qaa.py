#!/usr/bin/env python
file="./15_3C/Mus_musculus_alignmentAligned.out.sam"            

mapped:int=0
unmapped:int=0

with open(file, "r") as fh:
    for line in fh:
        if line[0] != "@":
            # print(line)
            lxl=line.split("\t")
            flag=int(lxl[1])
            # print(flag)

            if((flag & 4) != 4):
            # mapped = True
                if((flag  & 256)!=256):
                    mapped += 1
            else:
                if((flag  & 256)!=256):
                    unmapped += 1
                
    # print(mapped, unmapped)
with open("6_2D_qaa_py.output", "w") as fa:
    fa.write(f'Mapped   Unmapped\n')    
    fa.write(f"{mapped}    {unmapped}\n")