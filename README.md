[![stable-badge]][stable-link] [![ci-badge]][ci-link] [![tag-badge]][ci-link] [![license-badge]][license-link]

<div align="center">
    <h1><code>SecFlood</code></h1>
    <strong>SecFlood is a web-based toolkit platform for generating/emulating cyber attacks and benign traffic.</strong>
</div>

# Overview

Evaluating the efficiency and reliability of cyber security tools like IDS,
firewalls, DDoS detection, etc., is always challenging due to the need for
representative data on attack traffic and near-realistic benign traffic
patterns. Despite the growth of publicly available datasets, traffic
characteristics remain remarkably restricted due to the cost of
gathering and labeling real traffic traces and privacy concerns for 
sharing them. SecFlood leverages existing traffic generation tools like
Cisco Trex, D-ITG, etc., to generate/emulate benign traffic while allowing
users to run cyber attacks through many offensive security tools. SecFlood
was designed to be executed along with Mininet-Sec
(http://github.com/mininet-sec/mininet-sec) and together with the HackInSDN
framework (https://github.com/hackinsdn/), which allows a controlled
environment for studying or experimenting with offensive and defensive
cyber security.

SecFlood main features include:

- Web-based User Interface to generate/emulate cyber attacks and benign traffic
- Traffic profiles for emulating EMIX (Enterprise MIX) traffic enhanced with DNS traces from CIC 2021 dataset.
- Hability to setup duration of a cyber attack emulation allowing customization per-tool of the number of executions, fixed and random interval between executions, attack profile, etc.
- Integration with Mininet-Sec enabling full isolation of experiments and running on different platforms (barematel/VM hosts, Kubernetes, Docker, etc)

# Getting started

The easiest way of using SecFlood is through the Docker container:

```
docker pull hackinsdn/secflood:latest
docker run -d --name secflood --privileged -p 8443:443 hackinsdn/secflood:latest
```

Now you can point your browser to https://x.x.x.x:8443/ (replace x.x.x.x with your IP address, or 127.0.0.1 if running locally).

TODO: document better the usage of the interfaces.


# Credits

SecFlood was originally based on [Kali-Linux-Tools-Interface](https://github.com/lucasfrag/Kali-Linux-Tools-Interface), a tool created by [lucasfrag](https://github.com/lucasfrag/) as a Graphical Web interface developed to facilitate the use of security information tools. Read more documentation about Kali-Linux-Tools-Interface [here](https://medium.com/@lucasfrag/documentação-do-projeto-final-de-ads-f80a1117841f) or [original README](README-orig.md).


<!-- URLs -->

[stable-badge]: https://img.shields.io/badge/stability-stable-green.svg
[stable-link]: https://github.com/hackinsdn/secflood
[ci-badge]: https://github.com/hackinsdn/secflood/actions/workflows/test.yml/badge.svg
[ci-link]: https://github.com/hackinsdn/secflood/actions/workflows/test.yml
[tag-badge]: https://img.shields.io/github/tag/hackinsdn/secflood.svg
[tag-link]: https://github.com/hackinsdn/secflood/tags
[license-badge]: https://img.shields.io/github/license/hackinsdn/secflood.svg
[license-link]: https://github.com/hackinsdn/secflood/blob/master/LICENSE
