{ system, pkgs, callTest }:
# The return value of this function will be an attrset with arbitrary depth and
# the `anything` returned by callTest at its test leafs.
# The tests not supported by `system` will be replaced with `{}`, so that
# `passthru.tests` can contain links to those without breaking on architectures
# where said tests are unsupported.
# Example callTest that just extracts the derivation from the test:
#   callTest = t: t.test;

with pkgs.lib;

let
  discoverTests = val:
    if !isAttrs val then val
    else if hasAttr "test" val then callTest val
    else mapAttrs (n: s: discoverTests s) val;
  handleTest = path: args:
    discoverTests (import path ({ inherit system pkgs; } // args));
  handleTestOn = systems: path: args:
    if elem system systems then handleTest path args
    else {};

  nixosLib = import ../lib {
    # Experimental features need testing too, but there's no point in warning
    # about it, so we enable the feature flag.
    featureFlags.minimalModules = {};
  };
  evalMinimalConfig = module: nixosLib.evalModules { modules = [ module ]; };
in
{
  _3proxy = handleTest ./3proxy.nix {};
  acme = handleTest ./acme.nix {};
  adguardhome = handleTest ./adguardhome.nix {};
  aesmd = handleTest ./aesmd.nix {};
  agate = handleTest ./web-servers/agate.nix {};
  agda = handleTest ./agda.nix {};
  airsonic = handleTest ./airsonic.nix {};
  amazon-init-shell = handleTest ./amazon-init-shell.nix {};
  apfs = handleTest ./apfs.nix {};
  apparmor = handleTest ./apparmor.nix {};
  atd = handleTest ./atd.nix {};
  atop = handleTest ./atop.nix {};
  avahi = handleTest ./avahi.nix {};
  avahi-with-resolved = handleTest ./avahi.nix { networkd = true; };
  babeld = handleTest ./babeld.nix {};
  bazarr = handleTest ./bazarr.nix {};
  bcachefs = handleTestOn ["x86_64-linux" "aarch64-linux"] ./bcachefs.nix {};
  beanstalkd = handleTest ./beanstalkd.nix {};
  bees = handleTest ./bees.nix {};
  bind = handleTest ./bind.nix {};
  bird = handleTest ./bird.nix {};
  bitcoind = handleTest ./bitcoind.nix {};
  bittorrent = handleTest ./bittorrent.nix {};
  blockbook-frontend = handleTest ./blockbook-frontend.nix {};
  blocky = handleTest ./blocky.nix {};
  boot = handleTestOn ["x86_64-linux" "aarch64-linux"] ./boot.nix {};
  boot-stage1 = handleTest ./boot-stage1.nix {};
  borgbackup = handleTest ./borgbackup.nix {};
  botamusique = handleTest ./botamusique.nix {};
  bpf = handleTestOn ["x86_64-linux" "aarch64-linux"] ./bpf.nix {};
  breitbandmessung = handleTest ./breitbandmessung.nix {};
  brscan5 = handleTest ./brscan5.nix {};
  btrbk = handleTest ./btrbk.nix {};
  buildbot = handleTest ./buildbot.nix {};
  buildkite-agents = handleTest ./buildkite-agents.nix {};
  caddy = handleTest ./caddy.nix {};
  cadvisor = handleTestOn ["x86_64-linux"] ./cadvisor.nix {};
  cage = handleTest ./cage.nix {};
  cagebreak = handleTest ./cagebreak.nix {};
  calibre-web = handleTest ./calibre-web.nix {};
  cassandra_2_1 = handleTest ./cassandra.nix { testPackage = pkgs.cassandra_2_1; };
  cassandra_2_2 = handleTest ./cassandra.nix { testPackage = pkgs.cassandra_2_2; };
  cassandra_3_0 = handleTest ./cassandra.nix { testPackage = pkgs.cassandra_3_0; };
  cassandra_3_11 = handleTest ./cassandra.nix { testPackage = pkgs.cassandra_3_11; };
  ceph-multi-node = handleTestOn ["x86_64-linux"] ./ceph-multi-node.nix {};
  ceph-single-node = handleTestOn ["x86_64-linux"] ./ceph-single-node.nix {};
  ceph-single-node-bluestore = handleTestOn ["x86_64-linux"] ./ceph-single-node-bluestore.nix {};
  certmgr = handleTest ./certmgr.nix {};
  cfssl = handleTestOn ["x86_64-linux"] ./cfssl.nix {};
  charliecloud = handleTest ./charliecloud.nix {};
  chromium = (handleTestOn ["x86_64-linux"] ./chromium.nix {}).stable or {};
  cjdns = handleTest ./cjdns.nix {};
  clickhouse = handleTest ./clickhouse.nix {};
  cloud-init = handleTest ./cloud-init.nix {};
  cntr = handleTest ./cntr.nix {};
  cockroachdb = handleTestOn ["x86_64-linux"] ./cockroachdb.nix {};
  collectd = handleTest ./collectd.nix {};
  consul = handleTest ./consul.nix {};
  containers-bridge = handleTest ./containers-bridge.nix {};
  containers-custom-pkgs.nix = handleTest ./containers-custom-pkgs.nix {};
  containers-ephemeral = handleTest ./containers-ephemeral.nix {};
  containers-extra_veth = handleTest ./containers-extra_veth.nix {};
  containers-hosts = handleTest ./containers-hosts.nix {};
  containers-imperative = handleTest ./containers-imperative.nix {};
  containers-ip = handleTest ./containers-ip.nix {};
  containers-macvlans = handleTest ./containers-macvlans.nix {};
  containers-names = handleTest ./containers-names.nix {};
  containers-nested = handleTest ./containers-nested.nix {};
  containers-physical_interfaces = handleTest ./containers-physical_interfaces.nix {};
  containers-portforward = handleTest ./containers-portforward.nix {};
  containers-reloadable = handleTest ./containers-reloadable.nix {};
  containers-restart_networking = handleTest ./containers-restart_networking.nix {};
  containers-tmpfs = handleTest ./containers-tmpfs.nix {};
  convos = handleTest ./convos.nix {};
  corerad = handleTest ./corerad.nix {};
  coturn = handleTest ./coturn.nix {};
  couchdb = handleTest ./couchdb.nix {};
  cri-o = handleTestOn ["x86_64-linux"] ./cri-o.nix {};
  custom-ca = handleTest ./custom-ca.nix {};
  croc = handleTest ./croc.nix {};
  cryptpad = handleTest ./cryptpad.nix {};
  deluge = handleTest ./deluge.nix {};
  dendrite = handleTest ./dendrite.nix {};
  dex-oidc = handleTest ./dex-oidc.nix {};
  dhparams = handleTest ./dhparams.nix {};
  disable-installer-tools = handleTest ./disable-installer-tools.nix {};
  discourse = handleTest ./discourse.nix {};
  dnscrypt-proxy2 = handleTestOn ["x86_64-linux"] ./dnscrypt-proxy2.nix {};
  dnscrypt-wrapper = handleTestOn ["x86_64-linux"] ./dnscrypt-wrapper {};
  dnsdist = handleTest ./dnsdist.nix {};
  doas = handleTest ./doas.nix {};
  docker = handleTestOn ["x86_64-linux"] ./docker.nix {};
  docker-rootless = handleTestOn ["x86_64-linux"] ./docker-rootless.nix {};
  docker-edge = handleTestOn ["x86_64-linux"] ./docker-edge.nix {};
  docker-registry = handleTest ./docker-registry.nix {};
  docker-tools = handleTestOn ["x86_64-linux"] ./docker-tools.nix {};
  docker-tools-cross = handleTestOn ["x86_64-linux" "aarch64-linux"] ./docker-tools-cross.nix {};
  docker-tools-overlay = handleTestOn ["x86_64-linux"] ./docker-tools-overlay.nix {};
  documize = handleTest ./documize.nix {};
  doh-proxy-rust = handleTest ./doh-proxy-rust.nix {};
  dokuwiki = handleTest ./dokuwiki.nix {};
  domination = handleTest ./domination.nix {};
  dovecot = handleTest ./dovecot.nix {};
  drbd = handleTest ./drbd.nix {};
  ec2-config = (handleTestOn ["x86_64-linux"] ./ec2.nix {}).boot-ec2-config or {};
  ec2-nixops = (handleTestOn ["x86_64-linux"] ./ec2.nix {}).boot-ec2-nixops or {};
  ecryptfs = handleTest ./ecryptfs.nix {};
  ejabberd = handleTest ./xmpp/ejabberd.nix {};
  elk = handleTestOn ["x86_64-linux"] ./elk.nix {};
  emacs-daemon = handleTest ./emacs-daemon.nix {};
  engelsystem = handleTest ./engelsystem.nix {};
  enlightenment = handleTest ./enlightenment.nix {};
  env = handleTest ./env.nix {};
  ergo = handleTest ./ergo.nix {};
  ergochat = handleTest ./ergochat.nix {};
  etc = pkgs.callPackage ../modules/system/etc/test.nix { inherit evalMinimalConfig; };
  etcd = handleTestOn ["x86_64-linux"] ./etcd.nix {};
  etcd-cluster = handleTestOn ["x86_64-linux"] ./etcd-cluster.nix {};
  etebase-server = handleTest ./etebase-server.nix {};
  etesync-dav = handleTest ./etesync-dav.nix {};
  fancontrol = handleTest ./fancontrol.nix {};
  fcitx = handleTest ./fcitx {};
  fenics = handleTest ./fenics.nix {};
  ferm = handleTest ./ferm.nix {};
  firefox = handleTest ./firefox.nix { firefoxPackage = pkgs.firefox; };
  firefox-esr    = handleTest ./firefox.nix { firefoxPackage = pkgs.firefox-esr; }; # used in `tested` job
  firefox-esr-91 = handleTest ./firefox.nix { firefoxPackage = pkgs.firefox-esr-91; };
  firejail = handleTest ./firejail.nix {};
  firewall = handleTest ./firewall.nix {};
  fish = handleTest ./fish.nix {};
  flannel = handleTestOn ["x86_64-linux"] ./flannel.nix {};
  fluentd = handleTest ./fluentd.nix {};
  fluidd = handleTest ./fluidd.nix {};
  fontconfig-default-fonts = handleTest ./fontconfig-default-fonts.nix {};
  freeswitch = handleTest ./freeswitch.nix {};
  frr = handleTest ./frr.nix {};
  fsck = handleTest ./fsck.nix {};
  ft2-clone = handleTest ./ft2-clone.nix {};
  gerrit = handleTest ./gerrit.nix {};
  geth = handleTest ./geth.nix {};
  ghostunnel = handleTest ./ghostunnel.nix {};
  gitdaemon = handleTest ./gitdaemon.nix {};
  gitea = handleTest ./gitea.nix {};
  gitlab = handleTest ./gitlab.nix {};
  gitolite = handleTest ./gitolite.nix {};
  gitolite-fcgiwrap = handleTest ./gitolite-fcgiwrap.nix {};
  glusterfs = handleTest ./glusterfs.nix {};
  gnome = handleTest ./gnome.nix {};
  gnome-xorg = handleTest ./gnome-xorg.nix {};
  go-neb = handleTest ./go-neb.nix {};
  gobgpd = handleTest ./gobgpd.nix {};
  gocd-agent = handleTest ./gocd-agent.nix {};
  gocd-server = handleTest ./gocd-server.nix {};
  google-oslogin = handleTest ./google-oslogin {};
  gotify-server = handleTest ./gotify-server.nix {};
  grafana = handleTest ./grafana.nix {};
  graphite = handleTest ./graphite.nix {};
  graylog = handleTest ./graylog.nix {};
  grocy = handleTest ./grocy.nix {};
  grub = handleTest ./grub.nix {};
  gvisor = handleTest ./gvisor.nix {};
  hadoop.all = handleTestOn [ "x86_64-linux" "aarch64-linux" ] ./hadoop/hadoop.nix {};
  hadoop.hdfs = handleTestOn [ "x86_64-linux" "aarch64-linux" ] ./hadoop/hdfs.nix {};
  hadoop.yarn = handleTestOn [ "x86_64-linux" "aarch64-linux" ] ./hadoop/yarn.nix {};
  haka = handleTest ./haka.nix {};
  haproxy = handleTest ./haproxy.nix {};
  hardened = handleTest ./hardened.nix {};
  hedgedoc = handleTest ./hedgedoc.nix {};
  herbstluftwm = handleTest ./herbstluftwm.nix {};
  installed-tests = pkgs.recurseIntoAttrs (handleTest ./installed-tests {});
  invidious = handleTest ./invidious.nix {};
  oci-containers = handleTestOn ["x86_64-linux"] ./oci-containers.nix {};
  odoo = handleTest ./odoo.nix {};
  # 9pnet_virtio used to mount /nix partition doesn't support
  # hibernation. This test happens to work on x86_64-linux but
  # not on other platforms.
  hibernate = handleTestOn ["x86_64-linux"] ./hibernate.nix {};
  hitch = handleTest ./hitch {};
  hledger-web = handleTest ./hledger-web.nix {};
  hocker-fetchdocker = handleTest ./hocker-fetchdocker {};
  hockeypuck = handleTest ./hockeypuck.nix { };
  home-assistant = handleTest ./home-assistant.nix {};
  hostname = handleTest ./hostname.nix {};
  hound = handleTest ./hound.nix {};
  hub = handleTest ./git/hub.nix {};
  hydra = handleTest ./hydra {};
  i3wm = handleTest ./i3wm.nix {};
  icingaweb2 = handleTest ./icingaweb2.nix {};
  iftop = handleTest ./iftop.nix {};
  ihatemoney = handleTest ./ihatemoney {};
  incron = handleTest ./incron.nix {};
  influxdb = handleTest ./influxdb.nix {};
  initrd-network-openvpn = handleTest ./initrd-network-openvpn {};
  initrd-network-ssh = handleTest ./initrd-network-ssh {};
  initrdNetwork = handleTest ./initrd-network.nix {};
  initrd-secrets = handleTest ./initrd-secrets.nix {};
  input-remapper = handleTest ./input-remapper.nix {};
  inspircd = handleTest ./inspircd.nix {};
  installer = handleTest ./installer.nix {};
  invoiceplane = handleTest ./invoiceplane.nix {};
  iodine = handleTest ./iodine.nix {};
  ipfs = handleTest ./ipfs.nix {};
  ipv6 = handleTest ./ipv6.nix {};
  iscsi-multipath-root = handleTest ./iscsi-multipath-root.nix {};
  iscsi-root = handleTest ./iscsi-root.nix {};
  isso = handleTest ./isso.nix {};
  jackett = handleTest ./jackett.nix {};
  jellyfin = handleTest ./jellyfin.nix {};
  jenkins = handleTest ./jenkins.nix {};
  jenkins-cli = handleTest ./jenkins-cli.nix {};
  jibri = handleTest ./jibri.nix {};
  jirafeau = handleTest ./jirafeau.nix {};
  jitsi-meet = handleTest ./jitsi-meet.nix {};
  k3s-single-node = handleTest ./k3s-single-node.nix {};
  k3s-single-node-docker = handleTest ./k3s-single-node-docker.nix {};
  kafka = handleTest ./kafka.nix {};
  kbd-setfont-decompress = handleTest ./kbd-setfont-decompress.nix {};
  kbd-update-search-paths-patch = handleTest ./kbd-update-search-paths-patch.nix {};
  kea = handleTest ./kea.nix {};
  keepalived = handleTest ./keepalived.nix {};
  keepassxc = handleTest ./keepassxc.nix {};
  kerberos = handleTest ./kerberos/default.nix {};
  kernel-generic = handleTest ./kernel-generic.nix {};
  kernel-latest-ath-user-regd = handleTest ./kernel-latest-ath-user-regd.nix {};
  kexec = handleTest ./kexec.nix {};
  keycloak = discoverTests (import ./keycloak.nix);
  keymap = handleTest ./keymap.nix {};
  knot = handleTest ./knot.nix {};
  krb5 = discoverTests (import ./krb5 {});
  ksm = handleTest ./ksm.nix {};
  kubernetes = handleTestOn ["x86_64-linux"] ./kubernetes {};
  latestKernel.login = handleTest ./login.nix { latestKernel = true; };
  leaps = handleTest ./leaps.nix {};
  libinput = handleTest ./libinput.nix {};
  libreddit = handleTest ./libreddit.nix {};
  libresprite = handleTest ./libresprite.nix {};
  libreswan = handleTest ./libreswan.nix {};
  lidarr = handleTest ./lidarr.nix {};
  lightdm = handleTest ./lightdm.nix {};
  limesurvey = handleTest ./limesurvey.nix {};
  litestream = handleTest ./litestream.nix {};
  locate = handleTest ./locate.nix {};
  login = handleTest ./login.nix {};
  logrotate = handleTest ./logrotate.nix {};
  loki = handleTest ./loki.nix {};
  lxd = handleTest ./lxd.nix {};
  lxd-image = handleTest ./lxd-image.nix {};
  lxd-nftables = handleTest ./lxd-nftables.nix {};
  lxd-image-server = handleTest ./lxd-image-server.nix {};
  #logstash = handleTest ./logstash.nix {};
  lorri = handleTest ./lorri/default.nix {};
  maddy = handleTest ./maddy.nix {};
  magic-wormhole-mailbox-server = handleTest ./magic-wormhole-mailbox-server.nix {};
  magnetico = handleTest ./magnetico.nix {};
  mailcatcher = handleTest ./mailcatcher.nix {};
  mailhog = handleTest ./mailhog.nix {};
  man = handleTest ./man.nix {};
  mariadb-galera = handleTest ./mysql/mariadb-galera.nix {};
  matomo = handleTest ./matomo.nix {};
  matrix-appservice-irc = handleTest ./matrix-appservice-irc.nix {};
  matrix-conduit = handleTest ./matrix-conduit.nix {};
  matrix-synapse = handleTest ./matrix-synapse.nix {};
  mattermost = handleTest ./mattermost.nix {};
  mediatomb = handleTest ./mediatomb.nix {};
  mediawiki = handleTest ./mediawiki.nix {};
  meilisearch = handleTest ./meilisearch.nix {};
  memcached = handleTest ./memcached.nix {};
  metabase = handleTest ./metabase.nix {};
  minecraft = handleTest ./minecraft.nix {};
  minecraft-server = handleTest ./minecraft-server.nix {};
  minidlna = handleTest ./minidlna.nix {};
  miniflux = handleTest ./miniflux.nix {};
  minio = handleTest ./minio.nix {};
  misc = handleTest ./misc.nix {};
  mjolnir = handleTest ./matrix/mjolnir.nix {};
  mod_perl = handleTest ./mod_perl.nix {};
  molly-brown = handleTest ./molly-brown.nix {};
  mongodb = handleTest ./mongodb.nix {};
  moodle = handleTest ./moodle.nix {};
  morty = handleTest ./morty.nix {};
  mosquitto = handleTest ./mosquitto.nix {};
  moosefs = handleTest ./moosefs.nix {};
  mpd = handleTest ./mpd.nix {};
  mpv = handleTest ./mpv.nix {};
  mumble = handleTest ./mumble.nix {};
  musescore = handleTest ./musescore.nix {};
  munin = handleTest ./munin.nix {};
  mutableUsers = handleTest ./mutable-users.nix {};
  mxisd = handleTest ./mxisd.nix {};
  mysql = handleTest ./mysql/mysql.nix {};
  mysql-autobackup = handleTest ./mysql/mysql-autobackup.nix {};
  mysql-backup = handleTest ./mysql/mysql-backup.nix {};
  mysql-replication = handleTest ./mysql/mysql-replication.nix {};
  n8n = handleTest ./n8n.nix {};
  nagios = handleTest ./nagios.nix {};
  nar-serve = handleTest ./nar-serve.nix {};
  nat.firewall = handleTest ./nat.nix { withFirewall = true; };
  nat.firewall-conntrack = handleTest ./nat.nix { withFirewall = true; withConntrackHelpers = true; };
  nat.standalone = handleTest ./nat.nix { withFirewall = false; };
  nats = handleTest ./nats.nix {};
  navidrome = handleTest ./navidrome.nix {};
  nbd = handleTest ./nbd.nix {};
  ncdns = handleTest ./ncdns.nix {};
  ndppd = handleTest ./ndppd.nix {};
  nebula = handleTest ./nebula.nix {};
  neo4j = handleTest ./neo4j.nix {};
  netdata = handleTest ./netdata.nix {};
  networking.networkd = handleTest ./networking.nix { networkd = true; };
  networking.scripted = handleTest ./networking.nix { networkd = false; };
  specialisation = handleTest ./specialisation.nix {};
  # TODO: put in networking.nix after the test becomes more complete
  networkingProxy = handleTest ./networking-proxy.nix {};
  nextcloud = handleTest ./nextcloud {};
  nexus = handleTest ./nexus.nix {};
  # TODO: Test nfsv3 + Kerberos
  nfs3 = handleTest ./nfs { version = 3; };
  nfs4 = handleTest ./nfs { version = 4; };
  nghttpx = handleTest ./nghttpx.nix {};
  nginx = handleTest ./nginx.nix {};
  nginx-auth = handleTest ./nginx-auth.nix {};
  nginx-etag = handleTest ./nginx-etag.nix {};
  nginx-modsecurity = handleTest ./nginx-modsecurity.nix {};
  nginx-pubhtml = handleTest ./nginx-pubhtml.nix {};
  nginx-sandbox = handleTestOn ["x86_64-linux"] ./nginx-sandbox.nix {};
  nginx-sso = handleTest ./nginx-sso.nix {};
  nginx-variants = handleTest ./nginx-variants.nix {};
  nitter = handleTest ./nitter.nix {};
  nix-serve = handleTest ./nix-serve.nix {};
  nix-serve-ssh = handleTest ./nix-serve-ssh.nix {};
  nixops = handleTest ./nixops/default.nix {};
  nixos-generate-config = handleTest ./nixos-generate-config.nix {};
  nixpkgs = pkgs.callPackage ../modules/misc/nixpkgs/test.nix { inherit evalMinimalConfig; };
  node-red = handleTest ./node-red.nix {};
  nomad = handleTest ./nomad.nix {};
  noto-fonts = handleTest ./noto-fonts.nix {};
  novacomd = handleTestOn ["x86_64-linux"] ./novacomd.nix {};
  nsd = handleTest ./nsd.nix {};
  nzbget = handleTest ./nzbget.nix {};
  nzbhydra2 = handleTest ./nzbhydra2.nix {};
  oh-my-zsh = handleTest ./oh-my-zsh.nix {};
  ombi = handleTest ./ombi.nix {};
  openarena = handleTest ./openarena.nix {};
  openldap = handleTest ./openldap.nix {};
  openresty-lua = handleTest ./openresty-lua.nix {};
  opensmtpd = handleTest ./opensmtpd.nix {};
  opensmtpd-rspamd = handleTest ./opensmtpd-rspamd.nix {};
  openssh = handleTest ./openssh.nix {};
  openstack-image-metadata = (handleTestOn ["x86_64-linux"] ./openstack-image.nix {}).metadata or {};
  openstack-image-userdata = (handleTestOn ["x86_64-linux"] ./openstack-image.nix {}).userdata or {};
  opentabletdriver = handleTest ./opentabletdriver.nix {};
  owncast = handleTest ./owncast.nix {};
  image-contents = handleTest ./image-contents.nix {};
  orangefs = handleTest ./orangefs.nix {};
  os-prober = handleTestOn ["x86_64-linux"] ./os-prober.nix {};
  osrm-backend = handleTest ./osrm-backend.nix {};
  overlayfs = handleTest ./overlayfs.nix {};
  packagekit = handleTest ./packagekit.nix {};
  pam-file-contents = handleTest ./pam/pam-file-contents.nix {};
  pam-oath-login = handleTest ./pam/pam-oath-login.nix {};
  pam-u2f = handleTest ./pam/pam-u2f.nix {};
  pantalaimon = handleTest ./matrix/pantalaimon.nix {};
  pantheon = handleTest ./pantheon.nix {};
  paperless-ng = handleTest ./paperless-ng.nix {};
  parsedmarc = handleTest ./parsedmarc {};
  pdns-recursor = handleTest ./pdns-recursor.nix {};
  peerflix = handleTest ./peerflix.nix {};
  peertube = handleTestOn ["x86_64-linux"] ./web-apps/peertube.nix {};
  pgadmin4 = handleTest ./pgadmin4.nix {};
  pgadmin4-standalone = handleTest ./pgadmin4-standalone.nix {};
  pgjwt = handleTest ./pgjwt.nix {};
  pgmanage = handleTest ./pgmanage.nix {};
  php = handleTest ./php {};
  php74 = handleTest ./php { php = pkgs.php74; };
  php80 = handleTest ./php { php = pkgs.php80; };
  php81 = handleTest ./php { php = pkgs.php81; };
  pict-rs = handleTest ./pict-rs.nix {};
  pinnwand = handleTest ./pinnwand.nix {};
  plasma5 = handleTest ./plasma5.nix {};
  plasma5-systemd-start = handleTest ./plasma5-systemd-start.nix {};
  plausible = handleTest ./plausible.nix {};
  pleroma = handleTestOn [ "x86_64-linux" "aarch64-linux" ] ./pleroma.nix {};
  plikd = handleTest ./plikd.nix {};
  plotinus = handleTest ./plotinus.nix {};
  podgrab = handleTest ./podgrab.nix {};
  podman = handleTestOn ["x86_64-linux"] ./podman/default.nix {};
  podman-dnsname = handleTestOn ["x86_64-linux"] ./podman/dnsname.nix {};
  podman-tls-ghostunnel = handleTestOn ["x86_64-linux"] ./podman/tls-ghostunnel.nix {};
  pomerium = handleTestOn ["x86_64-linux"] ./pomerium.nix {};
  postfix = handleTest ./postfix.nix {};
  postfix-raise-smtpd-tls-security-level = handleTest ./postfix-raise-smtpd-tls-security-level.nix {};
  postfixadmin = handleTest ./postfixadmin.nix {};
  postgis = handleTest ./postgis.nix {};
  postgresql = handleTest ./postgresql.nix {};
  postgresql-wal-receiver = handleTest ./postgresql-wal-receiver.nix {};
  powerdns = handleTest ./powerdns.nix {};
  powerdns-admin = handleTest ./powerdns-admin.nix {};
  power-profiles-daemon = handleTest ./power-profiles-daemon.nix {};
  pppd = handleTest ./pppd.nix {};
  predictable-interface-names = handleTest ./predictable-interface-names.nix {};
  printing = handleTest ./printing.nix {};
  privacyidea = handleTest ./privacyidea.nix {};
  privoxy = handleTest ./privoxy.nix {};
  prometheus = handleTest ./prometheus.nix {};
  prometheus-exporters = handleTest ./prometheus-exporters.nix {};
  prosody = handleTest ./xmpp/prosody.nix {};
  prosody-mysql = handleTest ./xmpp/prosody-mysql.nix {};
  proxy = handleTest ./proxy.nix {};
  prowlarr = handleTest ./prowlarr.nix {};
  pt2-clone = handleTest ./pt2-clone.nix {};
  pulseaudio = discoverTests (import ./pulseaudio.nix);
  qboot = handleTestOn ["x86_64-linux" "i686-linux"] ./qboot.nix {};
  quorum = handleTest ./quorum.nix {};
  rabbitmq = handleTest ./rabbitmq.nix {};
  radarr = handleTest ./radarr.nix {};
  radicale = handleTest ./radicale.nix {};
  rasdaemon = handleTest ./rasdaemon.nix {};
  redis = handleTest ./redis.nix {};
  redmine = handleTest ./redmine.nix {};
  resolv = handleTest ./resolv.nix {};
  restartByActivationScript = handleTest ./restart-by-activation-script.nix {};
  restic = handleTest ./restic.nix {};
  retroarch = handleTest ./retroarch.nix {};
  riak = handleTest ./riak.nix {};
  robustirc-bridge = handleTest ./robustirc-bridge.nix {};
  roundcube = handleTest ./roundcube.nix {};
  rspamd = handleTest ./rspamd.nix {};
  rss2email = handleTest ./rss2email.nix {};
  rstudio-server = handleTest ./rstudio-server.nix {};
  rsyncd = handleTest ./rsyncd.nix {};
  rsyslogd = handleTest ./rsyslogd.nix {};
  rxe = handleTest ./rxe.nix {};
  sabnzbd = handleTest ./sabnzbd.nix {};
  samba = handleTest ./samba.nix {};
  samba-wsdd = handleTest ./samba-wsdd.nix {};
  sanoid = handleTest ./sanoid.nix {};
  sddm = handleTest ./sddm.nix {};
  seafile = handleTest ./seafile.nix {};
  searx = handleTest ./searx.nix {};
  service-runner = handleTest ./service-runner.nix {};
  shadow = handleTest ./shadow.nix {};
  shadowsocks = handleTest ./shadowsocks {};
  shattered-pixel-dungeon = handleTest ./shattered-pixel-dungeon.nix {};
  shiori = handleTest ./shiori.nix {};
  signal-desktop = handleTest ./signal-desktop.nix {};
  simple = handleTest ./simple.nix {};
  slurm = handleTest ./slurm.nix {};
  smokeping = handleTest ./smokeping.nix {};
  snapcast = handleTest ./snapcast.nix {};
  snapper = handleTest ./snapper.nix {};
  soapui = handleTest ./soapui.nix {};
  sogo = handleTest ./sogo.nix {};
  solanum = handleTest ./solanum.nix {};
  solr = handleTest ./solr.nix {};
  sonarr = handleTest ./sonarr.nix {};
  sourcehut = handleTest ./sourcehut.nix {};
  spacecookie = handleTest ./spacecookie.nix {};
  spark = handleTestOn ["x86_64-linux"] ./spark {};
  sslh = handleTest ./sslh.nix {};
  sssd = handleTestOn ["x86_64-linux"] ./sssd.nix {};
  sssd-ldap = handleTestOn ["x86_64-linux"] ./sssd-ldap.nix {};
  starship = handleTest ./starship.nix {};
  step-ca = handleTestOn ["x86_64-linux"] ./step-ca.nix {};
  strongswan-swanctl = handleTest ./strongswan-swanctl.nix {};
  sudo = handleTest ./sudo.nix {};
  sway = handleTest ./sway.nix {};
  switchTest = handleTest ./switch-test.nix {};
  sympa = handleTest ./sympa.nix {};
  syncthing = handleTest ./syncthing.nix {};
  syncthing-init = handleTest ./syncthing-init.nix {};
  syncthing-relay = handleTest ./syncthing-relay.nix {};
  systemd = handleTest ./systemd.nix {};
  systemd-analyze = handleTest ./systemd-analyze.nix {};
  systemd-binfmt = handleTestOn ["x86_64-linux"] ./systemd-binfmt.nix {};
  systemd-boot = handleTest ./systemd-boot.nix {};
  systemd-confinement = handleTest ./systemd-confinement.nix {};
  systemd-cryptenroll = handleTest ./systemd-cryptenroll.nix {};
  systemd-escaping = handleTest ./systemd-escaping.nix {};
  systemd-journal = handleTest ./systemd-journal.nix {};
  systemd-machinectl = handleTest ./systemd-machinectl.nix {};
  systemd-networkd = handleTest ./systemd-networkd.nix {};
  systemd-networkd-dhcpserver = handleTest ./systemd-networkd-dhcpserver.nix {};
  systemd-networkd-dhcpserver-static-leases = handleTest ./systemd-networkd-dhcpserver-static-leases.nix {};
  systemd-networkd-ipv6-prefix-delegation = handleTest ./systemd-networkd-ipv6-prefix-delegation.nix {};
  systemd-networkd-vrf = handleTest ./systemd-networkd-vrf.nix {};
  systemd-nspawn = handleTest ./systemd-nspawn.nix {};
  systemd-timesyncd = handleTest ./systemd-timesyncd.nix {};
  systemd-unit-path = handleTest ./systemd-unit-path.nix {};
  taskserver = handleTest ./taskserver.nix {};
  teeworlds = handleTest ./teeworlds.nix {};
  telegraf = handleTest ./telegraf.nix {};
  teleport = handleTest ./teleport.nix {};
  thelounge = handleTest ./thelounge.nix {};
  tiddlywiki = handleTest ./tiddlywiki.nix {};
  tigervnc = handleTest ./tigervnc.nix {};
  timezone = handleTest ./timezone.nix {};
  tinc = handleTest ./tinc {};
  tinydns = handleTest ./tinydns.nix {};
  tinywl = handleTest ./tinywl.nix {};
  tomcat = handleTest ./tomcat.nix {};
  tor = handleTest ./tor.nix {};
  # traefik test relies on docker-containers
  traefik = handleTestOn ["x86_64-linux"] ./traefik.nix {};
  trafficserver = handleTest ./trafficserver.nix {};
  transmission = handleTest ./transmission.nix {};
  trezord = handleTest ./trezord.nix {};
  trickster = handleTest ./trickster.nix {};
  trilium-server = handleTestOn ["x86_64-linux"] ./trilium-server.nix {};
  tsm-client-gui = handleTest ./tsm-client-gui.nix {};
  txredisapi = handleTest ./txredisapi.nix {};
  tuptime = handleTest ./tuptime.nix {};
  turbovnc-headless-server = handleTest ./turbovnc-headless-server.nix {};
  tuxguitar = handleTest ./tuxguitar.nix {};
  ucarp = handleTest ./ucarp.nix {};
  udisks2 = handleTest ./udisks2.nix {};
  unbound = handleTest ./unbound.nix {};
  unifi = handleTest ./unifi.nix {};
  unit-php = handleTest ./web-servers/unit-php.nix {};
  upnp = handleTest ./upnp.nix {};
  usbguard = handleTest ./usbguard.nix {};
  user-activation-scripts = handleTest ./user-activation-scripts.nix {};
  uwsgi = handleTest ./uwsgi.nix {};
  v2ray = handleTest ./v2ray.nix {};
  vault = handleTest ./vault.nix {};
  vault-postgresql = handleTest ./vault-postgresql.nix {};
  vaultwarden = handleTest ./vaultwarden.nix {};
  vector = handleTest ./vector.nix {};
  vengi-tools = handleTest ./vengi-tools.nix {};
  victoriametrics = handleTest ./victoriametrics.nix {};
  vikunja = handleTest ./vikunja.nix {};
  virtualbox = handleTestOn ["x86_64-linux"] ./virtualbox.nix {};
  vscodium = discoverTests (import ./vscodium.nix);
  vsftpd = handleTest ./vsftpd.nix {};
  wasabibackend = handleTest ./wasabibackend.nix {};
  wiki-js = handleTest ./wiki-js.nix {};
  wine = handleTest ./wine.nix {};
  wireguard = handleTest ./wireguard {};
  without-nix = handleTest ./without-nix.nix {};
  wmderland = handleTest ./wmderland.nix {};
  wpa_supplicant = handleTest ./wpa_supplicant.nix {};
  wordpress = handleTest ./wordpress.nix {};
  xandikos = handleTest ./xandikos.nix {};
  xautolock = handleTest ./xautolock.nix {};
  xfce = handleTest ./xfce.nix {};
  xmonad = handleTest ./xmonad.nix {};
  xrdp = handleTest ./xrdp.nix {};
  xss-lock = handleTest ./xss-lock.nix {};
  xterm = handleTest ./xterm.nix {};
  xxh = handleTest ./xxh.nix {};
  yabar = handleTest ./yabar.nix {};
  yggdrasil = handleTest ./yggdrasil.nix {};
  zammad = handleTest ./zammad.nix {};
  zfs = handleTest ./zfs.nix {};
  zigbee2mqtt = handleTest ./zigbee2mqtt.nix {};
  zoneminder = handleTest ./zoneminder.nix {};
  zookeeper = handleTest ./zookeeper.nix {};
  zsh-history = handleTest ./zsh-history.nix {};
}
