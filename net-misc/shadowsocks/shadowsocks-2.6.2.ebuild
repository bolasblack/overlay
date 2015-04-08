# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

PYTHON_COMPAT=( python{2_6,2_7,3_3,3_4} )

inherit user distutils-r1

DESCRIPTION="Shadowsocks server-side"
HOMEPAGE="https://github.com/clowwindy/shadowsocks"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND="dev-python/pip"
RDEPEND="${DEPEND}"

pkg_setup() {
	enewuser shadowsocks -1 -1 /var/empty shadowsocks
}

src_install() {
	distutils-r1_src_install

	keepdir /var/log/shadowsocks
	fowners shadowsocks:shadowsocks /var/log/shadowsocks

	insinto /etc
	if [ ! -s /etc/shadowsocks.json ]; then
		newins "${FILESDIR}/shadowsocks.json" shadowsocks.json
	fi
	newconfd "${FILESDIR}/conf" shadowsocks
	newinitd "${FILESDIR}/init" shadowsocks
}
