EAPI="4"

inherit eutils flag-o-matic user git-2

DESCRIPTION="This is dnscrypt wrapper (server-side dnscrypt proxy), which helps to add dnscrypt support to any name resolver."
HOMEPAGE="https://github.com/Cofyc/dnscrypt-wrapper"
SRC_URI=""

EGIT_REPO_URI="https://github.com/Cofyc/${PN}.git"
EGIT_COMMIT="v${PV}"
EGIT_HAS_SUBMODULES="1"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 x86"

DEPEND="dev-libs/libsodium
        dev-libs/libevent"
RDEPEND="${DEPEND}"

pkg_setup() {
	enewuser dnscrypt-wrapper -1 -1 /var/empty daemon
}

src_compile() {
	emake || die "compile failed"
}

src_install() {
	dobin dnscrypt-wrapper

	keepdir /etc/dnscrypt-wrapper
	keepdir /etc/dnscrypt-wrapper/example
	insinto /etc/dnscrypt-wrapper/example
	doins example/crypt_secret.key
	doins example/dnscrypt.cert
	doins example/public.key
	doins example/secret.key
	doins example/start_proxy.sh
	doins example/start_wrapper.sh
	doins example/README.md

	newconfd "${FILESDIR}/conf" dnscrypt-wrapper
	newinitd "${FILESDIR}/init" dnscrypt-wrapper
}
