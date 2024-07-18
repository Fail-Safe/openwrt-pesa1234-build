# openwrt-pesa1234-build

This is a definition of a viable build container for building [@pesa1234's](https://github.com/pesa1234) OpenWrt image.

## About

This project and container does not replace the need to have knowledge about the [OpenWrt Build System](https://openwrt.org/docs/guide-developer/toolchain/use-buildsystem).

The intent of this project is to provide a minimal basis for those wanting to get into building [@pesa1234's](https://github.com/pesa1234) image for the incredible [GL.iNet GL-MT6000 device](https://openwrt.org/toh/gl.inet/gl-mt6000).

Knowledge of how to work with the build system, including Menuconfig, is up to the user of this repo.

## Requirements

* One or more [GL.iNet GL-MT6000 Devices](https://openwrt.org/toh/gl.inet/gl-mt6000)
* Reading Skills (Did you read through the [OpenWrt Build System](https://openwrt.org/docs/guide-developer/toolchain/use-buildsystem) usage yet? 😉)
* Follow [@pesa1234's](https://github.com/pesa1234) [MT6000 Build Thread](https://forum.openwrt.org/t/mt6000-custom-build-with-luci-and-some-optimization-kernel-6-6-x/185241)
* Patience
* Patience
* Patience (Yes, I wrote this three times. I'm serious about this.)
* [Docker Desktop](https://www.docker.com/products/docker-desktop/)
* Basic shell/bash Experience
* Willingness to hit a bug, live through it, be a decent human, and respectfully bring it forward. 😎

## Usage

### Clone this Repo

Clone this project to your local system:

Https:
```bash
$ git clone https://github.com/Fail-Safe/openwrt-pesa1234-build.git
```

SSH:
```bash
$ git clone git@github.com:Fail-Safe/openwrt-pesa1234-build.git
```

### Container Volume

Because a Docker container's default storage is ephemeral, you will not want to lose your build environment everytime you exit the container (whether intentionally or due to a crash/reboot/etc.).

We get around this by creating a [Docker Volume](https://docs.docker.com/storage/volumes/) to hold the non-ephemeral build system. We then mount this persistent volume each time we run the build container.

I have included a script to create a Docker volume for this purpose. If you are an advanced Docker user, feel free to skip this step and configure an alternate mount option yourself.

#### Create Container Volume

Run the following one time:

```bash
$ ./scripts/1_Create_Container_Volume.sh
```

You should see this:

```bash
Copyright (C) 2024  Mark Baker <mark@vpost.net>
This program comes with ABSOLUTELY NO WARRANTY.
This is free software, and you are welcome to redistribute it
under certain conditions.

>> Creating docker volume:
pesa1234-build

>> Created docker volume pesa1234-build for your build system.
```

If you see the following output, you have already created this volume and do not need to recreate it regularly:

```bash
bash-5.2$ ./scripts/1_Create_Container_Volume.sh
Copyright (C) 2024  Mark Baker <mark@vpost.net>
This program comes with ABSOLUTELY NO WARRANTY.
This is free software, and you are welcome to redistribute it
under certain conditions.

>> ** Uh oh! The docker volume pesa1234-build already exists. You likely do not want to be running this again! **
```

### Container Image

To create or update the build container image, run the following:

```bash
$ ./scripts/2_Create_or_Update_Container_Image.sh
```

⚠ ***This will take some time to run!***

On my MacBook Pro M1, this container image takes upwards of 10 minutes to build. Grab a cola, coffee, or a water and relax. Let it run its course.

Patience is something you will need to learn if you're going to be building your own OpenWrt images. 😉

If all goes well, you will end up with some output that looks like this:

```bash
Copyright (C) 2024  Mark Baker <mark@vpost.net>
This program comes with ABSOLUTELY NO WARRANTY.
This is free software, and you are welcome to redistribute it
under certain conditions.

>> Creating docker container image:

[+] Building 484.3s (15/15) FINISHED                                                                                        docker:desktop-linux
 => [internal] load build definition from Dockerfile                                                                                        0.0s
 => => transferring dockerfile: 2.54kB                                                                                                      0.0s
 => [internal] load metadata for docker.io/library/ubuntu:23.10                                                                             0.6s
 => [internal] load .dockerignore                                                                                                           0.0s
 => => transferring context: 2B                                                                                                             0.0s
 => CACHED [ 1/10] FROM docker.io/library/ubuntu:23.10@sha256:fd7fe639db24c4e005643921beea92bc449aac4f4d40d60cd9ad9ab6456aec01              0.0s
 => => resolve docker.io/library/ubuntu:23.10@sha256:fd7fe639db24c4e005643921beea92bc449aac4f4d40d60cd9ad9ab6456aec01                       0.0s
 => [internal] load build context                                                                                                           0.0s
 => => transferring context: 1.29kB                                                                                                         0.0s
 => [ 2/10] RUN apt-get update     && apt-get upgrade -y     && apt-get install -y --no-install-recommends     bison     build-essential  398.3s
 => [ 3/10] RUN wget --ca-directory=/etc/ssl/certs/ https://go.dev/dl/go1.22.5.linux-arm64.tar.gz     && tar -C /usr/local -xzf go1.22.5.l  4.4s
 => [ 4/10] RUN bash -c "$(wget -O - https://apt.llvm.org/llvm.sh)"                                                                        51.5s
 => [ 5/10] RUN useradd -m user     && echo "user ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/user     && chown -R user:user "/home/user"     0.1s
 => [ 6/10] COPY ./assets/quiltrc /home/user/.quiltrc                                                                                       0.0s
 => [ 7/10] COPY ./assets/gitconfig /home/user/.gitconfig                                                                                   0.0s
 => [ 8/10] COPY ./assets/setup_pesa1234_repo.sh /tmp/setup_pesa1234_repo.sh                                                                0.0s
 => [ 9/10] RUN chmod +x "/tmp/setup_pesa1234_repo.sh"                                                                                      0.1s
 => [10/10] WORKDIR /home/user/openwrt                                                                                                      0.0s
 => exporting to image                                                                                                                     29.1s
 => => exporting layers                                                                                                                    22.2s
 => => exporting manifest sha256:4b13d8048abd117ab3a1fca5a9809751aab0ed9d46a7160b42ba698ff81cc5ed                                           0.0s
 => => exporting config sha256:145a689c7f8bb189ce75c166646b2fa4ca7372d6c254e457ebe21ea0c9837167                                             0.0s
 => => exporting attestation manifest sha256:f874fdd198e08287526ece2d1650ef779e1d8f3f6234d4126f4ae544325370cf                               0.0s
 => => exporting manifest list sha256:c324559a1f21341efdc7da5399e39f9f4eb58f5b5cbb6f4734112712cddca679                                      0.0s
 => => naming to docker.io/library/pesa1234-builder:latest                                                                                  0.0s
 => => unpacking to docker.io/library/pesa1234-builder:latest                                                                               6.8s

View build details: docker-desktop://dashboard/build/desktop-linux/desktop-linux/uyy2x6tq1fz18xjzpnoi9dwez

What's next:
    View a summary of image vulnerabilities and recommendations → docker scout quickview

>> Created docker container image: pesa1234-builder. You can now run ./scripts/3_Run_Build_Container.sh
```

### Run the Build Image

Once you have allowed the Container Image to build to completion, you are now ready to launch (read: run) the container.

You can do so by running:

```bash
$ ./scripts/3_Run_Build_Container.sh
```

✅ ***This script can be run anytime you want to launch your build environment.***

If all went well, you should drop into the container like so:

```bash
bash-5.2$ ./scripts/3_Run_Build_Container.sh
Copyright (C) 2024  Mark Baker <mark@vpost.net>
This program comes with ABSOLUTELY NO WARRANTY.
This is free software, and you are welcome to redistribute it
under certain conditions.

>> Running docker container...

user@7e371c1614ad:~/openwrt$
```

## Setup [Pesa1234's](https://github.com/pesa1234) Repo

Last, but far from least, there is a script you will need to **run one time** that I have placed into your container's `/tmp` directory.

You will execute the script as follows **from within the container**:

```bash
$ /tmp/setup_pesa1234_repo.sh
```

You should see output that looks like this:

```bash
Copyright (C) 2024  Mark Baker <mark@vpost.net>
This program comes with ABSOLUTELY NO WARRANTY.
This is free software, and you are welcome to redistribute it
under certain conditions.

>> Cloning pesa1234's repo into the container. This will take a bit...

Cloning into '/home/user/openwrt'...
remote: Enumerating objects: 703795, done.
remote: Counting objects: 100% (218/218), done.
remote: Compressing objects: 100% (133/133), done.
remote: Total 703795 (delta 112), reused 153 (delta 81), pack-reused 703577
Receiving objects: 100% (703795/703795), 266.93 MiB | 18.14 MiB/s, done.
Resolving deltas: 100% (474411/474411), done.
```

You can confirm you're on Pesa's latest stable branch (r2.9.3) by running:

```bash
$ git branch
* next-r2.9.3.mtk
```

If you missed my emboldened note above about running it once, you're in luck. It won't overwrite your build environment. But you will get a message like so:

```bash
user@7e371c1614ad:~/openwrt$ /tmp/setup_pesa1234_repo.sh
Copyright (C) 2024  Mark Baker <mark@vpost.net>
This program comes with ABSOLUTELY NO WARRANTY.
This is free software, and you are welcome to redistribute it
under certain conditions.

>> Cloning pesa1234's repo into the container. This will take a bit...

fatal: destination path '/home/user/openwrt' already exists and is not an empty directory.
```

## Next Steps

Did you read through the [OpenWrt Build System](https://openwrt.org/docs/guide-developer/toolchain/use-buildsystem) usage yet? 😉

Seriously.

From here the process to build will follow standard process in the OpenWrt build system.

e.g. For those of you who just aren't going to read the docs...

```bash
$ git fetch && git pull
$ ./scripts/feeds update -a && ./scripts/feeds install -a
$ make menuconfig && make defconfig
$ make -j$((1+`nproc`)) clean download world V=s 2>&1 | tee build.log | grep -i -E "^make.*(error|[12345]...Entering dir)"
```

## Feedback

I am providing this as a free resource written in my own time, just as [Pesa1234](https://github.com/pesa1234) pours hours of life into the source repo. That said, I welcome any feedback and will get to any bug fixes or improvements as time allows.

Thanks and enjoy!
