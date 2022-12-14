#include <stdio.h>
#include <stdlib.h>

#define NUM_VERTICES 99999999
#define NUM_EDGES 99999999


int main(int argc, char *argv[])
{
  int *col_index;
  col_index= (int *) malloc(sizeof(int)*NUM_VERTICES);
  int *row_ptr;
  row_ptr = (int *) malloc(sizeof(int)*NUM_EDGES);
  int edge;
  //char *argument2 = argv[2];
  //int vertex=atoi(argument2);
  int data=0;
  int count=0;
  int vertex =13;

  /*FILE *file;
  file = fopen(argv[1],"r");
  char *file_name = argv[1];
  printf("%s, ",file_name);
  printf("%d, ",vertex);*/
  FILE *file;
  file = fopen("ex_2.csr","r");
  if(file == NULL)
  {
    printf("file not opened\n");
    exit(0);
  }

  else
  {
    fscanf(file , "%d", &edge);

    for(int i=0; i<=vertex+1; i++)
    {
      fscanf(file, "%d", &data);
      row_ptr[i]=data;
      //printf("%d ",row_ptr[i]);
    }
    //printf("\n");
    for(int j=0; j<edge; j++)
    {
        fscanf(file,"%d", &data);
        col_index[j]=data;
        //printf("%d ",col_index[j]);

     }
     //printf("\n");
   }
   fclose(file);
   file = fopen("ex_2.metis","w");
   fprintf(file,"%d ",vertex);
   fprintf(file,"%d ",edge/2);
   //fprintf(file,"\n");
   //-----------writing into the file ----------//
   for (int i=0; i<=vertex+1; i++)
   {
     for (int j=row_ptr[i]; j<row_ptr[i+1]; j++)
     {
       fprintf(file,"%d ",col_index[j]);
       //printf(" %d ",col_index[j]);
     }
     fprintf(file, "\n");
     //printf("\n");
   }
return 0;
}
