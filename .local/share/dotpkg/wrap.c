#include <dlfcn.h>
#include <errno.h>
#include <fcntl.h>
#include <inttypes.h>
#include <stdarg.h>
#include <stdint.h>
#include <stdio.h>
#include <string.h>
#include <sys/mman.h>
#include <sys/stat.h>
#include <sys/types.h>

#define PATH_MAX 4096

static int (*__real_open)(const char *, int, ...);
static int (*__real_openat)(int, const char *, int, ...);
static int (*__real_stat)(const char *, struct stat *);
static int (*__real_lstat)(const char *, struct stat *);
static int (*__real_fstatat)(int, const char *, struct stat *, int);
static void *(*__real_dlopen)(const char *, int);
static ssize_t (*__real_readlink)(const char *, char *, size_t);
static ssize_t (*__real_readlinkat)(int, const char *, char *, size_t);
static int (*__real_access)(const char *, int);
static int (*__real_faccessat)(int, const char *, int, int);

__attribute__((constructor))
void init(void)
{
	__real_open = dlsym((void *)-1, "open");
	__real_openat = dlsym((void *)-1, "openat");
	__real_stat = dlsym((void *)-1, "stat");
	__real_lstat = dlsym((void *)-1, "lstat");
	__real_fstatat = dlsym((void *)-1, "fstatat");
	__real_dlopen = dlsym((void *)-1, "dlopen");
	__real_readlink = dlsym((void *)-1, "readlink");
	__real_readlinkat = dlsym((void *)-1, "readlinkat");
	__real_access = dlsym((void *)-1, "access");
	__real_faccessat = dlsym((void *)-1, "faccessat");
}

static void translate_path(const char **pathname, char *newpath)
{
	if ((*pathname)[0] != '/')
		return;

#ifdef DEBUG
	fprintf(stderr, "trying to open %s\n", *pathname);
#endif

	if ((*pathname)[1] == '/') {
		*pathname = &(*pathname)[1];
		return;
	}

	if (!strncmp(*pathname, "$HOME/.local", sizeof ("$HOME/.local")))
		return;

	if (!strncmp(*pathname, "/usr", 4)
			|| !strncmp(*pathname, "/etc", 4)
			|| !strncmp(*pathname, "/lib", 4)
			|| !strncmp(*pathname, "/bin", 4))
	{
		int i = 0;
		for (; (*pathname)[i]; ++i)
			newpath[i + sizeof ("$HOME/.local") - 1] = (*pathname)[i];
		newpath[i + sizeof ("$HOME/.local") - 1] = 0;

		struct stat sb;
		if (__real_lstat(newpath, &sb) != -1 || errno != ENOENT)
			*pathname = newpath;
	}

#ifdef DEBUG
	fprintf(stderr, "changed to open %s\n", *pathname);
	fflush(stderr);
#endif
}

void *dlopen(const char *pathname, int flags)
{
	char newpath[PATH_MAX] = "$HOME/.local";
	translate_path(&pathname, newpath);
	return __real_dlopen(pathname, flags);
}

int stat(const char *pathname, struct stat *statbuf)
{
	char newpath[PATH_MAX] = "$HOME/.local";
	translate_path(&pathname, newpath);
	return __real_stat(pathname, statbuf);
}

int lstat(const char *pathname, struct stat *statbuf)
{
	char newpath[PATH_MAX] = "$HOME/.local";
	translate_path(&pathname, newpath);
	return __real_lstat(pathname, statbuf);
}

int fstatat(int fd, const char *pathname, struct stat *statbuf, int flags)
{
	char newpath[PATH_MAX] = "$HOME/.local";
	translate_path(&pathname, newpath);
	return __real_fstatat(fd, pathname, statbuf, flags);
}

int open(const char *pathname, int flags, ...)
{
	va_list vl;
	va_start(vl, flags);
	int mode = va_arg(vl, int);
	va_end(vl);

	char newpath[PATH_MAX] = "$HOME/.local";
	translate_path(&pathname, newpath);
	return __real_open(pathname, flags, mode);
}

int openat(int fd, const char *pathname, int flags, ...)
{
	va_list vl;
	va_start(vl, flags);
	int mode = va_arg(vl, int);
	va_end(vl);

	char newpath[PATH_MAX] = "$HOME/.local";
	translate_path(&pathname, newpath);
	return __real_openat(fd, pathname, flags, mode);
}

ssize_t readlink(const char *pathname, char *buf, size_t bufsize)
{
	char newpath[PATH_MAX] = "$HOME/.local";
	translate_path(&pathname, newpath);
	return __real_readlink(pathname, buf, bufsize);
}

ssize_t readlinkat(int fd, const char *pathname, char *buf, size_t bufsize)
{
	char newpath[PATH_MAX] = "$HOME/.local";
	translate_path(&pathname, newpath);
	return __real_readlinkat(fd, pathname, buf, bufsize);
}

int access(const char *pathname, int mode)
{
	char newpath[PATH_MAX] = "$HOME/.local";
	translate_path(&pathname, newpath);
	return __real_access(pathname, mode);
}

int faccessat(int dirfd, const char *pathname, int mode, int flags)
{
	char newpath[PATH_MAX] = "$HOME/.local";
	translate_path(&pathname, newpath);
	return __real_faccessat(dirfd, pathname, mode, flags);
}
