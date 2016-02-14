class Adminer < Formula
  desc "Full-featured database management tool written in PHP."
  homepage "http://www.adminer.org/"
  url "https://www.adminer.org/static/download/4.2.4/adminer-4.2.4.php"
  sha256 "ea21b95da1a2f66d26849160f3257823254663144e6b3b506c35160b70c7b3bd"

  bottle do
    cellar :any_skip_relocation
    revision 1
    sha256 "dcc3965fff0ef6847c2e56b350785e42d666e66a2703fbf1fddc24134fa0e605" => :el_capitan
    sha256 "ae4c830f9977cf21312c1b611df67072913b134ef2efea7261a1611cada2a2c9" => :yosemite
    sha256 "a6c06b4f01eabf1b980e97b2b550caa4a80ca66bfa3381da6fe168782bc882d1" => :mavericks
  end

  def install
    pkgshare.install "adminer-"+version+".php" => "index.php"
  end

  def caveats; <<-EOS.undent
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
