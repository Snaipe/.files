pkgname=host-system
pkgver=0.0.1
pkgrel=0
pkgdesc="Meta package for host-provided programs, incl. coreutils"
url="localhost.localdomain"
arch="noarch"
license="none"
makedepends=""
depends=""
install=""
subpackages=""
source=""

provides="/bin/sh busybox"
replaces="busybox"
replaces_priority=1000

package() {
	mkdir -p "$pkgdir" "$pkgdir"/bin
	ln -sfT //bin/sh "$pkgdir"/bin/sh
	ln -sfT //bin/true "$pkgdir"/bin/add-shell
	ln -sfT //bin/true "$pkgdir"/bin/remove-shell
}
