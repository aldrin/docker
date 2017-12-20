[![Build Status](https://travis-ci.org/aldrin/docker-build.svg?branch=master)](https://travis-ci.org/aldrin/docker-build)

This repository defines the following Docker images published at: https://hub.docker.com/u/ajdz/

| Image         | Purpose                                         | Latest Release Tag |
|---------------|-------------------------------------------------|--------------------|
| `ajdz/rust`   | See [rust/README.md](rust/README.md)            |              0.1.0 |
| `ajdz/mdbook` | Building [mdbook] books used by [aldrin/etc] CI |              0.1.0 |

As expected, to use a released image:

```bash
> docker pull ajdz/rust:0.1.0
```

In addition to the release tags the usual `latest` tag is also available.

```bash
> docker pull ajdz/rust
```

The `latest` tag aligns with the current `master` and is also built every night. 
The nightly builds pick updates from underlying images (e.g. `FROM rust`).


[mdbook]: https://github.com/rust-lang-nursery/mdBook
[aldrin/etc]: https://github.com/aldrin/etc
