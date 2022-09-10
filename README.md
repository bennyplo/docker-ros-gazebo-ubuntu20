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
a)start the terminal program<br/>
b)Go to the ~/catkin_ws directory<br/>
	$cd ~/catkin_ws<br/>
c)Build the catkin <br/>
$catkin build --summary<br/>
d)If you see errors, try running the “catkin build” again<br/>
e)Set up the envirionment:<br/>
	$source ~/catkin_ws/devel/setup.bash<br/>
Note: the username and password are both: ubuntu<br/>
<h3>Issues found in catkin build (due to dVRK cisst)</h3>
1. When running the “$catkin build –summary”, and you see errors, such as:<br/>
  Make Error at /home/ubuntu/catkin_ws/src/cisst-saw/sawForceDimensionSDK/example/CMakeLists.txt:25 (find_package): <br/>
  Could not find a configuration file for package “cisst” that is compatible with requested version “1.0.11”….<br/>
  The following configuration files were considered but not accepted:<br/>
  /home/ubuntu/catkin_ws/devel/cmake/cisst-config.cmake, version 1.1.0<br/>
2. Edit the file:<br/>
  $sudo nano /home/ubuntu/catkin_ws/src/cisst-saw/sawForceDimensionSDK/example/CMakeLists.txt<br/>
3. and change the following<br/>
find_package(cisst 1.0.11 REQUIRED ….)<br/>
4. To<br/>
find_package(cisst 1.1.0 REQUIRED ….)<br/>
Note: you may have to edit a few files like this….<br/>







