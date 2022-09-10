# docker-ros-gazebo-ubuntu20
Docker file for creating the Ubuntu20 desktop with ROS noetic, Juypter notebook, and Gazebo installed

You can find the image from the docker hub:<br/>
bennyplo1218/ros-gazebo-20:latest<br/>

To build the docker image<br/>
<pre>$./build_docker</pre><br/>
To run the docker image<br/>
<pre>$./Rundocker</pre><br/>
<h3>Set up the software</h3>
You may need to set up the docker resources to ensure that you have sufficient space/memory for running the programs. <br/>
1. Start the Docker Desktop then click the setup button<br/>
2. Then select Resources, you will then be able to adjust the memory/disk space for your docker images<br/>
Once you are able to get onto the linux desktop screen via a web browser, do the following:<br/>
a)start the terminal program<br/>
b)Go to the ~/catkin_ws directory<br/>
	<pre>$cd ~/catkin_ws</pre><br/>
c)Build the catkin <br/>
<pre>$catkin build --summary</pre><br/>
d)If you see errors, try running the “catkin build” again<br/>
e)Set up the envirionment:<br/>
	<pre>$source ~/catkin_ws/devel/setup.bash</pre><br/>
Note: the username and password are both: ubuntu<br/>
<h3>Issues found in catkin build (due to dVRK cisst)</h3>
1. When running the “$catkin build –summary”, and you see errors, such as:<br/>
 <p><pre>Make Error at /home/ubuntu/catkin_ws/src/cisst-saw/sawForceDimensionSDK/example/CMakeLists.txt:25 (find_package): 
  Could not find a configuration file for package “cisst” that is compatible with requested version “1.0.11”….
  The following configuration files were considered but not accepted:
  /home/ubuntu/catkin_ws/devel/cmake/cisst-config.cmake, version 1.1.0</pre></p>
2. Edit the file:<br/>
  <pre>$sudo nano /home/ubuntu/catkin_ws/src/cisst-saw/sawForceDimensionSDK/example/CMakeLists.txt</pre><br/>
3. and change the following<br/>
<pre>find_package(cisst 1.0.11 REQUIRED ….)</pre><br/>
4. To<br/>
<pre>find_package(cisst 1.1.0 REQUIRED ….)</pre><br/>
Note: you may have to edit a few files like this….<br/>
<br/>
1. When running the “$catkin build –summary”, and you see errors, such as:<br/>
   <p><pre>Make Error at /home/ubuntu/catkin_ws/src/dvrk-ros/dvrk_robot/CMakeLists.txt:66 (find_package): 
Could not find a configuration file for package “sawIntuitiveResearchKit” that is compatible with requested version “2.1.0”….
The following configuration files were considered but not accepted:
/home/ubuntu/catkin_ws/devel/share/sawIntuitiveResearchKit/cmake/sawIntuitiveResearchKitConfig.cmake, version 2.0.1</pre></p>
2. Edit the file:<br/>
   <pre>$sudo nano /home/ubuntu/catkin_ws/src/dvrk-ros/dvrk_robot/CMakeLists.txt</pre><br/>
3. and change the following lines<br/>
   <p><pre>find_package(sawRobotIO1394 2.1.0 REQUIRED)
   find_package(sawIntuitiveResearchKit 2.1.0 REQUIRED)</pre></p>
4. To <br/>
   <p><pre>find_package(sawRobotIO1394 2.0.0 REQUIRED)
   find_package(sawIntuitiveResearchKit 2.0.1 REQUIRED)</pre></p>
<br/>   
1. Edit the file:<br/>
   <pre>$gedit ~/catkin_ws/src/cisst-saw/sawConstraintController/examples/CMakeLists.txt</pre>
2. Comment out the following lines:<br/>
   <p><pre>#add_subdirectory (SimpleCommunication)
   #add_subdirectory(BasicSetup)</pre></p>
3. Edit the file:<br/>
   <pre>$gedit ~/catkin_ws/src/cisst-saw/sawOptoforceSensor/examples/CMakeLists.txt</pre>
4. Comment out the following lines:<br/>
   <p><pre>#add_subdirectory (console)
   #add_subdirectory (Qt)</pre></p>
<br/>











