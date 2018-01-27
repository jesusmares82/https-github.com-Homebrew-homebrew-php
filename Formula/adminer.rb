class Adminer < Formula
  desc "Full-featured database management tool written in PHP."
  homepage "https://www.adminer.org"
  url "https://github.com/vrana/adminer/releases/download/v4.5.0/adminer-4.5.0.php"
  sha256 "ccadc33019cb57a56a268d0d6be1a9e242dd0881dbddc06f376a06c7c5846ed0"

  bottle do
    cellar :any_skip_relocation
    sha256 "3ca33630e072a6d69d9774e7a17e800d22dc0479ee7b0940fd603cf0809e80a5" => :high_sierra
    sha256 "3ca33630e072a6d69d9774e7a17e800d22dc0479ee7b0940fd603cf0809e80a5" => :sierra
    sha256 "3ca33630e072a6d69d9774e7a17e800d22dc0479ee7b0940fd603cf0809e80a5" => :el_capitan
  end

  def install
    pkgshare.install "adminer-"+version+".php" => "index.php"
  end

  def caveats; <<~EOS
    Note that this formula will NOT install MySQL or any other
    database. It is not required since you might want to get
    connected to a remote database server.

    Webserver configuration example (add this at the end of
    your /etc/apache2/httpd.conf for instance):

      Alias /adminer #{HOMEBREW_PREFIX}/share/adminer
      <Directory "#{HOMEBREW_PREFIX}/share/adminer/">
        Options None
        AllowOverride None
        <IfModule mod_authz_core.c>
          Require all granted
        </IfModule>
        <IfModule !mod_authz_core.c>
          Order allow,deny
          Allow from all
        </IfModule>
      </Directory>

    Then, open http://localhost/adminer
    EOS
  end

  test do
    system "php", "-l", "#{pkgshare}/index.php"
  end
end
