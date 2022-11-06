#include<cuda.h>
#include<stdio.h>
#include<iostream>
// #include<bits/stdc++.h>
#include <stdlib.h>
#include <string.h>
using namespace std;
__global__ void mul( int *ro, int *co ,int *aa,int *fv,int v,int x,int *res,int ex){
    int row=blockIdx.x*blockDim.x+threadIdx.x;
    if(row<ex){
        int rinitial=ro[row];
        int rend=ro[row+1];
        int r_new=aa[row];
         printf("%d\t %d\n",r_new,row);
        double  sum,offset;
       // sum=0;
        for(int j=0;j<x;j++){
          sum=0;
          for(int h=rinitial;h<rend;h++){  
            offset=fv[co[h]*x+j];
           printf("offset %lf\n",offset); 
            //printf("va[h] %d\n",va[h]);
               
            sum+=offset;
            //printf("sum %lf\t %d\n",sum,row);
          }
         // printf("%lf\t",sum);
          res[r_new*x+j]=sum;
        // printf("res %lf\t tid %d\n",res[r_new*x+j],row);
        }
    }
    //printf("res %lf\t tid %d\n",res[0],res[1]);
}

int main()
{ 
  
  int vertex=10;
  int v=vertex;
  char buffer[8090];
  char *record,*line;
  int i=0,j=0;
  // int begn=1;
  // int last=v+1;
  int ex=0;
  int rx=0;
  int incrr=ex+1;
  int t=0;
  int n=0,m=1,f=2,nnz=INT_MAX;
  int z=1;
  int d=0;
  int q=0;
  int s=0;
  //int c=0;
  //int* mat = new int[v * v];
   int* mat = (int*)malloc(v*v*sizeof(int));
  int* rowptr = (int*)malloc((v+1)*sizeof(int));
  int* rowptr_nxt=(int*)malloc(incrr*sizeof(int));
  int* ar_nxt=(int*)malloc(ex*sizeof(int));
  int* mx = (int*)malloc(v*v*sizeof(int));
  double *rowptr_new=(double*)malloc((v+1)*sizeof(double));
  int* b=(int*)malloc(v*f*sizeof(int));
  int* g=(int*)malloc(v*f*sizeof(int));
  int* colindex=(int*)malloc(nnz*sizeof(int));
  int* colindex_new=(int*)malloc(nnz*sizeof(int));
  int* access=(int*)malloc(v*sizeof(int));
  int* acc=(int*)malloc(v*sizeof(int));
  int* n_o_p=(int*)malloc(v*sizeof(int));
  int* par=(int*)malloc(v*sizeof(int));
  double *rpt;
  int *cdx,*b_f;
  int *res;
  int *rrpt,*aa_ne;
  cudaMalloc(&res, v*f*sizeof(int));
  cudaMalloc(&rpt, (v+1)*sizeof(double));
  cudaMalloc(&b_f, v*f* sizeof(int));
   //cudaMalloc(&res,v*f*sizeof(double));
   //cudaMalloc(&vls, nnz * sizeof(int));
FILE *fstream = fopen("ex_3.csv","r");
  if(fstream == NULL)
    {
      printf("\n file opening failed ");
      return -1 ;
    }
  
   
  while((line=fgets(buffer,sizeof(buffer),fstream))!=NULL)
  {
    record = strtok(line,";");
    while(record != NULL)
    {

      int x =0;
      for(int k=0;k<strlen(record);k+=2)
      {
         
        mat[i * v + x] = record[k]-'0';
        x++;
      }
      
      record = strtok(NULL,",");
      
    }
     
    i++ ;
  
    // if (i == v) break;
  }
  for(int i=0;i<v;i++)
  {
    for(int j=0;j<v;j++)
    {
     mx[i * v + j] = mat[i * v + j];
    }
  }
   
  const char* filename="partitions.csv";
  FILE *file = fopen(filename,"r");
  if(file==NULL)
    {
      printf("not open");
      exit(0);
    }    

  int ind;
  int p=0;
  while(fscanf(file,"%d",&ind)!=EOF)
    {
      access[p]=ind;
      p++;
      // if(p == v)
      //   break;
    } 
  for(int i=0;i<p;i++)
  {
    acc[q]= access[i];
    q++;
    // if(q==v)
    //   break;
  }
  //////////////////////////////////////////////////////////////////////////////////////
  const char* filenam="ex_3_3.csv";
  FILE *fil = fopen(filenam,"r");
  if(fil==NULL)
    {
      printf("not open");
      exit(0);
    }    

  int in;
  int a=0;
  while(fscanf(fil,"%d",&in)!=EOF)
    {
      n_o_p[a]=in;
      a++;
      // if(p == v)
      //   break;
    } 
  for(int i=0;i<a;i++)
  {
    par[s]= n_o_p[i];
    s++;
    // if(q==v)
    //   break;
  }
   ///////////////////////////////////////////////////////////////////////////////////////// 

   // printf("calculate the column indices\n");
  for(int i=0;i<v;i++)
  {
    for(int j=0;j<v;j++)
    {
      if(mx[i * v + j]==1)
      {
          colindex[n++]=j+1;
      }
    }
  }
  /////////////////////////////////////////////////
  // for(int i=0;i<n;i++){
  //   printf("%d",colindex[i]);
  // }
 // printf("%d",n);
//printf("feature matrix\n");
  for(int i=0;i<v*f;i++)
  {
     b[i] = 1;
    //  c_v++;
    //  printf("%d\n",c_v);
  }
  
  
//printf("new rowptr is\n");
  for( int i=0;i<q;i++)
  {
    // printf("%d\n",i);
    //  printf("i: %d\n",i);
    for( int j=0;j<v;j++)
    {
      if(j==acc[i]-1)
      {
        // printf("j: %d\n",j);
        int  rowval_new=0;
        for( int k=0;k<v;k++)
        {
          // printf("k: %d\n",j);
          if(mx[j * v + k] == 1)
          {
            rowval_new++;
            // printf("j: %d\n",j);
          } 
            
          rowptr_new[0]=0;
          rowptr_new[z]=rowval_new+rowptr_new[z-1];
        }
          
        z++;
        // if(z==v)
        // break;
      }
    }
  }
 // printf("%d",z);
  //printf("the rowptr array corresponding \n");
  // for(int i=0;i<z;i++){
  //    printf("%lf\n",rowptr_new[i]);
  //    }
  //printf("new colindex \n ");
  for(int i=0;i<q;i++)
  {
    // printf("%d\n",i);
    for(j=0;j<v;j++)
    {
      if(j==acc[i]-1)
      {
        for(int k=0;k<v;k++)
        {
          if(mx[j * v + k]==1)
          {
            colindex_new[d++]=k+1;
                    
          }
                
        }
            
      }
      
    }
  }
 ///////////////////
    // for( int i=0;i<d;i++){
    //     printf("%d\n",colindex_new[i]);
    //  }
  cudaMalloc(&cdx, d * sizeof(int));
  
  cudaMemcpy(cdx, colindex_new, d * sizeof(int),
                                  cudaMemcpyHostToDevice ) ;
  cudaMemcpy( b_f, b, v*f* sizeof(int),
                                  cudaMemcpyHostToDevice );
  //printf("calculate the rowpointer\n");
  for(int i=0;i<v;i++)
  {
    int rowval=0;
    for(int j=0;j<v;j++)
    {
      if(mx[i * v + j]==1)
      {
        rowval++;
      }
      rowptr[0]=0;
      rowptr[m]=rowval+rowptr[m-1];
        
    }
    m++;
  }
 int c=0;
  while (c<s)
  {
    int  noz=INT_MAX;
    ex=par[c];
      //printf("%d",c);
    t=rx;
    rx+=ex;
    int sum=0;
    for(int i=t+1; i<=rx; i++)
    {
      if(i==rx)
      sum= rowptr_new[rx]-rowptr_new[t];
    }
     //printf("%d",sum);
    noz=noz-sum;
    if(noz>sum)
    {

      //    printf("send value till %d",rx);.
      //    printf("next row_ptr value is");
      rowptr_nxt[0]=rowptr_new[t];
      int r=1;
      for(int i=t+1;i<=rx;i++)
      {
        rowptr_nxt[r] = rowptr_new[i];
        r++;
      }
      //////////////////////////////////////
      // for(int i=0;i<r;i++)
      // {
      // printf("%d",rowptr_nxt[i]);
      // }
        int y=0;
        for(int i=t;i<rx;i++)
        {
          ar_nxt[y]= acc[i];
          y++;
        }
        //////////////////////////////////////////////////////////////////////////////////////
        // for(int i=0;i<y;i++)
        // printf("%d",ar_nxt[i]);
        
        cudaMalloc(&rrpt,  incrr* sizeof(int));
        
        cudaMalloc(&aa_ne, ex* sizeof(int));
        
    
        cudaMemcpy( rrpt, rowptr_nxt, incrr * sizeof(int), cudaMemcpyHostToDevice );
              
        cudaMemcpy(aa_ne , ar_nxt, ex * sizeof(int),cudaMemcpyHostToDevice );
                        
               
        //  float elapsed_time;
        // cudaEvent_t start, stop;
        // cudaEventCreate(&start);
        // cudaEventCreate(&stop);

        // cudaEventRecord(start);
        //  mul<<<v/ex,ex>>>(rrpt,cdx,aa_ne,b_f,v,f,res,ex);
          mul<<<1,ex>>>(rrpt,cdx,aa_ne,b_f,v,f,res,ex);
          
        //    cudaEventRecord(stop);
        //    cudaDeviceSynchronize();
        //   cudaEventSynchronize(stop);
        //   cudaEventElapsedTime(&elapsed_time, start, stop);

        //  printf("\nRunning time:  %.4f ms\n", elapsed_time);
        cudaDeviceSynchronize();
          
         //begn+=ex;
        
      //   c++;
      //  printf("%d",c);
      }
    else
    break;
    c++;
  }

  cudaMemcpy(g,res,v*f*sizeof(int),cudaMemcpyDeviceToHost);
   //for(i=0; i<v; i++)
     //printf("i: g[0] %lf\t, g[1] %lf\n",g[i*f],g[i*f+1]);
     ////////////////////////////
  //  for(int i=0; i<v; i++)
  //      for(int j=0;j<f;j++)
  //        printf("%d\n", g[i*f+j]);
         /////////////////////////
    // cudaFree(res);
  //  fclose(fopen("result.txt", "w"));

  //   char buf[100];
  //   double *temp1 = (double*) malloc(sizeof(double));
  //   double *temp2 = (double*) malloc(sizeof(double));
    
  //   FILE *results = fopen("result.txt", "a");
  
      // for(int i=0;i<v*f;i+=2){}
      //    printf("result %lf \t",g[i*f+j]);
  //         cudaMemcpy(temp1,res+(i),sizeof(double),cudaMemcpyDeviceToHost);
  //         cudaMemcpy(temp2,res+(i+1),sizeof(double),cudaMemcpyDeviceToHost);
  //        snprintf(buf, 50, "Result : %d -> %lf\t%lf", (i/2), *temp1, *temp2);
  //        fprintf(results, "%s\n", buf);
  //     }
  //     printf("end\n");
  //     fclose(results);
}
