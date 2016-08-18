require File.expand_path("../../Requirements/php-meta-requirement", __FILE__)

class Phpmyadmin < Formula
  desc "Administration of MySQL over the Web"
  homepage "http://www.phpmyadmin.net"
  url "https://github.com/phpmyadmin/phpmyadmin/archive/RELEASE_4_6_4.tar.gz"
  sha256 "67072b1a8d3ef2d064f6a70db02dd0bb16c70fb40f841281dc1027ac357f2cf4"
  head "https://github.com/phpmyadmin/phpmyadmin.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "74b82d753b33d0855faf0a0c1e7c86aaa041bc32cf85552668ce54f92742bcde" => :el_capitan
    sha256 "263b7b744b367cedee5c58ab3e8cfb140e7e7de517f8ea7e23cce5f34e57fd19" => :yosemite
    sha256 "263b7b744b367cedee5c58ab3e8cfb140e7e7de517f8ea7e23cce5f34e57fd19" => :mavericks
  end

  depends_on PhpMetaRequirement
  depends_on "php53-mcrypt" if Formula["php53"].linked_keg.exist?
  depends_on "php54-mcrypt" if Formula["php54"].linked_keg.exist?
  depends_on "php55-mcrypt" if Formula["php55"].linked_keg.exist?
  depends_on "php56-mcrypt" if Formula["php56"].linked_keg.exist?
  depends_on "php70-mcrypt" if Formula["php70"].linked_keg.exist?
  depends_on "php71-mcrypt" if Formula["php71"].linked_keg.exist?

  def install
    (share+"phpmyadmin").install Dir["*"]

    unless File.exist?(etc+"phpmyadmin.config.inc.php")
      cp (share+"phpmyadmin/config.sample.inc.php"), (etc+"phpmyadmin.config.inc.php")
    end
    ln_s (etc+"phpmyadmin.config.inc.php"), (share+"phpmyadmin/config.inc.php")
  end

  def caveats; <<-EOS.undent
    Note that this formula will NOT install mysql. It is not
    required since you might want to get connected to a remote
    database server.

    Webserver configuration example (add this at the end of
    your /etc/apache2/httpd.conf for instance) :
      Alias /phpmyadmin #{HOMEBREW_PREFIX}/share/phpmyadmin
      <Directory #{HOMEBREW_PREFIX}/share/phpmyadmin/>
        Options Indexes FollowSymLinks MultiViews
        AllowOverride All
        <IfModule mod_authz_core.c>
          Require all granted
        </IfModule>
        <IfModule !mod_authz_core.c>
          Order allow,deny
          Allow from all
        </IfModule>
      </Directory>
    Then, open http://localhost/phpmyadmin

    More documentation : file://#{pkgshare}/doc/

    Configuration has been copied to #{etc}/phpmyadmin.config.inc.php
    Don't forget to:
      - change your secret blowfish
      - uncomment the configuration lines (pma, pmapass ...)

    EOS
  end

  test do
    assert File.exist?("#{etc}/phpmyadmin.config.inc.php")
  end
end
