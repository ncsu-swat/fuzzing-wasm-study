fn main() {
    unsafe {
        let base_fd = 5;
        let fd = wasi::path_open(
            base_fd,
            0,
            "dir/a",
            wasi::OFLAGS_CREAT,
            wasi::RIGHTS_FD_WRITE,
            0,
            0,
        )
        .unwrap();

        wasi::path_symlink("a", fd, "link").unwrap();
    }
}
