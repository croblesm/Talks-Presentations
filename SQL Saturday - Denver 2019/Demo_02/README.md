# Demo 02 - Custom image for development

* 1- Folder structure
```console
Demo_02
├── 2_1_DockerBuild.sh  # 👉 Demo script
├── Backups
│   └── humanresources_backup_2019_1105.bak
├── DBA_scripts
│   ├── RestoreDatabase.sql
│   ├── CreateLoginsMaskData.sql
│   ├── sql_deployment.sh
│   └── entry_point.sh
├── Dockerfile
├── README.md
└── .gitignore
└── .dockerignore
```
* 2- Inspect [Dockerfile](Dockerfile)
* 3- Inspect [application scripts](./DBA)
* 4- Build custom image for development
* 5- Test custom image (Create container)
* 6- Check deployment logs (Azure Data Studio)
* 7- Check DBA objects (Azure Data Studio)
* 8- Execute stored procedures (Azure Data Studio)
* 9- Tag image with Docker Hub repository and version
* 10- Push image to Docker Hub

# Questions?
If you have questions or comments about this demo, don't hesitate to contact me at <crobles@dbamastery.com>

# Contact information
[![N|Solid](http://dbamastery.com/wp-content/uploads/2018/08/if_twitter_circle_color_107170.png)](https://twitter.com/dbamastery) [![N|Solid](http://dbamastery.com/wp-content/uploads/2018/08/if_github_circle_black_107161.png)](https://github.com/dbamaster) [![N|Solid](http://dbamastery.com/wp-content/uploads/2018/08/if_linkedin_circle_color_107178.png)](https://www.linkedin.com/in/croblesdba/) [![N|Solid](http://dbamastery.com/wp-content/uploads/2018/08/if_browser_1055104.png)](http://dbamastery.com/)
