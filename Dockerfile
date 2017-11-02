FROM ubuntu:14.04
MAINTAINER asushieno <atsushieno@gmail.com>

RUN apt-get update -y && apt-get upgrade -y && apt-get install git-core gnupg flex bison gperf build-essential zip curl zlib1g-dev gcc-multilib g++-multilib libc6-dev-i386 lib32ncurses5-dev x11proto-core-dev libx11-dev lib32z-dev ccache libgl1-mesa-dev libxml2-utils xsltproc unzip -y
RUN apt-get install software-properties-common python-software-properties -y

# Java setup
RUN \
	echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | debconf-set-selections && \
	add-apt-repository -y ppa:webupd8team/java && \
	apt-get update -y && \
	apt-get install -y oracle-java8-installer && \
	rm -rf /var/lib/apt/lists/* && \
	rm -rf /var/cache/oracle-jdk8-installer
# Android SDK installation
RUN cd /usr/local/ && curl -L -O https://dl.google.com/android/repository/sdk-tools-linux-3859397.zip && unzip sdk-tools-linux-3859397.zip && \
    /usr/local/tools/bin/sdkmanager --update && yes | /usr/local/tools/bin/sdkmanager --licenses && \
    /usr/local/tools/bin/sdkmanager "platform-tools" && \
    /usr/local/tools/bin/sdkmanager "build-tools;26.0.0" && \
    /usr/local/tools/bin/sdkmanager "platforms;android-26" && \
    /usr/local/tools/bin/sdkmanager "extras;android;m2repository" && \
    /usr/local/tools/bin/sdkmanager "extras;google;m2repository" && \
    /usr/local/tools/bin/sdkmanager "extras;google;google_play_services" && \
    /usr/local/tools/bin/sdkmanager "extras;m2repository;com;android;support;constraint;constraint-layout-solver;1.0.2" && \
    /usr/local/tools/bin/sdkmanager "extras;m2repository;com;android;support;constraint;constraint-layout;1.0.2" && \
    rm -rf /usr/local/sdk-tools-linux-3859397.zip

# Install Android NDK
RUN cd /usr/local && curl -L -O https://dl.google.com/android/repository/android-ndk-r15b-linux-x86

# Environment variables
ENV JAVA_HOME /usr/lib/jvm/java-8-oracle
ENV ANDROID_HOME /usr/local/tools/bin
ENV ANDROID_NDK_HOME /usr/local/android-ndk-r15b
ENV PATH $PATH:$ANDROID_HOME/tools
ENV PATH $PATH:$ANDROID_HOME/platform-tools
ENV PATH $PATH:$ANDROID_NDK_HOME


