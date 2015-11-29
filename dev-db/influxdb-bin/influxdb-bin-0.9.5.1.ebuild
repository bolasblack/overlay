# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit user

DESCRIPTION="Scalable datastore for metrics, events, and real-time analytics"
HOMEPAGE="http://influxdb.com"
SRC_URI="https://s3.amazonaws.com/influxdb/influxdb_${PV}_x86_64.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

S=${WORKDIR}/influxdb_${PV}_x86_64
RPN=${PN/-bin/}

pkg_setup() {
  ebegin "Creating ${RPN} user and group"
  enewgroup ${RPN}
  enewuser ${RPN} -1 -1 "/var/lib/${RPN}" ${RPN}
  eend $?
}

src_install() {
  dobin usr/bin/influx usr/bin/influxd usr/bin/influx_inspect usr/bin/influx_stress

  keepdir /etc/influxdb
  insinto /etc/influxdb
  newins etc/influxdb/influxdb.conf influxdb.conf

  insinto /etc/logrotate.d
  newins etc/logrotate.d/influxdb influxdb

  newinitd usr/lib/influxdb/scripts/init.sh ${RPN}

  keepdir /var/log/${RPN}
  fowners -R ${RPN}:${RPN} /var/log/${RPN}
}

pkg_postinst() {
  elog "The InfluxDB Shell (CLI) is always included within the main package."
  elog "Executing 'influx' will start the CLI and automatically connect to"
  elog "the local InfluxDB instance. The InfluxDB Shell stores that last 1000"
  elog "commands in your home directory in a file called .influx_history."
  elog
  elog "The InfluxDB HTTP API includes a built-in authentication mechanism,"
  elog "based on user credentials, which is disabled by default. To add"
  elog "authentication to InfluxDB set in the [http] section of the"
  elog " config file:"
  elog
  elog "  [http]"
  elog "  ..."
  elog "  auth-enabled = true"
  elog "  ..."
  elog
  elog "By default, InfluxDB sends anonymouse statistics about your InfluxDB"
  elog "instance. If you would like to disable this funcionality, set in"
  elog "the [monitoring] section of your config file:"
  elog
  elog "  [monitoring]"
  elog "  ..."
  elog "  enabled = false"
  elog "  ..."
}
