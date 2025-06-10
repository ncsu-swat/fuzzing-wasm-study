#include <stdio.h>
#include <fcntl.h>
#include <unistd.h>
#include <sys/stat.h>

int main() {
    const char* file_name = "Data/hello.txt";
    int open_style= O_RDONLY;
    int fd = get_fd(file_name, open_style);
    snapshot(fd);
    return 0;
}


int get_fd(const char* file_name, int open_style){
    // Open a file for reading
    int fd = open(file_name, open_style);
    if (fd == -1) {
        perror("Failed to open the file");
        return 1;
    }

    return fd;
}


int snapshot(int myfd){   
    struct stat file_info;
    if (fstat(myfd, &file_info) == -1) {
        perror("Error getting file attributes");
        close(myfd);
        return 1;
    }

    printf("File Size: %lld bytes\\n", (long long)file_info.st_size);
    printf("File Permissions: %o\\n", file_info.st_mode & ~S_IFMT); 
    printf("File Owner UID: %d\\n", file_info.st_uid); 
    printf("File Group GID: %d\\n", file_info.st_gid);
    

    off_t cur_offset = lseek(myfd, 0, SEEK_CUR);
    if (cur_offset == -1) {
        perror("Error getting current offset");
    }
    printf("Current offset: %lld\\n", (long long)cur_offset);

    if (close(myfd) == -1) {
        perror("Error closing file");
        return 1;
    }
}
