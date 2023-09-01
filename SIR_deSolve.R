#Load required libraries
library(ggplot2)
library(deSolve)
library(reshape2)

# Variable inputs

init_variable_values=c(S=9998,I=2,R=0)
parameters=c(gamma=0.143,beta=0.666)

# Time points

time=seq(from=1,to=60,by=1)

# SIR model function 

sir_model <- function(time,state,parameters){
  with(as.list(c(state,parameters)),{
    N=S+I+R
    tau=beta*(I/N) 
    dS=-tau*S
    dI=tau*S-gamma*I
    dR=gamma*I
    
    return(list(c(dS,dI,dR)))
  }
  )
}


#Solving SIR model
output<-as.data.frame(ode(y=init_variable_values,func = sir_model,parms=parameters,times = time))

 out_long=melt(output,id="time")
 # To plot the susceptible, infectious and recovered population over time
 ggplot(data = out_long,          
      aes(x = time, y = value/10000, colour = variable, group = variable)) +  
  geom_line() +xlab("Time")+ylab("Proportion of the population")+geom_line(size=1.5)+scale_color_manual(values=c('blue', 'pink', 'green')) +
  theme(
    panel.background = element_rect(fill='transparent'),
    plot.background = element_rect(fill='transparent', color=NA),
    panel.grid.major = element_blank(),
    panel.grid.minor = element_blank(),
    legend.background = element_rect(fill='transparent'),
    legend.box.background = element_rect(fill='transparent'),
    axis.title.x = element_text(size = 14),  # Change x-axis label font size
    axis.title.y = element_text(size = 14)   # Change y-axis label font size
  )

 