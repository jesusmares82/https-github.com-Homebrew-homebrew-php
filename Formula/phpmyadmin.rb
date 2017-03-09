require File.expand_path("../../Requirements/php-meta-requirement", __FILE__)

class Phpmyadmin < Formula
  desc "A web interface for MySQL and MariaDB"
  homepage "https://www.phpmyadmin.net"
  url "https://github.com/phpmyadmin/phpmyadmin/archive/RELEASE_4_6_6.tar.gz"
  sha256 "4de8e0924dd11dcf74781b3fd6457e6b87d633987c2d09e0df8993b40faf16d3"
  head "https://github.com/phpmyadmin/phpmyadmin.git"

  bottle do
    cellar :any_skip_relocation
    rebuild 1
    sha256 "a9ad4539ccd1e9c0cafb26c05b99ad64e1149c871c7e1d7464490087248077e4" => :sierra
    sha256 "a9ad4539ccd1e9c0cafb26c05b99ad64e1149c871c7e1d7464490087248077e4" => :el_capitan
    sha256 "f27a207fb48e8bfa9a6c145a746c758de88956970775633be1e76a454793c059" => :yosemite
  end

  devel do
    url "https://github.com/phpmyadmin/phpmyadmin/archive/RELEASE_4_7_0RC1.tar.gz"
    sha256 "18d694a7f8a8fa7bc909bead7a5981be945aefaa70b3cb27008a29679fdf4af7"
    version "4.7.0-RC1"
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
