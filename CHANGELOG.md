#### 0.1.0

- Rust development and mdbook 

##### New Images

- `ajdz/rust`: An image for local rust development, mostly
   to get `kcov` running on OSX and Windows.

- `ajdz/mdbook`: mdbook is a tool to compile books from
   markdown pages. Using it directly in the CI requires us to
   `cargo install mdbook` which takes a while, this prebuilt image
   helps in reducing the build times considerably.
