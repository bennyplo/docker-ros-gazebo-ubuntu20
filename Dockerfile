# ubuntu v20.0<<
FROM dorowu/ubuntu-desktop-lxde-vnc:focal
#>>
LABEL maintainer "bennyplo@gmail.com"

ENV DEBIAN_FRONTEND noninteractive

ARG ROS_VER=noetic

# Setup your sources list and keys
RUN apt-get -y clean
RUN apt-get -o Acquire::Check-Valid-Until=false -o Acquire::Check-Date=false update
RUN apt-get install -q -y \
    dirmngr \
    gnupg2 \
    lsb-release \
    && rm -rf /var/lib/apt/lists/*
RUN sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'
# noetic <<
RUN apt install -y curl
RUN apt -y upgrade
RUN curl -s https://raw.githubusercontent.com/ros/rosdistro/master/ros.asc | sudo apt-key add -
#>>

# Install ROS Noetic/Melodic
RUN apt -y -o Acquire::Check-Valid-Until=false -o Acquire::Check-Date=false update
#RUN apt -y update
RUN apt -y upgrade 

RUN apt install -y ros-$ROS_VER-desktop-full

# Noetic <<
RUN apt install -y python3-rosdep python3-rosinstall python3-rosinstall-generator python3-wstool build-essential
#>>
RUN rosdep init && rosdep update

# Install some essentials
RUN apt-get install -y git wget curl nano mercurial python3-pip
# Noetic <<
RUN apt-get install -y python3-rosinstall python3-rosinstall-generator python3-wstool build-essential
# >>

# Setup the shell
RUN /bin/bash -c "echo 'export HOME=/home/ubuntu' >> /root/.bashrc"
RUN /bin/bash -c "echo 'source /opt/ros/$ROS_VER/setup.bash' >> /root/.bashrc"
RUN cp /root/.bashrc /home/ubuntu/.bashrc
RUN /bin/bash -c "source /home/ubuntu/.bashrc"

# Install VS Code and Python extensions
RUN curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
RUN install -o root -g root -m 644 microsoft.gpg /etc/apt/trusted.gpg.d/
RUN sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'
RUN apt-get install -y apt-transport-https
RUN apt-get -y -o Acquire::Check-Valid-Until=false -o Acquire::Check-Date=false update
RUN apt-get install -y code
RUN apt-get install -y pylint
# noetic <<
RUN pip install pylint
#>>

RUN apt install -y gedit

# Install Catkin
# noetic <<
RUN apt install -y python3-catkin-tools python3-osrf-pycommon
RUN pip3 install --user git+https://github.com/catkin/catkin_tools.git
# >>

# Copy some starter models
RUN mkdir -p /home/ubuntu/.gazebo/
#COPY models /home/ubuntu/.gazebo/models

# Setup workshop directory
RUN mkdir -p ROAST
#COPY lib/curiosity_mars_rover_description ROAST/
RUN echo check parameter
# Set up Panda Simulator
#RUN \
#  mkdir -p /home/ubuntu/catkin_ws &&\
#  mkdir -p /home/ubuntu/catkin_ws/src;\
WORKDIR /home/ubuntu/catkin_ws/src
RUN git clone -b $ROS_VER-devel https://github.com/justagist/panda_simulator
WORKDIR /home/ubuntu/catkin_ws/src/panda_simulator
#RUN pip install -r requirements.txt 
RUN pip install numpy
RUN pip install numpy-quaternion
RUN apt install -y ros-$ROS_VER-libfranka 
RUN apt install -y ros-$ROS_VER-franka-ros
RUN apt install -y ros-$ROS_VER-panda-moveit-config
RUN apt install -y ros-$ROS_VER-gazebo-ros-control
RUN apt install -y ros-$ROS_VER-rospy-message-converter
RUN apt install -y ros-$ROS_VER-effort-controllers
RUN apt install -y ros-$ROS_VER-joint-state-controller
RUN apt install -y ros-$ROS_VER-moveit
RUN apt install -y ros-$ROS_VER-moveit-commander
RUN apt install -y ros-$ROS_VER-moveit-visual-tools
#RUN ./build_ws.sh
RUN rm /bin/sh && ln -s /bin/bash /bin/sh
RUN source /opt/ros/noetic/setup.bash
WORKDIR /home/ubuntu/catkin_ws/src
RUN wstool init
RUN wstool merge panda_simulator/dependencies.rosinstall
RUN wstool up
WORKDIR /home/ubuntu/catkin_ws/src/orocos_kinematics_dynamics
RUN git checkout b35c424e77ebc5b7e6f1c5e5c34f8a4666fbf5bc
WORKDIR /home/ubuntu/catkin_ws/
RUN rosdep install -y --from-paths src --ignore-src --rosdistro noetic
RUN rosdep update
RUN source /opt/ros/noetic/setup.bash
#RUN catkin build

WORKDIR /home/ubuntu/
#RUN source home/ubuntu/catkin_ws/devel/setup.bash >> ~/.bashrc
RUN source ~/.bashrc

RUN apt-get install ros-noetic-gazebo-ros-pkgs ros-noetic-gazebo-ros-control
RUN mkdir -p /home/ubuntu/catkin_ws
WORKDIR /home/ubuntu/catkin_ws
RUN mkdir -p /home/ubuntu/catkin_ws/src
WORKDIR /home/ubuntu/catkin_ws/src
RUN git clone https://github.com/ros-simulation/gazebo_ros_pkgs.git -b noetic-devel

#Install panda robot
RUN pip install panda-robot
RUN pip install future
RUN python3 -m pip install --upgrade pip
RUN python3 -m pip install --upgrade Pillow
RUN pip install numba

#install pcg gazebo
RUN pip install pcg-gazebo
RUN apt install -y libspatialindex-dev pybind11-dev libgeos-dev

#Install Jupyter notebook
RUN pip install jupyterlab
RUN pip install notebook

RUN pip3 uninstall -y flask
RUN pip3 install flask


#install dvrk
WORKDIR /home/ubuntu/catkin_ws/src
RUN apt-get update
RUN apt-get -y install libxml2-dev libraw1394-dev libncurses5-dev qtcreator swig sox espeak cmake-curses-gui
RUN apt-get -y install cmake-qt-gui git subversion gfortran libcppunit-dev libqt5xmlpatterns5-dev python3-wstool
RUN apt-get -y install python3-catkin-tools python3-osrf-pycommon
RUN git clone https://github.com/jhu-cisst/cisst-saw --recursive
RUN git clone https://github.com/jhu-dvrk/dvrk-ros
RUN git clone https://github.com/jhu-dvrk/dvrk-gravity-compensation
RUN git clone https://github.com/collaborative-robotics/crtk_msgs crtk/crtk_msgs
RUN git clone https://github.com/collaborative-robotics/crtk_python_client crtk/crtk_python_client
RUN git clone https://github.com/collaborative-robotics/crtk_matlab_client crtk/crtk_matlab_client
RUN rm -r /home/ubuntu/catkin_ws/src/cisst-saw/sawUniversalRobot
RUN apt-get -y install python3-rospy

#install dvrk gazebo 
WORKDIR /home/ubuntu/catkin_ws/src
RUN git clone https://github.com/WPI-AIM/dvrk_env.git
WORKDIR /home/ubuntu/catkin_ws/src/dvrk_env/dvrk_description
RUN ./install.sh

WORKDIR /home/ubuntu/catkin_ws
RUN source /opt/ros/noetic/setup.bash
#RUN wstool init src
RUN catkin init
RUN catkin config --cmake-args -DCMAKE_BUILD_TYPE=Release
WORKDIR /home/ubuntu/catkin_ws/src
RUN wstool merge https://raw.githubusercontent.com/jhu-dvrk/dvrk-ros/master/dvrk_ros.rosinstall
#RUN wstool up
RUN apt-get -y update
RUN apt-get -y upgrade
RUN echo 'source ~/catkin_ws/devel/setup.bash'>> ~/.bashrc

RUN apt-get -y install ros-noetic-rqt
RUN apt-get y install ros-noetic-rqt-common-plugins

#RUN catkin build --summary



