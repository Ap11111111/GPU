import csv
from numpy import array
from scipy.sparse import coo_matrix

row =[]
col =[]
data =[]

vertex=13
v=vertex+1
D=1
file = open('ex_2.tsv','r')

tsv_file = csv.reader(file, delimiter="\t")

for line in tsv_file:
	line = line[0].split()
	row.append(int(line[0]))
	col.append(int(line[1]))
	data.append(D)

print(row)
print(col)
print(data)

A = coo_matrix((data, (row, col))).tocsr()

file = open('ex_2.csr','w')
print(A.nnz)
print(A.indptr)
print(A.indices)

file.write(str(A.nnz) + "\n")
#print("len of : ",len(A.indptr))
for data in range(v+1) :
	if (data < len(A.indptr)) :
		file.write("%i " % A.indptr[data])
	else:
		file.write("%i " % A.nnz)
file.write("\n")
for data in A.indices :
	file.write("%i " % data)
	
