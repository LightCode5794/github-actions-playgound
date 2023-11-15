<!-- Improved compatibility of back to top link: See: https://github.com/othneildrew/Best-README-Template/pull/73 -->
<a name="readme-top"></a>

-->

<!-- PROJECT LOGO -->
<br />


<!-- TABLE OF CONTENTS -->
<details>
  <summary>Table of Contents</summary>
  <ol>
    <li>
      <a href="#about-the-project">About The Project</a>
    </li>
    <li>
      <a href="#prerequisites">Prerequisites</a>
    </li>
    <li><a href="#creating-your-workflow">Creating your workflow</a></li>
    <li><a href="#setting-up-a-ssh-key">Setting up a SSH Key</a></li>
    <li><a href="#setup-secrets-key">Setup secrets key</a></li>
    <li><a href="#setup-your-docker-compose">Setup your docker-compose</a></li>
    <li><a href="#setup-on-server ">Setup on server </a></li>
    <li><a href="#explanation-and-usage-of-template">Explanation and usage of Template</a>
        <ul>
            <li><a href="#workflow-trigger">Workflow trigger</a></li>
            <li><a href="#jobs-in-this-workflow">Jobs in this workflow</a></li>
        </ul>
    </li>
    <li><a href="#commit-code-and-see-the-results">Commit code and see the results</a></li>
    <li><a href="#references">References</a></li>
  </ol>
</details>



<!-- ABOUT THE PROJECT -->
## About The Project

![Alt text](image.png)

This is an example of CI/CD for your project using github action with github runner host, build image using docker, push it to github package and deploy it on remote aws server using ssh private key
Here is the basic flow of the process:

![Alt text](image-1.png)

<p align="right">(<a href="#readme-top">back to top</a>)</p>



## Prerequisites
* Your project already has a dockerfile and docker compose at the root folder
![Alt text](image-3.png)
* A server can be accessed by ssh for deployment
* Docker was installed on your server

## Creating your workflow


1. Create a <code>.github/workflows</code>  create a file named <code>ci-cd.yml</code>  (Just the example name, you can define the name you want)
2. Copy this [Template](.github\workflows\ci-cd.yaml) and paste it to <code>ci-cd.yml</code>
   
<!-- 3. Install NPM packages
   ```sh
   npm install
   ```
4. Enter your API in `config.js`
   ```js
   const API_KEY = 'ENTER YOUR API';
   ``` -->
## Setting up a SSH Key
The best practice is create the SSH Keys on local machine not remote machine. Login with username specified in Github Secrets. Generate a RSA Key-Pair:
1. Open your terminal and run the command:
 ```sh
   ssh-keygen -t rsa
   ```
2. Connect to sever, copy the private key in <code>id_rsa.pub</code> in your local machine, and paste it to /.ssh/authorized_keys on the server like this:
![Alt text](image-6.png)

## Setup secrets key
1. Click setting in your repository access the <code>Secrets and variables</code>
![Alt text](image-7.png)
2. Add three key with name <code>DEPLOY_KEY</code>, <code>HOST</code>, <code>USERNAME</code>:
* DEPLOY_KEY: the private key in file <code>id_rsa.pub</code> that you generate above
* HOST: The public ip of the deployment server
* USERNAME: SSH username, ex: ubuntu, root, ..., this the username on server you use to add the public rsa key above

You can add another key you need for your project, but three key above is required to connect to the deployment server

Note: If you want to change the name of three keys, you also must change with the same key name in secrets in [Template](.github\workflows\ci-cd.yaml)
![Alt text](image-14.png)


<p align="right">(<a href="#readme-top">back to top</a>)</p>

## Setup your docker-compose
1. Change your image follow the format: 
```
ghcr.io/{your_repository_path}:latest
```
Like this:
![Alt text](image-21.png)

2. You must add the env_file flag like this:
![Alt text](image-20.png)

## Setup on server 
1. On server you need to create an folder to save your .env and docker-compose.yaml files, in my case, this is: 
![Alt text](image-8.png)
2. Create .env file in this folder and add your environment variables , in my example case:![Alt text](image-10.png)

Note: this folder is also place github runner use to save the you docker-compose.yaml of your project

<!-- USAGE EXAMPLES -->
## Explanation and usage of [Template](.github\workflows\ci-cd.yaml)
I will explain and how to edit the template to make it suitable for your project  
![Alt text](image-12.png)

### Workflow trigger
Every time your code changes and you push it to git, if it matches the branch specified in the file, this workflow will run.
### Jobs in this workflow 

The <code>ci-cd.yml</code> will have two jobs: <b>Build</b>  and <b>Deploy</b> 

* <b>Build</b> : This job contains steps to build and push the image project to [Github package registry](https://github.com/features/packages)
* <b>Deploy</b> : This job contains steps to access the remote server, pull and run the docker image [Github package registry](https://github.com/features/packages)
1. You will access the server by secrets key
![Alt text](image-14.png)
2. The command in script will be run on server
* <code>Login</code> to github package registry
![Alt text](image-16.png)
* <code>pull</code> image image latest 
![Alt text](image-15.png)
* <code>cd</code> to your folder contain the .env file, which was created in <a href="#setup-on-server">this</a> step
![Alt text](image-17.png)
* Download the your docker-compose.yml from your github project to server
![Alt text](image-18.png)
* Delete the old container and run the new image
![Alt text](image-19.png)
## Commit code and see the results
1. After all steps above, commit and push your code
2. You will see your workflow when click the <code>Action</code>
3. You can see your image stored in the Github Package Registry
![Alt text](image-22.png)
![Alt text](image-23.png)
4. After all, let check the image and container run on your server

  
<!-- References -->
## References

* [GitHub Actions documentation](https://docs.github.com/en/actions)
* [Publishing Docker images](https://docs.github.com/en/actions/publishing-packages/publishing-docker-images)
* [Docker/login-action@v3](https://github.com/docker/login-action)
* [Docker/metadata-action@v5t](https://github.com/docker/metadata-action/)
* [Docker/build-push-action@v5](https://github.com/marketplace/actions/build-and-push-docker-images)
* [Appleboy/ssh-action@v1.0.0](https://github.com/appleboy/ssh-action)
<!-- * [GitHub Pages](https://pages.github.com)
* [Font Awesome](https://fontawesome.com) -->


<p align="right">(<a href="#readme-top">back to top</a>)</p>

