import numpy as np

T = 0.5       
Sam = input('Please input the number of samples:')
Sam = int(Sam) 
C = input ('Please input 1 or 0,0 for Call option 1 for Put option:')  
C = int (C)  
r = 0.03       
q = 0
sigma = 0.3   
strike = 50    
spot = 48     
mu = r-q-sigma*sigma/2

epsv=np.random.normal(size=(Sam,1)) #vector of random standard normal
STE = spot*np.exp(mu*T+epsv*sigma*np.sqrt(T));
ST = (-1)**C*(STE-strike)
ST = np.maximum(ST,0)

V=np.exp(-r*T)*np.mean(ST)
print (V)
