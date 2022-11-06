#include <stdio.h>
#include <stdlib.h>

#define NUM_VERTICES 99999999

int main(int argc, char *argv[])
{
  int *p;
  p= (int *) malloc(sizeof(int)*NUM_VERTICES);
   int *k;
  k= (int *) malloc(sizeof(int)*NUM_VERTICES);
  //char *argument2 = argv[2];
  //int vertex=atoi(argument2);
  int data=0;
  int vertex =13;
  int a;
  int l=0;

  /*FILE *file;
  file = fopen(argv[1],"r");
  char *file_name = argv[1];
  printf("%s, ",file_name);
  printf("%d, ",vertex);*/
  FILE *file;
  file = fopen("ex_2.metis.part.3","r");
  if(file == NULL)
  {
    printf("file not opened\n");
    exit(0);
  }

  else
  {
    for(int i=0; i<vertex; i++)
    {
      fscanf(file, "%d", &data);
      p[i]=data;
      //printf("%d ",row_ptr[i]);
    }
    //printf("\n");
     //printf("\n");
   }
   fclose(file);
     for (int i = 0; i < vertex; ++i) 
        {
 
            for (int j = i + 1; j < vertex; ++j)
            {
 
                if (p[i] > p[j]) 
                {
 
                    a =  p[i];
                    p[i] = p[j];
                    p[j] = a;
 
                }
 
            }
 
        }
        //   printf("The numbers arranged in ascending order are given below \n");
        // for (int i = 0; i < vertex; ++i)
        //     printf("%d\n", p[i]);
        for(int i=0;i<vertex;i++){
            int c=1;
            while(p[i]==p[i+1]&&i+1<vertex){
                c++;
                i++;
            }
            k[l]=c;
            l++;
        }
   file = fopen("ex_2_3.csv","w");
   //fprintf(file,"\n");
   //-----------writing into the file ----------//
   for (int i=0; i<l; i++)
   {
       fprintf(file,"%d ",k[i]);
       //printf(" %d ",col_index[j]);
       fprintf(file, "\n");
     }
     fprintf(file, "\n");
     //printf("\n");
     return 0;
   }
