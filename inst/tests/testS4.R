# setClass(
# 	Class="Trajectories",
# 	representation=representation(
# 		times = "numeric",
# 		traj = "matrix"
# 	)
# );
# 
# t1 = new(Class="Trajectories")
# t2 = new(Class="Trajectories",times=c(1,3,4))
# t3 = new(Class="Trajectories",times=c(1,3),traj=matrix(1:4,ncol=2))
# 
# cat(asJSON(t3, pretty=T))
# cat(encode(t3, pretty=T))
