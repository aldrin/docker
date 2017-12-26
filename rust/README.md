## Rust Developer Image

This image extends the standard `rust` image to simplify some common usage scenarios.

### `cover`

Runs all the tests in the project and produces a coverage report in `target/kcov/index.html`.

``` bash
» docker run --privileged -v `pwd`:/src ajdz/rust cover
```

This invokes the `cover` recipe in the [Justfile] which in turn runs the following pipeline:

```bash
» cargo test --target=x86_64-unknown-linux-gnu --no-run --message-format=json 
  | jq -r 'select(.profile.test == true) | .filenames[]' 
  | xargs -n 1 kcov --exclude-pattern=/usr/local/cargo,/usr/lib --verify target/kcov
```

### `sanitize SAN`

Runs sanitizers (see [this PR](https://github.com/rust-lang/rust/pull/38699)) for details.

```bash
» docker run --privileged -v `pwd`:/src ajdz/rust sanitize address
```

This invokes the `sanitize` recipe in the [Justfile] which in turn runs the following:

```bash
» RUSTFLAGS="-Z sanitizer=address" rustup run nightly cargo test --target x86_64-unknown-linux-gnu
```

[Justfile]: ./Justfile
