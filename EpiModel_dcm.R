# Load EpiModel; DCMs
library(EpiModel)

control <- control.dcm(type = "SIR", nsteps = 100, nsims = 10)

# initinize the model
init <- init.dcm(s.num = 997, i.num = 3, r.num = 0)


param <- param.dcm(inf.prob = 0.05, act.rate = 10, rec.rate = 1/20, 
                   a.rate = (10.5/365)/1000, ds.rate = (18.6/365)/1000, di.rate = (14/365)/1000, 
                   dr.rate = (9.3/365)/1000)


sim <- dcm(param, init, control)

sim


#plot the function
plot(sim) #part (a)




