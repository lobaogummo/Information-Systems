# SINF Template Repository

This repository serves as a sample for Information Systems (SINF), demonstrating how to utilize GitLab for managing your SINF project and providing a foundational starting point for development.

## Introduction

In this project, you will work with **Dinasore**, **PostgreSQL**, **Grafana**, and **4DIAC-IDE**. The Dynamic INtelligent Architecture for Software and MOdular REconfiguration (**Dinasore**) is a distributed platform that facilitates the configuration and development of Cyber-Physical Systems (CPS). **Dinasore** supports the implementation of Function Block (FB) based pipelines for sensor integration, data processing, and systems control. These FBs are developed in Python. **Dinasore** employs the **4DIAC-IDE** as its graphical user interface (GUI). Sensor data is produced via **Dinasore** and stored in a relational database (**PostgreSQL**). Finally, **Grafana** connects to **PostgreSQL**, enabling the visualization of this data through the creation of dashboards.

If you are utilizing this repository as a starting point, there’s no need to worry about the implementation of PostgreSQL, Grafana, and Dinasore, as they will be virtualized using Docker. You only need to have Docker installed and the 4DIAC-IDE downloaded from our provided sources. For more details on preparing the development environment, please refer to the [Documentation](#documentation) section.

## Project Management

This section contains links to GitLab resources pertinent to the management of your project, organized by individual repository.

* [Wiki](https://gitlab.up.pt/sinf/sinf-template/-/wikis)
* [Milestones](https://gitlab.up.pt/sinf/sinf-template/-/milestones)
* [Plan & Backlog](https://gitlab.up.pt/sinf/sinf-template/-/boards)

## Tutorials & Documentation

In this section, we provide links to tutorials and documentation covering
various components of the project.

### Documentation

* [Installation](docs/installation.md)  $\leftarrow$  <span style="color:red">**Start here**</span>
* [Usage](docs/usage.md)

### Tutorials

* [4DIAC-IDE](docs/4diac-ide.md)
* [PostgreSQL](docs/postgre.md)
* [Grafana](docs/grafana.md)


