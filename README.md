# docker-ros-gazebo-ubuntu20
Docker file for creating the Ubuntu20 desktop with ROS noetic, Juypter notebook, and Gazebo installed

You can find the image from the docker hub:<br/>
bennyplo1218/ros-gazebo-20:latest<br/>

To build the docker image<br/>
$./build_docker<br/>
To run the docker image<br/>
$./Rundocker<br/>
<h3>Set up the software</h3>
You may need to set up the docker resources to ensure that you have sufficient space/memory for running the programs. <br/>
1. Start the Docker Desktop then click the setup button<br/>
2. Then select Resources, you will then be able to adjust the memory/disk space for your docker images<br/>
Once you are able to get onto the linux desktop screen via a web browser, do the following:<br/>
a)start the terminal program
b)Go to the ~/catkin_ws directory
	$cd ~/catkin_ws
c)Build the catkin 
$catkin build --summary
d)If you see errors, try running the “catkin build” again
e)Set up the envirionment:
	$source ~/catkin_ws/devel/setup.bash
Note: the username and password are both: ubuntu
