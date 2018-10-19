
dynamic2table<-function(dinamica){
  a<-as.matrix(dinamica)
  a1<-as.vector(a)
  
  carro<-row.names(dinamica)
  carro<-rep(carro,ncol(dinamica))
  
  x<-vector('character')
  atrib<-vector('character')
  
  for(i in 1:ncol(dinamica)){
    x<-rep(colnames(dinamica)[i],nrow(dinamica))
    atrib<-cbind(atrib,x)
  }
  atrib<-as.vector(atrib)
  
  tabla<-cbind(carro, atrib, a1)
}