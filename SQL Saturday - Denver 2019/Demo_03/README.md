# Demo 03 - Docker compose - Database + Application

* 1- Folder structure
```console
Demo_03_
├── 3_1_DockerCompose.sh # 👉 Demo script
├── hr_app
│   ├── docker-compose.yml # 👉 Docker compose file
│   ├── backend
│   │   ├── appsettings.DockerAdmin.json
│   │   ├── appsettings.DockerWebApp.json
│   │   ├── Dockerfile
│   │   ├── Controllers # 👉 Multiple folders was ommited
│   │   └── Models # 👉 Multiple folders was ommited
│   ├── frontend
│   │   ├── Dockerfile
│   │   └── src # 👉 Multiple folders was ommited
│   └── README.md
├── .dockerignore
├── .gitignore
└── README.md
```
* 2- Inspect [Dockerfile](./hr_app/docker-compose.yml)
* 3- Execute Docker compose
* 4- Check database objects (Azure Data Studio)
* 5- Check RESTful API (Backend - RESTful API)
* 6- Check application (Frontend - Web brower)
* 7- Docker compose cleanup

# Questions?
If you have questions or comments about this demo, don't hesitate to contact me at <crobles@dbamastery.com>

# Contact information
[![N|Solid](http://dbamastery.com/wp-content/uploads/2018/08/if_twitter_circle_color_107170.png)](https://twitter.com/dbamastery) [![N|Solid](http://dbamastery.com/wp-content/uploads/2018/08/if_github_circle_black_107161.png)](https://github.com/dbamaster) [![N|Solid](http://dbamastery.com/wp-content/uploads/2018/08/if_linkedin_circle_color_107178.png)](https://www.linkedin.com/in/croblesdba/) [![N|Solid](http://dbamastery.com/wp-content/uploads/2018/08/if_browser_1055104.png)](http://dbamastery.com/)
