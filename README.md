The main problem is that the size of the graph is sometimes so large that it might not fit in the gpu as the size of the GPU is not that much large.
So to solve this problem we are partitioning the graph in such a way that the similar nodes(in terms of neighbour) are send for computation parts by parts.
To achive this we are using metis whic forms cluster of similar nodes.
We are using graph challenge dataset which are in the form of  edge list.
So first we are converting edge list form to CSR matrix. Code for the same is present in CSR.py file.
After that we are converting CSR matrix to the form where each node contains its corresponding neighbours which is given to input for metis,and this file is present in
part_csr.c
After this we are giving input to the metis in terms of arguments eg. how many partitions we want etc.and we will get a file which will contatin the all the nodes and their corresponding partition.
THere is a file name called file_sorter.p which rearrange all the partitions in sorted order,eg.nodes present in partitions 0 comes first and then partitions 1,....2.3..
File name partitions.c count the number od nodes present in corresponding partitions.
After that we are sending  these three files  as a input to fb8.cu which will send each partitions one by one for furthur computation in GPU.
