# WARP.md

This file provides guidance to WARP (warp.dev) when working with code in this repository.

Project purpose
- Source of Docker images used for Debian/Ubuntu package building. Images are tagged and published under vitexsoftware/* for multiple distro codename variants.

Common commands
- Build all maintained images (default):
  make

- Build a specific image locally (examples):
  make bookworm
  make trixie
  make forky
  make jammy
  make noble

- Multi-arch builds (uses Docker Buildx):
  # Configure buildx once in your environment
  docker buildx create --use
  # Build and push a set of images for common platforms
  make buildx
  # Or per-distro multi-arch builds
  make buildx-bookworm
  make buildx-trixie
  make buildx-forky
  make buildx-jammy
  make buildx-noble

- Publish images (after building locally with make):
  make push
  # Build and push in one go
  make publish

- Cleanup local Docker cache and remove built images:
  make clean
  # Full reset (clean + rebuild all)
  make reset

Notes
- Targets map 1:1 to distro directories and tags. For example:
  - debian:bookworm/Dockerfile -> vitexsoftware/debian:bookworm
  - debian:trixie/Dockerfile   -> vitexsoftware/debian:trixie and vitexsoftware/debian:unstable
  - ubuntu:jammy/Dockerfile    -> vitexsoftware/ubuntu:jammy and vitexsoftware/ubuntu:stable
- The update target is a placeholder for Ansible playbook usage (ansible/regenerate.yml exists but is empty). The base Dockerfile content is defined by ansible/templates/Dockerfile.j2.

High-level architecture
- Makefile orchestrates all builds:
  - Local single-arch builds via docker build -t … -f <distro>/Dockerfile <distro>/
  - Multi-arch builds via docker buildx build --platform linux/arm/v7,linux/arm64/v8,linux/amd64 … with per-distro buildx-* targets and an aggregate buildx target.
  - Tagging conventions: Debian images tag codename directly (e.g., :bookworm, :trixie) and some aliases (:unstable). Ubuntu images apply aliases like :stable for jammy and :latest for some legacy targets.
  - Utility targets: clean (prune cache and remove built images), reset (clean + all), push/publish.

- Dockerfiles by distro/codename:
  - Stored in directories named with the pattern <family>:<codename>/Dockerfile (e.g., debian:bookworm/Dockerfile, ubuntu:jammy/Dockerfile).
  - All Dockerfiles use the scripts/add-vitexsoftware-apt.sh script to configure APT repositories.
  - VitexSoftware APT repository configuration includes both main and backports components:
    - Main repository: http://repo.vitexsoftware.com/{codename}/main
    - Backports repository: http://repo.vitexsoftware.com/{codename}/backports (corresponds to http://repo.vitexsoftware.cz/pool/backports/)
  - Content for a canonical Dockerfile is captured in ansible/templates/Dockerfile.j2, which:
    - Starts FROM the requested Debian codename.
    - Sets noninteractive locale to en_US.UTF-8.
    - Adds VitexSoftware repository (main and backports) and keyring, installs packaging toolchain: pbuilder, debhelder, sudo, curl, wget, php, composer, lsb-release, jq, aptitude, gdebi-core, apt-utils, po-debconf.
    - Creates a jenkins user with passwordless sudo and prepares a workspace at /var/lib/jenkins/workspace/.
    - Adjusts PHP sendmail_path to capture mail to /tmp/mailfile.

- CI/CD
  - GitHub Actions (.github/workflows/docker-image.yml):
    - On push/PR to main: checkout, docker buildx create --use, then make buildx.
    - Updates Docker Hub description using peter-evans/dockerhub-description with Docker Hub credentials provided via repository secrets.
  - Jenkins (Jenkinsfile):
    - Matrix-style loops across architectures ['amd64','armhf','aarch64'] and distributions ['debian:bookworm','debian:trixie','ubuntu:jammy','ubuntu:noble'].
    - Stages: Build image with docker.build, Test inside container (installs linuxlogo and runs it), optional push tagged as <codename>-<BUILD_NUMBER>-SNAPSHOT when PUSH=true and with configured credentials.
  - Jenkins Test pipelines (Test/Jenkinsfile, Test/Jenkinsfile-arch):
    - Consume a built image vitexsoftware/<family>:<codename> and build a Debian package inside using debuild-pbuilder.
    - Produce artifacts under dist/debian/ and test installation via a local file-based APT repo. The -arch variant infers architectures from debian/control.

- Test assets
  - Test/ contains example Debian packaging workflow and a helper tool (ldd2debs) with README explaining usage. These are illustrative for validating images against real packaging tasks.

Getting/using images
- Pull prebuilt images from Docker Hub (see README for links):
  docker pull vitexsoftware/debian:bookworm
  docker pull vitexsoftware/debian:trixie
  docker pull vitexsoftware/debian:forky
  docker pull vitexsoftware/ubuntu:jammy
  docker pull vitexsoftware/ubuntu:noble

Testing repository configuration
- Verify that both main and backports repositories are configured:
  # Build and test a specific image
  make bookworm
  docker run --rm vitexsoftware/debian:bookworm cat /etc/apt/sources.list.d/vitexsoftware.list
  
- Expected output should show both main and backports components:
  deb [signed-by=/etc/apt/keyrings/vitexsoftware.gpg] https://repo.vitexsoftware.com bookworm main backports

- Test package availability from backports:
  docker run --rm vitexsoftware/debian:bookworm apt-cache policy

Repository policies and external agent rules
- No CLAUDE, Cursor, or Copilot rules were found in this repository. The README includes a basic quickstart (make) and links to Docker Hub tags; the critical parts are reflected above.

Troubleshooting
- If multi-arch builds fail with a driver error, ensure Buildx is initialized:
  docker buildx create --use
- Some legacy targets (e.g., bionic, hirsute, impish, kinetic) exist in the Makefile but may rely on older Dockerfiles; build/push availability can vary.

