Author  : CarbonSphere <br>
Email   : carbonsphere@gmail.com<br>


<h2>Dockerfile for building docker image. This Base image is based on carbonsphere/docker-centos6-php-nginx </h2>

<h3> This image provides a MySQL DB on port 3306 and PHPMyAdmin on port 80. It also has a createUserDb.sh to help create a new user granted access to new db.</h3>

<h4>Steps for creating image from Dockerfile and running procedure:</h4>

<b>1 :</b> Clone Docker-Mysql-PHPMyAdmin.git
<pre>
<b>Command: </b>
git clone https://github.com/carbonsphere/docker-mysql-phpmyadmin.git
</pre>

<b>2 :</b> Build docker image from Dockerfile
<pre>
<b>Command: </b>
#Change Directory
cd Docker-Mysql-PHPMyAdmin

#Build Image
sudo docker build -t #YOUR_IMAGE_NAME# .
#ex:  sudo docker build -t youraccount/docker-mysql-phpmyadmin .
</pre>

<b>3 :</b> Run image
<pre>
<b>Command: </b>
sudo docker run -d -P youraccount/docker-mysql-phpmyadmin 

</pre>

<b>4 :</b> Run image
<pre>
<b>Command: </b>
sudo docker run -d -P --name db youraccount/docker-mysql-phpmyadmin 

#docker_daemon_ip#:#image_port#
docker_daemon_ip can be found using "boot2docker ip" or you can check your environment variable "echo $DOCKER_HOST"
image_port can be found using "docker port db"

</pre>
