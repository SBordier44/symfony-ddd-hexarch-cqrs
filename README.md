[![Version][version-shield]][version]
[![Contributors][contributors-shield]][contributors-url]
[![Forks][forks-shield]][forks-url]
[![Stargazers][stars-shield]][stars-url]
[![Issues][issues-shield]][issues-url]
[![MIT License][license-shield]][license-url]
[![LinkedIn][linkedin-shield]][linkedin-url]

<br />

<h2 align="center">symfony-ddd-hexarch-cqrs</h3>
<p align="center">
    Code examples and good practices using Domain Drive Development, Hexagonal Architecture, CQRS, 
    Symfony 5, PHP8 and anything else I can think of... 
    <br /><br />
    <a href="https://github.com/masfernandez/symfony-ddd-hexarch-cqrs/issues">Report Bug</a>
    ·
    <a href="https://github.com/masfernandez/symfony-ddd-hexarch-cqrs/issues">Request Feature</a>
</p>

<br />

<details open="open">
  <summary>Table of Contents</summary>
  <ol>
    <li>
      <a href="#about-the-project">About The Project</a>
    </li>
    <li>
      <a href="#getting-started">Getting Started</a>
      <ul>
        <li><a href="#prerequisites">Prerequisites</a></li>
        <li><a href="#installation">Installation</a></li>
        <li><a href="#running-prod-env">Running prod env</a></li>
        <ul>
            <li><a href="#curl-examples">Curl examples</a></li>
        </ul>
        <li><a href="#running-dev-env">Running dev env</a></li>
        <li><a href="#tests">Tests</a></li>
      </ul>
    </li>
    <li><a href="#roadmap">Roadmap</a></li>
    <li><a href="#contributing">Contributing</a></li>
    <li><a href="#license">License</a></li>
    <li><a href="#contact">Contact</a></li>
    <li><a href="#acknowledgements">Acknowledgements</a></li>
  </ol>
</details>

## About The Project

I have created this project to have a guide of code examples and good practices as a future reference for me and for anyone who may be interested.

I will be adding more examples that I think are interesting and that provide an extra for anyone who wants to get started in the technologies mentioned bellow.

**Features**

- [x] PHP8
- [x] Symfony 5
- [x] DDD guidelines
- [x] Hexagonal Architecture
- [x] SOLID
- [x] Docker  
- [x] Albums module with CQRS pattern (command and query bus)
- [x] Behat 
- [x] PHPUnit

**Upcoming Features**
- [] Redis examples
- [] Authorization JWT to some endpoints
- [] Frontend (Vue, Webpack, Babel, etc.)


## Getting Started

### Prerequisites

- docker: How to install docker? [Please click here](https://docs.docker.com/install/)
- composer: How to install composer? [Please click here](https://getcomposer.org/download/)
- make

### Installation

```
git clone https://github.com/masfernandez/symfony-ddd-hexarch-cqrs.git
make composer-install
make up
```

### Running prod env

```
make prod-start
```
After few seconds, you have some services running up. 

- Rabbit 
```
url: http://localhost:15672
user: root
pass: toor
```

- Kibana
```
url: http://localhost:5601
```

#### Curl examples

- Create a new Album:
```
curl -X POST 'https://backend.127.0.0.1.xip.io/albums/0da69030-3ed7-42b5-8aa5-25fb61dab1b9' \
-H 'Content-Type: application/json' \
--data-raw '{
    "id": "0da69030-3ed7-42b5-8aa5-25fb61dab1b2",
    "title": "Abbey Road",
    "publishing_date": "1969-09-26 00:00:00"
}'
```

- Get all Albums:
```
curl -X GET 'https://backend.127.0.0.1.xip.io/albums?page[number]=1&page[size]=1&sort=title&fields[albums]=id,title,publishing_date'
```

### Running dev env

Only few docker services will up for development... It can be change easily as you prefer.

```
make dev-start
```

### Tests
```
make test
```


## Roadmap

See the [open issues](https://github.com/masfernandez/symfony-ddd-hexarch-cqrs/issues) for a list of proposed features (and known issues).


## Contributing

Contributions are what make the open source community such an amazing place to be learn, inspire, and create. Any contributions you make are **greatly appreciated**.

1. Fork the Project
2. Create your Feature Branch (`git checkout -b feature/AmazingFeature`)
3. Commit your Changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the Branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request


## License

Distributed under the MIT License. See `LICENSE.txt` for more information.


## Contact

Miguel Ángel Sánchez Fernández - mangel.sanfer@gmail.com

Project Link: [https://github.com/masfernandez/symfony-ddd-hexarch-cqrs](https://github.com/masfernandez/symfony-ddd-hexarch-cqrs)


## Acknowledgements

* README template based on: [https://github.com/othneildrew/Best-README-Template](https://github.com/othneildrew/Best-README-Template)
* CHANGELOG template based on: [https://keepachangelog.com/en/1.0.0/](https://keepachangelog.com/en/1.0.0/)

[version-shield]: https://img.shields.io/github/v/release/masfernandez/symfony-ddd-hexarch-cqrs?style=for-the-badge
[version]: https://github.com/masfernandez/symfony-ddd-hexarch-cqrs/releases

[contributors-shield]: https://img.shields.io/github/contributors/masfernandez/symfony-ddd-hexarch-cqrs.svg?style=for-the-badge
[contributors-url]: https://github.com/masfernandez/symfony-ddd-hexarch-cqrs/graphs/contributors

[forks-shield]: https://img.shields.io/github/forks/masfernandez/symfony-ddd-hexarch-cqrs.svg?style=for-the-badge
[forks-url]: https://github.com/masfernandez/symfony-ddd-hexarch-cqrs/network/members

[stars-shield]: https://img.shields.io/github/stars/masfernandez/symfony-ddd-hexarch-cqrs.svg?style=for-the-badge
[stars-url]: https://github.com/masfernandez/symfony-ddd-hexarch-cqrs/stargazers

[issues-shield]: https://img.shields.io/github/issues/masfernandez/symfony-ddd-hexarch-cqrs.svg?style=for-the-badge
[issues-url]: https://github.com/masfernandez/symfony-ddd-hexarch-cqrs/issues

[license-shield]: https://img.shields.io/github/license/masfernandez/symfony-ddd-hexarch-cqrs.svg?style=for-the-badge
[license-url]: https://github.com/masfernandez/symfony-ddd-hexarch-cqrs/blob/master/LICENSE.txt

[linkedin-shield]: https://img.shields.io/badge/-LinkedIn-black.svg?style=for-the-badge&logo=linkedin&colorB=555
[linkedin-url]: https://linkedin.com/in/masfernande