# Running Apache Airflow in a Docker Container

This guide outlines the steps to build and run a Docker container with Apache Airflow, and access it via port 8080.

## Step 1: Build the Docker Image

1. Navigate to the directory where the Dockerfile is located.

2. Execute the following command to build the Docker image:

    ```bash
    docker build -t airflow_dev .
    ```

    This command will create an image named `airflow_dev` based on the Dockerfile.

## Step 2: Run the Container

1. Run the Docker container using the following command:

    ```bash
    docker run -it -p 8080:8080 airflow_dev airflow webserver
    ```

    This will start the container in the background and map port 8080 from the container to port 8080 on your EC2 instance.

## Step 3: Access the Apache Airflow Web UI

1. After the container has started, you can access the Apache Airflow Web UI in your web browser by entering your EC2 instance's IP and port 8080. Use the following format:

    ```
    http://<your_ec2_ip>:8080/
    ```
    or
    
    ```
    http://localhost:8080/
    ```

2. Ensure that port 8080 is open in your EC2 instance's security group to allow internet access.

3. Replace `<your_ec2_ip>` with the actual IP address of your EC2 instance.

4. User: admin & Password:admin

Please keep in mind that this guide provides a basic setup for running Apache Airflow in a Docker container. In a production environment, consider security, scalability, and data persistence, such as using an external database for Apache Airflow and implementing additional configurations.

### Additional Docker Commands

To see all running and stopped containers, use the following command:
This code block shows commands for managing Docker containers. The `docker ps -a` command lists all containers, while `docker start <container_id>` and `docker stop <container_id>` start and stop a specific container respectively.
```
docker ps -a
```

```
docker start <container_id>
```

```
docker stop <container_id>
```
