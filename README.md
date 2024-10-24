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
docker run -d --name secflood1 --privileged -e SECFLOOD_INTF_INSIDE=secflood1-eth0 -e SECFLOOD_GW_INSIDE=192.168.20.254 -e SECFLOOD_INTF_OUTSIDE=secflood1-eth1 -e SECFLOOD_GW_OUTSIDE=172.16.20.254 -p 8443:443 hackinsdn/secflood:latest
```

Note: the two environment variables defined above are used so that secflood can auto configure TRex for traffic generator:
- SECFLOOD\_INTF\_INSIDE: will be used for inside traffic generator
- SECFLOOD\_GW\_INSIDE: TRex need to know the destination MAC address to use on each port (in this case, inside port). You can specify this in two ways: Specify destination mac directly (not supported now on secflood) or specify the gatewat IP address and TRex will issue ARP request to this IP, and will use the result as dest MAC.
- SECFLOOD\_INTF\_OUTSIDE: will be used for outside traffic generator
- SECFLOOD\_GW\_OUTSIDE: same as for the inside port -- IP address of the gateway so that TRex will send ARP requests to know which mac address packets should be sent to on the outside interface.

The other security tools like nmap, hydra, hping3, etc. will leverage those interfaces based on the routing table and networking configs you define.

Example of manually defining those interfaces using VXLAN:
```
# assuming 10.0.1.2 will be the other side of the VXLAN tunnel for inside interface
ip link add secflood1-eth0 type vxlan id 100 remote 10.0.1.2 dstport 8472
ip link set up secflood1-eth0
ip addr add 192.168.20.1/24 dev secflood1-eth0

# assuming 10.0.2.2 will be ther other side of the VXLAN tunnel for outside interface
ip link add secflood1-eth1 type vxlan id 101 remote 10.0.2.2 dstport 8472
ip link set up secflood1-eth1
ip addr add 172.16.20.1/24 dev secflood1-eth1
```

Now you can point your browser to https://x.x.x.x:8443/ (replace x.x.x.x with your IP address, or 127.0.0.1 if running locally).



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
